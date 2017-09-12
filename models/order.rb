class Order < ActiveRecord::Base
  include ActiveModel::Validations

  before_create :remove_duplicate

  validates :text_order, presence: true

  scope :todays_orders, -> { where('created_at >= CURDATE()') }

  def self.any?
    todays_orders.length > 0
  end

  def self.multiple?
    todays_orders.length > 1
  end

  private

  def remove_duplicate
    order = Order.todays_orders.where(name: name, text_order: text_order).first
    order.destroy if order
  end
end
