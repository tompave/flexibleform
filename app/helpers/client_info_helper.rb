module ClientInfoHelper


  # punto di accesso ai metodi del modulo
  def fetch_info(request)
    if ua = find_user_agent(request)
      osys = find_current_os(ua) # me la creo prima perchè devo passarla come parametro due volte

      info_hash = {
        :user_agent => ua, # so che qui non può essere nil
        :o_system => osys,
        :os_version => find_os_version(ua, osys)
      }
    else
      info_hash = {
        :user_agent => "noUA",
        :o_system => "NA_noUA",
        :os_version => "NA_noUA"
      }
    end
    return info_hash
  end


	def find_user_agent(request)
		if request != nil
    	request.env["HTTP_USER_AGENT"]
    else
    	return nil #"console-offline-test"
    end
  end

  
  
  def find_current_os(user_agent)
		case user_agent
			when /Android|GINGERBREAD/ then :Android
			when /iPhone|iPad/ then :iOS
      when /Windows Phone OS/ then :WindowsPhone
      when /BlackBerry/ then :BlackBerry
      when /Windows/ then :Windows
      when /Macintosh/ then :MacOSX
      when /Symbian/ then :NokiaSymbian
      
      else :other
    end
  end

  # User Agents:
  # Android - default: "Mozilla/5.0 (Linux; U; Android 4.1.1; it-it; Galaxy Nexus Build/JRO03C) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30"
  # Android - strano:  "Mozilla/5.0 (Linux; U; it-it; GT-I9001 Build/GINGERBREAD) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Safari/533.1"
  # Android - Chrome:  "Mozilla/5.0 (Linux; Android 4.1.1; Galaxy Nexus Build/JRO03C) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166 Mobile Safari/535.19"
  # Android - Firefox: "Mozilla/5.0 (Android; Mobile; rv:15.0) Gecko/15.0 Firefox/15.0.1"
  # iOS - Default:     "Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A403 Safari/8536.25"
  # iOS - Chrome:      "Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X; it-it) AppleWebKit/534.46.0 (KHTML, like Gecko) CriOS/21.0.1180.80 Mobile/10A403 Safari/7534.48.3"
  # iOS - iPadDefault: "Mozilla/5.0 (iPad; CPU OS 5_1_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9B206 Safari/7534.48.3"
  # WindowsPhone7.5 - default: "Mozilla/5.0 (compatible; MSIE 9.0; Windows Phone OS 7.5; Trident/5.0; IEMobile/9.0; SAMSUNG; SGH-i917)"
  # Nokia - default:   "Mozilla/5.0 (Symbian/3; Series60/5.4 Nokia700/112.010.1404; Profile/MIDP-2.1 Configuration/CLDC-1.1 ) AppleWebKit/535.1 (KHTML, like Gecko) NokiaBrowser/8.2.1.20 Mobile Safari/535.1 3gpp-gba"
  # BlackBerry - def:  "BlackBerry8310/4.5.0.174 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/132"
  # BlackBerry -Opera: "Opera/9.80 (BlackBerry; Opera Mini/4.4.28684/28.2555; U; en) Presto/2.8.119 Version/11.10"

  # Mac: "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Safari/530.17"

  #deve essere un numero
  def find_os_version(ua_str, os_sym)

    if os_sym == :Android
      if index = ua_str.index(/(Android \d\.)/)
        index += 8
        length = (ua_str.index(/\d\;/, index) - index) +1
        ua_str[index, length] || "N/A"
      elsif index = ua_str.index(/(Android)(.+)(Firefox)/)
        "non rilavata, Firefox per Android"
      else
        "non rilevata"
      end
    elsif os_sym == :iOS
      if index = ua_str.index(/(\d_)/)
        length = (ua_str.index(/\_\d\s/, index) - index) +2
        ua_str[index, length] || "N/A"
      else
        "non rilevata"
      end
    else
      "non gestita"
    end
  end
    # puts "user_agent: #{user_agent}".colorize(:blue)
    # puts "os_index: #{os_index}".colorize(:blue)
    # puts "first_space_index: #{first_space_index}".colorize(:green)
    # puts "second_space_index: #{second_space_index}".colorize(:green)
    # puts "length: #{length}".colorize(:green)
    # puts "os_version: #{os_version}".colorize(:red)

  def find_ip_address(request)
    if request != nil
      # request.remote_ip ...ma questo non funziona se si usa Apache davanti a dei mongrel, perchè le richieste partono da Apache
      begin
        request.remote_ip || request.env["HTTP_X_FORWARDED_FOR"]
      rescue
        "impossibile recuperare IP (proxy?)"
      end
    else
      "NA_noRequest"
    end
  end

  
end
