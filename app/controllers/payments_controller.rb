class PaymentsController < ApplicationController
    def success
    end

    def webhook
        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        puts params
        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    end
end