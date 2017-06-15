class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people2 do |t|
      t.string :name, null: false # enforce every cat to be a name, will not accept null into table.
      # t.timestamps :timestamp
      t.integer :house_id, null: false
      # may be a foreign key point to a person
    end
  end
end
