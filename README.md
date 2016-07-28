# Install Rails
[![Build Status](https://travis-ci.org/onemonth/install_rails.png?branch=master)](https://travis-ci.org/onemonth/install_rails)

Patches welcome.

## Setup

After following the instructions on [the site](http://installrails.com), run

```bash
rvm install 2.3.1

# if you don't already have MongoDB
brew update
brew install mongodb

bundle install
rails server
```

Open http://localhost:3000 in your browser.
