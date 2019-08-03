class OrdersController < ApplicationController
    #/GET ALL
    def index
        if params[:email]
            @order = Order.find_by email: params[:email]
        elsif params[:customerId]
            @order = Order.find_by customerId: params[:customerId]
        end
        
        if @order.nil?
            json_response({''})
        else
            json_response(@order)
        end
    end
    
    #/POST
    def create
        Order.create!(order_params)
        json_response(@item, :created)
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
