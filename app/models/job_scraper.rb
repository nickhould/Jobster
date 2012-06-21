class JobScraper < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :job_scraper
  belongs_to :job
  
end
