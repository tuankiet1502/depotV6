FROM ruby:3.1.2

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  apt-get update -qq && \
  apt-get install -y vim apt-utils nodejs sqlite3 libsqlite3-dev yarn && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /depotV6
WORKDIR /depotV6
ENV RAILS_ENV production

COPY Gemfile* ./
RUN gem install bundler

ARG RAILS_MASTER_KEY=""
RUN bundle config set deployment 'true'
RUN bundle config set without 'development test'
RUN bundle install --jobs 5 --retry 3
COPY yarn.lock package.json ./
RUN yarn install
COPY . /depotV6
RUN test -z "$RAILS_MASTER_KEY" || RAILS_ENV=$RAILS_ENV bundle exec rake assets:precompile
EXPOSE 3000 80
ENTRYPOINT ["bundle", "exec"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]