class Scraper < ActiveRecord::Base
  attr_accessible :name, :source, :icon

  has_many :job_scrapers
  has_many :jobs, :through => :job_scrapers

end
