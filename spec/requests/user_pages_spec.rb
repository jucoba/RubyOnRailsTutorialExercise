require 'spec_helper'
require 'i18n'

describe "User pages" do

	subject { page }

	describe "profile page" do
	  let ( :user ) {FactoryGirl.create( :user ) }
	  before { visit user_path(user) }

	  it { should have_selector('h1',    text: user.name) }
	  it { should have_selector('title', text: user.name) }
	end

	describe "signin" do

		before { visit signup_path }

		sign_up_text = I18n.t ('sign_up')
		
		it { should have_selector('h1', text: sign_up_text) }

		let ( :submit ) { I18n.t ('pages.signup.create_account') }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end

			describe "after submission" do
				before { click_button submit }

				it { should have_selector('title', text: sign_up_text) }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do
			testUser = User.new
			testUser.name = "Example User"
			testUser.email = "user@example.com"
			testUser.churchname = "Mi iglesia en linea"
			testUser.password = "foobar"
			testUser.password_confirmation = "foobar"
			nombre_field = I18n.t ('activerecord.attributes.user.name')
			email_field = I18n.t ('activerecord.attributes.user.email')
			churchname_field = I18n.t ('activerecord.attributes.user.churchname')
			password_field = I18n.t ('activerecord.attributes.user.password')
			password_confirmation_field = I18n.t ('activerecord.attributes.user.password_confirmation')

			before do
				fill_in nombre_field, with: testUser.name
				fill_in email_field,	with: testUser.email
				fill_in churchname_field,	with: testUser.churchname 
				fill_in password_field,	with: testUser.password
				fill_in password_confirmation_field, with: testUser.password_confirmation
			end

			it "should create a user" do
				expect {click_button submit }.to change(User, :count).by(1)							
			end

			describe "after saving the user" do
				welcome_text = I18n.t (:welcome)
				before { click_button submit }
				let(:newUser) { User.find_by_email (testUser.email) }
				it { should have_selector('title', text: newUser.name ) }
				it { should have_selector('div.alert-success', text: welcome_text) }

			end
						
		end
	end
end