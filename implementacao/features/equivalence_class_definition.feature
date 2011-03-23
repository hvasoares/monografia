@wip
Feature: writing a scenario to create a equivalence class partitioning tests

Scenario: Creating a scenario with integer ranges
	Given I wrote the following scenario:
	"""
	@ecp
	Scenario: Sum two integer numbers
		Given I had the following ecp classes:
		| class		| definition		 |	is valid?| applies_to |
		| number	| integer from 0 to 1    |	valid	 |  a,b	      |
		| invalid	| strings		 |	invalid	 |  a,b	      |
		And "c" is an integer
		When I sum "a" and "b"
		Then the result is "c"
	"""
	When I create the paritioning tests
	Then I got the generated cucumber feature:
	"""
	@ecp_valid
	Examples:
		| a | b |
		| 0 | 0 |
		| 0 | 1 |
		| 1 | 0 |
		| 1 | 1 |
	Scenario Outline: Sum two intergers
		When I sum "a" and "b"
		Then the result is "integer"
	"""


