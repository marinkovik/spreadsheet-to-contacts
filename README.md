# spreadsheet-to-contacts
Contacts book from Google spreadsheet

Swift language version: 4.2
Pods: Alamofire, SwiftyJSON, RealmSwift

# Spreadsheet to contacts book
Make a google spreadsheet with phone numbers and emails of your employees. Have their numbers in seperate application. 

# Demo
![](https://media.giphy.com/media/ZBVoWeoZzHI5az703V/giphy.gif)

# How to use
Make a Google spreadsheet with three columns and name them "Name", "Mail" and "Phone Number". Get shareable link and pass the link into
 textFieldForSource. You can override this by adding more columns and you can access to those columns in the method "getContactsData" 
 with contact["YOUROWNTHING"].string!, for example 
 ``` contact["Home Adress"].string! ```
![](screenshot1.png)
The contacts will be available without internet and even after terminate the application. There is feature for updating the users' phone and mails. The location of database for debugging and testing is ```Realm.Configuration.defaultConfiguration.fileURL```



# How to build
1. Clone this repository 
``` $ git clone https://github.com/marinkovik/spreadsheet-to-contacts.git ```
2. Install pods
``` $ pod install ```

Database location for debugging 

```Realm.Configuration.defaultConfiguration.fileURL```


//TODO: Search feature and sending mail
