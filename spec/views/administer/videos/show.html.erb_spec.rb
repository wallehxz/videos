require 'rails_helper'

RSpec.describe "videos/show", type: :view do
  before(:each) do
    @video = assign(:video, Video.create!(
      :column_id => 1,
      :tv_code => "Tv Code",
      :recommend => 2,
      :title => "Title",
      :cover => "Cover",
      :duration => "Duration",
      :summary => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Tv Code/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Cover/)
    expect(rendered).to match(/Duration/)
    expect(rendered).to match(/MyText/)
  end
end
