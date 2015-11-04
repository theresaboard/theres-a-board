class Light
  def self.on
    begin
      a = ['red','green','blue','0,128,128', "128,0,128"]
      Particle.publish(name: "aBcK9anskFasd", data: a.sample)
    rescue
      return false
    end
  end

  def self.off
    begin
      Particle.publish(name: "aBcK9anskFasd", data: "off")
    rescue
      return false
    end
  end

end
