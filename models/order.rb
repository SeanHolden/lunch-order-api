class Order < ActiveRecord::Base
  scope :todays_orders, -> { where("created_at > DATE_SUB(NOW(), INTERVAL 1 DAY)") }
end
