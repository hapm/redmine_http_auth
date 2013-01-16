require 'redmine'

Rails.logger.info 'Starting Redmine Http Auth plugin for RedMine'
 
Redmine::Plugin.register :redmine_http_auth do
  name 'HTTP Authentication plugin'
  author 'Steve Morrissey forked from Adam Lantos'
  url 'http://github.com/uberamd/redmine_http_auth' if respond_to?(:url)
  description 'A plugin for doing HTTP authentication'
  version '0.3.1-dev-redmine-2.x'

  settings :partial => 'settings/redmine_http_auth_settings',
    :default => {
      'enable' => 'true',
      'server_env_var' => 'REMOTE_USER',
      'lookup_mode' => 'login',
      'auto_registration' => 'false',
      'keep_sessions' => 'false'
      'disable_new_accounts' => 'true',
    }
end

RedmineApp::Application.config.after_initialize do
  unless ApplicationController.include? (RedmineHttpAuth::HTTPAuthPatch)
    ApplicationController.send(:include, RedmineHttpAuth::HTTPAuthPatch)
  end
end

