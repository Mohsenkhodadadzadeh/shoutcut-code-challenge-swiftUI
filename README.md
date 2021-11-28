# Shortcut-code-challenge UIKit Version

## Project Images
here is the screenshots of views:

![Browse View](https://github.com/Mohsenkhodadadzadeh/shoutcut-code-challenge-swiftUI/blob/master/raedmeimages/br.png) ![Detail View](https://github.com/Mohsenkhodadadzadeh/shoutcut-code-challenge-swiftUI/blob/master/raedmeimages/dt.png) ![Favorite view](https://github.com/Mohsenkhodadadzadeh/shoutcut-code-challenge-swiftUI/blob/master/raedmeimages/fv.png)

## Prepare app before run:

Before run the project you must define `server_url` and `destination_file` as process enviorment object. for doing that you need open `Edit scheme` from `Product -> Scheme -> Edit scheme' menu. and add the Enviorment Variables same as following image if they are not exist.
![Enviorment variables in scheme](https://github.com/Mohsenkhodadadzadeh/shoutcut-code-challenge-swiftUI/blob/readme/raedmeimages/scheme.png)

## Some notes before reviewing code and commits.

### Why I have just added bitrise as CI:
because I use iOS 15 as deployment target to use `async await` multithreading way and for this reason I could not use Github CI ( because the max deployment target for github CI is iOS 14), and may you want to know why any merge did not test with Bitrise. it is because of I used the free plan of Bitrise and I used all credits as free and unfortunately I am not able to charge it, because I live in a country which does not access to any International credit card ( like visacard and master card), but all tests were passed on xcode.


## Services

#### Services
This class is responsible for generating URL and also loading an image from a remote server

Relative tests for this class are:

```swift
ServicesTest.testgenerateCurrentUrl()
ServicesTest.testGenerateSpecificComicUrl()
```

#### Storage

this class is responsible to save and retrieve data from CoreData

Relative test for this class is:

```swift
ServicesTest.testSaveComicOnCoreData()
ServicesTest.testFetchAllData()
ServicesTest.testRemoveData()
ServicesTest.testRemoveItemNotExist()
ServicesTest.testDuplicateSave()

```

#### RemoteDownloader

This ObservableObject class is responsible for download data from remote server ( like image, video or etc) and feedback to the observed class.


#### UserNotification

This class is responsible to get push notification permission from user(or may do other activities if they are needed).

#### Background Task for sending notification

It is handled on `shortcut_code_challenge_swiftUIApp.swift` file (project's @main)
