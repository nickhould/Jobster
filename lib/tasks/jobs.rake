# encoding: utf-8
require 'rubygems' 
require 'nokogiri'
require 'open-uri'

namespace :fetch do

  desc "Fetch the jobs from all defined websites"
  task :all => [:espresso_jobs, :grenier_jobs, :infopresse_jobs]

  desc "Fetch the jobs from Espresso-Jobs"
  task :espresso_jobs => :environment do
    # Coder can define te number of pages to scrape
    number_of_pages_to_scrape = 1
    page_number = 1
    months = {"Jan" => 1, 
              "Feb" => 2,
              "Mar" => 3,
              "Avr" => 4,
              "May" => 5,
              "Jun" => 6,
              "Jul" => 7,
              "Aug" => 8,
              "Sep" => 9,
              "Oct" => 10,
              "Nov" => 11,
              "Dec" => 12}

              
    # Scraper in action            
    while page_number < number_of_pages_to_scrape+1 do
      page = Nokogiri::HTML(open("http://www.espresso-jobs.com/page/#{page_number}/"))  
      page.css('html body div#wrapper2 div#wrapper div#content-wrapper div#content div.post-wrapper').each do |post|
        
        # Create 
        title = post.css('div span.titles a').text
        job_url = post.css('div span.titles a').attribute("href").text
        business = post.css('table a').text    
        day_posted = post.css('div.date span.day').text
        month_posted = months[post.css('div.date span.month').text].to_s
        year_posted = Time.now.year.to_s
        date_posted =  year_posted + '-' + month_posted + '-' + day_posted
        if !business.empty?
          job = Job.create( title:       title.downcase,
                            business:    business.downcase,
                            posted_at:   date_posted)

          JobsScraper.create( job_id: job.id, 
                              scraper_id: 1,
                              url: job_url.downcase)

        end    
      end   
      page_number += 1
    end
    puts "Espresso-Jobs Scraped"
  end

  desc "Fetch the jobs from Grenier aux Emplois"
  task :grenier_jobs => :environment do
    #Define variables and hashes
    months = {"janvier" => 1, 
              "février" => 2,
              "mars" => 3,
              "avril" => 4,
              "mai" => 5,
              "juin" => 6,
              "juillet" => 7,
              "août" => 8,
              "septembre" => 9,
              "octobre" => 10,
              "novembre" => 11,
              "décembre" => 12}



    #Scraper in action  
    page = Nokogiri::HTML(open("http://www.grenier.qc.ca/emplois"))  
    page.css('html body.emplois div#bg_shadow div#container div#wrapper.clearfix div#content.clearfix div#main.list ul#emplois_postings li').each do |post|

      #Scrapping the H4 tag
      scrapped_h4 = post.css('h4 a').text

      #Parsing the H4 tag to split the job title and the business
      scrapped_h4 =~  %r{(.*)\s\|\s(.*)}

      #Defining the variables
      title = scrapped_h4[$2]
      business = scrapped_h4[$1]
      job_url = post.css('h4 a').attribute("href").text
      tag_list = title.split + business.split
      
      
      #Scrapping the date tag
      scrapped_raw_date = post.css('span.date').text

      #Parsing the date tag to split the day, the month and the year
      scrapped_raw_date =~ %r{\D*\s(\d*)\s(\D*)\s(\d*)\s\|\s(.*)}
      day_posted_raw = scrapped_raw_date[$1]
      month_posted_raw =  scrapped_raw_date[$2]
      year_posted = scrapped_raw_date[$3]
      city_posted = scrapped_raw_date[$4]

      # Formatting the date
      day_posted_raw =~ %r{(\d)(\d)}

      if day_posted_raw[$1].to_i == 0 
        day_posted = day_posted_raw[$2]
      else
        day_posted = day_posted_raw[$1] + day_posted_raw[$2]
      end

      month_posted = months[month_posted_raw.to_s]

      date_posted =  year_posted.to_s + '-' + month_posted.to_s + '-' + day_posted.to_s

      if !business.empty?
        job = Job.create( title:     title.downcase,
                          business:  business.downcase,
                          posted_at: date_posted)

        JobsScraper.create( job_id: job.id,
                            scraper_id: 2,
                            url: job_url.downcase)
      end
    end
    puts "Grenier-Jobs Scraped"
end

  desc "Fetch the jobs from Infopresse Jobs"
  task :infopresse_jobs => :environment do

    #Define variables and hashes
    months = {"janvier" => 1, 
              "février" => 2,
              "mars" => 3,
              "avril" => 4,
              "mai" => 5,
              "juin" => 6,
              "juillet" => 7,
              "août" => 8,
              "septembre" => 9,
              "octobre" => 10,
              "novembre" => 11,
              "décembre" => 12}
              
    #Define variables and hashes
    root_url = "http://www3.infopresse.com"
    x = 1

    #Scraper in action  
    page = Nokogiri::HTML(open("http://www3.infopresse.com/jobs/"))  
    page.css('html body #wraper #page #main #main-inner #content-area div div.view-content ul.liste-postes li').each do |post|


      # Little Hack to determine if the correct «li» was selected.
      day_posted = post.css('span.bg-block-job dl.clear-block dd.job-regular span.job-info ul li span.jour').text
      if day_posted != "" 

        #Fetching the date the job was posted
        date_posted_raw = post.css('span.bg-block-job dl.clear-block dd.job-regular li.job-date span').text    
        date_posted_raw =~ %r{(\d{1,2}).(\D*).(\d{4})}
        day_posted = date_posted_raw[$1]
        month_posted_raw = date_posted_raw[$2]
        year_posted = date_posted_raw[$3]
        month_posted = months[month_posted_raw.strip.to_s]
        date_posted =  year_posted + '-' + month_posted.to_s + '-' + day_posted.to_s  

        #Fetching the rest of the variables 
        title = post.css('span.bg-block-job dl.clear-block dd.job-regular span.job-info ul li.job-title a').text
        job_url_directory = post.css('span.bg-block-job dl.clear-block dd.job-regular span.job-info ul li.job-title a').attribute("href").text
        raw_business = post.css('span.bg-block-job dl.clear-block dd.job-regular span.job-info ul li.job-company').text
        raw_business =~ %r{(.*)\s\/(.*)}
        business =  raw_business[$1]
        city = raw_business[$2]
        job_url = root_url.to_s + job_url_directory.to_s

        #Creating the job
        job = Job.create( title:     title.downcase,
                          business:  business.downcase,
                          posted_at: date_posted)

        JobsScraper.create( job_id: job.id, 
                            scraper_id: 3,
                            url: job_url.downcase)

      end
    end
    puts "Infopresse-Jobs Scraped"
  end
end