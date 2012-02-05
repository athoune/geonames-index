require 'rubygems'
require 'tire'
require_relative 'hierarchy'

module Geoname

  class Index

    attr_accessor :hierarchy
    attr_reader :name

    def initialize name
      @name = name
      @created = false
      @batch_size = 10000
      @hierarchy = nil
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

    def read_line line
      keys = %w{id name asciiname alternatenames latitude longitude feature_class feature_code country_code cc2 admin1 admin2 admin3 admin4 population elevation gtopo30 timezone modification}
      values = {}
      i = 0
      line[0..-2].split("\t").each do |v|
        values[keys[i]] = v
        i += 1
      end
      values['alternatenames'] = values['alternatenames'].split(',')
      %w{latitude longitude}.each do |f|
        values[f] = values[f].to_f
      end
      if @hierarchy
        values['path'] = @hierarchy.parents[values[id]].join('/')
      end
      values
    end

    def index data
      cpt = 0
      values = []
      data.each do |line|
        values << read_line(line)
       cpt += 1
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
