import RPi.GPIO as GPIO
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(10,GPIO.OUT)
print "FAN on"
GPIO.output(10,GPIO.HIGH)
