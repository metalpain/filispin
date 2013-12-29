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
      #results.start

      @users.times do |user|
        thread = Thread.new(user) do |user|
          run_session_for_user(user, context)
        end
        threads << thread
      end

      threads.each { |t| t.join }

      #results.finish


    end

    protected

    # run each of the concurrent sessions
    def run_session_for_user(user, context)

      session_context = {}
      session_context[:user] = user
      session_context[:params] = {}
      session_context[:browser] = Mechanize.new

      # TODO set session variables

      @iterations.times do |iteration|
        session_context[:iteration] = iteration
        @scenarios.each do |scenario|
          scenario.run session_context
        end
      end
    end


  end
end