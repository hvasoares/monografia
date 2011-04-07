require 'ecp_features_translator'

describe EcpFeaturesTranslator do
 before :each do
  @feature_text = <<EOF
Feature: a feature

@ecp
Scenario: Sum two integer numbers
	Given I had the following ecp classes:
	| class	 | definition		 |	is valid?| applies_to |
	| number | integer from 0 to 1   |	valid	 |  a,b	      |
	| invalid| strings		 |	invalid	 |  a,b	      |
	And "c" is an integer
	When I sum "a" and "b"
	Then the result is "c"
EOF
 end



end
