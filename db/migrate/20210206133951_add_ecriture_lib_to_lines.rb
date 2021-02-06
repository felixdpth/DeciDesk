class AddEcritureLibToLines < ActiveRecord::Migration[6.0]
  def change
    add_column :lines, :ecriture_lib, :string
  end
end
