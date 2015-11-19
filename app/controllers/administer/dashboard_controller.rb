class  Administer::DashboardController < ApplicationController
  before_action :authenticate_admin!
  layout 'just_admin'
  def index
  end
end
