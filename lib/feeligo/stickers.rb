require "feeligo/stickers/version"

module Feeligo
  module Stickers
    
    # Returns a <script> tag which can be added to a View to load the Feeligo
    # Stickers module.
    # The <script> tag should be inserted right after the opening <body> tag
    def self.loader_script_tag opts = {}
      user_id = valid_user_id opts
      "<script type='text/javascript'>\n#{js user_id}</script>"
    end


    # returns the javascript code for the given user_id
    def self.js user_id = nil
      product = 'feeligo-stickers-ruby'
      version = Feeligo::Stickers::VERSION
      <<-JS
      (function(f,ee,l,i,g,o){f[l]=f[l]||{};o&&(o+='').length?(f[l].context={viewer:
      {id:o},platform:{name:i,version:g}})&&(o='-'+o):(o='');(function(s,t,k,r){
      t=ee.createElement(r='script');k=ee.getElementsByTagName(r)[0];t.async=1;t.src=s;
      k.parentNode.insertBefore(t,k);})('http://stickersapp.feeligo.com/'+
      ee.location.hostname+'/loader'+o+'.js')})
      (window,document,'flg','#{product}','#{version}'#{user_id ? ",'#{user_id}'" : ''});
      JS
    end


  protected


    # returns a valid user id based on the provided parameters
    def self.valid_user_id opts
      if (id = (opts[:user_id] || opts['user_id'])) && id.respond_to?(:to_s)
        if (id = id.to_s).size > 0 && id != '0'
          return id
        end
      end
    end

  end
end
