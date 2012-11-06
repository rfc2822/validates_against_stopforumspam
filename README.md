= ValidatesAgainstStopForumSpam

Rails gem for ActiveRecord comment model validation against StopForumSpam.com. No API key required.

Respect their terms of use: http://www.stopforumspam.com/apis

Compatibility: Rails 3, tested with Ruby 1.9.3

Licensed under MIT license.


Installation
============

Specify the gem in your Gemfile:

		gem "validates_against_stopforumspam"

or for the current edge version:

		gem "validates_against_stopforumspam", :git => 'git://github.com/rfc2822/validates_against_stopforumspam'

and install it with bundler.


Usage
=====

validates_against_stopforumspam processes three parameters:

* `username`
* `email`
* `ip`

If your model's attribute names are different, you can specify the names in the
`validates_against_stopforumspam` call. If an attribute is not present, it will be ignored.

		class Comment < ActiveRecord::Base
			validates_against_stopforumspam :username => :user_name
		end

You may also pass other parameters for `validate`:

		class Comment < ActiveRecord::Base
			validates_against_stopforumspam :username => :user_name, :ip => :ip_address, :on => :create
		end

When the comment may be spam (because at least one of the parameters appear on stopforumspam.com), the
validation error `:spam_according_to_stopforumspam` is added to the model instance. Translate
it in your i18n files.

