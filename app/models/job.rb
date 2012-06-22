class Job < ActiveRecord::Base
	
	has_many :job_scrapers
  has_many :scrapers, :through => :job_scrapers 

end
