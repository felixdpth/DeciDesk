class AddColumnToLines < ActiveRecord::Migration[6.0]
  def change
    add_column :lines, :sub_category, :string
  end
end
