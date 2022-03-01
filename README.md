<h1 align="center">
Weather Forecast
</h1>

<img src="https://user-images.githubusercontent.com/75203610/155876141-975cdea4-fd22-4e76-96c7-14a2d0421e1d.gif" align="right" width="380" height="400">

WeatherForecast is a weather app that lists cities near your location and you can get daily forecasts using  [MetaWeather](https://www.metaweather.com/) api.

# Table of contents
1. [Features](#Features)
2. [Used Methods and Libraries](#UsedMethodsandLibraries)
4. [Usage](#Usage)
5. [Requiremonts](#Requiremonts)
6. [Installation](#Installation)
7. [Warning](#Warning)
8. [Screen Shots](#ScreenShots)
9. [Communication](#Communication)

## Features<a name="Features"></a>
- With user interface UI design
- Capturing the same image for different resolution devices with responsive screen design
- It has high testability and readability with Clean Architecture -VIP
- Rest Api operations are done using Alamofire library
- With the KingFisher library, the images are kept in the cache and the loading of the images is made easier
- Repeated code blocks recommended for clean coding are combined in flexible methods
- The operations to be done on the project created on Git are divided into branches and the project is completed over the branches
- Care was taken to ensure that in-app method and variable naming are in English and comprehensible

## Used Methods and Libraries <a name="UsedMethodsandLibraries"></a>
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [KingFisher](https://github.com/onevcat/Kingfisher)
- [SwiftGifOrigin](https://cocoapods.org/pods/SwiftGifOrigin)

## Usage <a name="Usage"></a>
The city you are in and nearby cities are listed on the home page of the weather forecast application. You can search by city name with the help of the search bar on the main page. Clicking on the desired cell in the list will take you to the city detail page. Daily forecast details and 1-week forecast are listed. Clicking on any day displays the details of that day.
## Requiremonts <a name="Requiremonts"></a>
Versions I use:
- `ruby 2.6.3p62`
- `cocoapods-1.11.2` 

## Installation <a name="Installation"></a>
- paste `git clone https://github.com/SaniyeToy/WeatherForecast.git` into terminal
- `pod install` is written to the file path of the application in the terminal and the application is run on xcode
 

## Warning <a name="Warning"></a>
- if you are getting a `Error domain kclerrordomain code 0 null`  error
- Go to :
Product -> Scheme -> Edit Scheme -> Options -> Allow Location Simulation must be checked and try providing a default location, don't leave it set to "none"
And restart Xcode and you're done :)

## Screen Shots <a name="ScreenShots"></a>

 <table>
  <tr>
    <td>CityList View</td>
    <td>City Details View</td>
    <td>List View Search</td>

  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/75203610/156005617-c7d3372b-805f-4d87-a0b0-5869119faa84.jpeg" width=230 height=480></td>
    <td><img src="https://user-images.githubusercontent.com/75203610/156005326-4a575677-eecd-4b69-a8d1-e3f33f61d666.jpeg" width=230 height=480></td>
    <td><img src="https://user-images.githubusercontent.com/75203610/156005246-ee5df9ec-0d5d-48cc-b740-15adc43d53ba.jpeg" width=230 height=480></td>
   
  </tr>
 </table>

https://user-images.githubusercontent.com/75203610/156004885-02d7fa65-32b0-4c28-bead-4a901f4c8b69.mp4


## Communication <a name="Communication"></a>
- [GitHub](https://github.com/SaniyeToy)
- [Linkedln](https://www.linkedin.com/in/saniye-toy/)
