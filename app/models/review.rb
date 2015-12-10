class Review < ActiveRecord::Base
  belongs_to :product
  validates :rating, presence: true, inclusion: 1..5
end
