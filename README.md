# Data collection automation application
iOS automated testing data collection application with SwiftUI, allowing the client to automatically save a CSV file of test event & timestamp.

## Start Lab Test
The opening screen for starting a test contains options for preliminary data if you want to add data from a previous test for continuous test sets. Once Start is pressed the timer begins for timestamp. <br>
<img width="200" alt="Screenshot 2024-01-02 at 13 46 57" src="https://github.com/scanner255/data_management_automation_iOS_application/assets/95446494/326c501b-d008-48fd-a680-d89e967bf7ef">

## Logging Events
When logging events, the button will flash to indicate that an event has been pressed and the list preview above will display the 5 most recent events that have been logged. <br>
<img width="200" alt="Screenshot 2024-01-02 at 13 47 11" src="https://github.com/scanner255/data_management_automation_iOS_application/assets/95446494/cd1932f2-61fe-49da-b27d-7146eca4d318"> 
<img width="200" alt="Screenshot 2024-01-02 at 13 47 23" src="https://github.com/scanner255/data_management_automation_iOS_application/assets/95446494/ceafa5ca-68a8-4561-ac1c-b4aed72a5369">

## Logging Custom Events
When logging custom events, the user must enter the title for the custom event, this event is logged on the timestamp when the custom button was clicked, not when the user enters the name. <br>
<img width="200" alt="Screenshot 2024-01-02 at 13 47 53" src="https://github.com/scanner255/data_management_automation_iOS_application/assets/95446494/7d025dc9-c217-4c6b-8658-f87ad5ac7d6a">

## Undoing Events
The user may undo any event, there is a confirmation popup to ensure the user does not accidentally remove any events. <br>
<img width="200" alt="Screenshot 2024-01-02 at 13 48 06" src="https://github.com/scanner255/data_management_automation_iOS_application/assets/95446494/3435b9f9-f38b-409c-a463-4b77c1505286">
<img width="200" alt="Screenshot 2024-01-02 at 13 48 11" src="https://github.com/scanner255/data_management_automation_iOS_application/assets/95446494/c283f0c3-35e4-4f27-8b48-04d6afee57a9">

## Ending Test & Saving File
Once the user has finished the test and hits Stop, the timer will stop and the file manager will open, prompting user to enter name (default is "event_log"), and location to save file. <br>
<img width="200" alt="Screenshot 2024-01-02 at 13 48 34" src="https://github.com/scanner255/data_management_automation_iOS_application/assets/95446494/fb80f50a-373a-4e76-b592-556d9f156eb0">

## CSV Output
<img width="451" alt="Screenshot 2024-01-02 at 13 49 41" src="https://github.com/scanner255/data_management_automation_iOS_application/assets/95446494/8fc83275-41e9-40b5-be70-daa49612710d">


