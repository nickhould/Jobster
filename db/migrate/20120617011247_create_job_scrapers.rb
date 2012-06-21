class CreateJobScrapers < ActiveRecord::Migration
  def change
    create_table :job_scrapers do |t|

      t.timestamps
    end
  end
end
