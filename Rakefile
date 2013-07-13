require 'rake/testtask'
require './lib/report'

desc "Generate Purchase Report"
task :report do
  report = Report.new(["line_items_comma.txt", "line_items_pipe.txt"])
  report.print()  
end

Rake::TestTask.new do |t|
  t.libs = ["lib"]
  t.test_files = FileList['test/*_test.rb']
end