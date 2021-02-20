class AddTitleToComment < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :title, :text
  end
end
