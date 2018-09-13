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
sleep 5

# need to see the browser? Connect via [VNC](https://en.wikipedia.org/wiki/Virtual_Network_Computing) (password is 'secret')
# You can also do this via the Finder: Go > Connect to server (cmd+k)
open vnc://:secret@0.0.0.0:5900

#build a container with the gems specified in our Gemfile and Gemfile.lock
docker build . -t ruby_test

# start it up and run cucumber
docker run -v "$(PWD)":/app -it ruby_test

```

## Advanced usage

### Using the 'pry' debugger.
You can add a step `And I debug` to your features to open the [pry](https://github.com/pry/pry) interactive debugger which lets you write code to interact with the browser in real-time without restarting your tests.

## Use Scenario Outlines
You can use "[scenario outlines](https://docs.cucumber.io/gherkin/reference/)" to quickly run through the same scenario with different variables.

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
Don't forget to kill off the browser container when you're finished with something like this:
```
docker kill $(docker ps | grep selenium/standalone-chrome | grep -o "^\w\+")
```
