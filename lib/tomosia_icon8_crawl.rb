module TomosiaIcon8Crawl
	require 'open-uri'
	require "HTTParty"
	require 'pry'
	require 'WriteExcel'
	class CrawlIcon8

		# get data from website
		def self.json(key, max)
			if key == nil
				p "No data!"
			else 
				if max == nil
					uri = "https://search.icons8.com/api/iconsets/v5/search?term=#{key}&amount=1"
					page = HTTParty.get(uri)
					res = page.parsed_response
					countAll = res['parameters']['countAll']
					url = "https://search.icons8.com/api/iconsets/v5/search?term=#{key}&amount=#{countAll}"
				else
					url = "https://search.icons8.com/api/iconsets/v5/search?term=#{key}&amount=#{max}"
				end
			end
			
			page_data = HTTParty.get(url)
			@responses = page_data.parsed_response	
		end

		# save file to txt
		def self.save_file_txt(index, name, url, size, extension)   
	      	File.open("log_image.txt", "a+") do |f|
	      		f.write("#{index}. name: #{name} | url: #{url} | size: #{size}Kb | extension: #{extension} \n")
	      	end
		end

		# save file to excel
		def self.save_file_excel( path, data = {})
			begin
				des = path + '/export.xls'
				workbook  = WriteExcel.new(des)
				format = workbook.add_format
				format.set_bold()
				format.set_align('center')

				data_col = workbook.add_format
				data_col.set_align('center')
				format_url = workbook.add_format
				format_url.set_color('blue')
				format_url.set_align('center')

				worksheet = workbook.add_worksheet
				
	    		worksheet.write_string(0, 0, 'STT', format)
		    	worksheet.write_string(0, 1, 'NAME', format)
		    	worksheet.write_string(0, 2, 'URL', format)
		    	worksheet.write_string(0, 3, 'SIZE', format)
		    	worksheet.write_string(0, 4, 'EXTENSION', format)

		    	multi = []
		    	data.each_with_index do |row, index|
		    		i = index + 1
		    		# p i
		    		# p row
		    		multi << Thread.new do
			    		row.each do |key, value|
			    			# p key

				    		worksheet.write_string(i, 0, row['index'], data_col)
				    		worksheet.write_string(i, 1, row['name'], data_col)
				    		worksheet.write_url(i, 2, row['url'], format_url)
				    		worksheet.write_string(i, 3, row['size'], data_col)
				    		worksheet.write_string(i, 4, row['extension'], data_col)
			    		end
			    	end
		    	end
		    	multi.each{ |m| m.join }

	    		workbook.close
			rescue Exception => e
				p "Can't saved file"
				p e
				# break
			end
		end

		# download image
		def self.download_image(path, img)
			timeout = 0
			begin 
				open(img) do |image|
					File.open(path, 'wb') do |file|
						file.write(image.read)
						@size = image.size
						# p @size
					end	
				end
			rescue
				if timeout < 5
					timeout += 1
					p "Retry download image"
					retry
				end
			end		
		end

		# multi download image
		def self.multi_download_image(path, imgs)
			begin
				threads = []
				@data = []

				imgs.each_with_index do |img, index|
					# p index
					title = File.basename(img, '.png')
					des = path. + "/" + index.to_s + "-" + title + ".png"
					ext = File.extname(img).delete('.')
					threads << Thread.new do 
						download_image(des, img)
						@size = @size.to_s + "byte"
						row = {"index" => index, "name" => title, "url" => img, "size" => @size, "extension" => ext}
						@data.push(row)
					end
				end
				threads.each{ |t| t.join }	
			rescue Exception => e
				p "no data"
				p e
			end
		end

		# main
	    def self.crawl(keyword = nil, path = ".", max = nil)
	    	begin
	        	
				images = []
				des = ""
	        	json(keyword, max)
				@responses['icons'].each_with_index do |item, index| 

					src = "https://img.icons8.com/#{item['platform']}/2x/#{item['commonName']}.png"

					# add image
					images.push(src)
				end

				multi_download_image(path, images)
				save_file_excel(path, @data)
	    	rescue Exception => e
	    		p "--Runtime error--"
	    		p e
	    	end
	    end
	end
end