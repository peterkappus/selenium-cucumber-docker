require 'rspec' #for page.shoud etc
require 'capybara/cucumber'
require 'cucumber'
require 'pry'

require "selenium-webdriver"

# Ask capybara to register a driver called 'selenium'
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(
      app,

      #what browser do we want? Must match whatever is in our seleniarm stand-alone image
      browser: :firefox, 
      
      #where does it live? By passing a URL we tell capybara to use a selenium grid instance (not local)
      url: "http://#{ENV['SELENIUM_HOST']}:#{ENV['SELENIUM_PORT']}" 
  )
end

# make the driver we just registered our default driver
Capybara.default_driver = :selenium

# set the default URL for our tests
Capybara.app_host = "https://www.google.com/"
