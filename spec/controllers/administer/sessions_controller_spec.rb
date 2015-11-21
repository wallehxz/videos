require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #admin_sign_in" do
    it "returns http success" do
      get :admin_sign_in
      expect(response).to have_http_status(:success)
    end
  end

end
