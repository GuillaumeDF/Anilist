# ani_list

A mobile application using Flutter & Firebase to keep track of your animes.

## Features

* Keep track of your anime list
* View top animes
* Search animes

## How to run 

### Flutter
Install [Flutter](https://flutter.dev/docs/get-started/install). 
Run flutter upgrade to ensure you're on the latest. 
```shell
$: flutter upgrade
```
Get repository as zip or git clone.
```shell
$: git clone git@github.com:angela-boyadjian/AniList.git
```
At the root of the repository get Packages.
```shell
$: flutter pub get
```
Run the application on your device or emulator.
```shell
$: flutter run
```

### Cloud Function
To use the Cloud Functions emulator, first install the Firebase CLI:
```shell
$: npm install -g firebase-tools
```

Move to the directory Firebase
```shell
$: cd Firebase
```
Launch the emulator
```shell
$: firebase emulators:start
```
### Setup
To setup the Firebase structure you can use the provided script inside of the
admin_pannel folder. You will first need to install the requirements with the
following command:
```bash
$: pip3 install -U firebase_admin
```
Then run the script with python3 and the Google Services json file as argument:
```bash
$: python3 setup.py ./GoogleServices.json
```
This script will create the following administrator account:
```python
{
	"name": "Admin",
	"bio": "Administrator Account",
	"email": "amdin@anilist.com",
	"favs": [],
	"animesList": [],
	"id": "0000000000000000000000000000",
	"photo": "",
	"admin": True,
}
```
## Documentation
The documentation is located in the Wiki of this repository.

## Resources

* [API](https://jikan.docs.apiary.io/#)
