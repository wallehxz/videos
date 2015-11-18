require 'rails_helper'

RSpec.describe "Columns", type: :request do
  describe "GET /columns" do
    it "works! (now write some real specs)" do
      get columns_path
      expect(response).to have_http_status(200)
    end
  end
end
