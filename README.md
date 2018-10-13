# Install Rails
[![Build Status](https://travis-ci.org/onemonth/install_rails.png?branch=master)](https://travis-ci.org/onemonth/install_rails)

Patches welcome.

## Setup in your local

1. After following the instructions on [the site](http://installrails.com), run

   ```bash
   rvm install 2.4.4
   ```

2. If you don't already have MongoDB, then run:

   ```sh
   brew update
   brew install mongodb
   ```

3. Enter into the project folder with:

   ```sh
   cd install_rails
   ```

4. Install its dependencies, run:

   ```ruby
   gem install bundler
   bundle install
   ```

5. You're good to go, set it live by running:

   ```ruby
   rails server
   ```

6. Open `http://localhost:3000` in your browser.

## Contributing

 1. Fork it
 2. Clone to your local (`git clone git@github.com:onemonth/install_rails.git`)
 3. Create your feature branch (`git checkout -b my-new-feature`)
 4. Commit your changes (`git commit -am 'Add some feature'`)
 5. Push to the branch (`git push origin my-new-feature`)
 6. Create new Pull Request
