# encoding: utf-8
require "minitest/autorun"
require "stringio"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../..', 'lib'))

require "geoname"

describe Geoname::Index do
  let(:data){ StringIO.new <<EOF
3038814	Costa de Xurius	Costa de Xurius		42.5	1.48333	T	SLP	AD		00				0		1316	Europe/Andorra	1993-12-23
3038815	Font de la Xona	Font de la Xona		42.55003	1.44986	H	SPNG	AD		04				0		2082	Europe/Andorra	2010-01-11
3038816	Xixerella	Xixerella		42.55327	1.48736	P	PPL	AD		04				0		1520	Europe/Andorra	2009-04-24
3038817	Xixerella	Xixerella	Xixerella	42.55	1.48333	A	ADMD	AD		00				0		1548	Europe/Andorra	2012-01-18
3038818	Riu Xic	Riu Xic		42.56667	1.68333	H	STM	AD		00				0		2340	Europe/Andorra	1993-12-23
3038819	Pas del Xic	Pas del Xic		42.5	1.58333	R	TRL	AD		00				0		1888	Europe/Andorra	1993-12-23
3038820	Roc del Xeig	Roc del Xeig		42.56667	1.48333	T	RK	AD		00				0		1508	Europe/Andorra	1993-12-23
3038821	Collada del Xeig	Collada del Xeig		42.56667	1.48333	T	PK	AD		00				0		1508	Europe/Andorra	1993-12-23
3038822	Fonts Vives	Fonts Vives		42.5	1.56667	H	SPNG	AD		00				0		1776	Europe/Andorra	1993-12-23
3038823	Roc de Vista	Roc de Vista		42.5	1.48333	T	RK	AD		00				0		1316	Europe/Andorra	1993-12-23
3038824	Obaga de Vista	Obaga de Vista		42.48333	1.45	T	SLP	AD		00				0		1195	Europe/Andorra	1993-12-23
3038825	Coll de Vista	Coll de Vista		42.46667	1.58333	T	SPUR	AD		00				0		2367	Europe/Andorra	1993-12-23
3038826	Coll de Vista	Coll de Vista	Coll de Vista	42.48333	1.43333	T	PASS	AD		00				0		1938	Europe/Andorra	2012-01-18
3038827	Visanseny	Visanseny	Visanceny,Visanseny	42.56667	1.61667	L	LCTY	AD	AD	00				0		1920	Europe/Andorra	2012-01-18
3038828	Roc de la Vinya	Roc de la Vinya		42.53333	1.56667	T	RK	AD		00				0		1418	Europe/Andorra	1993-12-23
3038829	Canal de la Vinya	Canal de la Vinya		42.51667	1.51667	H	STM	AD		00				0		1265	Europe/Andorra	1993-12-23
3038830	Bosc de Villar	Bosc de Villar		42.6	1.55	V	FRST	AD		00				0		2298	Europe/Andorra	1993-12-23
3038831	Torrent de Vila	Torrent de Vila		42.53333	1.56667	H	STM	AD		00				0		1418	Europe/Andorra	1993-12-23
3038832	Vila	Vila	Casas Vila,Vila	42.53222	1.57392	P	PPL	AD		03				0		1418	Europe/Andorra	2012-01-18
3038833	Basers de Vicenç	Basers de Vicenc		42.48333	1.48333	T	CLF	AD		00				0		981	Europe/Andorra	1993-12-23
EOF
}

  it 'shoulde parse the data' do
    idx = Geoname::Index.new 'test'
    values = {}
    data.each do |line|
      v = idx.read_line line
      values[v['id']] = v
    end
    values['3038827']['alternatenames'][1].should eq 'Visanseny'
  end

end
