class AddLogoToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :Logo, :string
  end
end
