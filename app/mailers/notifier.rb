class Notifier < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_received.subject
  #
  def order_received(user)
@user = user
ActionMailer::Base.mail(:from => "kumarnithesh61@gmail.com", :to => "nitheshk@railsfactory.org", :subject => "Adding new product", :body => "the product is added into the list").deliver
end
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_shipped.subject
  #
  def order_shipped
    @greeting = "Hi"

    mail to: "to@example.org"
  end
  
  
  def welcome_mail(user)
    @user = user
    @url  = "http://0.0.0.0:3000/login"
    mail(:from => "kumarnithesh61@gmail.com", :to => user.email_id, :subject => "Welcome to Online Store").deliver
    end


def welcome_mail_product(product)
  ActionMailer::Base.mail(:from => "kumarnithesh61@gmail.com", :to => "nitheshk@railsfactory.org", :subject => "Added new product", :body => "New product is added into the product list").deliver
end
end