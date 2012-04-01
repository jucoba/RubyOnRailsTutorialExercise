require 'spec_helper'

describe "LayoutLinks" do
  it "should have a Home page at '/' " do
    get '/'
    response.should have_selector("title",:content => "Mi Iglesia en Linea");
  end

  it 'Should have the correct links' do
    visit root_path
    click_link "Acerca de"
    response.should have_selector("title",:content => "Mi Iglesia en Linea");
  end
end
