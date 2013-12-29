namespace :filispin do


  desc 'Run all sessions in performance directory'
  task :run => :environment do
    sessions = Dir.glob('performance/sessions/**.rb')
    Filispin.run sessions
  end

end