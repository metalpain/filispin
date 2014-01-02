require 'filispin/rails/filispin-rails'


module Filispin
  autoload :Config, File.dirname(__FILE__) + '/filispin/config'
  autoload :Block, File.dirname(__FILE__) + '/filispin/block'
  autoload :OnceBlock, File.dirname(__FILE__) + '/filispin/once_block'
  autoload :Results, File.dirname(__FILE__) + '/filispin/results'
  autoload :Runner, File.dirname(__FILE__) + '/filispin/runner'
  autoload :Scenario, File.dirname(__FILE__) + '/filispin/scenario'
  autoload :Request, File.dirname(__FILE__) + '/filispin/operations/request'
  autoload :ThinkFor, File.dirname(__FILE__) + '/filispin/operations/think_for'
  autoload :Format, File.dirname(__FILE__) + '/filispin/util/format'
  autoload :Parameters, File.dirname(__FILE__) + '/filispin/util/parameters'
  autoload :Progress, File.dirname(__FILE__) + '/filispin/util/progress'
  autoload :Stats, File.dirname(__FILE__) + '/filispin/util/stats'
  autoload :Timer, File.dirname(__FILE__) + '/filispin/util/timer'
  autoload :BlockBuilder, File.dirname(__FILE__) + '/filispin/dsl/block_builder'
  autoload :OnceBlockBuilder, File.dirname(__FILE__) + '/filispin/dsl/once_block_builder'
  autoload :GlobalConfig, File.dirname(__FILE__) + '/filispin/dsl/global_config'
  autoload :ScenarioBuilder, File.dirname(__FILE__) + '/filispin/dsl/scenario_builder'


  def self.run_load_test(files)
    config = Config.load files
    Runner.new(config).run_load_test
  end

  def self.run_stress_test(files)
    config = Config.load files
    Runner.new(config).run_stress_test
  end
end
