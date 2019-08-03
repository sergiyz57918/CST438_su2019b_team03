require 'httparty'

class Customer

	include HTTParty
	
	# default_options.update(verify: false) # Turn off SSL
    base_uri "http://localhost:8081"
    format :json

    def Customer.id(id)
        get('/customers?id='+id)
    end
    
    def Customer.email(email)
        get('/customers?email='+email)
    end

end

class Item

	include HTTParty
	
	# default_options.update(verify: false) # Turn off SSL
    base_uri "http://localhost:8082"
    format :json
    
    def Items.id(id)
        get('/customers?id='+id)
    end
    

end