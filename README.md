# Eazyshow

### Installation
Add package from https://github.com/KopievDev/Eazyshow
| First step | Second step |
| ------ | ------ |
|![Снимок экрана 2022-07-05 в 15 53 08](https://user-images.githubusercontent.com/78022759/177332120-de504661-d744-4e59-b3a4-a1ab9dac2ed4.png)|![Снимок экрана 2022-07-05 в 15 53 44](https://user-images.githubusercontent.com/78022759/177332515-5ca0828c-fbba-4026-a332-1ed00209a390.png)|


### 1) Get a token and ID from your account and create an instance of the `Assignment` class

| Token | Account ID |
| ------ | ------ |
|![token](https://user-images.githubusercontent.com/78022759/177321304-b13dbe91-ffb7-421b-9b06-c9b019f1da8d.png)|![account](https://user-images.githubusercontent.com/78022759/177321320-62df6f71-70c2-4553-b09c-fd1a3393592b.png)|

```swift
 lazy var assignment = Assignment(parameters: ["account": "95453f64-b803-4495-abd9-9c785590f2fe", 
                                                 "token": "7157fb3c-268b-4cf9-9988-beb4d2370cda"]) // With Dictionaty
 lazy var assignment = Assignment(account: "95453f64-b803-4495-abd9-9c785590f2fe",
                                    token: "7157fb3c-268b-4cf9-9988-beb4d2370cda")  // simple initialization without other parameters
```

### 2) Create an instance of the `User` class using a dictionary or directly

```swift
 lazy var user = User(parameters: ["firstName":"John", "lastName":"Dorian", "id":"2323"]) // With Dictionaty
 lazy var user = User(firstName: "John", lastName: "Dorian") // simple initialization without other parameters
```
### 3) Create an instance of the `Session` class using User, Assignment instances and a connection reference

```swift
 lazy var session = Session(user: user, assignment: assignment, url: URL(string: "https://stage.verishow.com/client/conference/sdk/ios")!)
```

### 4) To call a session, use the following method `func show(from vc: UIViewController)`
```swift
  override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      session.show(from: self)
  }
```
if your ViewController conforms to the `SessionDelegate` protocol, then after calling this method, your controller will become the delegate of this session
```swift
//MARK: - SessionDelegate -
extension ViewController: SessionDelegate {
    func session(_ session: Session, didReceive data: [String : Any]?) {
        let resp = data?["name"] as? String ?? "other data format"
        print(resp)
        if resp == "vsSessionClosed" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                session.close()
            }
        }
    }
}
```



### 5)And be sure to add this code to `info.plist`
```xml
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Location please</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Location please</string>
<key>NSDocumentsFolderUsageDescription</key>
<string>DocumentsFolder please</string>
<key>NSCameraUsageDescription</key>
<string>camera please</string>
<key>NSMicrophoneUsageDescription</key>
<string>mic please</string>
```

### 6) To close a session window, use the `func close()` method

```swift
 session.close()
```

### Example 
```swift
import UIKit
import Eazyshow

class ViewController: UIViewController {
    //MARK: - Required Properties -
    private var session: Session!
    //MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        let user = User(parameters: ["firstName":"John", "lastName":"Dorian", "id":"2323"])
        let agent = Assignment(parameters: ["account": "95453f64-b803-4495-abd9-9c785590f2fe", "token": "7157fb3c-268b-4cf9-9988-beb4d2370cda"])
        Assignment(account: "95453f64-b803-4495-abd9-9c785590f2fe", token: "7157fb3c-268b-4cf9-9988-beb4d2370cda")
        session = Session(user: user, assignment: agent, url: URL(string: "https://stage.verishow.com/client/conference/sdk/ios")!)
        session.isDebug = true
    }
    
    @IBAction private func didTap(button: UIButton) {
        session.show(from: self)
    }
}

//MARK: - SessionDelegate -
extension ViewController: SessionDelegate {
    func session(_ session: Session, didReceive data: [String : Any]?) {
        let resp = data?["name"] as? String ?? "other data format"
        print(resp)
        //Если раскомментировать код ниже, экран с сессией закроется после отправки обратной связи
//        if resp == "vsFeedbackSent" {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                session.close()
//            }
//        }
    }
}
```
