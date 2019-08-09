require 'rails_helper'


RSpec.describe 'OrdersController', type: :request  do

  before(:each) do
    @headers =  { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}    
  end

    describe 'POST /orders' do
        let(:valid_attributes) {{ email: 'john@dow.com', itemId: 1 } }
        let (:item_return){{
                id: 1, 
                description: "Sexy Leya",
                price: 99.99, 
                stockQty:1
        }}
        
        let (:customer_return){{
                email: 'john@dow.com',
                lastName: 'Dow', 
                firstName: 'John',
                lastOrder: 99.99, 
                lastOrder2: 99.99, 
                lastOrder3: 99.99,  
                award: 9.99
        }}
        
        context 'when the request is valid' do
            before {
                item = Item.new
                customer = Customer.new
                allow(item).to receive(:id).and_return(item_return)
                allow(customer).to receive(:email).and_return(customer_return)
                post '/orders', params: valid_attributes 
                }
        
            it 'Get user and create order' do

                puts JSON.parse(response.body)
                expect(response).to have_http_status(201)
                 
            end
        end
    
    end

    describe 'GET /orders' do
    
    end
    
    describe 'GET /orders/:id' do
    
    end
    
    describe 'GET /orders?customerId=nnn' do
    
    end
    
    describe '/orders?email=nn@nnnn' do
    
    end
    
    it 'should be able to get order by id' do
        order = Order.create(itemId: 2, customerId: 32)
        get '/orders?id=1', :headers => @headers
        expect(response).to have_http_status(200)   
        orderDB = JSON.parse(response.body)
        expect(orderDB['itemId']).to eq order.itemId
    end

end