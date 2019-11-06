class PaymentsController < ApplicationController
    def success
    end

    def webhook
        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        byebug
        puts params
        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    end
end