class AddForeignKeyToBooksUserId < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :books, :users, column: :user_id
  end
end
