class AddProfileAndCountryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile, :text
    add_column :users, :country, :string
  end
end
