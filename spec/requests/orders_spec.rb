require 'rails_helper'


RSpec.describe 'OrderssController', type: :request  do


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
            before { post '/orders', params: valid_attributes }
        
            it 'Get user and create order' do
                item = class_double ("Item")
                customer = class_double("Customer")
                allow(item).to receive(:id).and_return(item_return)
                allow(customer).to receive(:email).and_return(customer_return)
                allow(customer).to receive(:id).and_return(customer_return)
                
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

end