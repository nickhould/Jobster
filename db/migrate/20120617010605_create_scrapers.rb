class CreateScrapers < ActiveRecord::Migration
  def change
    create_table :scrapers do |t|
      t.string :name
      t.string :source
      t.string :icon

      t.timestamps
    end
  end
end
