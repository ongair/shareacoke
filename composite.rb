require 'rubygems'
require 'rmagick'

# # textorize -fYou2013 -gtransparent -s55 Gaurav -cwhite

# name = ARGV[0]

# puts "Generating for #{name}"

# `textorize -fYou2013 -gtransparent -s55 -cwhite #{name}`

# bottle = Magick::Image.read('bottle.png')[0]

# # x=485
# x=475
# # y=250

# # x=485
# y=265

# width=140
# height=55

# file = "output"
# img = Magick::Image.read("#{file}.png")[0]
# # binding.pry
# # i.resize_to_fill(100,100).write("#{output}-square-thumb.jpg")
# puts "This image is #{img.columns}x#{img.rows} pixels"

# raw_width = img.columns
# if raw_width > width
#   scale = width.to_f / raw_width.to_f

#   puts "Scale by #{scale}"
#   img = img.scale(scale)
# end

# # img.write("#{file}_smaller.png")

# bottle = bottle.composite(img, x, y, Magick::OverCompositeOp)
# bottle.write("final.png")

# img.composite(bottle, x, y, Magick::OverCompositeOp)
# img.write("final.png")

module Composite

  X=475
  Y=265
  WIDTH=130
  HEIGHT=50

  def self.generate_image source, name, id
    puts "Generating image for #{name}"
    output_name = "tmp/#{id}_#{name}.png"

    `textorize -fYou2013 -gtransparent -s55 -cwhite -o#{output_name} #{name}`
    sleep(0.5)
    # output_name

    bottle = Magick::Image.read('bottle.png')[0]
    name_img = Magick::Image.read(output_name)[0]
    name_width = name_img.columns

    to_scale = self.scale(Composite::WIDTH, name_width)
    name_img = name_img.scale(to_scale)

    coordinates = Composite.center(name_img.columns, name_img.rows)
    bottle = bottle.composite(name_img, coordinates[0], coordinates[1], Magick::OverCompositeOp)
    final = "tmp/#{id}_#{name}_final.png"
    bottle.write(final)
    sleep(0.5)
    final
  end

  def self.scale container, name_width
    scale = 1.0 
    if name_width > container
      scale = container.to_f / name_width.to_f
    end
    puts ">>> Name Width: #{name_width}. Container: #{container} Scale #{scale}"
    scale
  end

  def self.center width, height
    # x = 475
    # y = 265

    x = Composite::X + ((Composite::WIDTH - width) / 2)
    y = Composite::Y + ((Composite::HEIGHT - height) / 2)

    [x,y]
  end
end