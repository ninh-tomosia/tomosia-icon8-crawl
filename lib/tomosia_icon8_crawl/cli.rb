require 'thor'
require_relative '../tomosia_icon8_crawl'

module TomosiaIcon8Crawl
  class Cli < Thor

    desc "crawl KEYWORD", "enter KEYWORD to search"
    option :destination
    option :max
    def crawl(keyword)
      TomosiaIcon8Crawl::CrawlIcon8.crawl(keyword, options[:destination], options[:max])
    end
  end
end