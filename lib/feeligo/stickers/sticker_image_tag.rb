require "feeligo/stickers/version"


class Feeligo::Stickers::StickerImageTag

  def initialize path, opts
    @path = path
    @opts = opts
  end


  def to_s
    code = build_tag
    if code.respond_to?(:html_safe) then code.html_safe else code end
  end



protected



  # The <img> tag
  def build_tag
    "<img " << tag_attributes_string << "/>"
  end


  # Attributes of the <img> tag, joined as a string
  def tag_attributes_string
    tag_attributes.map{|k, v| "#{k}=\"#{v}\""}.join(' ')
  end


  # Attributes of the <img> tag, as a Hash
  # any options passed to initialize will be set as attributes of the <img> tag
  # the "src" attribute will be set to the image_url
  def tag_attributes
    attrs = {}
    @opts.each_pair{|k, v| attrs[k.to_s] = v.to_s}
    attrs["src"] = image_url
    attrs
  end


  # The URL of the image
  def image_url
    return "" if @path.nil? || @path.empty?
    "http://stkr.es/" << if m = /^(p3w|p7s|p)\/(.*)$/.match(@path)
      "p/" << m[2]
    else
      @path
    end
  end

end
