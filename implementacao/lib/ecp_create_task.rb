require 'cucumber/rake/task'

class ECPCreateTask 
	def initialize 
		Cucumber::Rake::Task.new(:ecp_create) do | t|
			t.cucumber_opts = 'features --tags @ecp'
		end
	end
end
