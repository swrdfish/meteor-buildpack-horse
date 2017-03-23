# Reaction Commerce Buildpack 

A heroku buildpack for [Reaction Commerce](https://reactioncommerce.com/)

To use this with your meteor app and heroku:

1. Set up your app to [deploy to heroku with git](https://devcenter.heroku.com/articles/git).
2. Set this repository as the buildpack URL:

        heroku buildpacks:set https://github.com/swrdfish/meteor-buildpack-horse.git

3. Add the MongoLab addon:
        
        heroku addons:create mongolab

4. Set the `ROOT_URL` environment variable. This is required for bundling and running the app.  Either define it explicitly, or enable the [Dyno Metadata](https://devcenter.heroku.com/articles/dyno-metadata) labs addon to default to `https://<appname>.herokuapp.com`.

        heroku config:set ROOT_URL="https://<appname>.herokuapp.com" # or other URL

Once that's done, you can deploy your app using this build pack any time by pushing to heroku:

    git push heroku master

## Environment

The following are some important environment variables for bundling and running your meteor app on heroku.  Depending on your settings, you may need to override these on heroku.  See [heroku's documentation](https://devcenter.heroku.com/articles/config-vars) for how to set these.

 - `ROOT_URL`: The root URL for your app, needed for bundling as well as running. If you enable the [Dyno Metadata](https://devcenter.heroku.com/articles/dyno-metadata) labs addon and `ROOT_URL` is undefined, it will default to `https://<appname>.herokuapp.com`).
 - `MONGO_URL`: The URL to mongodb.  It not defined, it will default the value of `MONGODB_URI`, `MONGOLAB_URI`, or `MONGOHQ_URL` (in order).  If you don't use mongolab as a regular addon (and none of the fallbacks are defined), you'll need to set this.

