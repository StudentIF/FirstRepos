class AddKeyToComment2 < ActiveRecord::Migration[5.1]
  def change
    add_reference :comments, :post, index: true
    add_foreign_key :comments, :posts
  end
end
