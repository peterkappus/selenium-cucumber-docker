#start with the base ruby image
FROM ruby

#always a good idea to update and have an editor
RUN apt-get update; apt-get install -y vim

#make sure we have a folder called /app
RUN mkdir /app

#cd into our app folder each time we start up
WORKDIR /app

#copy our Gemfile and Gemfile.lock
COPY Gemfile* /app/

#install the gems
RUN bundle

CMD cucumber
