require 'rails_helper'

RSpec.describe "columns/edit", type: :view do
  before(:each) do
    @column = assign(:column, Column.create!(
      :name => "MyString",
      :english => "MyString",
      :cover => "MyString",
      :summary => "MyText"
    ))
  end

  it "renders the edit column form" do
    render

    assert_select "form[action=?][method=?]", column_path(@column), "post" do

      assert_select "input#column_name[name=?]", "column[name]"

      assert_select "input#column_english[name=?]", "column[english]"

      assert_select "input#column_cover[name=?]", "column[cover]"

      assert_select "textarea#column_summary[name=?]", "column[summary]"
    end
  end
end
