require 'rails_helper'

RSpec.describe "site/home/index.html.slim", :type => :view do
  it "should contain the search photo text" do
    render
    expect(rendered).to have_css("input#search_photo_text")
  end
end
