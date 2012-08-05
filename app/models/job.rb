class Job < ActiveRecord::Base
  attr_accessible :business, :posted_at, :title, :url
	
	has_many :jobs_scrapers
  has_many :scrapers, :through => :jobs_scrapers 

end
