module ResultsCrawl
  class ResultCommand

    attr_reader :num_unique_events

    def initialize(doc)
      @doc               = doc
      @num_unique_events = doc.css('.results-group').length
    end

    def party_attrs
      @doc.css('.results-data').map.with_index do | party_result_doc, index |
        name                  = parse_attribute(@doc.css('h4>a'), index)
        state                 = parse_attribute(@doc.css('h3>a'), index)
        date                  = parse_attribute(@doc.css('p.timestamp'), index)
        party                 = @doc.css('.title>h5')[index].text

        PartyResultEntity.new(party_result_doc, { name: name, date: date, party: party,
           state: state, reporting_percentage: reporting_percentage(index) }).attrs
      end
    end

    def reporting_percentage(index)
      percent_string = @doc.css('.results-meta')[index].css('.title>p')
      percent_string && percent_string.text.split(" ")[0].to_f
    end

    def parse_attribute(node, index)
      node.length > 1 ? node[index].text.strip : node.text.strip
    end


    def persist!
      party_attrs.each do |attrs|
        stats = attrs.delete(:result_statistics).map{|s| ResultStatistic.new(s)}
        r = Result.find_or_initialize_by(party: attrs[:party], state: attrs[:state])
        r.assign_attributes(attrs.merge({result_statistics: stats}))
        r.save
      end
    end

    class PartyResultEntity

      def initialize(doc, opts={})
        @doc  = doc
        @opts = opts
      end

      def name
        @opts[:name] || @doc.css('h4>a').text.strip
      end

      def date
        @opts[:date] || @doc.css('p.timestamp').text.strip
      end

      def delegates_allocated
        @doc.css('p.pos-1').text.sub("Delegates Allocated: ", "")
      end

      def result_statistics
        @doc.css('tr').map do |result_doc|
          PartyResultStatistic.new(result_doc).attrs
        end
      end

      def attrs
        {
          name: name,
          party: @opts[:party],
          state: @opts[:state],
          date: Date.parse(date),
          delegates_allocated: delegates_allocated,
          reporting_percentage: @opts[:reporting_percentage],
          result_statistics: result_statistics
        }
      end
    end

    class PartyResultStatistic

      def initialize(doc)
        @doc = doc
      end

      def candidates_map
        {
          'D. Trump': 'Donald Trump',
          'T. Cruz':  'Ted Cruz',
          'M. Rubio': 'Marco Rubio',
          'J. Kasich': 'John Kasich',
          'H. Clinton': 'Hillary Clinton',
          'B. Sanders': 'Bernie Sanders',
        }
      end


      def candidate_name
        candidates_map.with_indifferent_access[@doc.css('span.name-combo').children.last.text.strip] || "Others"
      end

      def percentage
        @doc.css('.results-percentage').text.to_f
      end

      def num_delegates
        @doc.css('.delegates-cell').text.to_i
      end

      def attrs
        {
          candidate_name: candidate_name,
          percentage: percentage,
          num_delegates: num_delegates
        }
      end
    end
  end
end
