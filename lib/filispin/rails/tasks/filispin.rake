namespace :filispin do


  desc 'Run all scenarios in performance directory'
  task :run => :environment do
    scenarios = Dir.glob('performance/scenarios/**.rb')
    Filispin.run_load_test ['performance/filispin_config.rb', scenarios].flatten
  end


  desc 'Run stress test'
  task :stress => :environment do
    scenarios = Dir.glob('performance/scenarios/**.rb')
    Filispin.run_stress_test ['performance/filispin_config.rb', scenarios].flatten
  end
end