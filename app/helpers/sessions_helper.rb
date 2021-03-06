module SessionsHelper

	def sign_in(user)
		#remember_token = User.new_remember_token
	  cookies.permanent[:remember_token] = user.remember_token
		#user.update_attribute(:remember_token, User.encrypt(remember_token))
	  self.current_user = user
	end

	def sign_out
    #current_user.update_attribute(:remember_token, User.encrypty(User.new_remember_token))
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def signed_in?
	  !current_user.nil?
	end

  def signed_in_admin?
    if current_user.nil?
      false
    else
      current_user.admin
    end
  end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		#remember_token = User.encrypt(cookies[:remeber_token])
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
		
	end

end
