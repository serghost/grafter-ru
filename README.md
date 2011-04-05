# Grafter
**Grafter**  - allows you to publish your study things. You might create the price for your university or review, for future incoming members. Create a price that kills grafters!

# HOW TO TEST IT?
You must to have already installed a MySQL for working with grafter.

In terminal:

    git clone git://github.com/TimothyKlim/grafter-ru.git
    cd grafter-ru
    gem install bundler --no-ri --no-rdoc
    bundle install
    bundle exec rake db:create db:migrate db:test:prepare
    bundle exec rake cucumber:ok
    bundle exec rails s

Open the path "http://localhost:3000" in your browser.
