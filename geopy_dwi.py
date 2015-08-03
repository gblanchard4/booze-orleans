# Geopy DWI
from geopy.geocoders import GoogleV3
import time

geolocator = GoogleV3()

with open("dwi.address",'r') as addresses, open("dwi.address.geocode", 'w') as output:
	for line in addresses:
		location = geolocator.geocode(line.rstrip('\n'))
		time.sleep(.5)
		output.write("{},{},{}\n".format(line.rstrip('\n'), location.latitude, location.longitude))
