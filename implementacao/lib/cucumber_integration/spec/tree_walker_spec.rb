require 'spec_helper'
require 'tree_walker'

include CucumberFTC::CucumberIntegration
describe TreeWalker do
	it_should_require_the_right_argument_in_constructor(
		:argument_types => CucumberFTC::CucumberIntegration::Runtime,
		:class => TreeWalker
	)

	before :each do
		@runtime = create_mock_for_class(Runtime)
		@instance = TreeWalker.new(@runtime)
	end

	it 'should register a given feature and its ecp tagged scenarios' do
		feature = mock('feature')
		feature.should_receive(:accept).with(@instance)

		@instance.visit_feature(feature)
		@instance.visit_feature_name(:name,:indent_name)

		non_ecp_scenario :desc
		ecp_scenario :cenario_desc
		@instance.features.include?(:name).should be_true
		@instance.scenario_descriptions_for(:name).include?(
			:cenario_desc	
		).should be_true

		@instance.steps_for_scenario(:cenario_desc).should ==[
			{
				:keyword=> 'And',
				:name => 'other step',
				:multiline_arg => :arg
			}
		]
	end

	def non_ecp_scenario description
		visit_scenario 'description','nonecp'
		visit_steps false
	end


	def visit_scenario description,*tag_names
		scenario = create_scenario_mock("scenario #{description}")
		tags = mock('tags')
		steps = mock('steps')

		[scenario,tags].each{|node|
			node.should_receive(:accept)
		}

		@instance.visit_feature_element(scenario)
		@instance.visit_tags(tags)

		for tag in tag_names
			@instance.visit_tag_name(tag)
		end

		@instance.visit_scenario_name(
			'Scenario',description, 'line 5', 'ident'
		)
	end

	def create_scenario_mock name
		result = mock(name)
		result.stub!(:is_a?).with(
			Cucumber::Ast::Scenario
		).and_return(true)
		return result
	end


	def visit_steps should_visit
		steps = mock('steps')
		if should_visit then
			steps.should_receive(:accept).with(@instance)
		else
			steps.should_not_receive(:accept)
		end

		@instance.visit_steps(steps)
	end

	def ecp_scenario desc
		visit_scenario desc,'ecp'
		visit_steps true

		declaration_step = mock('step',
			:keyword => :Given,
			:name => :name,
			:multiline_arg => :table
		)
		ordinary_step = mock('step ordinary',
			:keyword => 'And',
			:name => 'other step',
			:multiline_arg => :arg
		)

		@instance.visit_step(declaration_step)
		@instance.visit_step(ordinary_step)
	end

end
