iPhone-App : Yelp (BookMarkSearchMap)
=====================================


What is it?
-----------

This is an iPhone app, which is capable of searching for a list 
of venues (restaurants, etc...) matching a keyword within an N 
mile radius. Think Google maps.
This app implement a framework (library) to handle the searching,  
enable the user to input a search term, and plot the results on 
a map. Moreover, this app provide another viewing option: a list of 
venues. The user may want to remember details about a location 
offline. So, we are going to use CoreData to save those results.


The Latest Version
------------------

Details of the latest version can be found on the  project page:
```iOS-App-Project-----Yelp```, under https://github.com/kiddkevin00


Documentation
-------------
1. User will pass it a GPS location(user’s current location). 
Implement query term and radius, and it will return a list of 
Venue objects
2. The results will come through a protocol callback. Displaying 
the results on a map.
3. Implement UITabBar, UITableView Controller to display different 
view(page).
4. Implement CoreData to store user in user’s preference


Installation
------------
Simply open the project file through Xcode(Version 5.0+). Before 
running it on iPhone Simulator, make sure ENTER YOUR GOOGLE API KEY in ```ViewController.m```








