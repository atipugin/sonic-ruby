# sonic-ruby

[![Gem Version](https://badge.fury.io/rb/sonic-ruby.svg)](https://badge.fury.io/rb/sonic-ruby)
[![Build Status](https://travis-ci.com/atipugin/sonic-ruby.svg?branch=master)](https://travis-ci.com/atipugin/sonic-ruby)
[![Maintainability](https://api.codeclimate.com/v1/badges/dcbb9919a64c96fb629c/maintainability)](https://codeclimate.com/github/atipugin/sonic-ruby/maintainability)

A Ruby client for [Sonic search backend](https://github.com/valeriansaliou/sonic).

## Installation

Add following line to your Gemfile:

```ruby
gem 'sonic-ruby'
```

And then execute:

```shell
$ bundle
```

Or install it system-wide:

```shell
$ gem install sonic-ruby
```

## Usage

Start with creating new client:

```ruby
client = Sonic::Client.new('localhost', 1491, 'SecretPassword')
```

Now you can use `#channel` method in order to connect to specific channels:

```ruby
control = client.channel(:control)
ingest = client.channel(:ingest)
search = client.channel(:search)
```

[Learn more about Sonic Channels](https://github.com/valeriansaliou/sonic/blob/master/PROTOCOL.md).

## Indexing

```ruby
# Init `ingest` channel
ingest = client.channel(:ingest)

# Add data to index
ingest.push('users', 'all', 1, 'Alexander Tipugin')
# => true

# Remove data from index
ingest.pop('users', 'all', 1, 'Alexander Tipugin')
# => 2

# Count collection/bucket/object items
ingest.count('users', 'all', 1)
# => 1

# Flush entire collection
ingest.flushc('users')
# => 1

# Flush entire bucket inside collection
ingest.flushb('users', 'all')
# => 1

# Flush specific object inside bucket
ingest.flusho('users', 'all', 1)
# => 2
```

## Searching

```ruby
# Init `search` channel
search = client.channel(:search)

# Find indexed object by term
search.query('users', 'all', 'tipugin')
# => 1

# Auto-complete word
search.suggest('users', 'all', 'alex')
# => alexander
```

## TODO

- [ ] Take into account maximum buffer size.
- [ ] Consider using connection pool.
- [x] Return more meaningful responses from commands (i.e. bool `true` instead of string `OK`, int `1` instead of string `RESULT 1` etc).
