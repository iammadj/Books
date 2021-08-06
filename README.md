# Books (better naming came later, sorry. I would name it "BookSearchApp")

This is a test and simple app for iOS platform, which was written on Swift.

In this demo application was used VIPER architecture and some of desgin patterns.

UI is fully programmatically and code based on Protocol Oriented Programming. 

App has things like:
- Managers;
- Abstract Endpoint, JSON object Mapping, Service protocols and realization; 
- Custom Views;
- Factory desing pattern;
- Best practice extensions;
- Helper;
- Error Catching and showing it.

Used minimum third-party libraries with Swift Package Dependencies
(Alamofire, Kingfisher, SwiftyJSON)

Edited Info.plist to allow arbitrary loads.

And finally about scenes:
1. App has main screen (UICollectionView) with search controller, where we can enter query text and get items from google API.
After getting items and showing them with thumbnail, book title and author, we can select item and go to next screen.
2. Next screen is Book Details, where we can see thumbnail at the top and below the book title, authors and book description.
3. If we will get error, then app shows Error View.

Thanks!
