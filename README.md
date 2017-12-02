# proteus-ruby-e2e-tests
Some simple cucumber/Capybara tests in Ruby for Proteus.


## Set up

Download the chrome webdriver:
https://chromedriver.storage.googleapis.com/index.html?path=2.33/

Unzip and move the "chromedriver" executable into your path.
e.g. `sudo cp ~/Downloads/chromedriver /usr/local/bin`

Ensure you have ruby 2.0 or better
`ruby -v`

Install bundler
`gem install bundler`

NOTE: I had to `sudo chmod -R a+rwx /Library/Ruby/Gems/2.0.0/` before I could install Gems

run bundler
`bundle`

You might have to explicitly install nokogiri:
http://www.nokogiri.org/tutorials/installing_nokogiri.html#mac_os_x
(maybe install iconv `brew install libiconv`)

## Do it with docker.
....
```
docker run -v "$(PWD)":/app -it ruby bash
#inside container
cd /app
bundle
```
elsewhere...
