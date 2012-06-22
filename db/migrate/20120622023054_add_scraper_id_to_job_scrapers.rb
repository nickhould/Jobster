class AddScraperIdToJobScrapers < ActiveRecord::Migration
  def change
    add_column :job_scrapers, :scraper_id, :integer
  end
end
