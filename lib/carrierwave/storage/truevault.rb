require 'rest_client'

module CarrierWave
  module Storage
    ##
    # Stores blobs using TrueVault.
    #
    # You need to setup some options to configure your usage:
    #
    #     CarrierWave.configure do |config|
    #       config.truevault_api_key  = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
    #       config.truevault_vault_id = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
    #     end
    #
    class TrueVault < Abstract
      ##
      # Store a file
      #
      # === Parameters
      #
      # [file (CarrierWave::SanitizedFile)] the file to store
      #
      # === Returns
      #
      # [CarrierWave::Storage::TrueVault::File] the stored file
      #
      def store!(file)
        f = CarrierWave::Storage::TrueVault::File.new(api_key, vault_id)
        f.store(file) && update_identifier!(f.blob_id)
        f
      end

      ##
      # Retrieve a file
      #
      # === Parameters
      #
      # [identifier (String)] unique identifier for file
      #
      # === Returns
      #
      # [CarrierWave::Storage::TrueVault::File] the stored file
      #
      def retrieve!(identifier)
        CarrierWave::Storage::TrueVault::File.new(api_key, vault_id, identifier)
      end

      private

      ##
      # Update the model's identifier
      #
      # Since TrueVault generates the blob_id *after* we save the blob,
      # we need to update the underying AR model with the newly generated uuid.
      #
      # === Parameters
      # [identifier (String)] new identifier for file
      #
      def update_identifier!(identifier)
        uploader.model.update_column(uploader.mounted_as, identifier)
      end

      def vault_id
        uploader.truevault_vault_id
      end

      def api_key
        uploader.truevault_api_key
      end

      class File
        include CarrierWave::Utilities::Uri

        attr_accessor :blob_id

        def initialize(api_key, vault_id, blob_id = nil)
          @api_key = api_key
          @vault_id = vault_id
          @blob_id = blob_id
        end

        ##
        # Read content of file from service
        #
        # === Returns
        #
        # [String] contents of file on success or raises error
        #
        def read
          client["/vaults/#{vault_id}/blobs/#{blob_id}"].get
        end

        ##
        # Read content type of file from service
        #
        # === Returns
        #
        # [String] content type of the file
        #
        def content_type
          headers[:content_type]
        end

        ##
        # Return size of file body
        #
        # === Returns
        #
        # [Integer] size of file body
        #
        def size
          headers[:content_length].to_i
        end

        def path
          filename
        end

        ##
        # Reads the original filename from the service
        #
        # Since TrueVault stores blobs with a uuid, we read the filename from
        # the metadata (eg `Content-Disposition: attachment; filename=abc.txt`)
        #
        # === Returns
        #
        # [Integer] size of file body
        #
        def filename
          c = headers[:content_disposition]
          c && c.match(/filename=(\"?)(.+)\1/)[2]
        end

        ##
        # Write file to service
        #
        # === Returns
        #
        # [Boolean] true on success or raises error
        #
        def store(new_file)
          res = client["/vaults/#{vault_id}/blobs"].post file: new_file.to_file
          json = JSON.parse(res)
          self.blob_id = json['blob_id']
          true
        end

        private

        attr_reader :api_key, :vault_id

        def headers
          client["/vaults/#{vault_id}/blobs/#{blob_id}"].head.headers
        end

        def client
          @client ||= RestClient::Resource.new base_uri, api_key, nil
        end

        def base_uri
          'https://api.truevault.com/v1'
        end
      end
    end
  end
end
