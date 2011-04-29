@tag1 @tag2 @tag3
Feature: Sum of two integers


@s_tag1 @s_tag2
Scenario: add 5 to 4
	Given i have 5
	And i have 4
	Then the result is 9
	And table step:
	| a | b |
	| c | d |

