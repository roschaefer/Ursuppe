from spyrk import SparkCloud

USERNAME = 'post@jakobvicari.de'
PASSWORD = 'nh55;4()&A43/!'
ACCESS_TOKEN = 'e4d91251296c3d1f3d1814865d76868ab73883c3'

spark = SparkCloud(USERNAME, PASSWORD)
# Or
spark = SparkCloud(ACCESS_TOKEN)

# List devices
print(spark.devices)

# Access device

spark.devices['DrJakobs_CoreZwo']
# Or, shortcut form
spark.DrJakobs_CoreZwo
# List functions and variables of a device
print(spark.DrJakobs_CoreZwo.functions)
print(spark.DrJakobs_CoreZwo.variables)

# Tell if a device is connected
print(spark.DrJakobs_CoreZwo.connected)

## Call a function
##spark.DrJakobs_CoreZwo.digitalwrite('D7', 'HIGH')
##print(spark.DrJakobs_CoreZwo.analogread('A0'))
## (or any of your own custom function)

## Get variable value
#spark.DrJakobs_CoreZwo.myvariable
