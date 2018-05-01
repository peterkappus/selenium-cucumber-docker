# Selenium Cucumber Docker
This repo shows how to setup Ruby/Cucumber/Capybara tests in one docker container but using the browsers in another standalone selenium grid container.

See `support/env.rb` for the magic.

## Start ruby/test container
```
docker run -v "$(PWD)":/app -it ruby bash

#inside the container run:
cd /app
bundle
```
## Start the selenium/browser container
In another terminal window: 
```
docker run -d -p 4444:4444 -p 5900:5900 selenium/standalone-chrome-debug
```

##  Connect/view the browser via VNC (in OSX)
```
open vnc://:secret@0.0.0.0:5900
```

You can also do this via the Finder: Go > Connect to server (cmd+K)

### Hint: Go headless
```
docker run -d -p 4444:4444 -p 5900:5900 selenium/standalone-chrome
```

## Manually starting browser sessions to play with:
You can start a session on the selenium machine manually:

* Browse to http://0.0.0.0:4444/wd/hub
* Click "Create session"
* Select "Chrome"
* Connect via VNC (see above) `open vnc://:secret@0.0.0.0:5900`

## Run the tests:
In the ruby container run:
```
cucumber
```

## Cleaning up
Don't forget to kill off the browser container when you're finished. use `docker ps` to get the hash/id and then use `docker kill <ID>` to stop it.
