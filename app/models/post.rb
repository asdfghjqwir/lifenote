class Post < ApplicationRecord
  
  belongs_to :user
  has_many :post_comments, dependent: :destroy

  validates:title,presence:true, length:{maximum:50}
  validates:content,presence:true,length:{maximum:200}
 
  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content)
    elsif method == 'forward'
      Post.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Post.where('title LIKE ?', '%'+content)
    else
      Post.where('title LIKE ?', '%'+content+'%')
    end
  end
  
  
end