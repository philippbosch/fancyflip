require 'liquid'
require 'sinatra'
require 'yaml'

app_config = open(File.join(File.dirname(__FILE__), 'config.yml')) {|f| YAML.load(f)}

configure do
  set :environment, :development
  set :public_folder, Proc.new { root }
  set :views, Proc.new { root }
end

get '/' do
  liquid :index, :locals => {
    :debug => settings.environment == :development,
    :app_name => app_config['app_name'],
    :app_title => app_config['app_title']
  }
end