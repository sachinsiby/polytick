require_relative '../../scripts/results_crawl/crawl.rb'
require_relative '../../scripts/results_crawl/result_command.rb'

namespace :crawl do
  desc 'This is for crawling results info'
  task :results => :environment do
    puts "Crawling results"
    # eval(File.open('scripts/results_crawl/crawl.rb').read)
    ResultsCrawl::Crawl.run
  end
end
