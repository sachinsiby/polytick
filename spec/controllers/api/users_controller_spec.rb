require 'rails_helper'

describe Api::UsersController do
  describe "#show"
    it "returns the right user information" do
      user = create(:user)
    end
end
