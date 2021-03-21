class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  accepts_nested_attributes_for :categories

  has_many :comments
  has_many :users, through: :comments

  def commentor_list
    self.comments.map{|comment|comment.user}.uniq
  end

  def categories_attributes=(attributes)
    attributes.values.each do |attribute|
      if attribute["name"].present?
        category = Category.find_or_create_by(attribute)
        self.categories << category
      end
    end
  end


  def category_name=(name)
      category = Category.find_or_create_by(name:name)
      self.categories << category
  end
  
  def category_name

  end

end
