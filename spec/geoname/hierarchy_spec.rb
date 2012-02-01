require "minitest/autorun"
require "stringio"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../..', 'lib'))

require "geoname/hierarchy"

describe Geoname::Hierarchy do
  let(:data){ StringIO.new <<EOF
6295630	6255146	ADM
6295630	6255152	ADM
6295630	6255147	ADM
6295630	6255148	ADM
6295630	6255149	ADM
6295630	6255151	ADM
6295630	6255150	ADM
6255148	3041565	ADM
6255147	290557	ADM
6255147	1149361	ADM
6255149	3576396	ADM
6255149	3573511	ADM
6255148	783754	ADM
6255147	174982	ADM
6255149	0	ADM
EOF
}
  it 'should parse a file' do
    h = Geoname::Hierarchy.new data
    p h
  end

end
