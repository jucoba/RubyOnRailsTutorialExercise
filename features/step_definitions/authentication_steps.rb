Given /^a user visits the signin page$/ do
  visit signin_path
end

When /^he submits invalid signin information$/ do
  click_button I18n.t('pages.signin.submit_button')
end

Then /^he should see an error message$/ do
  page.should have_selector('div.alert.alert-error')
end

Given /^the user has an account$/ do
  @user = FactoryGirl.create(:user) 
end

Given /^the user submits valid sigin information$/ do
  email_field = I18n.t ('activerecord.attributes.user.email')
  password_field = I18n.t ('activerecord.attributes.user.password')
  fill_in email_field, with: @user.email
  fill_in password_field,	with: @user.password
  click_button I18n.t('pages.signin.submit_button')
end

Then /^he should see his profile page$/ do
	profile_link = I18n.t ('profile')
	signout_link = I18n.t (:signout)
	signin_link = I18n.t (:signin)
	page.should have_selector('title', text: @user.name)	
	page.should have_link( profile_link, href: user_path(@user) )
	page.should_not have_link(signin_link, href: signin_path)
	
end

Then /^se should see a signout link$/ do
	signout_link = I18n.t (:signout)
	page.should have_link(signout_link, href: signout_path)
end

