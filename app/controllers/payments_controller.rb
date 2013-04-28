class PaymentsController < ApplicationController

  layout 'authorize_net'
  helper :authorize_net
  protect_from_forgery :except => :relay_response

  # GET
  # Displays a payment form.
  def payment

    @amount = session[:cart_total]
    @sim_transaction = AuthorizeNet::SIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], @amount, :hosted_payment_form => true)
    @sim_transaction.set_hosted_payment_receipt(AuthorizeNet::SIM::HostedReceiptPage.new(:link_method => AuthorizeNet::SIM::HostedReceiptPage::LinkMethod::GET, :link_text => 'Continue', :link_url => payments_thank_you_url(:only_path => false)))

  end
  
  # GET
  # Displays a thank you page.
  def thank_you
    @auth_code = params[:x_auth_code]
  
          session[:cart_total] = nil
 redirect_to(store_url, :notice =>
      "Thanks for your purchase! Your authorization code is #{@auth_code}." ) 
  end

end


