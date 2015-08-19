# Geopy DWI
from geopy.geocoders import GoogleV3
from geopy.exc import GeocoderTimedOut

import time

geolocator = GoogleV3()


#with open("2011_DWI.csv",'r') as addresses, open("2011_DWI.geo.csv", 'w') as output, open("2011_DWI.errors.csv", 'w') as err:
#with open("2012_DWI.csv",'r') as addresses, open("2012_DWI.geo.csv", 'w') as output, open("2012_DWI.errors.csv", 'w') as err:
#with open("2013_DWI.csv",'r') as addresses, open("2013_DWI.geo.csv", 'w') as output, open("2013_DWI.errors.csv", 'w') as err:
with open("2014_DWI.csv",'r') as addresses, open("2014_DWI.geo.csv", 'w') as output, open("2014_DWI.errors.csv", 'w') as err:
	for line in addresses:
		location = geolocator.geocode(line.rstrip('\n').split(',')[1]+"New Orelans", timeout=10)
		try:
			output.write("{},{},{}\n".format(line.rstrip('\n'), location.latitude, location.longitude))
			time.sleep(1)
		except AttributeError:
			err.write(line)
			time.sleep(1)
		except GeocoderTimedOut:
			print "timeout"
			err.write(line)
