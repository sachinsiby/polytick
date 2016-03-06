require 'rails_helper'

describe PresidentialEvent do
  context "validations" do
    it "validates that event is either Republican or Democratic", :focus do
      event = build(:presidential_event, party: "Tea Party")
      expect(event).to_not be_valid

      event.party = "Republican"
      expect(event).to be_valid
    end
  end
end
