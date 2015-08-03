# Geopy DWI
from geopy.geocoders import GoogleV3
import time

geolocator = GoogleV3()

with open("DWI_2011_2014.csv",'r') as addresses, open("dwi.address.geocode.csv", 'w') as output:
	for line in addresses:
		location = geolocator.geocode(line.rstrip('\n').split(',')[1])
		try: 
			output.write("{},{},{}\n".format(line.rstrip('\n'), location.latitude, location.longitude))
			time.sleep(.5)
		except AttributeError:
			print line

