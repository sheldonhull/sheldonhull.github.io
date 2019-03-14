# Integration of the fluidbox lightbox
# https://github.com/terrymun/Fluidbox
# https://nokogiri.org/tutorials/modifying_an_html_xml_document.html#wrapping_a_nodeset
require 'nokogiri'

module Jekyll
  module FluidboxFilter
    def fluidify(text)
      doc = Nokogiri::HTML(text)
      images = doc.css "img"
      wrapper = images.wrap("<a href=\"\" alt=\"lightbox\"></a>")
      # wrapper = images.wrap("<a href=\"\" alt=\"lightbox\"></a>")


      # if img = doc.xpath('//img')
      #   p img.attr('src')
      # end
      # images.each do |node|
      #   node.each do |attr_name,attr_val|
      #    node.attributes["src"].value = attr_val.to_s.gsub("./", "/assets/img/")
      #   end
      # end


      # doc.css('img').each do |node|
      #   node.each do |attr_name,attr_val|
      #    node.attributes["src"].value = attr_val.to_s.gsub("./", "/assets/img/")
      #   end
      # end
      #if img = doc.xpath('//img')
      #  p img.attr('src')
      #    img.wrap("<a href=\"\" alt=\"lightbox\"></a>")
      #end

#      Jekyll.logger.info "Matched Images"
      #wrapper = images.wrap("<a href=\"\" alt=\"lightbox\"></a>")
      doc.to_html
    end
  end
end
#Jekyll.logger.info "Finished running jekyll_fluidbox.rb"
Liquid::Template.register_filter(Jekyll::FluidboxFilter)