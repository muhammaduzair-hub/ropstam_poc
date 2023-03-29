# ropstam_poc

Flutter Car Management System

#installation
To run this application, you will need to have Flutter installed on your machine. 
Once Flutter is installed, clone this repository and navigate to the project directory in your terminal. Run the following command to install the required dependencies:

flutter pub get

#usage
To run the application, use the following command:

flutter run

## poc_discription
Once the application is running, you will be presented with a sign-in page. If you do not have an account, you can create one by selecting the "Sign Up" option. 
Once you are signed in, you will be taken to the dashboard, which displays the number of registered cars in the system.

To register a new car, navigate to the "Cars" page and select "Add Car". You will be presented with a form where you can enter the car's make, model, color, 
registration number, and category. The form includes front-end validation to ensure that all required fields are filled in.

To view or update an existing car, select the car from the list on the "Cars" page. You will be taken to a detail page where you can update the car's information. 
The form includes front-end validation to ensure that all required fields are filled in.

To delete a car, select the car from the list on the "Cars" page and select "Delete". You will be notify car is deleted.

#data_Storage
This application uses the Sembast package to store data locally on the device. User data is stored in a separate store from car data.

