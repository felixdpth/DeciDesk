class AddPhotoToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :business, :string
  end
end
