$: << './lib'
require 'geoname'

file 'hierarchy.zip' do
  `curl -O http://download.geonames.org/export/dump/hierarchy.zip`
end

file 'allCountries.zip' do
  `curl -O http://download.geonames.org/export/dump/allCountries.zip`
end

task :zip => ['hierarchy.zip', 'allCountries.zip']

file 'hierarchy.txt' => 'hierarchy.zip' do
  `unzip hierarchy.zip` unless File.exist? 'hierarchy.txt' # FIXME
end

file 'allCountries.txt' => 'allCountries.zip' do
  `unzip allCountries.zip` unless File.exist? 'allCountries.txt' # FIXME
end

task :data => ['allCountries.txt', 'hierarchy.txt' ]

task :hierarchy => 'hierarchy.txt' do
  f = File.open 'hierarchy.txt'
  $hierarchy = Geoname::Hierarchy.new f
end

task :index => ['allCountries.txt', :hierarchy] do
  f = File.open 'allCountries.txt'
  idx = ::Geoname::Index.new 'geoname'
  idx.hierarchy = $hierarchy
  idx.index f do |cpt|
    p cpt
  end
end
