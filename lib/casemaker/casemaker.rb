require 'casemaker/wall'

class CaseMaker
 def self.setter(*method_names)
    method_names.each do |name|
      send :define_method, name do |data|
        instance_variable_set "@#{name}".to_sym, data 
      end
    end
  end

  setter :name, :height, :width, :depth, :thickness, :length

  def initialize(&block)
    instance_eval(&block)

    @walls = []

    @walls += make_case
    @walls += make_lid
  end

  def to_stl(filename = @name)
    File.open(filename, 'w') do |f|
      f.puts "solid #{@name}"

      @walls.each do |wall|
        f.puts wall.to_stl
      end

      f.puts "endsolid"
    end
  end

  private

  def make_case
    walls = []


    walls.push CaseMaker::Wall.new height: @thickness,
                                   width: @width + @thickness * 2,
                                   depth: @depth + @thickness * 2,
                                   position_x: 0, position_y: 0, position_z: 0

    walls.push CaseMaker::Wall.new height: @height + @thickness,
                                   width: @width + @thickness * 2,
                                   depth: @thickness,
                                   position_x: 0, position_y: 0, position_z: 0

    walls.push CaseMaker::Wall.new height: @height + @thickness,
                                   width: @width + @thickness * 2,
                                   depth: @thickness,
                                   position_x: 0, position_y: @depth + @thickness, position_z: 0

    walls.push CaseMaker::Wall.new height: @height + @thickness,
                                   width: @thickness,
                                   depth: @depth + @thickness * 2,
                                   position_x: 0, position_y: 0, position_z: 0

    walls.push CaseMaker::Wall.new height: @height + @thickness,
                                   width: @thickness,
                                   depth: @depth + @thickness * 2,
                                   position_x: @width + @thickness, position_y: 0, position_z: 0

    walls
  end

  def make_lid
    walls = []

    walls.push CaseMaker::Wall.new height: @thickness,
                                   width: @width + @thickness * 2,
                                   depth: @depth + @thickness * 2,
                                   position_x: 0, position_y: @depth + @thickness * 6, position_z: 0

    walls.push CaseMaker::Wall.new height: @thickness,
                                   width: @width,
                                   depth: @depth,
                                   position_x: @thickness, position_y: @depth + @thickness * 7, position_z: @thickness

    walls
  end
end
