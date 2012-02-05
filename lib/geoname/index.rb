require 'rubygems'
require 'tire'
require_relative 'hierarchy'

module Geoname

  class Index

    def initialize name
      @name = name
      @created = false
      @batch_size = 10000
    end

    def delete
      Tire.index @name do
        delete
      end
      @created = false
    end

    def init
      unless @created
        Tire.index @name do
          create conf
        end
        @created = true
      end
    end

    def index data
      cpt = 0
      values = []
      data.each do |line|
        cpt += 1
        id, name = line.split("\t")
        values << {
          id: id,
          name: name
        }
       if (cpt % @batch_size) == 0
         batch_index values
         yield cpt
       end
      end
      data.close
    end

    private
    def batch_index values
      Tire.index @name do
        import values
      end
    end

  end

end
