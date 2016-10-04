# HeavyControl

[![Gem Version](https://badge.fury.io/rb/heavy_control.svg)](http://badge.fury.io/rb/heavy_control)
[![Build Status](https://travis-ci.org/ffloyd/heavy_control.svg?branch=master)](https://travis-ci.org/ffloyd/heavy_control)
[![Code Climate](https://codeclimate.com/github/ffloyd/heavy_control.svg)](https://codeclimate.com/github/ffloyd/heavy_control)
[![Test Coverage](https://codeclimate.com/github/ffloyd/heavy_control/badges/coverage.svg)](https://codeclimate.com/github/ffloyd/heavy_control/coverage)
[![git.legal](https://git.legal/projects/1859/badge.svg "Number of libraries approved")](https://git.legal/projects/1859)

HeavyControl adds tools which allows you to modify Rails autoloading logic.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'heavy_control'
```

And then execute:

    $ bundle

Rails 4.2 and 5.0 are supported by this gem.

## Usage

Create initializer and place HeavyControl config inside:

```ruby
# config/initializers/heavy_control.rb
HeavyControl.config do
  # example config:
  ignore_subfolder 'operations'
  always_load 'SomeClass'
end
```

HeavyControl resolves several problems related to Rails' autoloading:

* Debugging
* Ignore subfolders while constant resolving
* 'Toplevel constant referenced' situations

### Debugging

It may be useful to debug autoloading behaviour. To enable this feature just add `debug` to HeavyControl config:

```ruby
# config/initializers/heavy_control.rb
HeavyControl.config do
  debug
end
```

And you will get logs on `DEBUG` level via `Rails.logger`. Like this:

```
HeavyControl: Load missing constant 'Organization' from Object
HeavyControl: Search for file with suffix 'organization'
HeavyControl: and found '/vagrant/app/models/organization.rb'
HeavyControl: Require of load '/vagrant/app/models/organization' with const_path 'Organization'
```

You may also turn off previously enabled debugging using `debug false`.

### Ignore subfolders

Rails automatically adds all folders under `/app` into autoloading paths. When you use constant (class, module) first time autoloading will search for file
with implementation. File path calculation is based on naming convention. So, for `YourContext::YourClass` it will be `[RAILS_ROOT]/app/[ANY_FOLDER]/your_context/your_class.rb`.

But sometimes (when we use [trailblazer](http://trailblazer.to/), as example) we want to split our files into subfolders without affecting their namespaces. In other words we want `YourContext::YourClass` to be found in `app/whatever/your_context/your_class.rb` OR `app/whatever/your_context/subfolder/your_class.rb`. To achieve this you should add `ignore_subfolder` option to HeavyControl's config:

```ruby
# config/initializers/heavy_control.rb
HeavyControl.config do
  ignore_subfolder 'subfolder'
end
```

For example lets write substitution to [trailblazer-loader](https://github.com/trailblazer/trailblazer-loader). README of this gem describes three naming and directory layout styles: _Compound-Singular_, _Explicit-Singular_ and _Explicit-Plural_.

#### Compound-Singular

It's very non-rails style. It forces us to keep from one to several class definitions in a single file. If you are using Rails I suggest you to avoid this. Currently, heavy_control doesn't support any code-placement styles where we put several classes inside one file.

#### Explicit-Singular and Explicit-Plural

This directory layout styles will work with classic rails autoloading correctly, except 'operation' and 'operations' folders. Given directories doesn't affect class namespaces. So, we will easy express this rule via `ignore_subfolder` option.

```ruby
# config/initializers/heavy_control.rb
HeavyControl.config do
  ignore_subfolder 'operation'  # singular
  ignore_subfolder 'operations' # plural
end
```

### 'Toplevel constant referenced' situations

Sometimes we can get errors related to warnings like this:

```
warning: toplevel constant YourClass referenced by YourContext::YourClass
```

Classic solution is using of `require_dependency` method. HeavyControl brings another approach: `always_load` option. Solution for given warning will be:

```ruby
# config/initializers/heavy_control.rb
HeavyControl.config do
  always_load 'YourContext::YourClass'
end
```

In other words, for `always_load` you should use constant name which displays right after 'referenced by' words in a warning text.

You may write several names separated by comma.

`always_load` differs from `require_dependency`. It explicitly resolves constant names on initalization via `constantize` (before other constants are loaded). Also it happens each reload in development.

It seems to be a bit more accurate way than `require_dependency` because constant resolving involves Rails autoloading mechanism without direct using of more "low-level" `require_dependency`. Also it guarantees that `ignore_subfolder` feature will work as expected.

## Development

This gem uses [appraisal](https://github.com/thoughtbot/appraisal) for testing against both 4.2 and 5.0 Rails versions. The command is `bundle exec appraisal rake`.

Also code inside your PR should pass [rubocop](https://github.com/bbatsov/rubocop) checks: `bundle exec rake rubocop`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ffloyd/heavy_control.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
