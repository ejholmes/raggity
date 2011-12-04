require 'spec_helper'

describe User do

  it "properly creates a user" do
    user = Factory(:user)
    user.should be_valid
  end

end
