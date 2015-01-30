require 'rubygems'
require 'rmagick'

# textorize -fYou2013 -gtransparent -s55 Gaurav -cwhite

name = ARGV[0]

puts "Generating for #{name}"

`textorize -fYou2013 -gtransparent -s55 -cwhite #{name}`

bottle = Magick::Image.read('bottle.png')[0]

# x=485
x=475
# y=250

# x=485
y=265

width=140
height=55

file = "output"
img = Magick::Image.read("#{file}.png")[0]
# binding.pry
# i.resize_to_fill(100,100).write("#{output}-square-thumb.jpg")
puts "This image is #{img.columns}x#{img.rows} pixels"

raw_width = img.columns
if raw_width > width
  scale = width.to_f / raw_width.to_f

  puts "Scale by #{scale}"
  img = img.scale(scale)
end

# img.write("#{file}_smaller.png")

bottle = bottle.composite(img, x, y, Magick::OverCompositeOp)
bottle.write("final.png")

# img.composite(bottle, x, y, Magick::OverCompositeOp)
# img.write("final.png")
