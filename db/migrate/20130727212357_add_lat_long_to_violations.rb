class AddLatLongToViolations < ActiveRecord::Migration
  def change
    add_column :violations, :lat, :float
    add_column :violations, :long, :float
  end
end