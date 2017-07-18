//
// PublicationAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Alamofire



open class PublicationAPI: APIBase {
    /**
     Create a publication for a device for a user

     - parameter userId: (path) The id (UUID) of the user to create a device for
     - parameter deviceId: (path) The id (UUID) of the user device
     - parameter topic: (form) The topic of the publication. This will act as a first match filter. For a subscription to be able to match a publication they must have the exact same topic
     - parameter range: (form) The range of the publication in meters. This is the range around the device holding the publication in which matches with subscriptions can be triggered
     - parameter duration: (form) The duration of the publication in seconds. If set to &#39;-1&#39; the publication will live forever and if set to &#39;0&#39; it will be instant at the time of publication.
     - parameter properties: (form)  A string representing a map of (key, value) pairs in JSON format:  &#x60;{\&quot;key1\&quot;: \&quot;value1\&quot;, \&quot;key2\&quot;: \&quot;value2\&quot;}&#x60;
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func createPublication(userId: String, deviceId: String, topic: String, range: Double, duration: Double, properties: Properties, completion: @escaping ((_ data: Publication?,_ error: Error?) -> Void)) {
        createPublicationWithRequestBuilder(userId: userId, deviceId: deviceId, topic: topic, range: range, duration: duration, properties: properties).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Create a publication for a device for a user
     - POST /users/{userId}/devices/{deviceId}/publications
     - API Key:
       - type: apiKey api-key
       - name: api-key
     - examples: [{contentType=application/json, example={
  "duration" : 1.3579000000000001069366817318950779736042022705078125,
  "op" : "aeiou",
  "topic" : "aeiou",
  "range" : 1.3579000000000001069366817318950779736042022705078125,
  "location" : {
    "altitude" : 1.3579000000000001069366817318950779736042022705078125,
    "verticalAccuracy" : 1.3579000000000001069366817318950779736042022705078125,
    "latitude" : 1.3579000000000001069366817318950779736042022705078125,
    "horizontalAccuracy" : 1.3579000000000001069366817318950779736042022705078125,
    "timestamp" : 123456789,
    "longitude" : 1.3579000000000001069366817318950779736042022705078125
  },
  "publicationId" : "aeiou",
  "deviceId" : "aeiou",
  "properties" : "aeiou",
  "timestamp" : 123456789
}}]

     - parameter userId: (path) The id (UUID) of the user to create a device for
     - parameter deviceId: (path) The id (UUID) of the user device
     - parameter topic: (form) The topic of the publication. This will act as a first match filter. For a subscription to be able to match a publication they must have the exact same topic
     - parameter range: (form) The range of the publication in meters. This is the range around the device holding the publication in which matches with subscriptions can be triggered
     - parameter duration: (form) The duration of the publication in seconds. If set to &#39;-1&#39; the publication will live forever and if set to &#39;0&#39; it will be instant at the time of publication.
     - parameter properties: (form)  A string representing a map of (key, value) pairs in JSON format:  &#x60;{\&quot;key1\&quot;: \&quot;value1\&quot;, \&quot;key2\&quot;: \&quot;value2\&quot;}&#x60;

     - returns: RequestBuilder<Publication>
     */
    open class func createPublicationWithRequestBuilder(userId: String, deviceId: String, topic: String, range: Double, duration: Double, properties: Properties) -> RequestBuilder<Publication> {
        var path = "/users/{userId}/devices/{deviceId}/publications"
        path = path.replacingOccurrences(of: "{userId}", with: "\(userId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{deviceId}", with: "\(deviceId)", options: .literal, range: nil)
        let URLString = ScalpsAPI.basePath + path

        let nillableParameters: [String:Any?] = [
            "topic": topic,
            "range": range,
            "duration": duration,
            "properties": properties
        ]

        let parameters = APIHelper.rejectNil(nillableParameters)

        let convertedParameters = APIHelper.convertBoolToString(parameters)

        let requestBuilder: RequestBuilder<Publication>.Type = ScalpsAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    /**
     Get all publications for a device

     - parameter userId: (path) The id (UUID) of the user
     - parameter deviceId: (path) The id (UUID) of the device
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getPublications(userId: String, deviceId: String, completion: @escaping ((_ data: Publications?,_ error: Error?) -> Void)) {
        getPublicationsWithRequestBuilder(userId: userId, deviceId: deviceId).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Get all publications for a device
     - GET /users/{userId}/devices/{deviceId}/publications
     - API Key:
       - type: apiKey api-key
       - name: api-key
     - examples: [{contentType=application/json, example=""}]

     - parameter userId: (path) The id (UUID) of the user
     - parameter deviceId: (path) The id (UUID) of the device

     - returns: RequestBuilder<Publications>
     */
    open class func getPublicationsWithRequestBuilder(userId: String, deviceId: String) -> RequestBuilder<Publications> {
        var path = "/users/{userId}/devices/{deviceId}/publications"
        path = path.replacingOccurrences(of: "{userId}", with: "\(userId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{deviceId}", with: "\(deviceId)", options: .literal, range: nil)
        let URLString = ScalpsAPI.basePath + path

        let nillableParameters: [String:Any?] = [:]

        let parameters = APIHelper.rejectNil(nillableParameters)

        let convertedParameters = APIHelper.convertBoolToString(parameters)

        let requestBuilder: RequestBuilder<Publications>.Type = ScalpsAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

}