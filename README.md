# legendary-waffle

## Assignment

Code a simple application that meets the following requirements.
* The application should be able to fetch a list of all users from the following endpoint:

    * [http://jsonplaceholder.typicode.com/users](http://jsonplaceholder.typicode.com/users)

* The application should be able to persist the list of all users to the local
database, to be used on future startups

* The application should display the list of users from above
    * The list cells should provide the relevant and most important
information of the above user

* The application user should be able to select one of the users from the list,
and see all of the information related to that user

#### Extra Credit

* Make it pretty! Add some animations, styling, theming, etc. to the application

* For super-extra-credit, create a mechanism for displaying the photos, as defined by

    * [http://jsonplaceholder.typicode.com/photos](http://jsonplaceholder.typicode.com/photos)

    * There is no need to handle all of the photos, perhaps pick a specific
photo or two, or maybe an entire album in a list, depending on how far you want to go!

## Solution

The app "Sulution" is my answer to the assignment. It consists of a single Tab Bar Controller that toggles between two Navigation Controllers: UserNavigationViewControllers and PhotoNavigationViewController

### The UI

#### UserNavigationViewController

This has a subclassed Table View Controller embedded within it. When this Table View Controller is loaded, an NSURLSession reqeuest is called to the endpoint listed in the requirements. This request then populates the models with the data that was recieved and then NSFetchRequestController updates the table with the new data.

The application user can then select a "user" by tapping on a row, which will take them to a new Table View Controller that displays the detail data for the selected user. I used a third-party library called Static to create the tables as it allows for a quick generation of static tables like what was used for the user. The appication user can then further select the user's company field to display further information about the company.

#### PhotoNavigationViewController

This is initially similar to UserNavigationViewController, in that is has a Table View Controller that is embedded within it that also populates data via an NSURLSession and NSFetchRequestController. The table is populated by albums, which when selected navigate to a subclass of UICollectionViewController. The controller then creates cells and downloads that thumbnail for the corresponding Photo. If a user taps a thumbnail, a UIViewController is created and pushed, and a UIImageView will display the full size image (once downloaded)

### The Models

The models consists of the following:

* A **User** object consiting of:
    * ID
    * Name
    * Username
    * Email
    * Phone
    * Website
    * An **Address** object consisting of:
        * Street
        * Suite
        * City
        * Zip
        * A **Geo** object:
            * Latitude
            * Longitude
    * A **Company** object consisting of:
        * Name
        * Catch Phrase
        * BS

These are all subclasses of NSManagedObject as to be handled by Core Data.

## Further Development

A few featurs that could be added in the future:

* Currently the Address's geo coordinates are not used. A feature could be added to display a MapView with the geotagged coordinates as an annotation

* The thumbnail images could be cached or added to Core Data, though adding them to Core Data may effect performance.

* There is currently a bug with endpoint data for photos. The returned url for a photo's thumbnail and full size photo are not the same. A way to fix this would be to eliminate the different URLs in the Photo object and create a new attribute called "URLID" that just saves the very last part of the directory and uses it combined with a static url prefix to download the photos.
