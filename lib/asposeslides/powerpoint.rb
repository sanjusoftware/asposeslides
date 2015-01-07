module Asposeslides
  module Powerpoint

    def create_ppt(file = nil)
      file ? Rjb::import('com.aspose.slides.Presentation').new(file) : Rjb::import('com.aspose.slides.Presentation').new
    end

    def get_notes(ppt, index)
      slide = ppt.getSlides().get_Item(index)
      slide.getNotesSlide() ? slide.getNotesSlide().getNotesTextFrame().getText() : ''
    end

    def merge_ppts_into_template(dest_ppt_path, src_ppt_options)
      destPres = create_ppt(dest_ppt_path)
      offset_position = 0

      src_ppt_options.each do |ppt_option|
        src_ppt_paths = ppt_option[:ppts]

        if src_ppt_paths && src_ppt_paths.size > 0
          srcPres = merge_ppt_files(src_ppt_paths)
        else
          next
        end

        position = ppt_option[:position]
        replace = ppt_option[:replace]

        dest_slides = destPres.getSlides()
        src_slides = srcPres.getSlides()

        if position
          dest_slides.remove(dest_slides.get_Item(position + offset_position)) if replace
          (0..src_slides.toArray().length-1).map{|i| dest_slides.insertClone(position + offset_position + i, src_slides.get_Item(i))}

          offset_position = offset_position + (replace ? (src_slides.toArray().length - 1) : (src_slides.toArray().length))

        else
          (0..src_slides.toArray().length-1).map{|i| dest_slides.addClone(src_slides.get_Item(i))}
        end
      end
      destPres
    end

    def merge_ppt_files(ppt_paths)
      merged_ppt = create_ppt()
      merged_ppt_slides = merged_ppt.getSlides()
      ppt_paths.each do |ppt_path|
        ppt = create_ppt(ppt_path)
        slides = ppt.getSlides()
        (0..slides.toArray().length-1).map{|i| merged_ppt_slides.addClone(slides.get_Item(i))}
      end
      merged_ppt.getSlides().remove(merged_ppt.getSlides().get_Item(0))
      merged_ppt
    end

  end
end
