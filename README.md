# Selenium Cucumber Docker
This repo provides a simple way to setup a Ruby/Cucumber/Capybara/Selenium-Chrome based BDD environment.

See `support/env.rb` for the magic.

## Quick start (tl;dr)
Open a terminal in root directory and follow these steps:
```
# Use docker compose to start start the two services
# and open a bash session in the 'ruby' service:

docker-compose run ruby bash
# Note: This could take a few min the first time you run...

# To see the browser, connect to the second container via VNC 
# The password is 'secret'.
# From the Finder: Go > Connect to server (cmd+k)

# You can also open a NEW terminal session and run this command:
open vnc://:secret@0.0.0.0:5900

# Back in the original terminal session, we're now inside our ruby service.
# Run the tests with cucumber
cucumber

# When you're done, you can exit the ruby container
exit

# Now (from the host machine) stop all the containers
docker-compose down

```

## Background
The basic components of BDD are:
- A running application to test (usually a web app)
- A web browser (like Chrome) to render the app and give access to the UI elements
- A web driver (like Selenium) to drive the browser
- A testing framework (like Capybara) to examine (and interact with) elements on the page
- A BDD framework (like Cucumber) to describe our tests (using Gherkin syntax), run them for us, and report on the results.
- Some language to define the step definitions and tie everything together (in this case, Ruby)
 
## Using Docker

[Docker compose](https://docs.docker.com/compose/) makes it easy to package all the components into a couple of simple services (containers) and mount your source code into the containers from the host, without installing anything locally.
- The first service (which we'll call 'ruby') will hold the ruby runtime and any gems we need (e.g. cucumber and capybara). We'll build this with our Dockerfile.
- The second service will be an instance of the stand-alone [Selenium-Chrome container](https://github.com/SeleniumHQ/docker-selenium).

### Seeing the browser
Because the `standalone-chrome-debug` Chrome container gives you a full Ubuntu environment, you can view (and interact with) the running browser via [VNC](https://en.wikipedia.org/wiki/Virtual_Network_Computing). This is helpful for debugging and writing new tests.



## TROUBLESHOOTING

### Getting an error that port 5900 is already allocated.
You may have "Screen sharing" enabled on your mac.
Go to "Settings" > "Sharing" and *untick* the "Screen Sharing box"


## Advanced usage

### Run tests in one step

```
docker-compose run ruby cucumber
```

### Using the 'pry' debugger.
You can add a step `And I debug` to your features to open the [pry](https://github.com/pry/pry) interactive debugger which lets you write code to interact with the browser in real-time without restarting your tests.

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

### Use Scenario Outlines
You can use "[scenario outlines](https://docs.cucumber.io/gherkin/reference/)" to quickly run through the same scenario with different variables.
