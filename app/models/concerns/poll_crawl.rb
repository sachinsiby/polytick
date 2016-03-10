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
      pc.persist!
    end
  end

  def persist_first!
    pc = PollCommand.new(polls.first)
    pc.persist!
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

    private

    def poll_entity
      @entity ||= Poll.create(attrs)
    end


    def attrs
      {
        name:  name,
        poller: poller,
        state_name: state_name,
        start_date: start_date,
        end_date: end_date,
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

Poll.destroy_all
PollStatistic.destroy_all

doc = Nokogiri::HTML(open("http://www.politico.com/polls/#.VuEDuWwVhBc"))
PollCrawler.new(doc).persist!
