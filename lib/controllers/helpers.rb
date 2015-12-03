module Controllers
  module Helpers

    private

    def order
      Order.new(name: params[:name], text_order: params[:text_order])
    end

    def order_response
      Response::Order.new(params[:name], params[:text_order])
    end

  end
end
