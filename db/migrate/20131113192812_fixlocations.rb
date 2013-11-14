class Fixlocations < ActiveRecord::Migration
  def up
		add_column :locations, :country, :string
		add_column :locations, :country_code, :string
		add_column :locations, :postal_code, :string
		add_column :locations, :city, :string
		add_column :locations, :political, :string
		add_column :locations, :locality, :string
		add_column :locations, :sublocality, :string
		add_column :locations, :street_address, :string
  end

  def down
  end
end
