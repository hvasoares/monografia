require 'ecp_features'

describe EcpFeatures do
 before :each do
  @feature_ecp_file = <<EOF 
Feature: a feature_name

@ecp
Scenario:
	Given step 1
	When step 2
	Then step 3
EOF

  @non_ecp_file = <<EOF
Feature: non ecp

Scenario:
	Given step1
	When step2
	Then step3
EOF
  @instance = EcpFeatures.new
  @feature_ecp_filename = 'ecp.feature'
  @non_ecp_filename = 'non_ecp.feature'
 end

 it 'should search for ecp tagged features' do
  Dir.should_receive(:foreach).with('./features').and_yield(
    @feature_ecp_filename
   ).and_yield(
    @non_ecp_filename
   )

  {
  	@feature_ecp_filename => @feature_ecp_file,
	@non_ecp_filename => @non_ecp_file
  }.each{|filename,content|
	 File.should_receive(:open).with(
		"./features/#{filename}"
	  ).and_return(
		mock(File,:read=>content)
	  )
  }
 
  @instance.do_search().should == [@feature_ecp_filename]
 end

end
