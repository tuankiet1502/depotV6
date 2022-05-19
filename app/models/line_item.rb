class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :cart, optional: true

  def total_price(locale)
    case locale.to_s
    when "es"
      product.price * quantity * 1.05
    else 
      product.price * quantity
    end
  end
end
