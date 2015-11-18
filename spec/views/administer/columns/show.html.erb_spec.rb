require 'rails_helper'

RSpec.describe "columns/show", type: :view do
  before(:each) do
    @column = assign(:column, Column.create!(
      :name => "Name",
      :english => "English",
      :cover => "Cover",
      :summary => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/English/)
    expect(rendered).to match(/Cover/)
    expect(rendered).to match(/MyText/)
  end
end
