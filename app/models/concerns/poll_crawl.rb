require 'open-uri'

class PollCrawler
  def initialize(url)
    @doc = url
  end

  def polls
    @doc.xpath("//*[@id='pollingOutcome']").css('article.poll')
  end

  def persist!
    polls.each do |p|
      pc = PollCommand.new(p)
      if pc.validate_and_create_poll_entity.present?
        pc.persist!
      end
    end
  end

  def persist_first!
    pc = PollCommand.new(polls.first)
    if pc.validate_and_create_poll_entity.present?
      pc.persist!
    end
  end

  class PollCommand
    attr_reader :doc

    def initialize(doc)
      @doc = doc
    end

    def state_id
      #Don't use for now
      State.find_by(name: state_name).id
    end

    def party
      # no-op
    end

    def start_date
      Date.parse(doc.attributes["data-start-dt"].value)
    end

    def end_date
      Date.parse(doc.attributes["data-end-dt"].value)
    end

    def name
      doc.css('h2').text.strip
    end

    def poller
      doc.css('p').first.css('a').first.children.first.to_s.strip
    end

    def state_name
      name.split(' ')[1]
    end

    def party
      if name.include?("Republican")
        "Republican"
      elsif name.include?("Democratic")
        "Democratic"
      else
        "Invalid"
      end
    end

    def poll_statistics
      doc.css('article.results-group').css('tr')
    end

    def valid?
      poll_entity.valid?
    end

    def persist!
      poll_statistics.map  do |ps|
        poll_entity.poll_statistics.create(PollStatisticCommand.new(ps).attrs)
      end
    end


    def validate_and_create_poll_entity
      p =  Poll.find_or_initialize_by(unique_attrs)
      p.assign_attributes(attrs)

      if p.valid?
        @entity = p.save && p.reload
      end
    end

    private

    def poll_entity
      @entity
    end


    def attrs
      {
        name:  name,
        poller: poller,
        state_name: state_name,
        start_date: start_date,
        end_date: end_date,
        party: party
      }
    end

    def unique_attrs
      {
        name: name,
        poller: poller
      }
    end

    class PollStatisticCommand
      attr_reader :doc

      def initialize(doc)
        @doc     = doc
      end

      def poll_id
        @poll_id
      end

      def candidate_id
        #TODO: change to actually use candidate id
        Candidate.find_by(name: candidate_name).id
      end

      def candidate_name
        doc.css('a').text.strip
      end

      def percentage
        doc.css('span.number').first.children.first.text.to_f
      end

      def valid?
        poll_statistic_entity.valid?
      end

      def poll_statistic_entity
        @entity ||= PollStatistic.new(attrs)
      end

      def attrs
        {
          candidate_name: candidate_name,
          percentage: percentage,
          poll_id: poll_id
        }
      end
    end
  end
end

#Uncomment later
# for i in 1..25
#   doc = Nokogiri::HTML(open("http://www.politico.com/polls/?page=#{i}"))
#   PollCrawler.new(doc).persist!
# end
