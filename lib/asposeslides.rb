require 'asposeslides/version'
require 'asposeslides/powerpoint'
require 'logger'
require 'rjb'

module Asposeslides

  class << self
    attr_accessor :aspose_slides_config
  end

  def initialize_aspose
    dir = Asposeslides.aspose_slides_config['jar_dir']

    if File.exist?(dir)
      jardir = File.join(dir, '**', '*.jar')
    else
      logger = Logger.new(STDOUT)
      logger.level = Logger::WARN
      logger.warn('Using the non licensed aspose slides jar. Please specify path to your licensed aspose slides jar directory in config/aspose.yml file!')
      jardir = File.join(File.dirname(File.dirname(__FILE__)),'jars', '**', '*.jar')
    end
    Rjb::load(classpath = Dir.glob(jardir).join(':'), jvmargs=['-Djava.awt.headless=true'])
  end


  def self.configure_aspose_slides config
    Asposeslides.aspose_slides_config = config
  end
end
