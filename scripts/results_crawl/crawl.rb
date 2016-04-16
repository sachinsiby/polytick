module ResultsCrawl
  class Crawl
    def self.run
      url = "http://www.politico.com/2016-election/results/map/president"
      doc = Nokogiri::HTML(open(url))
      doc.css('.election-results article.timeline-group').each do |state|
        ResultsCrawl::ResultCommand.new(state).persist!
      end
      ResultsCrawl::UpdateWrongResults.new().update!
      ResultsCrawl::UpdateWrongResults.new().update_iowa!
    end
  end
end
