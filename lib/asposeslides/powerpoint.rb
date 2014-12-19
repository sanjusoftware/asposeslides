module Asposeslides
  module Powerpoint

    def create_ppt(file = nil)
      file ? Rjb::import('com.aspose.slides.Presentation').new(file) : Rjb::import('com.aspose.slides.Presentation').new
    end

    def merge_ppts(dest_ppt, src_ppt_options)
      destPres = create_ppt(dest_ppt)
      offset_position = 0

      src_ppt_options.each do |ppt_option|
        src_ppt = ppt_option[:ppt]
        position = ppt_option[:position]
        replace = ppt_option[:replace]

        srcPres = create_ppt(src_ppt)
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

  end
end
