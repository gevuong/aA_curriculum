class CreateVisit < ActiveRecord::Migration[5.0]
  def change
    create_table :visits do |t|
      t.integer :visitor_id  # foreign key
      t.string :visited_url # foreign key
      t.timestamps
    end

    add_index :visits, :visitor_id
    add_index :visits, :visited_url
  end
end
