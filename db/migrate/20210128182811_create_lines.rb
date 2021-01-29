class CreateLines < ActiveRecord::Migration[6.0]
  def change
    create_table :lines do |t|
      t.references :report, null: false, foreign_key: true
      t.string :category
      t.date :ecriture_date
      t.integer :compte_num
      t.float :debit
      t.float :credit
      t.string :compte_lib

      t.timestamps
    end
  end
end
