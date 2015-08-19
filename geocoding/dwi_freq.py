# count location frequency

with open("dwi.geo.csv",'r') as data, open("dwi.geo.freq.csv", 'w') as output:
	data_dict = {}
	for line in data:
		date, address, lat, lon = line.rstrip('\n').split(',')
		latlon = lat+','+lon
		# Is in dict?
		if lat+','+lon in data_dict:
			data_dict[latlon] += 1
			output.write("{},{}\n".format(line.rstrip('\n'),data_dict[latlon]))
		else:
			data_dict[latlon] = 1
			output.write("{},{}\n".format(line.rstrip('\n'),data_dict[latlon]))
