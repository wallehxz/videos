require 'rails_helper'

RSpec.describe ProfileController, type: :controller do

  describe "GET #new_avatar" do
    it "returns http success" do
      get :new_avatar
      expect(response).to have_http_status(:success)
    end
  end

end
