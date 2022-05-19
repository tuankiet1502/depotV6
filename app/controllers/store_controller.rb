class StoreController < ApplicationController
  include CurrentCart 
  skip_before_action :authorize
  before_action :set_cart
  def index
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
      session[:counter] -= 1 if session[:counter]
    else
      @products = Product.all.order(:title)
      case params[:locale]
      when "es"
        @products.map do |product| 
          product.price *= 1.05
          product
        end
      else
        @product
      end
    end
    if session[:counter].nil?
      session[:counter] = 0
    else 
      session[:counter] += 1
    end
  end
end
