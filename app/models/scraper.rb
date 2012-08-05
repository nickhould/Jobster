class Scraper < ActiveRecord::Base
  attr_accessible :name, :source, :icon

  has_many :jobs_scrapers
  has_many :jobs, :through => :jobs_scrapers

end
