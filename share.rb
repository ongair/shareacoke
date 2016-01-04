require 'grape'
require 'rmagick'
require 'httparty'

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

      post :image do
        # message_received
        if params[:notification_type] == "MessageReceived"
          phone_number = params[:external_contact_id]
          name = params[:name]

          # url = "http://188.166.182.98/api/pictures/share?recipient=#{name}&id=#{phone_number}.png"
          # token = "cfae9c460ba07ede023900d72ead3e35"
          # api_url = "http://localhost:3000/api/v1/base/send_image"
          # HTTParty.post(api_url, body: { image: url, phone_number: phone_number, token: token })
        end
      end
    end
  end
end