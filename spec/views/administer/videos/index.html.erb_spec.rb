require 'rails_helper'

RSpec.describe "videos/index", type: :view do
  before(:each) do
    assign(:videos, [
      Video.create!(
        :column_id => 1,
        :tv_code => "Tv Code",
        :recommend => 2,
        :title => "Title",
        :cover => "Cover",
        :duration => "Duration",
        :summary => "MyText"
      ),
      Video.create!(
        :column_id => 1,
        :tv_code => "Tv Code",
        :recommend => 2,
        :title => "Title",
        :cover => "Cover",
        :duration => "Duration",
        :summary => "MyText"
      )
    ])
  end

  it "renders a list of videos" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Tv Code".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Cover".to_s, :count => 2
    assert_select "tr>td", :text => "Duration".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
