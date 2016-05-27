require 'rails_helper'

RSpec.describe "site/home/search.html.slim", :type => :view do
  it "should contain the search input" do
    controller = HomeController.new
    controller.params = { :search_photo_text => 'dogs' }
    assign(:results, controller.search)
    render
    expect(rendered).to have_css("search_photo_text#search_input")
  end

  it "should contain thumbnails" do
    controller = HomeController.new
    controller.params = { :search_photo_text => 'dogs' }
    assign(:results, controller.search)
    render
    expect(rendered).to have_css(".thumbs img", :count => 8)
  end

  it "should contain links to larger images" do
    controller = HomeController.new
    controller.params = { :search_photo_text => 'dogs' }
    assign(:results, controller.search)
    render
    expect(rendered).to include("_c.jpg")
  end
end
