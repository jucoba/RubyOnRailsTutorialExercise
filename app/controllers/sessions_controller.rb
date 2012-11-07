class SessionsController < ApplicationController
	def new
	end

	def destroy
		sign_out
		redirect_to root_path
	end

	def create		
		user = User.find_by_email(params[:email].downcase)
		if (user && user.authenticate(params[:password]))
			#Correct
			sign_in user
			redirect_to user
		else
			#Invalid username / password
			#Se usa flash.now en lugar de flash porque el flash se quita luego del segunod request, pero el render no cuenta como request
			flash.now[:error] = t 'pages.signin.invalid_username_password'
			render 'new'
		end
		
	end
end
