class Post < ApplicationRecord
  
  belongs_to :user
  
  validates:title,presence:true, length:{maximum:50}
  validates:content,presence:true,length:{maximum:200}
 
  
  
  
end