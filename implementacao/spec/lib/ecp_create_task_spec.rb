require 'ecp_create_task'
require 'cucumber/rake/task'

describe ECPCreateTask do
	it 'should create a ecp test' do
		task = mock('task')
		Cucumber::Rake::Task.should_receive(:new).with(:ecp_create).and_yield(task)
		task.should_receive(:cucumber_opts=).with('features --tags @ecp')

		ECPCreateTask.new
	end
end
