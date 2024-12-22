class RenameBookIdToPostIdInFavorites < ActiveRecord::Migration[6.1]
  def change
    rename_column :favorites, :book_id, :post_id
  end
end
