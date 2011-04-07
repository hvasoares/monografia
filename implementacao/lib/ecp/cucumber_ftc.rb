module CucumberFTC
end

module CucumberFTC::ECP
end

[
	'semantic_model'
].each{|classname|
	require File.dirname(__FILE__) + "/#{classname}"
}
