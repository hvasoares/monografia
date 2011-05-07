require File.dirname(__FILE__)+'/module_def'
require File.dirname(__FILE__)+'/runtime'
require File.dirname(__FILE__)+'/feature_listener'

require 'rubygems'
require 'cucumber/ast/scenario'

class CucumberFTC::CucumberIntegration::TreeWalker
	attr_reader :step_mother
	attr_reader :features
	def initialize runtime
		arguments_must_be(
			runtime=>CucumberFTC::CucumberIntegration::Runtime
		)
		@step_mother = runtime
		@tags = Hash.new
		@scenario_with_ecp = false
		@features = Array.new
		@scenarios = Hash.new
		@steps = Hash.new
		@inputs_table = Hash.new
	end
	
	def inputs_declaration_for scenario
		@inputs_table[scenario].raw
	end

	def scenarios_for feature
		@scenarios[feature]	
	end

	def steps_for scenario_name
		@steps[scenario_name]
	end

	def visit_features features
		puts 'features'
		features.accept(self)
	end

	def visit_feature feature
		puts 'feature'
		@last_node = :feature
		feature.accept(self)
	end

	def visit_feature_element element
		if element.is_a?(Cucumber::Ast::Scenario) then
			puts 'detected a scenario'
			@last_node = :scenario
		end
		puts 'feature element ' + element.class.name
		element.accept(self)
	end


	def visit_scenario_name (keyword, name, file_colon_line, source_indent)
		if @scenario_with_ecp then
			@scenario_name = name
			put_into_hash(@scenarios,@feature_name,name)
		end
	end

	def visit_background_name (
		keyword, name, file_colon_line, source_indent
	)
			
	end


	def visit_feature_name name,indented_name
		puts 'feature name'
		@feature_name = name
	end

	def visit_tags tags
		puts 'tags'
		tags.accept(self)
	end

	def visit_tag_name name
		puts 'tag names ' + name
		if @last_node == :scenario and name == '@ecp' then
			puts 'this scenario is ecp'
			@scenario_with_ecp = true	
			@features.push(@feature_name)
			@step_count = 0
		end

	end

	def visit_background background
		puts 'background'
		background.accept(self)
	end

	def visit_steps steps
		if @scenario_with_ecp then
			puts 'i1m visiting steps'
			steps.accept(self)
		end
	end

	def visit_step step
		puts 'number of steps' + @step_count.to_s
		if @step_count>0 then
			puts 'registering an step'

			put_into_hash(@steps,@scenario_name,{
				:keyword => step.keyword,
				:name => step.name,
				:multiline_arg => step.multiline_arg
			})
		elsif step.name =~ /^I have the following inputs$/ then
			@inputs_table[@scenario_name]=	step.multiline_arg
		end

		@step_count +=1
	end

	def put_into_hash hash,key,value
		if not hash.has_key?(key) then
			hash[key] = Array.new
		end

		hash[key].push(value)
	end

end
