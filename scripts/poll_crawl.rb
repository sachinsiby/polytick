require 'open-uri'

STATES = [ "Alaska",
          "Alabama",
          "Arkansas",
          "American Samoa",
          "Arizona",
          "California",
          "Colorado",
          "Connecticut",
          "District of Columbia",
          "Delaware",
          "Florida",
          "Georgia",
          "Guam",
          "Hawaii",
          "Iowa",
          "Idaho",
          "Illinois",
          "Indiana",
          "Kansas",
          "Kentucky",
          "Louisiana",
          "Massachusetts",
          "Maryland",
          "Maine",
          "Michigan",
          "Minnesota",
          "Missouri",
          "Mississippi",
          "Montana",
          "North Carolina",
          "North Dakota",
          "Nebraska",
          "New Hampshire",
          "New Jersey",
          "New Mexico",
          "Nevada",
          "New York",
          "Ohio",
          "Oklahoma",
          "Oregon",
          "Pennsylvania",
          "Puerto Rico",
          "Rhode Island",
          "South Carolina",
          "South Dakota",
          "Tennessee",
          "Texas",
          "Utah",
          "Virginia",
          "Virgin Islands",
          "Vermont",
          "Washington",
          "Wisconsin",
          "West Virginia",
          "Wyoming",
          ""
        ]

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
      doc.css('p.byline').first.css('a').first.children.first.to_s.strip
    end

    def state_name
      state = ""
      STATES.any? { |word| name.include?(word) ? state = word : false }
      state
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
      children = poll_statistics.map  do |ps|
        PollStatistic.new(PollStatisticCommand.new(ps).attrs)
      end
      poll_entity.poll_statistics.replace(children)
    end


    def validate_and_create_poll_entity
      p =  Poll.find_or_initialize_by(unique_attrs)
      p.assign_attributes(attrs)

      if p.valid? && !name.include?('Senate')
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

for i in 1..25
  url = "http://www.politico.com/polls/?page=#{i}"
  puts url
  doc = Nokogiri::HTML(open(url))
  PollCrawler.new(doc).persist!
end
