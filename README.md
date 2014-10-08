# Carrierwave::Truevault

Adds [TrueVault](https://truevault.com) support to [CarrierWave](https://github.com/carrierwaveuploader/carrierwave)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'carrierwave-truevault'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install carrierwave-truevault

## Usage

Add a configuration block in your `config/initializers/carrierwave.rb` file.

```ruby
CarrierWave.configure do |config|
  config.truevault_api_key  = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
  config.truevault_vault_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
end
```

Set your uploader to use the `truevault` storage engine 

```ruby
class SecureFileUploader < CarrierWave::Uploader::Base
  storage :truevault
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/carrierwave-truevault/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
