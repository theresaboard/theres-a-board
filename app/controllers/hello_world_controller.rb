class HelloWorldController < ApplicationController
  def hello
    render json: {hello: "World"}
  end
end
