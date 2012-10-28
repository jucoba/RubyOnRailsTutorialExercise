class SessionsController < ApplicationController
	def new
	end

	def destroy
	end

	def create
		puts params[:session][:email]
		user = User.find_by_email(params[:session][:email].downcase)
		if (user && user.authenticate(params[:session][:password]))
			#Correct
		else
			#Invalid username / password
			#Se usa flash.now en lugar de flash porque el flash se quita luego del segunod request, pero el render no cuenta como request
			flash.now[:error] = t 'pages.signin.invalid_username_password'
			render 'new'
		end
		
	end
end
