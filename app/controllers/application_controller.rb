class ApplicationController < ActionController::Base
    include Response
    include ExceptionHandler
    include Customer
    include Item
end
