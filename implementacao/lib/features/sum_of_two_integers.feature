Feature: sum
	
	@ecp
	Scenario: sum
		Given I have the following inputs
			| a	| e1,e2,e3|
			| b	| integer from 0 to 10 |
			| c	| float from 0.1 to 10.4 |
		Given the first number is "<a>"
		And the second is "<b>"
