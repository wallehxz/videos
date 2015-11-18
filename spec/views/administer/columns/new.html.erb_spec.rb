require 'rails_helper'

RSpec.describe "columns/new", type: :view do
  before(:each) do
    assign(:column, Column.new(
      :name => "MyString",
      :english => "MyString",
      :cover => "MyString",
      :summary => "MyText"
    ))
  end

  it "renders new column form" do
    render

    assert_select "form[action=?][method=?]", columns_path, "post" do

      assert_select "input#column_name[name=?]", "column[name]"

      assert_select "input#column_english[name=?]", "column[english]"

      assert_select "input#column_cover[name=?]", "column[cover]"

      assert_select "textarea#column_summary[name=?]", "column[summary]"
    end
  end
end
