require "feeligo/stickers/version"


class Feeligo::Stickers::LoaderScriptTag

  def initialize opts
    @opts = opts
  end


  def to_s
    code = "<script type='text/javascript'>\n#{js_code}</script>"
    if code.respond_to?(:html_safe) then code.html_safe else code end
  end


protected


  # The Javascript code
  def js_code
    product = 'feeligo-stickers-ruby'
    version = Feeligo::Stickers::VERSION
    user_id = self.user_id ? ",'#{self.user_id}'" : ""
    hostname = client_hostname || "'+ee.location.hostname+'"
    <<-JS
    (function(f,ee,l,i,g,o){f[l]=f[l]||{};o&&(o+='').length?(f[l].context={viewer:
    {id:o},platform:{name:i,version:g}})&&(o='-'+o):(o='');(function(s,t,k,r){
    t=ee.createElement(r='script');k=ee.getElementsByTagName(r)[0];t.async=1;t.src=s;
    k.parentNode.insertBefore(t,k);})('http://#{feeligo_api_hostname}/#{hostname}/loader'+o+'.js');
    f[l].q=[];f[l].on=function(s,t,k){f[l].q.push([s,t,k])};
    })(window,document,'flg','#{product}','#{version}'#{user_id});
    JS
  end


  # The user id if provided and valid, or nil otherwise
  def user_id
    if (id = (@opts[:user_id] || @opts['user_id'])) && id.respond_to?(:to_s)
      if (id = id.to_s).size > 0 && id != '0'
        return id
      end
    end
  end


  # The hostname of Feeligo's API
  # defaults to stickersapi.feeligo.com
  def feeligo_api_hostname
    @opts[:feeligo_api_hostname] || 'stickersapi.feeligo.com'
  end


  # The hostname of the client Community
  # if unspecified will use the document.location.hostname JS variable
  def client_hostname
    @opts[:hostname]
  end

end
