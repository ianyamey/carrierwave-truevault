require 'carrierwave'
require 'carrierwave/storage/truevault'
require 'carrierwave/truevault/version'

class CarrierWave::Uploader::Base
  add_config :truevault_api_key
  add_config :truevault_vault_id

  configure do |config|
    config.storage_engines[:truevault] = 'CarrierWave::Storage::TrueVault'
  end
end
