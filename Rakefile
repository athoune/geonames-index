file 'hierarchy.zip' do
  `curl -O http://download.geonames.org/export/dump/hierarchy.zip`
end

file 'allCountries.zip' do
  `curl -O http://download.geonames.org/export/dump/allCountries.zip`
end

task :zip => ['hierarchy.zip', 'allCountries.zip']

file 'hierarchy.txt' => 'hierarchy.zip' do
  `unzip hierarchy.zip`
end

file 'allCountries.txt' => 'allCountries.zip' do
  `unzip allCountries.zip`
end

task :data => ['allCountries.txt', 'hierarchy.txt']
