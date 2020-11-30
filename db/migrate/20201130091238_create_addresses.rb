class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string	    :zipcode,               null: false 
      t.integer	    :prefecture_id,         null: false 
      t.string	    :city,                  null: false
      t.string	    :address,               null: false
      t.string	    :address_building_name
      t.string	    :telephone,             null: false
      t.references  :purchase,          null: false, foreign_key: true

      t.timestamps
    end
  end
end
