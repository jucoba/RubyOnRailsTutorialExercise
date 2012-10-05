require 'spec_helper'

describe "LayoutLinks" do
  it "should have a Home page at '/' " do
    visit '/'    
    page.should have_selector("title",:content => "Mi Iglesia en Linea");
  end
end
