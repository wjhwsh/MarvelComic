# MarvelComic
1. Third party libraries.
    SDWebImage

SDWebImage is an asyncronous image downloading library. 
 
2. Build the app.
   Step1: Open XCode, Open MarvelComic.xcworkspace. Don't open project file MarvelComic.xcodeproj.
   Step2: Open Service.swift, to put your own Marvel API public/private key as follow.  
   
   class Service {
       private static let privateKey =  //please put your own Marvel API private key here
       private static let publicKey =   //please put your own Marvel API public key here

3. You can visit https://developer.marvel.com/account to generate your own Public/Private Keys.


4. Main functions of the App.
   Show Marvel Comic detail information with title, cover image and description. 
   "Show Single Comic by ID" show the single Comic info by the id you enter in the textbox above.
   "Pick Randomly" show randomly the Comic.
   "Show lists of Comics" show a list of Comics, you can scroll horizontally from one to another.



