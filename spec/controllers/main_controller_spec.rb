require 'rails_helper'
RSpec.describe MainController, :type => :controller do
	include Devise::TestHelpers
	describe "GET home" do
    it "has a 200 status code" do
      get "home"
      expect(response.status).to eq(200)
    end
  end
end
