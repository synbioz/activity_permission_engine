# ActivityPermissionEngine

[![Join the chat at https://gitter.im/synbioz/activity_permission_engine](https://badges.gitter.im/synbioz/activity_permission_engine.svg)](https://gitter.im/synbioz/activity_permission_engine?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This gem provides flexible tooling for managing application permissions

It allows you to:

* Set permissions on activities (strings) for some entities like roles.
* Check for authorization

You can use it on its own but, it will fit very well with [Pundit](https://github.com/elabs/pundit) or cancan

## Installation

### Using Bundler

Add this line to your application's Gemfile:

```ruby
gem 'activity_permission_engine'
```

And then execute:

    $ bundle

### System-wide installation

    $ gem install activity_permission_engine

## Usage

### Configure

You need a persistence adapter. See [activity_permission_engine_redis](https://github.com/synbioz/activity_permission_engine_redis)

```ruby
ActivityPermissionEngine.configure do |config|
  config.activity_permissions_registry =  # Provide the persistence adapter choose from existing ones around the web or create yours
  config.activities = ['accounting:payments:register','accounting:accounts:read'] # Optional. The list of activities, can be provided at run time.
end
```

### Roles refs and activities refs

This library does not make assumptions upon roles except that they should be strings.
We do recommend to use business role from the organization chart.

eg : 'accounting:payment:register' may be allowed to 'accountant' and/or 'sales_executive'
'person:update_profile' maybe to 'it_staff:administrator'

But keep in mind to only use references (not database id). References do not changes and are easy to translate in user readable values.
( with I18n if you wish )


### Manage activities

Activities are part of code and rely on code, they can not persist they are refreshed at each application start.

eg:  'accounting:payment:register' or 'person:update_profile'

Activities can be provided at configuration time or run time. It's up to you to choose / mix strategies.

At run time you may want to create helper method that register the activity once the file is required.
At configuration time you'll likely maintain a file that contains all the activity refs.


#### Register an activity

`ActivityPermissionEngine.register_activity(#activity_ref)`

Given an activity_ref
It will add the activity_ref ( basically a string ) within the activities store.

```ruby
ActivityPermissionEngine.register_activity('accounting:payments:register')
#=> #<ActivityPermissionEngine::RegisterActivity::Response:0x0055c7cdc90f00 @success=true>
```

#### List activities

`ActivityPermissionEngine.list_activities`

Returns the list of activities. You'll need this to provide in your UI the list of activities.
The user should then allow role to perform activities.

```ruby
ActivityPermissionEngine.list_activities
#=> #<ActivityPermissionEngine::ListActivities::Response:0x0055c7cdc78d38 @activity_refs=["accounting:payments:register"]>
```


### Activity permissions

Activities permissions are persisted ( if you set the correct adapter ).
This data structure holds the role_ref allowed to perform an activity_ref

#### Allow role to perform activity

To allow a role to perform an activity use

`ActivityPermissionEngine.allow_activity(activity_ref, role_ref)`


```ruby
ActivityPermissionEngine.allow_activity('accounting:payments:register', 'accountant')
#=> #<ActivityPermissionEngine::AllowActivity::Response:0x0055c7cdc63938 @success=["accountant"]>

ActivityPermissionEngine.allow_activity('accounting:payments:register', 'sales:executives')
#=> #<ActivityPermissionEngine::AllowActivity::Response:0x0055c7cdc42828 @success=["accountant", "sales:executives"]>
```

#### Disallow role to perform activity

To disallow a role to perform an activity use

`ActivityPermissionEngine.disallow_activity(activity_ref, role_ref)`

```ruby
ActivityPermissionEngine.disallow_activity('accounting:payments:register', 'sales:executives')
#=> #<ActivityPermissionEngine::DisallowActivity::Response:0x0055c7cdc10c88 @success=["accountant"]
```

#### List existing permissions

A permission exists once you allow a user to perform an activity.

Use

`ActivityPermissionEngine.list_activities_permissions` to get a full list of existing activity permissions.

It returns a Response object that respond to `#activities_permissions` and returns an Array of activities permissions.

```ruby
response = ActivityPermissionEngine.list_activities_permissions
#=> #<ActivityPermissionEngine::ListActivitiesPermissions::Response:0x0055c7cdbe4278 @activities_permissions=[#<ActivityPermissionEngine::ActivityPermissionsRegistry::ActivityPermission:0x0055c7cdbe42a0 @activity_ref="accounting:payments:register", @role_refs=["accountant"]>]>
response.activities_permissions
#=> [#<ActivityPermissionEngine::ActivityPermissionsRegistry::ActivityPermission:0x0055c7cdbe42a0 @activity_ref="accounting:payments:register", @role_refs=["accountant"]>]
```

### Authorization check

To check for authorization you will use `ActivityPermissionEngine.check_authorization(#activity_ref, #role_refs)`
The request must respond to role_refs with an array, since most of the time a user can have many roles.
It only needs a single matching one to be authorized.

```ruby
response = ActivityPermissionEngine.check_authorization('accounting:payments:register',['accountant'])
#=> #<ActivityPermissionEngine::CheckAuthorization::Response:0x0055c7cdb95600 @authorized=true>
response.authorized?
#=> true
```

### Request objects

You are free to not use the request objects like `ActivityPermissionEngine::AllowActivity::Request`
You just need to supply an object that respond to the same methods like a struct.

But I think it could be wise to use it in order to ensure API compliance and forward compatibility.
By the way they are readonly data structures.

## Contributing

1. Fork it ( https://github.com/synbioz/activity_permission_engine/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
