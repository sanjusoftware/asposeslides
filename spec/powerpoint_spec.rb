require 'spec_helper'
require 'asposeslides/powerpoint'

describe 'Asposeslides::Powerpoint' do

  include Asposeslides
  include Asposeslides::Powerpoint

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

    context 'notes' do
      it 'should give the notes for a given slide in a ppt' do
        ppt_file = File.join(File.dirname(File.dirname(__FILE__)), 'spec', 'data', 'dest_template.pptx')
        ppt = create_ppt(ppt_file)
        expect(get_notes(ppt, 2)).to eq('NOTE1')
      end
    end

    context 'merge_ppt_files' do
      it 'should append given source presentation into destination presentation' do
        dest_ppt = File.join(File.dirname(File.dirname(__FILE__)), 'spec', 'data', 'dest_template.pptx')
        src_ppt1 = File.join(File.dirname(File.dirname(__FILE__)), 'spec', 'data', 'src_template1.pptx')

        ppt1 = create_ppt(dest_ppt)
        ppt2 = create_ppt(src_ppt1)

        merged_ppt = merge_ppt_files([dest_ppt, src_ppt1])
        expect(merged_ppt.getSlides().toArray().length).to eq(ppt1.getSlides().toArray().length + ppt2.getSlides().toArray().length)
      end
    end

    context 'merge_ppts_into_template' do

      it 'should replace a slide at a given position in destination presentation with slides from source presentation' do
        dest_ppt = File.join(File.dirname(File.dirname(__FILE__)), 'spec', 'data', 'dest_template.pptx')
        src_ppt = File.join(File.dirname(File.dirname(__FILE__)), 'spec', 'data', 'src_template1.pptx')

        ppt1 = create_ppt(dest_ppt)
        ppt2 = create_ppt(src_ppt)

        merged_ppt = merge_ppts_into_template(dest_ppt, [{:ppts => [src_ppt], :position => 4, :replace => true}])
        expect(merged_ppt.getSlides().toArray().length).to eq((ppt1.getSlides().toArray().length + ppt2.getSlides().toArray().length) - 1)
      end

      it 'should replace multiple slides at a given positions in destination presentation with slides from multiple source presentations' do
        dest_ppt = File.join(File.dirname(File.dirname(__FILE__)), 'spec', 'data', 'dest_template.pptx')
        src_ppt1 = File.join(File.dirname(File.dirname(__FILE__)), 'spec', 'data', 'src_template1.pptx')
        src_ppt2 = File.join(File.dirname(File.dirname(__FILE__)), 'spec', 'data', 'src_template2.pptx')

        ppt1 = create_ppt(dest_ppt)
        ppt2 = create_ppt(src_ppt1)
        ppt3 = create_ppt(src_ppt2)

        merged_ppt = merge_ppts_into_template(dest_ppt, [{:ppts => [src_ppt1], :position => 2, :replace => true}, {:ppts => [src_ppt2], :position => 5, :replace => true}])
        expect(merged_ppt.getSlides().toArray().length).to eq((ppt1.getSlides().toArray().length + ppt2.getSlides().toArray().length + ppt3.getSlides().toArray().length) - 2)

        merged_ppt = merge_ppts_into_template(dest_ppt, [{:ppts => [src_ppt1], :position => 2}, {:ppts => [src_ppt2], :position => 5}])
        expect(merged_ppt.getSlides().toArray().length).to eq((ppt1.getSlides().toArray().length + ppt2.getSlides().toArray().length + ppt3.getSlides().toArray().length))

        merged_ppt = merge_ppts_into_template(dest_ppt, [{:ppts => [src_ppt1, src_ppt2], :position => 2, :replace => true}, {:ppts => [src_ppt2, src_ppt1], :position => 5, :replace => true}])
        expect(merged_ppt.getSlides().toArray().length).to eq((ppt2.getSlides().toArray().length * 2) + (ppt3.getSlides().toArray().length * 2) + ppt1.getSlides().toArray().length - 2)
      end
    end
  end

end
