require 'spec_helper'

describe PagesController do
  
  render_views

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
     app_title = I18n.t ('app_title')
     visit 'home'
     page.should have_selector("title", text: app_title)
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
  end

  describe "GET 'info'" do
    it "should be successful" do
      get 'info'
      response.should be_success
    end
  end

end
