require 'rake'

describe 'ecp_create_task' do

 before do
  @rake = Rake::Application.new
  Rake.application = @rake
  @lib_dir =File.dirname(__FILE__)+"/../../lib"
  Rake.application.rake_require("#{@lib_dir}/ecp_tasks.rake")
 end

 it 'should create a ecp tests' do

  search_mock = mock(EcpFeaturesSearch)
  EcpFeaturesSearch.should_receive(:new).and_return(search_mock)
  search_mock.should_receive(:do_search)

  @rake[:ecp_create].invoke
 end

end
