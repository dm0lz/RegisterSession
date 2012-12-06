
Before do
	start
end

After do
	#binding.pry
	coll.drop
	stop
end

Before "@invalid2" do
	a = { "login" => "louis", "email" => "jean@fetcher.com", "password" => "password" }
 	object_id = coll.insert a
end

