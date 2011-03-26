# IT'S READY TO USE?
No, it's not finished yet.

# HOW TO TEST IT?
You must to have already installed a PostgreSQL for working with grafter.

In terminal:

    git clone git://github.com/TimothyKlim/grafter-ru.git
    cd grafter.ru
    gem install bundler --no-ri --no-rdoc
    bundle install --path vendor
    bundle exec rake db:create db:migrate db:test:prepare
    bundle exec rake cucumber:ok
    bundle exec rails s

Open "http://localhost:3000" in browser.
