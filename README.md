## Redis API

A simple API to allow access to a redis instance from Slack.

To set up the server, make sure to set the environment variables, potentially through a local .env file with `dotenv`

```
REDIS_HOST=REDIS_HOST_HERE
REQUIRED_TOKEN=SLACK_TOKEN_HERE
```

For development, load the app with

```
bundle exec rerun -b app.rb
```

To add an integration with Slack, after deploying somewhere, add `/redis` as a command that posts to the `/redis` endpoint of your deployed application.
