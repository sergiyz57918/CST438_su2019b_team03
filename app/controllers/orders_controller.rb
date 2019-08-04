
require 'httparty'
class Item

	include HTTParty
	
	# default_options.update(verify: false) # Turn off SSL
    base_uri "http://localhost:8082"
    format :json
    
    def id(id)
        get('http://localhost:8081/items?id='+id)
    end
    

end

class Customer

	include HTTParty
	
	# default_options.update(verify: false) # Turn off SSL
    base_uri "http://localhost:8081"
    format :json

    def id(id)
        get('http://localhost:8081/customers?id='+id)
    end
    
    def email(email)
        get('http://localhost:8081/customers?email='+email)
    end

end





class OrdersController < ApplicationController
    #/GET ALL
    def index
        if params[:email]
            customer = Customer.new
            customerId = customer.email(params[:email])
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
        customer = Customer.new
        item = Item.new
        itemId = order_params[:itemId]
        if order_params[:customerId]
            customerId = order_params[:customerId]
        elsif order_params[:email]
            or_customer = customer.email(order_params[:email])
            customerId = or_customer['email']
        end
        if itemId && customerId
            if !or_customer
                or_customer = customer.id(customerId)
            end
            or_item = item.id(itemId)
            if customer && or_item
                price = or_item['price']
                award = or_customer['award']
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
            else
                json_response({customer: or_customer,item: or_item},:bad_request)
            end
            
        else
           json_response(order_params,:bad_request) 
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
        params.permit(:itemId,:customerId,:email )
    end
    
end
