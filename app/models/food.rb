class Food < ApplicationRecord
  has_many :line_items
  belongs_to :category
  before_destroy :ensure_not_referenced_by_any_line_item
  validates :description, :title, presence: true
  validates :title, uniqueness: true
  validates :price, :numericality => { :only_integer => true, :greater_than => 0 }

  private
  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
