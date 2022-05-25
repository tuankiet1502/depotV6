FROM ruby:3.1.2

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  apt-get update -qq && \
  apt-get install -y vim nodejs sqlite3 libsqlite3-dev yarn && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /depotV6
WORKDIR /depotV6
COPY Gemfile* ./
RUN gem install bundler

RUN bundle install 
COPY yarn.lock package.json ./
RUN yarn install
RUN rails action_text:install
RUN rails db:migrate
COPY . /depotV6

EXPOSE 3000 80
ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "server", "-b", "0.0.0.0"]