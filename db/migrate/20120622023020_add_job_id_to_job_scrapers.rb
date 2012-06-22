class AddJobIdToJobScrapers < ActiveRecord::Migration
  def change
    add_column :job_scrapers, :job_id, :integer
  end
end
