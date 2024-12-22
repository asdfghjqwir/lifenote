class RenameBookIdToPostIdInFavorites < ActiveRecord::Migration[6.1]
  def change
    if column_exists?(:favorites, :book_id) && !column_exists?(:favorites, :post_id)
    rename_column :favorites, :book_id, :post_id
    end
  end
end
