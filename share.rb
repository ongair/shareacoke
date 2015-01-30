require 'grape'
require 'rmagick'
module Share
  class API < Grape::API    
    version 'v1', using: :header, vendor: 'ongair'
    format :json
    prefix :api

    resource :pictures do 

      desc "Return if we are working or not"
      get :status do
        true
      end

      desc "Return a share a coke image url"
      params do
        requires :id, type: String, desc: "Id"
        requires :sharer_name, type: String, desc: "Name of the person sharing the image"
        requires :sharer_pic, type: String, desc: "Profile pic of the sharer"
        requires :recipient, type: String, desc: "Person getting the image"
      end

      content_type :jpeg, "image/png"
      get :share do
        content_type "image/png"
        bottle = Magick::Image.read('bottle.png')[0]
        # bottle
        # data = File.open('bottle.png').read
        # body data
        body bottle
      end
      
    end
  end
end