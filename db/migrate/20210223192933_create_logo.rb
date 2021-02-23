class CreateLogo < ActiveRecord::Migration[6.0]
  def change
    create_table :logos do |t|
      t.string :logo
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
