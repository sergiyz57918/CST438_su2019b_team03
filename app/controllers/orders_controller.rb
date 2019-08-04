
require 'httparty'
class Customer

	include HTTParty
	
	# default_options.update(verify: false) # Turn off SSL
    base_uri "http://localhost:8081"
    format :json

    def Customer.id(id)
        get('http://localhost:8081/customers?id='+id)
    end
    
    def Customer.email(email)
        get('http://localhost:8081/customers?email='+email)
    end

end

class Item

	include HTTParty
	
	# default_options.update(verify: false) # Turn off SSL
    base_uri "http://localhost:8082"
    format :json
    
    def Item.id(id)
        get('http://localhost:8081/items?id='+id)
    end
    

end



class OrdersController < ApplicationController
    #/GET ALL
    def index
        if params[:email]
            customerId = Customer.id(params[:email])
            @order = Order.find_by customerId: customerId
        elsif params[:customerId]
            @order = Order.find_by customerId: params[:customerId]
        end
        
        if @order.nil?
            json_response({})
        else
            json_response(@order)
        end
    end
    
    #/POST
    def create
        itemId = order_params[:itemId]
        customerId = order_params[:customerId]
        if itemId && customerId
            customer = Customer.id(customerId)
            item = Item.id(itemId)
            if customer && item
                price = item['price']
                award = customer['award']
                order = {itemId: itemId,
                    description: item['description'],
                    customerId: customerId,
                    price: price,
                    award: award,
                    total: price-award}
                @order=Order.create (order)
                if @order
                    json_response(@order, :created)
                else
                    json_response(@order,:bad_request)
                end
            end
        end
    end
    
    #GET /orders/:id 
    def show 
        @item = Order.find(params[:id])
        if @item
            json_response(@item, :ok)
        else
            json_response(@item,:not_found)
        end
    end
    
    #PRIVATE METHODS
    private
    
    #ACCEPTED parametrs
    def order_params
        params.permit(:itemId,:customerId)
    end
    
end
