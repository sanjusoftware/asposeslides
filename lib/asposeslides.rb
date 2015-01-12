require 'asposeslides/version'
require 'asposeslides/powerpoint'
require 'logger'
require 'rjb'

module Asposeslides

  class << self
    attr_accessor :aspose_slides_config
  end

  def initialize_aspose
    aspose_jars_dir = Asposeslides.aspose_slides_config ? Asposeslides.aspose_slides_config['jar_dir'] : nil
    aspose_license_path = Asposeslides.aspose_slides_config ? Asposeslides.aspose_slides_config['license_path'] : nil

    load_aspose_jars(aspose_jars_dir)
    load_aspose_license(aspose_license_path)
  end

  def load_aspose_license(aspose_license_path)
    if aspose_license_path && File.exist?(aspose_license_path)
      set_license(File.join(aspose_license_path))
    else
      logger = Logger.new(STDOUT)
      logger.level = Logger::WARN
      logger.warn('Using the non licensed aspose slides jar. Please specify path to your aspose license directory in config/aspose.yml file!')
    end
  end

  def load_aspose_jars(aspose_jars_dir)
    if aspose_jars_dir && File.exist?(aspose_jars_dir)
      jardir = File.join(aspose_jars_dir, '**', '*.jar')
    else
      jardir = File.join(File.dirname(File.dirname(__FILE__)), 'jars', '**', '*.jar')
    end
    Rjb::load(classpath = Dir.glob(jardir).join(':'), jvmargs=['-Djava.awt.headless=true'])
  end

  def input_file(file)
    Rjb::import('java.io.FileInputStream').new(file)
  end

  def set_license(aspose_license_file)
    begin
      fstream = input_file(aspose_license_file)
      license = Rjb::import('com.aspose.slides.License').new()
      license.setLicense(fstream)
    rescue Exception => ex
      logger = Logger.new(STDOUT)
      logger.level = Logger::ERROR
      logger.error("Could not load the license file : #{ex}")
      fstream.close() if fstream
    end

  end

  def self.configure_aspose_slides config
    Asposeslides.aspose_slides_config = config
  end

end
