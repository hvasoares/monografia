Feature: sum

	@ecp
	Scenario: sum
		Given I have the following inputs
			| a	| a,b,c,d|
			| a	| x,y,z	|
			| b	| integer from 0 to 10 |
			| b	| float from 100.1 to 103.0 |
			| c	| integer from 40 to 50 |
			| c	| float from 0.1 to 10.4 |

		Given the first number is "<a>"
		And the second is "<b>"
