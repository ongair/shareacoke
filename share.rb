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
        { success: true, ongair_url: ENV['ONGAIR_URL'], ongair_token: ENV['TOKEN'] }.to_json
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
        if params[:notification_type] == "MessageReceived"
          external_contact_id = params[:phone_number]
          name = params[:text].strip.split(' ').first

          api_url = "#{ENV['ONGAIR_URL']}/api/v1/base/send_image"
          image = "#{ENV['URL']}/api/pictures/share?recipient=#{name}&id=#{external_contact_id}.png"

          puts "Url #{image}"
          token = ENV['TOKEN']

          response = HTTParty.post(api_url, body: { image: image, content_type: 'image/png', phone_number: external_contact_id, thread: true, token: token })
          puts "Response #{response}"
          { success: true }.to_json
        end
      end
    end
  end
end