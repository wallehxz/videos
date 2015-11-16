class Settings < Fume::Settable::Base
  # yaml_provider Rails.root.join("config/settings.yml")
  # yaml_provider Rails.root.join("spec/settings.yml") if Rails.env.test?
  ruby_provider Rails.root.join('config/settings.rb')

  def self.method_missing(name, *args, &block)
    self.settings.send(name, *args, &block)
  end

  def self.[] keys_string
    keys = keys_string.split('.')
    result = self.settings.send :[], keys.first
    keys[1..-1].each { |key| result = result.send :[], key }
    result
  end
end
