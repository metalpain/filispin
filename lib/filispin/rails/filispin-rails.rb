module Filispin
  module Rails
    class Railtie < ::Rails::Railtie
      rake_tasks do
        load 'filispin/rails/tasks/filispin.rake'
      end
    end
  end
end
