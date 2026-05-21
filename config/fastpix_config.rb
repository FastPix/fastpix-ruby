module FastPix
  module Config
    def self.server_url
      "https://api.fastpix.com/v1"
    end

    def self.live_stream_url
      "https://api.fastpix.com/v1/live"
    end

    def self.username
      ENV['FASTPIX_USERNAME'] || 'YOUR_FASTPIX_USERNAME'
    end

    def self.password
      ENV['FASTPIX_PASSWORD'] || 'YOUR_FASTPIX_PASSWORD'
    end
  end
end 