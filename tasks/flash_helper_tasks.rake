namespace :flash_helper do
  PLUGIN_ROOT = File.dirname(__FILE__) + '/../'
  
  desc 'Install sample CSS file for flash messages.'
  task :install do
    FileUtils.cp Dir[PLUGIN_ROOT + '/assets/stylesheets/*.css'], RAILS_ROOT + '/public/stylesheets'
    p "Flash messages stylesheet added."
  end
 
  desc 'Remove sample CSS file for flash messages..'
  task :remove do
    FileUtils.rm %{flash_helper.css}.collect { |f| RAILS_ROOT + "/public/stylesheets/" + f  }
    p "Flash messages stylesheet deleted."
  end
end