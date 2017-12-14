# Selenium Cucumber Docker
Some simple cucumber/Capybara tests in Ruby for Proteus using the awesome selenium standalone docker containers to host the browsers and a ruby container for the ruby.

See `support/env.rb` for the magic.

## Do it with docker.
....
```
docker run -v "$(PWD)":/app -it ruby bash
#inside container
cd /app
bundle
```
In another terminal window:
`docker run -d -p 4444:4444 -p 5900:5900 selenium/standalone-chrome-debug`

Now in OSX open a browser to http://0.0.0.0:4444/wd/hub
Click "Create session"
Select a browser
Now in OSX go to Finder > Go > Connect to server.
enter "vnc://0.0.0.0:5900" (password is "secret")
