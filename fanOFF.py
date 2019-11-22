import RPi.GPIO as GPIO
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(10,GPIO.OUT)
print "FAN off"
GPIO.output(10,GPIO.LOW)
