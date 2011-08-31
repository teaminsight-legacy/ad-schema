module Seed
  class << self

    def up
      self.down
      #container = AD::Container.create({ :name => "AD Schema Tests" })
    end

    def down
      #container = AD::Container.first({ :name => "AD Schema Tests" })
      #container.destroy if container
    end

  end
end
