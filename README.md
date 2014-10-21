## Before Heaven: The Loft IQP - Server

* Continuous integration with TravisCI: [![Build Status](https://magnum.travis-ci.com/rossfoley/beforeheaveniqp_server.svg?token=c7NsHagfz3eNmLLAx7YR&branch=master)](https://magnum.travis-ci.com/rossfoley/beforeheaveniqp_server)
* Tracked in [Trello](https://trello.com/b/0W3jM8qL/before-heaven-iqp)
* Documents in [Google Drive](https://drive.google.com/#folders/0BxcFcGALo__7WlBuWGxBX3M5LTg)
* Source code is on [Github](https://github.com/rossfoley/beforeheaveniqp_server).
* API Documentation available on [Apiary](http://docs.beforeheaveniqp.apiary.io/)
* [Production](http://beforeheaveniqp.herokuapp.com/) on Heroku


## Project Setup

You will need the following installed:

* MongoDB
* Rails (RVM preferred)
* Bundler

You can get these via [Homebrew](http://mxcl.github.io/homebrew/) and you'll find RVM [here](https://rvm.io/).

###Environment Setup

1. `bundle install` 
    - Installs all the ruby gems needed for the project
2. `rails s` 
    - Run the test server
3. `rails c` 
    - Run the rails console
4. `bundle exec guard`
    - Start guard so that tests are run whenever a file is changed
5. Install this [Chrome extension](https://chrome.google.com/webstore/detail/railspanel/gjpfobpafnhjhbajcjgccbbdofdckggg?hl=en-US) to allow for easy debugging with the Chrome Dev Tools

## Implementing New Website Pages

To implement a new website page, run `rails g controller controller_name list_of_actions` and fill in the corresponding controller and view files.

## Implementing a New API Endpoint

1. Create a controller in the `app/controllers/api` directory that extends from `Api::BaseController`
2. Create a tests for the controller in the `spec/controllers/api` directory
3. Add the appropriate routes to `config/routes.rb`
4. Document the API Endpoint on [Apiary](https://app.apiary.io/beforeheaveniqp/editor)


## Team Roles

* Ross Foley: Server Lead
* Andrew Busch: Server Developer
* Sean MacEachern: Unity Lead
* Nathan Bryant: Unity Developer
* Andrew Han: Unity Developer
* Randy Acheson: Unity Developer


## Requirement Flow in Trello

* To Do: Requirement has been created
* Red Tag: Requirement assigned to the Unity team
* Blue Tag: Requirement assigned to the Server team
* Done: Requirement has been completed and pushed to production (in the case of server requirements)
