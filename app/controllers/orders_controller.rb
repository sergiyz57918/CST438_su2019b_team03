
require 'httparty'

class Item

	include HTTParty
	
	# default_options.update(verify: false) # Turn off SSL
    base_uri "http://localhost:8082"
    format :json
    
    def Item.id(id)
        get('http://localhost:8082/items?id='+id)
    end
    

end

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





class OrdersController < ApplicationController


    #/GET ALL
    def index
        if params[:email]
            customerId = Customer.email(params[:email])
            @order = Order.find_by customerId: customerId
        elsif params[:customerId]
            @order = Order.find_by customerId: params[:customerId]
        else 
            @order =Order.all 
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
        if order_params[:customerId]
            customerId = order_params[:customerId]
        elsif order_params[:email]
            or_customer = Customer.email(order_params[:email])
            customerId = or_customer['id']
        end
        if itemId && customerId
            if !or_customer
                or_customer = Customer.id(customerId)
            end
            or_item = Item.id(itemId)
            if or_customer && or_item
                price = or_item['price'].to_f
                award = or_customer['award'].to_f
                total  = price-award
                order = {itemId: itemId,
                    description: or_item['description'],
                    customerId: customerId,
                    price: price,
                    award: award,
                    total: total}
                @order=Order.new (order)
                if @order.save
                    json_response(@order, :created)
                else
                    json_response(@order,:bad_request)
                end
            else
                json_response({customer: or_customer,item: or_item},:bad_request)
            end
            
        else
           json_response({customer: or_customer,itemId: itemId, customerId: customerId},:bad_request) 
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
        params.permit(:itemId,:email, :order )
    end
    
end
