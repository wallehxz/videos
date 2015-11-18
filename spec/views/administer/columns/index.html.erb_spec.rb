require 'rails_helper'

RSpec.describe "columns/index", type: :view do
  before(:each) do
    assign(:columns, [
      Column.create!(
        :name => "Name",
        :english => "English",
        :cover => "Cover",
        :summary => "MyText"
      ),
      Column.create!(
        :name => "Name",
        :english => "English",
        :cover => "Cover",
        :summary => "MyText"
      )
    ])
  end

  it "renders a list of columns" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "English".to_s, :count => 2
    assert_select "tr>td", :text => "Cover".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
