require "#{File.dirname(__FILE__)}/../../../../test_helper"

include_fixture_resources
PoolParty::Resource.define_resource_methods

class VirtualHostTest < Test::Unit::TestCase
  def setup
    clear!
    @pool = pool :apache_test_pool do
      cloud :httpd do
        virtual_host "poolpartyrb.com"
      end
    end
    @cloud = clouds[clouds.keys.first]
    @base = DependencyResolvers::Chef
  end
  
  def teardown
    FileUtils.rm_rf test_dir
  end
  
  def test_have_apache_in_the_resources
    assert !@cloud.virtual_hosts.empty?
  end
  
end