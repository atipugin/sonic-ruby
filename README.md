# sonic-ruby

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
# => OK

# Remove data from index
ingest.pop('users', 'all', 1, 'Alexander Tipugin')
# => RESULT 2

# Flush entire collection
ingest.flushc('users')
# => RESULT 1

# Flush entire bucket inside collection
ingest.flushb('users', 'all')
# => RESULT 1

# Flush specific object inside bucket
ingest.flusho('users', 'all', 1)
# => RESULT 2
```

## Searching

```ruby
# Init `search` channel
search = client.channel(:search)

# Find indexed object by term
search.query('users', 'all', 'tipugin')
# => EVENT QUERY duA0RC11 1

# Auto-complete word
search.suggest('users', 'all', 'alex')
# => EVENT SUGGEST DdwCPJ4G alexander
```

## TODO

- [ ] Take into account maximum buffer size.
- [ ] Consider using connection pool.
