require File.join(File.dirname(__FILE__), 'test_helper')

class GemThisTest < Test::Unit::TestCase
  context "When building a gem" do
    setup do
      build_gem do
        touch "README"
        touch "lib/thing.rb"
        touch "lib/thing/some/aspect/many/levels/deep.rb"
      end
    end

    should "contain lib files" do
      assert_gem_contains "lib/thing.rb"
    end
    
    should "contain deeply nested files" do
      assert_gem_contains "lib/thing/some/aspect/many/levels/deep.rb"
    end

    should "include the README" do
      assert_gem_contains "README"
    end

    should "put lib in require path" do
      assert_gem_spec :require_paths, ["lib"]
    end
  end
  
  context "When building a gem with tests" do
    setup do
      build_gem do
        touch "lib/thing.rb"
        touch "test/thing_test.rb"
      end
    end

    should "contain test files" do
      assert_gem_contains "test/thing_test.rb"
    end
    
    should "create a rake task for running tests" do
      assert_rake_task :test
    end
    
  end

  context "When building a gem with specs" do
    setup do
      build_gem do
        touch "lib/thing.rb"
        touch "spec/my_spec.rb"
      end
    end
    
    should "contain spec files" do
      assert_gem_contains "spec/my_spec.rb"
    end

    should "create a rake task for running specs" do
      assert_rake_task :spec
    end
  end

  context "When building a gem with features" do
    setup do
      build_gem do
        touch "lib/thing.rb"
        touch "features/gem-this.feature"
      end
    end

    should "create a rake task for running features" do
      assert_rake_task :features
    end

    should "add a features task to the default rake task dependencies" do
      assert_default_rake_task_dependencies_contains :features
    end
  end

  context "When building a gem without a lib directory" do
    setup do
      create_gem do
        touch "code/my_code_is_in_here_for_some_reason.rb"
      end
    end

    should "not build the gem" do
      assert_doesnt_hang do
        assert !@gem.build # the real test is whether or not this returns at all.
      end
    end
  end

  context "When the user has a .gem-this file" do
    setup do
      create_gem_this_file %{
desc "Something for my gems"
task :custom_task do
end
      }
      build_gem do
        touch "README"
        touch "lib/thing.rb"
      end
    end

    should "include custom tasks in the Rakefile" do
      assert_rake_task :custom_task
    end
  end
end
