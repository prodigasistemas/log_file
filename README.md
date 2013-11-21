# LogFile

 The basic instension of making this gem is to display the log file data in browser
for easy referencing and tracking the requests and application execution 

## Installation

Add this line to your application's Gemfile:

    gem 'log_file'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install log_file

## Usage

   add following lines to your development.rb file
       config.middleware.use LogFile::Display
  that's it now restart your app server
  go to http://localhost:port-no/log_file
  thats it you can see it in your browser  
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
