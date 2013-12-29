namespace :filispin do


  desc 'Run all scenarios in performance directory'
  task :run => :environment do
    scenarios = Dir.glob('performance/scenarios/**.rb')
    Filispin.run scenarios
  end

end