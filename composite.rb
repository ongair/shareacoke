require 'rubygems'
require 'rmagick'
require 'tmpdir'

module Composite

  X=475
  Y=265
  WIDTH=130
  HEIGHT=50

  def self.generate_image source, name, id
    # puts "Generating image for #{name}"
    output_name = "#{Dir.tmpdir}/#{id}_#{name}.png"

    font_path = File.expand_path('../you_db-webfont.ttf', __FILE__)
    # `convert -background transparent -fill white -font you_db-webfont.ttf -pointsize 55 label:#{name} #{output_name}`
    `convert -background transparent -fill white -font #{font_path} -pointsize 55 label:#{name} #{output_name}`
    sleep(0.5)

    template = File.expand_path('../bottle.png', __FILE__)

    # bottle = Magick::Image.read('bottle.png')[0]
    bottle = Magick::Image.read(template)[0]
    name_img = Magick::Image.read(output_name)[0]
    name_width = name_img.columns

    to_scale = self.scale(Composite::WIDTH, name_width)
    name_img = name_img.scale(to_scale)

    coordinates = Composite.center(name_img.columns, name_img.rows)
    bottle = bottle.composite(name_img, coordinates[0], coordinates[1], Magick::OverCompositeOp)
    final = "#{Dir.tmpdir}/#{id}_#{name}_final.png"
    bottle.write(final)
    sleep(0.5)
    final
  end

  def self.scale container, name_width
    scale = 1.0 
    if name_width > container
      scale = container.to_f / name_width.to_f
    end
    scale
  end

  def self.center width, height

    x = Composite::X + ((Composite::WIDTH - width) / 2)
    y = Composite::Y + ((Composite::HEIGHT - height) / 2)

    [x,y]
  end
end