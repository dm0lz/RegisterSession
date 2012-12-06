module MongoTest
	def browser
		@browser ||= Watir::Browser.new :firefox
	end
	def start
		browser.goto "http://localhost:4567"
	end
	def stop
		browser.close
	end
	def client
    @client ||= Mongo::Connection.new
  end
  def db
    @db ||= client["test"]
  end
  def coll
    @coll ||= db["users"]
  end
end


World MongoTest