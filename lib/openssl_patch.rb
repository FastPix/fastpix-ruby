# Patch Ruby's OpenSSL to use correct certificate file
# This file should be required before any SSL connections are made

require 'openssl'

# Find certificate file
CERT_FILE = if File.exist?('/opt/homebrew/etc/openssl@3/cert.pem')
              '/opt/homebrew/etc/openssl@3/cert.pem'
            elsif File.exist?('/usr/local/etc/openssl@3/cert.pem')
              '/usr/local/etc/openssl@3/cert.pem'
            elsif File.exist?('/etc/ssl/certs/ca-certificates.crt')
              '/etc/ssl/certs/ca-certificates.crt'
            elsif File.exist?('/etc/ssl/cert.pem')
              '/etc/ssl/cert.pem'
            else
              nil
            end

if CERT_FILE && File.exist?(CERT_FILE)
  # Patch OpenSSL::X509::Store to always include our certificate file
  module OpenSSL
    module X509
      class Store
        alias_method :original_set_default_paths, :set_default_paths
        
        def set_default_paths
          original_set_default_paths
          add_file(CERT_FILE) if CERT_FILE && File.exist?(CERT_FILE)
        end
      end
    end
  end
  
  # Set environment variable for any subprocesses
  ENV['SSL_CERT_FILE'] = CERT_FILE
  ENV['REQUESTS_CA_BUNDLE'] = CERT_FILE
  ENV['CURL_CA_BUNDLE'] = CERT_FILE
  ENV['RUBY_OPENSSL_CA_CERT_FILE'] = CERT_FILE
  
  # Also patch the default certificate file constant if possible
  if defined?(OpenSSL::X509::DEFAULT_CERT_FILE)
    OpenSSL::X509::DEFAULT_CERT_FILE.replace(CERT_FILE)
  end
  
  # Patch Net::HTTP to use our certificate store
  begin
    require 'net/http' unless defined?(Net::HTTP)
    
    module Net
      class HTTP
        alias_method :original_connect, :connect
        
        def connect
          original_connect
          # Ensure SSL context uses our certificate file (skip if context is frozen, e.g. Bundler)
          if use_ssl? && @ssl_context && !@ssl_context.frozen?
            store = OpenSSL::X509::Store.new
            store.set_default_paths
            store.add_file(CERT_FILE) if CERT_FILE && File.exist?(CERT_FILE)
            @ssl_context.cert_store = store
          end
        end
      end
    end
  rescue LoadError
    # Net::HTTP not available, skip
  end
  
  puts "[OpenSSL Patch] Configured SSL certificate: #{CERT_FILE}" if ENV['DEBUG']
end
