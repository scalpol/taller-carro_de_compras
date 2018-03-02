class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  before_save :sum
  
  def sum
    self.quantity += 1
  end
end
