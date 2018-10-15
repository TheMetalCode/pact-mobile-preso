# Sample iOS Swift consumer and ruby provider.
This is a demonstration project for using the [Swift Pact library](https://github.com/DiUS/pact-consumer-swift).

### To build and run Pact Swift Tests
The application uses Carthage for building library dependencies. If you are not familiar with carthage, see [Carthage](https://github.com/Carthage/Carthage) for more details.

* Install the pact mock service gem (required for running the iOS Pact tests).
```
CatKitNew $ bundle install
```

(Execute from the CatKit directory)

* Run the iOS unit tests. (can be done from within XCode if you prefer)
```
CatKitNew $ bundle exec pact-mock-service start --pact-specification-version 2.0.0 --log "tmp/pact.log" --pact-dir "tmp/pacts" -p 1234
CatKitNew $ export SIMULATOR_ID=$(xcrun instruments -s | grep -o "iPhone X (12.0) \[.*\]" | grep -o "\[.*\]" | sed "s/^\[\(.*\)\]$/\1/")
CatKitNew $ xcodebuild -workspace CatKitNew.xcworkspace -scheme CatKitNew -destination "platform=iOS Simulator,id=$SIMULATOR_ID" clean test
CatKitNew $ bundle exec pact-mock-service stop
```
This will run the unit tests (Pact Tests). After the pact tests run successfully the generated pact files should live in the `CatKitNew/tmp/pacts/` directory. A log of the pact test interactions can be found here `CatKitNew/tmp/pact.log`. If the tests fail, try looking in here for details as to why.

### Verify the ruby server with the generated pact file
Copy over the generated pact file from the iOS project, to the ruby server.
```
catkit-server $ cp ../CatKitNew/tmp/pacts/catkit_ios_app-catkit_service.json pacts/ios-app/
```
(Execute from the catkit-server directory)

Run the pact verification to verify that the server conforms to the CatKit client.
```
catkit-server $ bundle exec rake pact:verify
```

NB: to run the catkit-server:
```
catkit-server $ bundle exec rackup config.ru
```

# More reading
* [Swift Pact library](https://github.com/DiUS/pact-consumer-swift)
* The original pact library, with lots of background and guidelines [Pact](https://github.com/realestate-com-au/pact)
* The pact mock server that the Swift library uses under the hood [Pact mock service](https://github.com/bethesque/pact-mock_service)
* A pact broker for managing the generated pact files (so you don't have to manually copy them around!) [Pact broker](https://github.com/bethesque/pact_broker)
