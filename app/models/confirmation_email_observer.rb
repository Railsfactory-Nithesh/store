class ConfirmationEmailObserver < ActiveRecord::Observer
	observe  User
	 def after_create(user)
		 @user = user
		Notifier.welcome_mail(user).deliver
   end
 
end
