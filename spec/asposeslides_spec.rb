require 'spec_helper'

describe 'Aspose Slide Initialization' do

  include Asposeslides
  it 'should initialize aspose and return a valid object' do
    initialize_aspose
    expect(Rjb::import('com.aspose.slides.Presentation').new).not_to be_nil
  end

end
