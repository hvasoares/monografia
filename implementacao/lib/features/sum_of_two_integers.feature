Feature: sum
	
	@ecp
	Scenario: sum
		Given I have the following inputs
			| b	| integer from 0 to 10 |
			| a	| integer from 0 to 10 |
		Given the first number is "<a>"
		And the second is "<b>"
