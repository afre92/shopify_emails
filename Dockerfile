FROM ruby:2.4.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client

RUN mkdir /ultimate-mailer-embedded

WORKDIR /ultimate-mailer-embedded

COPY Gemfile /ultimate-mailer-embedded/Gemfile

COPY Gemfile.lock /ultimate-mailer-embedded/Gemfile.lock

RUN bundle install

COPY . /ultimate-mailer-embedded
