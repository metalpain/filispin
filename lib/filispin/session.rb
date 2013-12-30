require 'mechanize'

module Filispin

  #
  # A session is the basic configuration for a filispin performance test.
  # It is made of several scenarios that will be run sequentially a given number of times or iterations.
  #
  class Session < Scenario

    attr_reader :name, :users, :iterations, :scenarios

    def initialize(name, users, iterations, scenarios)
      @name = name
      @users = users
      @iterations = iterations
      @scenarios = scenarios
    end

    def run(context)

      threads = []

      results = initialize_results

      session_context = {}
      # TODO fill global parameters
      session_context[:results] = results

      results.start

      @users.times do |user|
        thread = Thread.new(user) do |user|
          run_session_for_user(user, session_context)
        end
        threads << thread
      end

      threads.each { |t| t.join }

      results.finish
      context[:results] << results
    end

    protected

    def initialize_results
      results = SessionResults.new @name
      @scenarios.each do |scenario|
        results << ScenarioResults.new(scenario.name)
      end
      results
    end

    # run each of the concurrent sessions
    def run_session_for_user(user, context)

      local_context = {}
      local_context[:results] = context[:results]
      local_context[:user] = user
      local_context[:params] = {}
      local_context[:browser] = Mechanize.new

      # TODO set session variables

      @iterations.times do |iteration|
        local_context[:iteration] = iteration
        @scenarios.each do |scenario|
          scenario.run local_context
        end
      end
    end


  end
end