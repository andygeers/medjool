medjool
=======
Date parsing with context.

The Date.parse method in ActiveSupport method is awesome. The only thing it lacks is the ability to provide a bit more context to override what 'now' is considered to be. By default, Medjool defers date parsing directly to Date.parse. On subsequent calls, if ambiguity exists in the parsed date, it will make sure that the result is after the previously parsed date.

Usage
=====

```
  parser = Medjool::Parser.new({:now => "2013-08-26".to_date})
  parser.parse("Tuesday") => "2013-08-27"
  parser.parse("Wednesday") => "2013-08-28"
  parser.parse("Tuesday") => "2013-09-03"
```

Tests
=====
To run the tests, type:

```
  rake test
```

Deploying
=========

```
  gem build medjool
  gem push medjool-[version].gem
```

License
=======
Medjool is licensed under an MIT license.
