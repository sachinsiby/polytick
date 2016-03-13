namespace :crawl do
  desc 'This is for crawling poll info'
  task :poll => :environment do
    puts "Crawling polls"
    eval(File.open('app/models/concerns/poll_crawl.rb').read)
  end
end
