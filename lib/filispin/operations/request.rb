module Filispin

  #
  #
  #
  class Request
    include Timer
    include Parameters

    def initialize(method, url, parameters = {})
      @method = method
      @url = url
      @parameters = parameters
    end

    def run(context)
      options = context[:options]
      browser = context[:browser]
      parameters = merge_parameters(context[:params], @parameters)
      submit_parameters = process @parameters
      url = url(@url, parameters, options)

      # think before request
      sleep(options[:think_time]) if options[:think_time]

      # perform request
      request @method, browser, url, submit_parameters, context[:results]
    end

    protected

    def request(method, browser, url, parameters, results)

      case method
        when :get
          time = get(browser, url)
        when :delete
          time = post(browser, url, {_method: 'delete'})
        when :post
          time = post(browser, url, parameters)
        when :path
          time = post(browser, url, parameters.merge(_method: 'patch'))
        when :put
          time = post(browser, url, parameters.merge(_method: 'put'))
        else
          raise 'unknown method'
      end

      # collect results
      results.success method, url, time, browser.current_page
    rescue
      results.error method, url
    end

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
      matches = /content="(.+?)" name="csrf-token"/.match(page.body)
      matches[1] if matches
    end

    def url(url, parameters, options)
      if url[0] == '/'
        path = interpolate url, parameters
        "#{options[:host]}#{path}"
      else
        interpolate @url, parameters
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