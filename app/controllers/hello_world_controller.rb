class HelloWorldController < ApplicationController
  def hello
    render json: [{hello: "World"},{hello: "Me"}]
  end
end
