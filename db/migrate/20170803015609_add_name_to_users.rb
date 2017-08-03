class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :spots, :name, :string
  end
end
