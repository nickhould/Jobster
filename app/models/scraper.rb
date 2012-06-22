class Scraper < ActiveRecord::Base

 has_many :job_scrapers
 has_many :jobs, :through => :job_scrapers

end
