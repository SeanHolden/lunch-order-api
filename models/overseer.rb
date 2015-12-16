class Overseer < ActiveRecord::Base
  validates :user_name, presence: true
  validates :user_id, presence: true
end
