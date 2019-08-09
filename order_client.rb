require 'httparty'


class CRJOrder
  include HTTParty
  
  base_uri "http://localhost:8080"
	format :json
 
  def CRJOrder.new(itemId, email) 
    obj = {"email"=>email,"itemId"=>itemId}
    response = post '/orders',
            body: obj.to_json,
            headers: { 'Content-Type' => 'application/json',
            'ACCEPT' => 'application/json' }
    response
  end 
  
  def CRJOrder.getId(id)
    get "/orders/#{id}" , 
      headers:  { 'ACCEPT' => 'application/json' }
  end
  
  def CRJOrder.getOrderByEmail(email)
    get('http://localhost:8080/orders?email='+email)
  end
  
  def CRJOrder.getOrderByCustomerId(customerId)
    get('http://localhost:8080/orders?customerId='+customerId)
  end
end 

menu=''
while true
    if menu == "1" #Create a new order'
      puts "enter itemId and email"
      ent = gets.chomp!
      ent=ent.split(" ")
      itemId = ent[0]
      email = ent[1]
      puts ent.inspect
      puts CRJOrder.new(itemId, email)
    end
    
    if menu == "2" #Retrieve an existing order by orderId'
      puts "enter Order id"
      id = gets.chomp!
      puts CRJOrder.getId(id)
    end
    
    if menu == "3" #Retrieve an existing order by customerId'
        puts "enter customerId"
        customerId = gets.chomp!
        puts CRJOrder.(customerId)
    end
    
    if menu == "4" #Retrieve an existing order by email'
        puts "enter email"
        email = gets.chomp!
        puts CRJOrder.(email)
    end
    
    if menu == "5" #Register a new customer'
        puts "enter lastName, firstName and email for new customer"
        ent = gets.chomp!
        ent=ent.split(" ")
        lastName = ent[0]
        firstName = ent[1]
        email = ent[2]
        puts ent.inspect
        puts "Hello #{firstName} #{lastName} email:#{email}"
        puts CRJCustomer.new(email, firstName, lastName)
    end
    
    if menu == "6" #Lookup a customer by id'
        puts "enter id"
        id = gets.chomp!
        puts CRJCustomer.id(id)
    end
    
    if menu == "7" #Lookup a customer by email'
        puts "enter email"
        email = gets.chomp!
        puts CRJCustomer.email(email)
    end
    
    if menu == "8" #Create a new item'
      puts 'enter item description'
      description = gets.chomp!
      puts 'enter item price'
      price = gets.chomp!
      puts 'enter item stockQty'
      stockQty = gets.chomp!
      puts = CRJItem.createItem(description: description, price: price, stockQty: stockQty)
    end
    
    if menu == "9" #Lookup an item by item id'
      puts 'enter id of item to lookup'
      id = gets.chomp!
      puts CRJItem.getItem(id)
    end
    
    if menu == "10" #Quit
      break
    end
    
    if menu == "quit" #Extra quit step if they type quit
      break
    end
    
puts 'What do you want to do?'
puts '1. Create a new order'
puts '2. Retrieve an existing order by orderId'
puts '3. Retrieve an existing order by customerId'
puts '4. Retrieve an existing order by email'
puts '5. Register a new customer'
puts '6. Lookup a customer by id'
puts '7. Lookup a customer by email'
puts '8. Create a new item'
puts '9. Lookup an item by item id'
puts '10. Quit'

menu = gets.chomp!
end