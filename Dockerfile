FROM ruby:2.2-slim

MAINTAINER Volodymyr Kornilov <mail@terion.name>

RUN useradd -d /home/u_web -m u_web
# disable the lecture
RUN su u_web && touch ~/.sudo_as_admin_successful

RUN apt-get update -qq && apt-get install -y sudo curl build-essential
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get update -qq && apt-get install -y nodejs git-core git

RUN gem install bundler

RUN npm install -g npm
RUN npm install -g bower
RUN npm install -g gulp

RUN apt-get install -y nginx
RUN mkdir /var/www/html/build
RUN sed -i 's#root /var/www/html#root /var/www/html/build#' /etc/nginx/sites-available/default
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

CMD service nginx start