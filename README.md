# Spotlight

Welcome to Spotlight, an API documentation analyzer!

## Usage

...

## Dependencies

- Ruby 2.4
- PostgreSQL 9.3

## Testing

RSpec is configured for testing. To run the tests:

```console
$ bin/rspec
```

In the tests, you have access to the `#last_response` and `#parsed_response` methods which return,
respectively, the last response object and the parsed body of the response.

## Deployment

The application is already configured for deployment on Heroku, including a release command that
runs DB migrations.

Provided that you have the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) installed,
deploying a new app should be as simple as:

```console
$ heroku create
$ figaro heroku
$ git push heroku master
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pragmarb/pragma-rails-starter.

## License

This software is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
