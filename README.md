# Install Rails
[![Build Status](https://travis-ci.org/onemonth/install_rails.png?branch=master)](https://travis-ci.org/onemonth/install_rails)

Patches welcome.

## Setup

After following the instructions on [the site](http://installrails.com), run

```bash
rvm install 2.0.0

# if you don't already have MongoDB
brew update
brew install mongodb

bundle install
rails server
```

Run `open http://localhost:3000` in a new Terminal window or open the address in your browser.
