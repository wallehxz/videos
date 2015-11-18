require "rails_helper"

RSpec.describe ColumnsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/columns").to route_to("columns#index")
    end

    it "routes to #new" do
      expect(:get => "/columns/new").to route_to("columns#new")
    end

    it "routes to #show" do
      expect(:get => "/columns/1").to route_to("columns#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/columns/1/edit").to route_to("columns#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/columns").to route_to("columns#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/columns/1").to route_to("columns#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/columns/1").to route_to("columns#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/columns/1").to route_to("columns#destroy", :id => "1")
    end

  end
end
