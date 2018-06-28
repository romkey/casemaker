class CaseMaker
  class Triangle
    attr_accessor :x1, :y1, :z1, :x2, :y2, :z2, :x3, :y3, :z3

    def initialize(x1, y1, z1, x2, y2, z2, x3, y3, z3)
      self.x1 = x1
      self.y1 = y1
      self.z1 = z1

      self.x2 = x2
      self.y2 = y2
      self.z2 = z2
      
      self.x3 = x3
      self.y3 = y3
      self.z3 = z3
    end

    def normal
      ux = self.x2 - self.x1
      uy = self.y2 - self.y1
      uz = self.z2 - self.z1

      vx = self.x3 - self.x1
      vy = self.y3 - self.y1
      vz = self.z3 - self.z1
      
      nx = uy*vz - uz*vy
      ny = uz*vx - ux*vz
      nz = ux*vy - uy*vx

      return [ nx, ny, nz ]
    end

    def offset(x, y, z)
      self.x1 += x
      self.x2 += x
      self.x3 += x

      self.y1 += y
      self.y2 += y
      self.y3 += y

      self.z1 += z
      self.z2 += z
      self.z3 += z
    end

    def to_stl
      n = normal
      n = [0, 0, 0]

      <<END_OF_STL
  facet normal #{n[0]} #{n[1]} #{n[2]}
    outer loop
      vertex #{self.x1} #{self.y1} #{self.z1}
      vertex #{self.x2} #{self.y2} #{self.z2}
      vertex #{self.x3} #{self.y3} #{self.z3}
    endloop
  endfacet

END_OF_STL
    end
  end
end
