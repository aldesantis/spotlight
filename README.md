# Spotlight

Welcome to Spotlight, an API documentation analyzer!

## Usage

TODO: Write usage instructions

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

## Possible checks

- Check operations are all documented
- Check groups, models and endpoints are ordered correctly
- Check traits are applied correctly
- Check properties are defined correctly in all endpoints
- Check model/endpoint visibility

## Todos

- [ ] Write tests for checks
