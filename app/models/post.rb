class Post < ApplicationRecord
  
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

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

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  
end