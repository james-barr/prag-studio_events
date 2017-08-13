class AddLocationToRegistration < ActiveRecord::Migration[5.1]
  def change
    add_column :registrations, :location, :string
  end
end
