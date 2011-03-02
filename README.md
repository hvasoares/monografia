Cucumber FTC (CFTC)
=============

Introduction
------------

Cucumber TC is a set of pre-defined steps which will enable functional testing criteria (FTC) be writen with your scenarios. All you need is to define some extra steps or a example with a scenario outline.
FTC is also known blackbox testing, blackbox testing is about test an application without knowledge about its inner workings ( its classes, functions ...). It s only observing what behaviour should appear if some inputs are entered. But there is a problem: the number of possible programs inputs are often infinite, an example is if one of your inputs is integer. FTC offers a set of algorithms to choose a good set of inputs to use in your test, it not turns your application fail safe (it will be possible if you test all of inputs) but puts best practices (proven practices by practice) to secure your program.
FTC has the following technics:
+ Equivalence class partitioning
+ Boundaries values analysis
+ Pair-wise testing

Equivalence class partitioning (ECP) and Cucumber-TC
-------------
ECP tells us that inputs or outputs must be separated into sets. The inputs/outpus that have the same behaviour are grouped together. For instance, integers greater than zero and less than ten should be in the valid group.
To define a class using CFTC:
>Functionality: fatorial   
>
>Example:   
>|Class name	| class definition		|    
>| n		| integer between 0 and 10	|    
>| result	| factorial(n)			|    
>Scenario outline: a factorial with a valid number    
>	Given a number <n>     
>	When i click "do fatorial"     
>	Then i should see <result>     
