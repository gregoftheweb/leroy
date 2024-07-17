

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
* System dependencies
* Configuration
* Database creation
* Database initialization
* How to run the test suite
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions
* ...

## Influence Mobile - Developer Assessment

**User Story breakdown of requirements.**

**User story 1:** As a player I need to be able to sign in / register with my unique user name and password.


| Technical Reqs.                                              | UI/UX Behavior Reqs |
| ------------------------------------------------------------ | ------------------- |
| Player Model<br>     - with - username and password<br> Add in Devise gem for user management |Create Login / Signup flow<br />Create Homepage<br />Create basic Navigation|


**User Story 2:** Once authorized, Players are taken to the Offers page with a list of Offers descriptions that are targeted for them (based on their "age" and "gender")


| Tech reqs                                                    | UI Behavior reqs                                             |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Create Offers model<br>\- Offer Title<br>\- Description<br>\- has\_many Genders<br>\- target age bracket<br>\- belongs\_to User<br><br>Create Genders table<br>\- gender<br>\- id<br><br>Extend Player model to have<br>\- has\_many offers<br>\- has genders<br>\- age \(int\)<br><br>Actions to select an offer and assign it to a Player. | List of offers page<br>\- buttons to select offer<br>\- change to "chosen" label if Player has already picked the offer\.<br><br>Maybe the ability to click into the offer details view...<br><br>Profile Page / sign up<br>\- select Age<br>\- Select gender |



**User Story 3:** As a Player I can chose to claim an offer 

| Tech Reqs                                                    | UI                                                           |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Extend offers model<br>-belongs\_to player<br><br>Assumption - once an offer is selected it is no longer available for other Players to select.<br><br>Extend Player model<br>\- has\_many offers | Choose offer button on the list page or on the offer details page |

 

**User Story 4:** As a Player I should be able to view the list of the Offers I already claimed, or chose a new one   

| Tech reqs | UI                                                           |
| --------- | ------------------------------------------------------------ |
| no change | surface the list of offers with the ones the Player has chosen highlighted in some way.<br>tabbed?  top of list? add a nice shade of pink or mauve to the line items.  TBD. |



**Development approach:**     
1\. Setup a basic user profile / signup / login/logout with devise

- test basic user flow                                
2\. Create gender model 
3\. Create offer model 
4\. do all the pretty UI stuff           