module MongoTest
	def browser
		@browser ||= Watir::Browser.new :firefox
	end
	def start
		browser.goto "http://localhost:4566/register"
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