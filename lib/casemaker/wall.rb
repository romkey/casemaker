# position_x, position_y and position_z are the offset from the origin of the lower front left corner of the wall
# so that it would be at the origin if they were all 0

class CaseMaker
  class Wall
    attr_accessor :width, :depth, :height
    attr_accessor :position_x, :position_y, :position_z

    def initialize(**args)
      %i{height depth width position_x position_y position_z}.each do |sym|
        if args[sym].nil?
          raise "Missing argument #{sym}"
        end

        self.instance_variable_set("@#{sym.to_s}", args[sym])
      end

      top1 = CaseMaker::Triangle.new 0, 0, @height,
                                     @width, 0, @height,
                                     0, @depth, @height

      top1.offset @position_x, @position_y, @position_z

      top2 = CaseMaker::Triangle.new 0, @depth, @height,
                                     @width, 0, @height,
                                     @width, @depth, @height
      top2.offset @position_x, @position_y, @position_z

      bottom1 = CaseMaker::Triangle.new 0, 0, 0,
                                        0, @depth, 0,
                                        @width, @depth, 0
      bottom1.offset @position_x, @position_y, @position_z

      bottom2 = CaseMaker::Triangle.new 0, 0, 0,
                                        @width, @depth, 0,
                                        @width, 0, 0
      bottom2.offset @position_x, @position_y, @position_z

      left1 = CaseMaker::Triangle.new 0, 0, 0,
                                      0, @depth, @height,
                                      0, @depth, 0
      left1.offset @position_x, @position_y, @position_z

      left2 = CaseMaker::Triangle.new 0, 0, 0,
                                      0, 0, @height,
                                      0, @depth, @height
      left2.offset @position_x, @position_y, @position_z

      right1 = CaseMaker::Triangle.new @width, 0, 0,
                                       @width, @depth, 0,
                                       @width, 0, @height
      right1.offset @position_x, @position_y, @position_z

      right2 = CaseMaker::Triangle.new @width, 0, @height,
                                       @width, @depth, 0,
                                       @width, @depth, @height
      right2.offset @position_x, @position_y, @position_z

      front1 = CaseMaker::Triangle.new 0, 0, 0,
                                       @width, 0, 0,
                                       @width, 0, @height
      front1.offset @position_x, @position_y, @position_z

      front2 = CaseMaker::Triangle.new 0, 0, 0,
                                       @width, 0, @height,
                                       0, 0, @height
      front2.offset @position_x, @position_y, @position_z

      back1 = CaseMaker::Triangle.new 0, @depth, 0,
                                      0, @depth, @height,
                                      @width, @depth, 0
      back1.offset @position_x, @position_y, @position_z

      back2 = CaseMaker::Triangle.new 0, @depth, @height,
                                      @width, @depth, @height,
                                      @width, @depth, 0
      back2.offset @position_x, @position_y, @position_z

      @triangles = [ top1, top2, bottom1, bottom2, left1, left2, right1, right2, front1, front2, back1, back2 ]
    end

    def to_stl
      stl = ''
      @triangles.each { |triangle| stl += triangle.to_stl }

      stl
    end
  end
end
