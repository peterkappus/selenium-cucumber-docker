# Selenium Cucumber Docker
This repo provides a simple way to setup a Ruby/Cucumber/Capybara/Selenium based environment for test automation with Behaviour Driven Development (BDD).

Check out the related [blog post & video](https://www.peterkappus.com/blog/get-started-with-bdd-using-docker-and-selenium/).

## History
Feb 2023 - updated to use Selenium 4 


## Quick start (tl;dr)
Open a terminal in root directory and follow these steps:
```
# Use docker compose to start start the two services
# and open a bash session in the 'ruby' service:

docker-compose run ruby bash
# Note: This could take a few min the first time you run...

# To see inside the browser, just open http://localhost:7900/?autoconnect=1&resize=scale&password=secret

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
- A web browser (like Chrome or firefox) to render the app and give access to the UI elements
- A web driver (like Selenium) to drive the browser
- A testing framework (like Capybara) to examine (and interact with) elements on the page
- A BDD framework (like Cucumber) to describe our tests (using Gherkin syntax), run them for us, and report on the results.
- Some language to define the step definitions and tie everything together (in this case, Ruby)
 
## Using Docker

[Docker compose](https://docs.docker.com/compose/) makes it easy to package all the components into a couple of simple services (containers) and mount your source code into the containers from the host, without installing anything locally.
- The first service (which we'll call 'ruby') will hold the ruby runtime and any gems we need (e.g. cucumber and capybara). We'll build this with our Dockerfile.
- The second service (which we'll call 'browser') will be an instance of the stand-alone [Selenium-Chrome container](https://github.com/SeleniumHQ/docker-selenium).
- NOTE: for Apple silicon (e.g. the M1 chip) you'll need to use the special M1 ["seleniarm" ports.](https://github.com/seleniumhq-community/docker-seleniarm)

### Seeing the browser
You can easily open open a browser tab with a VNC client into the running container via [this link](http://localhost:7900/?autoconnect=1&resize=scale&password=secret)


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

### Use Scenario Outlines
You can use "[scenario outlines](https://docs.cucumber.io/gherkin/reference/)" to quickly run through the same scenario with different variables.
