# Bogglr

My Swift implementation of a program that will find all the words on a generalized Boggle board.
http://en.wikipedia.org/wiki/Boggle

The driver program for running the Boggle solver algorithm comes in the form of a unit test in the `BogglrTests` package. Executing the `testBoggleSolver()` test in `BogglrTests.swift` will run through the implementation of the algorithm.

I wanted my solution to be written in Swift and make use of a standard iOS development environment. As a result I have used the latest Xcode version (9.2) and am running my test on the latest iOS simulator version (11.2).

Because the code makes use of the latest iOS dev tools, an Apple Mac computer will be required for testing.
The test can be run from the command line or from within Xcode. I will outline the steps for each scenario:

### Running from Xcode ###

Note: I was able to build and run the test code using Xcode 9.0 as well as Xcode 9.2, so either version should be fine (as well as 9.1)

If you're currently running an outdated version of Xcode, the latest can be downloaded from Apple here https://developer.apple.com/download/ under "Release Software"

Once the `Bogglr.zip` file is downloaded and unzipped, navigate into the `Bogglr` directory and double click the `Bogglr.xcodeproj` file to open it in Xcode.

From here, you can expand `BogglrTests` in Xcode's Project Navigator (left side of the IDE) and click on `BogglrTests.swift` to open it in the editor.

Now you can simply click on the diamond to the left of line 14 `func testBoggleSolver()`. This will initiate the test case, which runs the implemented Boggle solver algorithm on a board and dictionary that are defined in .txt files bundled with the app.

The output of the test can be viewed in the console output in the bottom pane of Xcode.

If you would like to change the dictionary or board inputs, you can easily do so by expanding the `Bogglr/Initialization` folder. Here you will find `dictionary.txt` and `board.txt` which you can open and edit to include whatever dictionary or board configuration you'd like to run the test with.

### Running from the command line ###

Note: This method also requires that Xcode and it's packaged command line tools are installed as it makes use of the `xcodebuild` utility.

Open the Mac's Terminal app and navigate to the directory in which you unzipped the `Bogglr.zip` file. Make sure you are in the directory that contains the `Bogglr.xcodeproj` file.

From here, you can execute the following command:
`xcodebuild test -project Bogglr.xcodeproj -scheme Bogglr -destination 'platform=iOS Simulator,name=iPhone 8,OS=11.2'`. Note that OS version at the end of the statement is set to 11.2. This requires that the latest Xcode simulators are available. If they are not, the OS value passed into the command line statement will need to be reduced to an iOS version that is available on your machine.

On the first run, you will notice a lot of output while `xcodebuild` is compiling and building the project. Once this is done, you will see the list of words output from the algorithm test case.

Similar to the running from Xcode method, you can edit the `dictionary.txt` and `board.txt` files that are found under the `Bogglr/Initialization/` directory.

### Assumptions ###
1. The dictionary input file is formatted in such a way that each word is on a new line.
2. The board input file is formatted in a way that adjacent letters contain no characters in between them.
3. According the Boggle rules from the Boggle wikipedia page, a valid answer in Boggle should contain at least 3 letters. As a result, the code only will print words that are greater or equal to 3 characters in length.
4. All rows have an equal amount of letters.
5. The board dimensions are inferred from the board input text file.
6. The English character set is used.

### Notes ###
I wanted to use a very large dictionary in order to test the performance and scalability of the algorithm. Many of the dictionary files I found online contained words that are extremely uncommon. For example you will see words such as `aah` and `qts` which seem wrong, but are actually contained in the dictionary file. Just wanted to point that out in case it caused any doubt that the algorithm was working properly.
