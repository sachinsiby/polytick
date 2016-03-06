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
end
