#coding: utf-8

import serial
import time
fpath = './test.json'

ser = serial.Serial('COM3', 115200, timeout=1)



while True:





	postition = ser.readline()	
	postition = postition.decode()
	if len(postition):
		#print(postition)
		x = postition.split(' ')[0]
		y = postition.split(' ')[1]

		print(int(x))
		print(int(y))
		y = str(int(y))
		x = '"theta":'+'"'+x+'",'
		y = '"phi":'+'"'+y+'"'
		f = open(fpath,'w')
		f.write('[')
		f.write('	{')
		f.write(x)
		f.write(y)
		f.write('	}')
		f.write(']')
		f.close()
	# print(x),
	# print(y)
