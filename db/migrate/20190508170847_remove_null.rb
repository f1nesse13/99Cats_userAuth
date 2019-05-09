class RemoveNull < ActiveRecord::Migration[5.2]
  def change
    remove_column :cats, :user_id
    add_column :cats, :user_id, :integer, index: true
  end
end
