def dev_path
	 File.dirname(__FILE__)+"/../../lib"
end

def test_env_path
	File.dirname(__FILE__)+"/../test_env"
end

def create_feature_file filename
	File.open("#{test_env_path}/features/#{filename}.feature","w")
end

def create_func_string_containing scenario_string
<<EOF
Feature: a func

#{scenario_string}
EOF

end


Before do
	FileUtils::cp_r(dev_path,test_env_path+"/cucumberftc")
	FileUtils::mkdir(test_env_path+"/features")
end

After do
	FileUtils::rm_rf(test_env_path+"/cucumberftc")
	FileUtils::rm_rf(test_env_path+"/features/")
end

Given /^I wrote the following scenario:$/ do |scenario|
	@file_name = Time.new.to_i
	feature_file = create_feature_file(@file_name)
	feature_file.write(create_func_string_containing(scenario))
	feature_file.close
end

When /^I create the paritioning tests$/ do
	system(
<<EOF
	cd #{test_env_path} && rake cucumber_ftc:ecp_create
EOF
	).should == true
end

Then /^I got the generated cucumber feature:$/ do |expected_scenario|
	generated_feature_file = File.open("#{test_env_path}/features/#{@file_name}.ftc.feature")
	generated_feature_text = generated_feature_file.read
	generated_feature_file.close
	generated_feature_text.should == create_func_string_containing(expected_scenario)
end
