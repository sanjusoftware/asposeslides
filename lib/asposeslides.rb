require 'asposeslides/version'
require 'rjb'

module Asposeslides
  def initialize_aspose
    dir = File.join(File.dirname(File.dirname(__FILE__)), 'jars')
    if File.exist?(dir)
      jardir = File.join(File.dirname(File.dirname(__FILE__)), 'jars', '**', '*.jar')
    else
      jardir = File.join('.','jars', '**', '*.jar')
    end
    Rjb::load(classpath = Dir.glob(jardir).join(':'), jvmargs=['-Djava.awt.headless=true'])
  end
end
