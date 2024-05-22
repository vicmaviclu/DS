class Pizza < ApplicationRecord
  belongs_to :pedido
  has_many :pizza_ingredientes_extra
end