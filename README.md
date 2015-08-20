# Ursuppe


## Installation

Clone this repository:

    $ git clone git@github.com:roschaefer/Ursuppe.git

Install the dependencies and setup your database:

    $ bundle
    $ rake db:migrate
    $ rake db:migrate RAILS_ENV=test

Create your [Twitter Tokens](https://apps.twitter.com/) and you will need your Spark Tokens as well. Save them in a file called 'secrets.yml'. You can use the [template](/blob/master/secrets.yml.default) of course.

In order to view the live blog you need to install the jekyll blogging framework.

## Usage

Set the ```START\_OF\_EXPERIMENT``` constant in the [Ursuppe.rb](/blob/master/ursuppe.rb).


Run:
    $ ruby loop.rb

Start jekyll in the blog folder:

    $ cd UrsuppeBlog
    $ jekyll server

Point your Browser to your [local web server](http://localhost:4000/ursuppe/).


## Development


## Contributing

1. Fork it ( https://github.com/[my-github-username]/Ursuppe/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
