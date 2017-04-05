# Shellject

Store your secret environment variables (API keys, AWS secrets etc.) with GPGME, and inject them into your current shell when needed.

[![Build Status](https://travis-ci.org/sergei-matheson/shellject.svg?branch=master)](https://travis-ci.org/sergei-matheson/shellject)
[![Code Climate](https://codeclimate.com/github/sergei-matheson/shellject/badges/gpa.svg)](https://codeclimate.com/github/sergei-matheson/shellject)
[![Test Coverage](https://codeclimate.com/github/sergei-matheson/shellject/badges/coverage.svg)](https://codeclimate.com/github/sergei-matheson/shellject)
[![Gem Version](https://badge.fury.io/rb/shellject.svg)](http://badge.fury.io/rb/shellject)

## Installation

1. Install [GPGTools](https://gpgtools.org) on OSX and create a new key pair, if you don't have one already
1. If you have more than 1 secret key in your keyring, you may want to ensure that the 'default-key' is specified in ~/.gnupg/gpg.conf
1. Then install the gem:
  ```ruby
  # In your Gemfile
  gem 'shellject'
  ```

  And then execute:

  ```sh
  $ bundle
  ```

  Or install it yourself as:

  ```sh
  $ gem install shellject
  ```

  *You may need to brew install gpgme on mac, or use your favourite package manager in linux*

4. Finally, run

  ```sh
  $ shellject setup
  ```
  for instructions on how to set up the shell wrapper needed for injection, and, optionally, command-line completion.


## Usage

### Creating a new shelljection
   1. Create a text file with the shell code you wish to have securely injected. Here's one we prepared earlier:
     
    $ cat my-secret-stuff.sh
    >
     export SECRET_APIKEY=abc123
     export OTHER_VAR=stuff
     
   2. Save the file contents as a shelljection:
     
     $ shellject save --name stuff my-secret-stuff.sh
     
   3. Test the shelljection:
   
     $ shellject load stuff

     echo $SECRET_APIKEY # "abc123"
     
     echo $OTHER_VAR # "stuff"
   4. *REMOVE THE ORIGINAL FILE!*
   5. Now, you can securely load the environment variables whenever you wish:

     $ shellject load stuff`

### For further help and options:
`$ shellject --help`
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec shellject` to use the code located in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/sergei-matheson/shellject/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Test your changes (`bundle exec rake`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
