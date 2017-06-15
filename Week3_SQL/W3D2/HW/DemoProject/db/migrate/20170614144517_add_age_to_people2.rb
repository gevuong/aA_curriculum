class AddAgeToPeople2 < ActiveRecord::Migration[5.0]
  def change
    add_column :people2, :age, :integer
  end
end
