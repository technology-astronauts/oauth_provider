module OAuthProvider
  module Backends
    class DataMapper
      class UserAccess
        include ::DataMapper::Resource

        property :id, Serial
        property :consumer_id, Integer, :required => false
        property :request_shared_key, String, :required => false
        property :shared_key, String, :unique => true, :required => false
        property :secret_key, String, :unique => true, :required => false

        belongs_to :consumer , :model => '::OAuthProvider::Backends::DataMapper::Consumer'

        def token
          OAuthProvider::Token.new(shared_key, secret_key)
        end

        def to_oauth(backend)
          OAuthProvider::UserAccess.new(backend, consumer.to_oauth(backend), request_shared_key, token)
        end
      end
    end
  end
end
