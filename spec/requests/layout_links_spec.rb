require 'spec_helper'

describe "LayoutLinks" do
  

  describe "Visit home page" do

  	subject { page }

  	describe "Without signin" do
  		before {visit '/'}
  		signin_link = I18n.t (:signin)
  		it { should have_selector("title",:content => "Mi Iglesia en Linea") }
  		it { should have_link(signin_link, href: signin_path) }
  	end  	
  end
end
