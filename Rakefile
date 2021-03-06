require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rack-evil_robot"
    gem.summary = "Detect crawlers that are ignoring your robots.txt file and give them the middle finger."
    gem.description = "Robots are good, they crawl your site and bring people to it.  Evil robots are bad, they slam your site, follow links they shouldn't and generally are a pain. Using Rack::EvilRobot you can tell them what's up, and keep them away for good."
    gem.email = "shanewolf@gmail.com"
    gem.homepage = "http://github.com/gizm0duck/rack-evil_robot"
    gem.authors = ["Shane Wolf"]
    gem.add_dependency "rack"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rack-evil_robot #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
