module Geoname

  class Hierarchy
    attr_reader :childrens, :parents, :hierarchy

    def initialize data
      @childrens = {}
      @parents = {}
      data.each do |line|
        parent, children, relation = line[0..-2].split("\t")
        @childrens[parent] = [] unless @childrens.key? parent
        @childrens[parent] << children
        @parents[children] = parent
      end
      data.close
      @hierarchy = {}
      @parents.each do |children, parent|
        @hierarchy[children] = []
        son = children
        while son
          son = @parents[son]
          @hierarchy[children] << son if son
        end
      end

    end
  end

end

