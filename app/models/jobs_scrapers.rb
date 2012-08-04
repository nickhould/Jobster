class JobsScraper < ActiveRecord::Base
  attr_accessible :job_id, :scraper_id

  belongs_to :scraper
  belongs_to :job
  
end
