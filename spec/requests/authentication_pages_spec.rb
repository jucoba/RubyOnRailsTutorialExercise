require 'spec_helper'

describe "AuthenticationPages" do
	subject {page}
	header = I18n.t ('pages.signin.header')
	email_field = I18n.t ('activerecord.attributes.user.email')
  	password_field = I18n.t ('activerecord.attributes.user.password')
  	title = I18n.t ('pages.signin.title')

  	describe "Sign in page" do
  		before { visit signin_path }
  		
  		
  		
    	it { should have_selector('title', text: title) }    	  
    	it { should have_selector('h1', text: header) }

    end

	describe "Sign" do
  		before { visit signin_path }
  		submit_button = I18n.t ('pages.signin.submit_button')

  		describe "with invalid information" do
      	before { click_button submit_button }
      		it { should have_selector('title', text: title) }
      		it { should have_selector('div.alert.alert-error') }

      		describe "after visting another page" do
      			before {click_link I18n.t(:home)}
      			it {should_not have_selector('div.alert.alert-error')}
      		end
    	end

    	describe "with valid information" do
    		let (:user) {FactoryGirl.create(:user)}
    		before do
    			fill_in email_field, with: user.email
				fill_in password_field,	with: user.password
				click_button submit_button
    		end
    		profile_link = I18n.t ('profile')
    		signout_link = I18n.t (:signout)
    		signin_link = I18n.t (:signin)
    		
    		it { should have_selector('title', text: user.name) }
    		it { should have_link(profile_link, href: user_path(user))}    		
    		it { should_not have_link(signin_link, href: signin_path)}

    		describe "followed by signout" do
    			before { click_link signout_link}
    			it { should have_link(signin_link)}
    		end

    	end

  	end    

  	#describe "Sign out page" do
  	#	before { visit signout_path }
  	#	title = I18n.t ('pages.signout.title')
  		

    #	it { should have_selector('title', text: title) }    	      	 
  	#end
end
