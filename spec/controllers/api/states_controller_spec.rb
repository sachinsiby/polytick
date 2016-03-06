require 'rails_helper'

describe Api::StatesController do
  let(:json_response) { JSON.parse(response.body) }

  describe "GET #index" do
    it "returns information about all the states" do
      state  = create(:state, name: "Iowa")
      state2 = create(:state, name: "Washington")

      get :index
      expect(json_response).to be_a(Array)
      expect(json_response.count).to eq(2)
      expect(json_response.map{ |s| s['name'] }).to eq(['Iowa', 'Washington'])
    end
  end

  describe "GET #show" do
    let!(:state){ create(:state, name: "Texas")}

    context "presidential events" do
      let(:republican_events) { json_response["republican_events"] }
      let(:democratic_events) { json_response["democratic_events"] }

      it "serializes all the presidential events in a state and separates them by party" do
        republican_event = create(:presidential_event, party: "Republican", state: state)
        democratic_event = create(:presidential_event, party: "Democratic", state: state)

        get :show, id: state.id
        expect(republican_events).to be_a(Array)
        expect(republican_events.size).to eq(1)

        expect(democratic_events).to be_a(Array)
        expect(democratic_events.size).to eq(1)
      end
    end

    context "delegate stats" do
      let(:republican_delegate_stats) { json_response["republican_delegate_stats"]}
      let(:democratic_delegate_stats) { json_response["democratic_delegate_stats"]}

      it "serializes the delegate stats" do
        candidate                = create(:candidate, party: "Republican")
        delegate_stat            = create(:delegate_stat, state: state, candidate: candidate)
        democratic_delegate_stat = create(:delegate_stat, state: state, party: "Democratic")


        get :show, id: state.id
        expect(republican_delegate_stats).to be_a(Array)
        expect(republican_delegate_stats.size).to eq(1)
        expect(republican_delegate_stats.first["count"]).to eq(delegate_stat.count)

        expect(democratic_delegate_stats).to be_a(Array)
        expect(democratic_delegate_stats.size).to eq(1)
      end
    end
  end
end
