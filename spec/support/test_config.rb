require 'yaml'

module TestConfig
  def self.load
    config_path = File.join(File.dirname(__FILE__), '..', 'config', 'test_config.yml')
    YAML.load_file(config_path)
  end

  def self.server_url
    load['server']['url']
  end

  def self.username
    load['server']['username']
  end

  def self.password
    load['server']['password']
  end

  def self.timeout
    load['server']['timeout']
  end
end 