class Product < ActiveRecord::Base
  attr_accessible :description, :price, :title
  validates :title, :description, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  default_scope :order => 'title'
has_many :line_items
before_destroy :ensure_not_referenced_by_any_line_item
 # after_create :welcome_mail_for_product

 def welcome_mail_for_product()
  		Notifier.welcome_mail_product(self).deliver
   end
# ensure that there are no line items referencing this product
def ensure_not_referenced_by_any_line_item
if line_items.count.zero?
return true
else
errors[:base] << "Line Items present"
return false
end
end
end
