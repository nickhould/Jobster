class FixJobSourcesTableName < ActiveRecord::Migration
  def up
  	rename_table :job_scrapers, :job_sources
  end

  def down
    rename_table :job_sources, :job_scrapers
  end
end
