require 'grape'
require 'rmagick'
require 'pry'
require_relative 'composite'

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
      #   requires :sharer_name, type: String, desc: "Name of the person sharing the image"
      #   requires :sharer_pic, type: String, desc: "Profile pic of the sharer"
        requires :recipient, type: String, desc: "Person getting the image"
      end

      content_type :png, "image/png"
      get :share do
        content_type "image/png"
        # bottle = Magick::Image.read('bottle.png')[0]

        # binding.pry
        puts ">>> #{params[:id]}"
        # puts ">>> #{params[:sharer_name]}"
        # puts ">>> #{params[:sharer_pic]}"
        puts ">>> #{params[:recipient]}"
        # puts params[:sharer_name]

        output = Composite.generate_image 'bottle.png', params[:recipient], params[:id]

        puts ">>> Output file is #{output}"
        # binding.pry

        # bottle
        # sleep(3)
        data = File.open(output).read
        body data
        # body bottle
      end
      
    end
  end
end