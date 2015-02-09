require 'grape'
require 'rmagick'

require_relative 'composite'

module Share
  class API < Grape::API    
    version 'v1', using: :header, vendor: 'ongair'
    format :txt
    prefix :api

    resource :pictures do 
      desc "Return if we are working or not"
      get :status do
        true
      end      

      desc "Return a share a coke image url"
      params do
        requires :id, type: String, desc: "Id"
        requires :recipient, type: String, desc: "Person getting the image"
      end

      content_type :png, "image/png"
      get :share do
        content_type "image/png"        

        output = Composite.generate_image 'bottle.png', params[:recipient], params[:id]
        data = File.open(output).read
        body data
      end
      
    end
  end
end