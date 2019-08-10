require 'rails_helper'


RSpec.describe 'OrdersController', type: :request  do

  before(:each) do
    @headers =  { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}    
  end

    # describe 'POST /orders' do
    #     let(:valid_attributes) {{ email: 'john@dow.com', itemId: 1 } }
        
    #     let(:item_response) { instance_double(HTTParty::Response, body: item_response_body) }
    #     let(:item_response_body) { {
    #             id: 1, 
    #             description: "Sexy Leya",
    #             price: 99.99, 
    #             stockQty: 1
    #     } }
        
    #     let(:customer_response) { instance_double(HTTParty::Response, body: customer_response_body) }
    #     let(:customer_response_body) { {
    #             id: 1,
    #             email: 'john@dow.com',
    #             lastName: 'Dow', 
    #             firstName: 'John',
    #             lastOrder: 99.99, 
    #             lastOrder2: 99.99, 
    #             lastOrder3: 99.99,  
    #             award: 9.99
    #     } }
        
        
    #     context 'when the request is valid' do
    #         before {
    #             item = class_double("Item").
    #                         as_stubbed_const(:transfer_nested_constants => true)
    #             customer = class_double("Customer").
    #                         as_stubbed_const(:transfer_nested_constants => true)
    #             allow(item).to receive(:id).and_return(item_response)
    #             allow(JSON).to receive(:parse)
               
    #             allow(customer).to receive(:email).and_return(customer_response)
    #             allow(JSON).to receive(:parse)
                
    #             post '/orders', params: valid_attributes 
    #             }
        
    #         it 'Get user and create order' do

    #             puts JSON.parse(response.body)
    #             expect(response).to have_http_status(201)
    #             #get '/orders'
    #             #puts JSON.parse(response.body)
                 
    #         end
    #     end
    
    # end

    describe 'GET /orders' do
        
    
    end
    
    describe 'GET /orders/:id' do
        it 'should get order by id' do
            order = Order.create(id: 1, itemId: 1, description: "Wii", customerId: 7, price: 250, award: 0, total: 250);
            get '/orders/1', :headers => @headers
            expect(response).to have_http_status(200)
            orderRetrieve = JSON.parse(response.body)
            expect(orderRetrieve['description']).to eq order.description
        end
    end
    
    describe 'GET /orders?customerId=nnn' do
        it 'should get order by customerId' do
            order = Order.create(id: 1, itemId: 1, description: "Wii", customerId: 7, price: 250, award: 0, total: 250);
            get '/orders?customerId=7', :headers => @headers
            expect(response).to have_http_status(200)
            orderRetrieve = JSON.parse(response.body)
            expect(orderRetrieve['description']).to eq order.description
        end
    
    end
    
    describe '/orders?email=nn@nnnn' do
    
    end
    


end