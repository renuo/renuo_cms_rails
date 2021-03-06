module RenuoCmsRails
  class << self
    attr_writer :config
  end

  def self.config
    @config ||= Config.new
  end

  def self.reset
    @config = Config.new
  end

  def self.configure
    yield(config)
  end

  class Config
    attr_writer :api_host
    attr_reader :api_host
    private :api_host
    attr_accessor :api_key
    attr_accessor :private_api_key
    attr_accessor :content_path_generator

    def initialize
      self.api_host = ENV['RENUO_CMS_API_HOST']
      self.api_key = ENV['RENUO_CMS_API_KEY']
      self.private_api_key = ENV['RENUO_CMS_PRIVATE_API_KEY']
      self.content_path_generator = ->(path) { "#{path}-#{I18n.locale}" }
    end

    def api_host_with_protocol
      host = api_host
      return host if host.start_with?('https://', 'http://', '//')
      "https://#{host}"
    end
  end
end
