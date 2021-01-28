class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :report, null: false, foreign_key: true
      t.text :comment
      t.string :category

      t.timestamps
    end
  end
end
