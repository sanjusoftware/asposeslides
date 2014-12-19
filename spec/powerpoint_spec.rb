require 'spec_helper'
require 'aspose4r/powerpoint'

describe 'Aspose4r::Powerpoint' do

  include Aspose4r
  include Aspose4r::Powerpoint

  context 'powerpoint' do

    before do
      initialize_aspose
    end

    context 'create' do
      it 'should create a new presentation for a given file' do
        file = File.join(File.dirname(File.dirname(__FILE__)), 'spec', 'data', 'dest_template.pptx')
        ppt = create_ppt(file)
        expect(ppt).to_not be_nil
      end
    end

    context 'merge' do
      it 'should append given source presentation into destination presentation' do
        dest_ppt = File.join(File.dirname(File.dirname(__FILE__)), 'spec', 'data', 'dest_template.pptx')
        src_ppt = File.join(File.dirname(File.dirname(__FILE__)), 'spec', 'data', 'src_template1.pptx')

        ppt1 = create_ppt(dest_ppt)
        ppt2 = create_ppt(src_ppt)

        merged_ppt = merge_ppts(dest_ppt, [{:ppt => src_ppt}])
        expect(merged_ppt.getSlides().toArray().length).to eq(ppt1.getSlides().toArray().length + ppt2.getSlides().toArray().length)
      end

      it 'should insert slides from source presentation into destination presentation at a given position' do
        dest_ppt = File.join(File.dirname(File.dirname(__FILE__)), 'spec', 'data', 'dest_template.pptx')
        src_ppt = File.join(File.dirname(File.dirname(__FILE__)), 'spec', 'data', 'src_template1.pptx')

        ppt1 = create_ppt(dest_ppt)
        ppt2 = create_ppt(src_ppt)

        merged_ppt = merge_ppts(dest_ppt, [{:ppt => src_ppt, :position => 4}])
        expect(merged_ppt.getSlides().toArray().length).to eq(ppt1.getSlides().toArray().length + ppt2.getSlides().toArray().length)
      end

      it 'should replace a slide at a given position in destination presentation with slides from source presentation' do
        dest_ppt = File.join(File.dirname(File.dirname(__FILE__)), 'spec', 'data', 'dest_template.pptx')
        src_ppt = File.join(File.dirname(File.dirname(__FILE__)), 'spec', 'data', 'src_template1.pptx')

        ppt1 = create_ppt(dest_ppt)
        ppt2 = create_ppt(src_ppt)

        merged_ppt = merge_ppts(dest_ppt, [{:ppt => src_ppt, :position => 4, :replace => true}])
        expect(merged_ppt.getSlides().toArray().length).to eq((ppt1.getSlides().toArray().length + ppt2.getSlides().toArray().length) - 1)
      end

      it 'should replace multiple slides at a given positions in destination presentation with slides from multiple source presentations' do
        dest_ppt = File.join(File.dirname(File.dirname(__FILE__)), 'spec', 'data', 'dest_template.pptx')
        src_ppt1 = File.join(File.dirname(File.dirname(__FILE__)), 'spec', 'data', 'src_template1.pptx')
        src_ppt2 = File.join(File.dirname(File.dirname(__FILE__)), 'spec', 'data', 'src_template2.pptx')

        ppt1 = create_ppt(dest_ppt)
        ppt2 = create_ppt(src_ppt1)
        ppt3 = create_ppt(src_ppt2)

        merged_ppt = merge_ppts(dest_ppt, [{:ppt => src_ppt1, :position => 2, :replace => true}, {:ppt => src_ppt2, :position => 5, :replace => true}])
        expect(merged_ppt.getSlides().toArray().length).to eq((ppt1.getSlides().toArray().length + ppt2.getSlides().toArray().length + ppt3.getSlides().toArray().length) - 2)

        merged_ppt = merge_ppts(dest_ppt, [{:ppt => src_ppt1, :position => 2}, {:ppt => src_ppt2, :position => 5}])
        expect(merged_ppt.getSlides().toArray().length).to eq((ppt1.getSlides().toArray().length + ppt2.getSlides().toArray().length + ppt3.getSlides().toArray().length))
      end
    end
  end

end
