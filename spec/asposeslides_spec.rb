require 'spec_helper'

describe 'Asposeslides Initialization' do

  include Asposeslides

  it 'should initialize aspose and return a valid object' do
    initialize_aspose
    expect(Rjb::import('com.aspose.slides.Presentation').new).not_to be_nil
  end

  it 'should create a input file object' do
    file = File.join(File.dirname(File.dirname(__FILE__)), 'spec', 'data', 'image001.jpg')
    expect(Rjb::import('java.io.FileInputStream').new(file).java_methods).to eq(input_file(file).java_methods)
  end

end
