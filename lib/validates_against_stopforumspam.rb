require "net/http"
require "uri"

module ValidatesAgainstStopForumSpam
	extend ActiveSupport::Concern

	module ClassMethods
		def validates_against_stopforumspam(options = {})
			attr_names = {}
			[ :username, :email, :ip, :comment].each do |param|
				attr_names[param] = options.delete(param) || param
			end
			validate options do |comment|
				query_options = []
				attr_names.each do |param,attr_name|
					if comment.respond_to? attr_name
						value = comment.send attr_name
						query_options << "#{param}=#{URI.escape(value)}" unless value.nil?
					end
				end
				return if query_options.empty?

				url = "http://www.stopforumspam.com/api?" + query_options.join('&')
        if Rails.env.production?
          logger.info "Querying StopForumSpam: #{url}"
          begin
            uri = URI.parse(url)
            http = Net::HTTP.new(uri.host)
            http.open_timeout = 2
            http.read_timeout = 2
            raw_response = http.get("#{uri.path}?#{uri.query}")
            response = Hash.from_xml(raw_response.body)
            errors.add :base, :spam_according_to_stopforumspam if [ response["response"]["appears"] ].flatten.include?("yes")
          rescue TimeoutError
            logger.warn "StopForumSpam request timed out"
          rescue StandardError => e
            logger.warn "Couldn't validate against StopForumSpam: + #{e.message}"
          end
        else
          logger.info "Would query StopForumSpam: #{url} in production mode"
        end
			end
		end
	end
end

ActiveRecord::Base.send :include, ValidatesAgainstStopForumSpam
