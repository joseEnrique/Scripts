from pymongo import MongoClient
import os
import sys
import datetime
from dateutil.relativedelta import *
import pprint
ip = os.getenv('MONGOIP') or 'localhost'
port = os.getenv('MONGOPORT') or 27017
db = os.getenv('MONGODB') or "db"
collection = os.getenv('MONGOCOLLECTION') or "collection"


client = MongoClient(ip, port)
db = client[db]
collection = db[collection]

list_lasts=collection.find({"read":False,"createdAt":{"$lt": datetime.datetime.utcnow()}})
count=0
for value in list_lasts:
    d_id = value["_id"]
    collection.update_one({'_id':d_id}, {"$set": {'read': True}})
    count += 1

print "Finished at "
print datetime.datetime.utcnow()
print "changed "+ str(count)
