class FixTableName < ActiveRecord::Migration
  def self.up
    rename_table :scrapers, :sources
  end

 def self.down
    rename_table :sources, :scrapers
 end
end
