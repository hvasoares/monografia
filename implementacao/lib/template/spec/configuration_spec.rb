require 'configuration'
include CucumberFTC::Template
describe CucumberFTC::Template::Configuration do
	before :each do
		@instance  = Configuration.new
	end
	it 'should create an feature' do
		Feature.should_receive(:new).with(
			"./feature_template.erb",
			'destination'
		)

		@instance.feature('destination')	
	end
end
