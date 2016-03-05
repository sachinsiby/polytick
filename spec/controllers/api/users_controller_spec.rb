require 'rails_helper'

describe Api::UsersController do

  it "returns the right user information" do
    user = create(:user)
    expect(User.count).to eq(1)
  end
end
