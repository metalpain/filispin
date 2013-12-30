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
      browser = context[:browser]
      url = @url
      #parameters = @parameters

      case @method
        when :get
          time = get(browser, url)
        when :post
          time = post(browser, url, {})
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

      time { browser.post url, parameters }
    end

    def authenticity_token(page)
      input = page.at("input[@name='authenticity_token']")
      input.nil? ? nil : input['value']
    end


  end
end