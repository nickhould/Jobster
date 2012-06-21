class Job < ActiveRecord::Base
  attr_accessible :business, :posted_at, :title, :url
	
	has_many :job_scrapers
  has_many :scrapers, :through => :job_scrapers 

end
