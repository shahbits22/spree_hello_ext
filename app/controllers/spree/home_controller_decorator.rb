module Spree
  HomeController.class_eval do
  	skip_before_filter :verify_authenticity_token
    def sale
      @products = Product.joins(:variants_including_master).where('spree_variants.sale_price is not null').uniq
    end

    def new
    	@client_token = Braintree::ClientToken.generate
    end

    def create
    	nonce = params[:payment_method_nonce]
    puts nonce
   # render action: :new and return unless nonce
    result = Braintree::Transaction.sale(
      amount: "50.00",
      payment_method_nonce: nonce
    )
    @result = result
	@success = result.success?
	@transaction_id = result.transaction.id
    flash[:notice] = "Success! " if result.success?
    flash[:alert] = "The nonces have eaten your sale. #{result.transaction.processor_response_text}" unless result.success?
    #redirect_to action: :new
    render 'result'
    end
  end
end