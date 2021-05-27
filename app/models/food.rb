class Food < ApplicationRecord
  belongs_to :category
  validates :description, :title, presence: true
  validates :title, uniqueness: true
  validates :price, :numericality => { :only_integer => true, :greater_than => 0 }
end
