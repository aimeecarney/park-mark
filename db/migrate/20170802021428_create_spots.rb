class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
     t.string :date
     t.string :time
     t.string :address
     t.integer :floor
     t.string :section
     t.string :row
     t.string :spot
     t.string :note
     t.integer :user_id
   end
  end
end
