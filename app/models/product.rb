class Product < ApplicationRecord
  has_one_attached :image, dependent: :purge
  serialize :size, Array
  serialize :material, Hash
  serialize :printing_type, Hash
end
