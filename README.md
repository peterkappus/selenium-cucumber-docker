# Selenium Cucumber Docker
This repo explains how to setup Ruby/Cucumber/Capybara tests in one docker container which drive a browser in a separate standalone Selenium  container.

See `support/env.rb` for the magic.

## Getting started

### Start the Ruby/test container
This container holds and runs the tests. From a terminal in the host run:
```
docker run -v "$(PWD)":/app -it ruby bash

# From inside the container:
cd /app
bundle
```
### Start the selenium/browser container
In another terminal window run: 
```
docker run -d -p 4444:4444 -p 5900:5900 selenium/standalone-chrome-debug
```

### Run the tests
In the Ruby container run:
```
cucumber
```

###  Connect via VNC (in OSX)
Need to see the browser in action? Connect via VNC to see it (password is '_secret_'):
```
open vnc://:secret@0.0.0.0:5900
```

You can also do this via the Finder: Go > Connect to server (cmd+k)

## Advanced usage

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
