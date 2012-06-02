require 'rake'
require "fileutils"

desc "Explaining what the task does"
namespace 'coffee-grounds' do
  task 'compile-asset'  => :environment do
    CoffeeGrounds::Grinder.new( Rails ).grind()
  end  
end
