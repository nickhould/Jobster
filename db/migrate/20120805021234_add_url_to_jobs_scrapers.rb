class AddUrlToJobsScrapers < ActiveRecord::Migration
  def change
    add_column :jobs_scrapers, :url, :string
  end
end
