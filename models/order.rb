class Order < ActiveRecord::Base
  scope :todays_orders, -> { where("created_at >= CURDATE()") }

  def self.any?
    todays_orders.length > 0
  end

  def self.multiple?
    todays_orders.length > 1
  end
end
