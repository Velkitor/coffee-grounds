require 'coffee-grounds/helpers/coffee-grounds_helper'
class CoffeeGroundsTasks < Rails::Railtie
  rake_tasks do
    Dir[File.join(File.dirname(__FILE__),'tasks/*.rake')].each { |f| load f }
  end
end

ActionView::Base.send :include, CoffeeGrounds::CoffeeGroundsHelper