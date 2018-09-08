require 'rspec' #for page.shoud etc
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'pry'

#if you're accessing an internal app behind a firewall, you may not need the proxy. You can unset it like so:
#ENV['HTTP_PROXY'] = ENV['http_proxy'] = nil

#get IP of host which has 4444 mapped from other container
docker_ip = %x(/sbin/ip route|awk '/default/ { print $3 }').strip

Capybara.register_driver :remote_chrome do |app|
  Capybara::Selenium::Driver.new(app,
  :browser => :remote,
  :desired_capabilities => :chrome,
  :url => "http://#{docker_ip}:4444/wd/hub")
end

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :remote_chrome
  config.app_host = 'http://www.google.com' # change this to point to your application
end
