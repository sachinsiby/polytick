require 'rails_helper'
require_relative '../../scripts/results_crawl/result_command'

RSpec.describe ResultsCrawl::ResultCommand do

  context 'when a state has both republican and democratic events on the same day' do
    let(:doc){ Nokogiri::HTML(File.open('spec/scripts/alabama.html')) }
    let(:subject) { ResultsCrawl::ResultCommand.new(doc) }
    let(:party_attrs) { subject.party_attrs }
    it 'returns the unique event count correctly' do
      expect(subject.num_unique_events).to eq(1)
    end

    it 'returns results for both Republican and Democratic parties' do
      expect(party_attrs.length).to eq(2)
      parties = party_attrs.map{|p| p[:party] }
      expect(parties).to match_array(['Republican', 'Democratic'])
    end

    context 'attributes' do
      it 'sets them correctly for the Democratic party' do
        democratic_attrs = party_attrs[0]
        expect(democratic_attrs[:name]).to eq('Presidential Primaries')
        expect(democratic_attrs[:state]).to eq('Alabama')
        expect(democratic_attrs[:date]).to eq(Date.parse('March 1, 2016'))
        expect(democratic_attrs[:party]).to eq('Democratic')
        expect(democratic_attrs[:delegates_allocated]).to eq('56/60')
      end
      it 'sets them correctly for the Republican party' do
        republican_attrs = party_attrs[1]
        expect(republican_attrs[:name]).to eq('Presidential Primaries')
        expect(republican_attrs[:state]).to eq('Alabama')
        expect(republican_attrs[:date]).to eq(Date.parse('March 1, 2016'))
        expect(republican_attrs[:party]).to eq('Republican')
        expect(republican_attrs[:delegates_allocated]).to eq('50/50')
      end
    end
  end

  context 'when a state has democratic and republican events on different days' do
    let!(:doc) { Nokogiri::HTML(File.open('spec/scripts/alaska.html'))}
    let!(:subject)  { ResultsCrawl::ResultCommand.new(doc) }
    let!(:party_attrs) { subject.party_attrs }
    it 'returns the unique event count correctly' do
      expect(subject.num_unique_events).to eq(2)
    end

    it 'has results for both Republican and Democratic parties' do
      expect(party_attrs.length).to eq(2)
      parties = party_attrs.map{|p| p[:party] }
      expect(parties).to match_array(['Republican', 'Democratic'])
    end

    it 'sets the date attributes correctly' do
      republican_attrs = party_attrs[0]
      democratic_attrs = party_attrs[1]

      expect(republican_attrs[:state]).to eq('Alaska')
      expect(republican_attrs[:date]).to eq(Date.parse('March 1, 2016'))
      expect(democratic_attrs[:date]).to eq(Date.parse('March 26, 2016'))
    end
  end

  context 'when a state has only result (other is not visible)' do
    let!(:doc) { Nokogiri::HTML(File.open('spec/scripts/colorado.html'))}
    let!(:subject)  { ResultsCrawl::ResultCommand.new(doc) }
    let!(:party_attrs) { subject.party_attrs }
    it "returns only one result" do
      expect(party_attrs.length).to eq(1)
    end
  end

  context 'when a state has one result; other one is not out yet' do
    let!(:doc) { Nokogiri::HTML(File.open('spec/scripts/iowa.html'))}
    let!(:subject)  { ResultsCrawl::ResultCommand.new(doc) }
    let!(:party_attrs) { subject.party_attrs }
    it "sets delegates allocated for pending result to an empty string" do
      expect(party_attrs.length).to eq(2)
      democratic_attrs = party_attrs[0]
      expect(democratic_attrs[:delegates_allocated]).to eq("")
    end

    context 'persistence' do
      it "persists records to the database" do
        expect(Result.count).to eq(0)
        expect(ResultStatistic.count).to eq(0)

        subject.persist!
        expect(Result.count).to eq(2)
        expect(ResultStatistic.count).to eq(13)
      end

      it "ensures persistence is idempotent" do
        expect(Result.count).to eq(0)
        subject.persist!
        subject.persist!
        expect(Result.count).to eq(2)
        expect(Result.all.map{ |rs| rs.result_statistics.count }.sum).to eq(13)
      end
    end
  end
end
