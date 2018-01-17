# Pinpoint
Simple iOS application based on ProjectDent's ARCL framework

## Features

* Ability to save current location or any other location on the map
* Offline support
* List of pins with surrounding map to differentiate amongst saved pins
* View pins(currently hard set to a car emoji) and the distance they're away from your current location 
* Map that shows Current location and Pin, while viewing pin in AR

## Bugs
* On initial launch when user goes to view a pin, the map does not automatically zoom in to where the current location and pin are, it is zoomed out to North America, fixes after going back and viewing again. 

## Requirements 
* As it's an AR app it cannot be run on simulators, only iPhones 6s and up due to needing arm v7 for ar, opitimized for iPhone X

Based off ProjectDent's AR+CL https://github.com/ProjectDent/ARKit-CoreLocation 
