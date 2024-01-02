# Data collection automation application
iOS automated testing data collection application with SwiftUI, allowing the client to automatically save a CSV file of test event & timestamp.

## Start Lab Test
The opening screen for starting a test contains options for preliminary data if you want to add data from a previous test for continuous test sets. Once Start is pressed the timer begins for timestamp. 

## Logging Events
When logging events, the button will flash to indicate that an event has been pressed and the list preview above will display the 5 most recent events that have been logged. 

## Logging Custom Events
When logging custom events, the user must enter the title for the custom event, this event is logged on the timestamp when the custom button was clicked, not when the user enters the name. 

## Undoing Events
The user may undo any event, there is a confirmation popup to ensure the user does not accidentally remove any events. 

## Ending Test & Saving File
Once the user has finished the test and hits Stop, the timer will stop and the file manager will open, prompting user to enter name (default is "event_log"), and location to save file. 

## CSV Output


