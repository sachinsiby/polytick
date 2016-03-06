require 'rails_helper'

describe Api::StatesController do
  describe "GET #index"
    let(:json_response) { JSON.parse(response.body) }

    it "returns information about all the states" do
      state  = create(:state, name: "Iowa")
      state2 = create(:state, name: "Washington")

      get :index
      expect(json_response).to be_a(Array)
      expect(json_response.count).to eq(2)
      expect(json_response.map{ |s| s['name'] }).to eq(['Iowa', 'Washington'])
    end

    context "presidential events" do
      let(:state){ create(:state, name: "Texas") }
      let(:republican_events) { json_response.first["republican_events"] }
      let(:democratic_events) { json_response.first["democratic_events"] }
      it "serializes all the presidential events in a state and separates them by party" do
        republican_event = create(:presidential_event, party: "Republican", state: state)
        democratic_event = create(:presidential_event, party: "Democratic", state: state)
        get :index
        expect(republican_events).to be_a(Array)
        expect(republican_events.size).to eq(1)

        expect(democratic_events).to be_a(Array)
        expect(democratic_events.size).to eq(1)
      end
    end
end
