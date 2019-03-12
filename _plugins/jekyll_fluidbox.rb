# Integration of the fluidbox lightbox
# https://github.com/terrymun/Fluidbox

require 'nokogiri'

module Jekyll
  module FluidboxFilter

    def fluidify(text)
      doc = Nokogiri::HTML(text)
      images = doc.css "figure img"
      Jekyll.logger.info "Matched Images"
      Jekyll.logger.info $images
      wrapper = images.wrap("<a href=\"\" alt=\"lightbox\"></a>")
      doc.to_html
    end

  end
end
Jekyll.logger.info "Finished running jekyll_fluidbox.rb"
Liquid::Template.register_filter(Jekyll::FluidboxFilter)