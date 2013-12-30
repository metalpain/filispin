module Filispin

  #
  #
  #
  class Request
    include Timer

    def initialize(method, url, parameters = {})
      @method = method
      @url = url
      @parameters = parameters
    end

    def run(context)
      options = context[:options]
      browser = context[:browser]
      parameters = process @parameters
      url = url(@url, parameters, options)

      # think before request
      sleep(options[:think_time]) if options[:think_time]

      case @method
        when :get
          time = get(browser, url)
        when :post
          time = post(browser, url, parameters)
        else
          raise 'unknown method'
      end

      # collect results
      results = context[:results]
      results.add @method, url, time, browser.current_page
    end

    protected

    def get(browser, url)
      time { browser.get url }
    end

    def post(browser, url, parameters)
      if browser.current_page
        # read authenticity_token
        token = authenticity_token browser.current_page
        parameters[:authenticity_token] = token if token
      end

      time { browser.post url, to_post_query(parameters) }
    end

    def authenticity_token(page)
      input = page.at("input[@name='authenticity_token']")
      input.nil? ? nil : input['value']
    end

    def url(url, parameters, options)
      if url[0] == '/'
        path = interpolate url, parameters
        "#{options[:host]}#{path}"
      else
        interpolate @url, parameters
      end
    end

    def process(parameters)
      if parameters.is_a? Proc
        parameters.call
      else
        parameters
      end
    end

    def interpolate(string, params)
      str = string.dup
      str.scan(/:[A-Za-z_]\w+/).each do |m|
        str.gsub!(m, params[m.gsub(/:/, '').to_sym].to_s)
      end
      str
    end

    def to_post_query(parameters, prefix = nil)
      params = {}
      parameters.each_pair do |key, value|
        attribute_name = prefix ? "#{prefix}[#{key}]" : key.to_s
        if value.is_a? Hash
          params.merge! to_post_query(value, attribute_name)
        else
          params[attribute_name] = value
        end
      end
      params
    end
  end
end