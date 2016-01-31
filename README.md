# ActivityPermissionEngine

This gem provide flexible tooling for managing application permissions

It allow you to :

* Set permissions on activities (strings) for some entities like roles.
* Check for authorization

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activity_permission_engine'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activity_permission_engine

## Usage

### Configure

```ruby
ActivityPermissionEngine.configure do |config|
  config.activity_permissions_registry =  # Provide the persistence adapter from lib/adapters/activity_permissions/registry
  config.activities = ['accounting:payments:register','accounting:accounts:read'] # The list of activities, can be provided at run time.
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/activity_permission_engine/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
