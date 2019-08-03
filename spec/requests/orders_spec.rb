require 'rails_helper'
RSpec.describe 'Todos API', type: :request do

    # initialize test data 
    let!(:orders) { create_list(:orders, 10) }
    let(:id) { orders.first.id }
    
    describe 'GET /orders' do
    
    end

    describe 'POST /orders' do
    
    end
    
    describe 'GET /orders/:id' do
    
    end
    
    describe 'GET /orders?customerId=nnn' do
    
    end
    
    describe '/orders?email=nn@nnnn' do
    
    end

end