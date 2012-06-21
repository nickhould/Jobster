class Scraper < ActiveRecord::Base
  attr_accessible :icon, :name, :source

 has_many :job_scrapers
 has_many :jobs, :through => :job_scrapers

end
