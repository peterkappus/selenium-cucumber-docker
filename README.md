# Selenium Cucumber Docker
This repo explains how to setup Ruby/Cucumber/Capybara tests in one docker container which drive a browser in a separate standalone Selenium  container.

See `support/env.rb` for the magic.

## Getting started
We're going to start two containers: one which holds chrome and the selenium hub and a second which holds ruby and runs our tests:
### Basic steps
```
# start the selenium chrome container in the background:
docker run -d -p 4444:4444 -p 5900:5900 selenium/standalone-chrome-debug

# wait while it starts up so we can connect...
sleep 3

# need to see the browser? Connect via VNC (password is 'secret')
# You can also do this via the Finder: Go > Connect to server (cmd+k)
open vnc://:secret@0.0.0.0:5900

# start a ruby container
docker run -v "$(PWD)":/app -it ruby bash

# Once inside the ruby container, install the gems:
cd /app
bundle

# run the tests
cucumber
```

## Advanced usage

### Save the state of your ruby container
Remember, you can commit the state of a running container and then restore it later so you don't have to reinstall the gems, etc:
```
# find the id of the container and copy it
docker ps

# commit it 
# for example: docker commit -m "ruby test container first commit" fed03851345a ruby_test:1
```
Run `docker commit -h` for more info on committing.

The next time you need to start the ruby container, just run
```
docker run -v "$(PWD)":/app -it ruby_test:1 bash
cd /app
```
### Go headless
If you don't need to see the browser, you can use a smaller/faster headless Selenium container:
```
docker run -d -p 4444:4444 -p 5900:5900 selenium/standalone-chrome
```

### Manually start a browser session
You can manually start a browser session in the Selenium container:

* Browse to http://0.0.0.0:4444/wd/hub
* Click "Create session"
* Select "Chrome"
* Connect via VNC (see above) `open vnc://:secret@0.0.0.0:5900`


## Cleaning up
Don't forget to kill off the browser container when you're finished. use `docker ps` to get the hash/id and then use `docker kill <ID>` to stop it.
