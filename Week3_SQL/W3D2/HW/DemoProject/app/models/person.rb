# create_table "people", force: :cascade do |t|
#   t.string  "name",     null: false
#   t.integer "house_id"
# end


class Person < ActiveRecord::Base
  # class method validates
  validates :name, :house_id, :presence => true

  belongs_to :house,
    class_name: :House,
    primary_key: :id,
    foreign_key: :house_id
end

Person.create(:name => "John Doe").valid?
Person.create(:name => nil).valid?
