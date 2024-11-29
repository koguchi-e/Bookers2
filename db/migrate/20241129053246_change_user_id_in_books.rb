class ChangeUserIdInBooks < ActiveRecord::Migration[6.1]
  def change
    change_column_null :books, :user_id, false
  end
end
