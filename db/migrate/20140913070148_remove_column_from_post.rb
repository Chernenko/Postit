class RemoveColumnFromPost < ActiveRecord::Migration
  def change
    remove_column :posts, :slug
    remove_column :users, :slug
    remove_column :categories, :slug
  end
end
