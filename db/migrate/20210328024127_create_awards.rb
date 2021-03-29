class CreateAwards < ActiveRecord::Migration[6.1]
  def change
    create_table :awards do |t|
      t.belongs_to :efile, index: true, foreign_key: true
      t.string :ein
      t.string :name
      t.string :address1
      t.string :city
      t.string :state
      t.string :zip_code
      t.float :amount
      t.timestamps
    end
  end
end
