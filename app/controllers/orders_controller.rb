
require 'httparty'

class Item

	include HTTParty
	
	# default_options.update(verify: false) # Turn off SSL
    base_uri "http://localhost:8082"
    format :json
    
    def Item.id(id)
        get('http://localhost:8082/items/'+id.to_s)
    end
    

end

class Customer

	include HTTParty
	
	# default_options.update(verify: false) # Turn off SSL
    base_uri "http://localhost:8081"
    format :json

    def Customer.id(id)
        get('http://localhost:8081/customers?id='+id.to_s)
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
     
            customer = Customer.email(order_params[:email])
            or_customer = JSON.parse(customer.body)
            customerId = or_customer['id']
        end
        
        customerId = customerId.to_i
        itemId = itemId.to_i
        
        if itemId>0 && customerId>0
            if !or_customer
                customer = Customer.id(customerId)
                or_customer = JSON.parse(customer.body)
            end
            item = Item.id(itemId)
            or_item =JSON.parse(item.body)
            
            if item.code.to_i==200 && customer.code.to_i==200
                
                price = or_item['price']
                award = or_customer['award']
                total  = price.to_f-award.to_f
                
                description  = or_item['description']
                
                order = {
                    itemId: itemId,
                    customerId: customerId,
                    description: description,
                    price: price,
                    award: award,
                    total: total                    
            
                }
                
                @order=Order.new (order)
                if @order.save
                    json_response(  @order, :created)
                else
                    json_response({
                                item: or_item,
                                order: @order, 
                                itemId: itemId,
                                customerId: customerId,
                                description: description,
                                price: price,
                                award: award,
                                total: total
                                
                        
                    },:bad_request)
                end
            else
                json_response({message: 'Not a hash',customer: or_customer, item: or_item},:bad_request)
            end
            
        else
           json_response({
                    message: 'No item or customer id',
                    customer: or_customer['id'],
                    itemId: itemId, 
                    customerId: customerId},:bad_request) 
        end
    end
    
    #GE1T /orders/:id 
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
