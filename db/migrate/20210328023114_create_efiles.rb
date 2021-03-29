class CreateEfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :efiles do |t|
      t.string :ein
      t.string :name
      t.string :address1
      t.string :city
      t.string :state
      t.string :zip_code
      t.integer :tax_year
      t.timestamps
    end
  end
end
