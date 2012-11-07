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
				logger.info "Querying StopForumSpam: #{url}"
				begin
					response = Hash.from_xml(Net::HTTP.get(URI.parse(url)))
					logger.debug response.inspect
					errors.add :base, :spam_according_to_stopforumspam if [ response["response"]["appears"] ].flatten.include?("yes")
				rescue StandardError => e
					logger.warn "Couldn't validate against StopForumSpam: + #{e.message}"
				end
			end
		end
	end
end

ActiveRecord::Base.send :include, ValidatesAgainstStopForumSpam
