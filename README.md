# App Developer Test
A simple app that allows user to search for venues using Foursquare API.

## Installation
Checkout the code and run `pod install`

## Project structure
* App (Put your screens code here, e.g. view controller, coordinators etc.)
* Helpers (Helpers and utility classes)
* Services (Any services that are used in the app. For example HTTPClient, persistent storage and so on)

## Libraries
* Alamofire
* AlamofireObjectMapper
* ObjectMapper
* OHHTTPStubs

## Approach description
Solution is based on MVC architecture, because the problem is simple and MVC is the quickest way.

### Foursquare API authentication
The solution supports userless Foursquare authentication. Feel free to change `clientID` and `clientSecret` as you wish inside `FoursquareAPI.default` implementation.

`FoursquareAPI` class contains http client (based on `Alamofire`) for foursquare REST requests. Authentication is made via `RequestAdapter`, see `FoursquareAPIRequestAdapter`.
