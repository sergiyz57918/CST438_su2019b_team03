class Order < ApplicationRecord
    validates :itemId, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :description, presence: true
    validates :customerId, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :price, presence: true, numericality: { greater_than: 0 }
end
