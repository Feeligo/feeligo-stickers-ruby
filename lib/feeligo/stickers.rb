require "feeligo/stickers/version"
require "feeligo/stickers/loader_script_tag"
require "feeligo/stickers/sticker_image_tag"


module Feeligo
  module Stickers
    
    # Returns a <script> tag which can be added to a View to load the Feeligo
    # Stickers module.
    # The <script> tag should be inserted right after the opening <body> tag
    def self.loader_script_tag opts = {}
      LoaderScriptTag.new(opts).to_s
    end


    # Takes a string and returns a copy of it with all [s:PATH] tags replaced
    # with HTML <img> tags
    def self.replace_sticker_tags string, opts = {}
      string.gsub(/\[s:(.+?)\]/){|m| StickerImageTag.new($1, opts).to_s}
    end

  end
end
