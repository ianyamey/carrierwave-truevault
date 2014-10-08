# Carrierwave::Truevault

Adds [TrueVault](https://truevault.com) support to [CarrierWave](https://github.com/carrierwaveuploader/carrierwave)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'carrierwave-truevault', github: 'ianyamey/carrierwave-truevault'
```

And then execute:

    $ bundle

## Usage

* Create a new vault from your [TrueVault console](https://console.truevault.com/#/vaults)

* Add a configuration block in your `config/initializers/carrierwave.rb` file.

```ruby
CarrierWave.configure do |config|
  config.truevault_api_key  = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
  config.truevault_vault_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
end
```

* Set your uploader to use the `truevault` storage engine 

```ruby
class SecureFileUploader < CarrierWave::Uploader::Base
  storage :truevault
end
```

## Acknowledgements

* This work was inspired by [@codemancode](https://github.com/codemancode) and his [gem](https://github.com/codemancode/carrierwave-truevault), which is based on HTTParty.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/carrierwave-truevault/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
