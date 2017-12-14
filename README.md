# Selenium Cucumber Docker
Some simple cucumber/Capybara tests in Ruby for Proteus using the awesome selenium standalone docker containers to host the browsers and a ruby container for the ruby.

See `support/env.rb` for the magic.

## Do it with docker.
Start up a ruby container to run cucumber:
```
docker run -v "$(PWD)":/app -it ruby bash
#inside container
cd /app
bundle
```

Now start a container with the browsers:
`docker run -d -p 4444:4444 -p 5900:5900 selenium/standalone-chrome-debug`



### Go look!
Now in OSX go to Finder > Go > Connect to server.
enter "vnc://0.0.0.0:5900" (password is "secret")
Use this view to debug your test steps by using the developer tools in the selenium containers.

#### HINT: Don't need to see it?
Remove the '-debug' from the image name to start a (faster?) headless selenium stack.

#### Manually starting browser sessions to play with:
In case you want to start an ad-hoc session and interact with it you can use your host machine to browse to  
http://0.0.0.0:4444/wd/hub
Then click "Create session"
Select Chrome
Now in OSX go to Finder > Go > Connect to server.
enter "vnc://0.0.0.0:5900" (password is "secret")

### Run the tests:
In the ruby container:
`cucumber`

### Shutting down
Don't forget to kill off the browser container when you're finished. use `docker ps` to get the hash/id and then use `docker kill <ID>` to stop it.
