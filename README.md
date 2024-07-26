

# README

## Influence Mobile - Developer Assessment

**General Summary of the Great Leroy Jenkin's QuestLink application:**

Hello, I had fun creating this little application.  The purpose of this app is to allow you, the grand questor that you are, to choose an adventure offer from the Great Leroy Jenkins.  You will have a wide variety of quests from which to choose, they are even sorted for your age and gender.

In creating this app I made some decisions.

1. I made my own seed file (ergo the nature of the offers)
2. I chose to keep it Rails front end and of course Rails backend.  Incorporating REACT as the front end was slowing me down too much.
3. I employed Devise gem for my user management - this gave me all the user login/logout/profile functionality OOTB.
4. I leveraged bootstrap because it is a great UI frontend framework.

I hope you like my little application.  

Thanks,

Greg



**note:** as you test the app, be aware that the filtering on the combination of age and gender may result in an empty set for some of those pairings with only 100 items in the seed.  You could increase the seeding to 1000 or so to reduce the likelihood of this occurrence.



**User Story breakdown of requirements.**

**User story 1:** As a player I need to be able to sign in / register with my unique user name and password.


| Technical Reqs.                                              | UI/UX Behavior Reqs |
| ------------------------------------------------------------ | ------------------- |
| Player Model<br />     - with - username and password<br />     - Will use email as the username.<br />Add in Devise gem for user management |Create Login / Signup flow<br /> - With Devise this flow comes OOTB. <br/>Create Homepage<br />Create basic Navigation<br /> - for navigation utilize bootstrap navbar class|

**User Story 2:** Once authorized, Players are taken to the Offers page with a list of Offers descriptions that are targeted for them (based on their "age" and "gender")


| Tech reqs                                                    | UI Behavior reqs                                             |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
|**Create Offers model**<br />\- Offer Title<br />\- Description<br />\- Payout $$<br />\- belongs_to Genders<br />\- target age bracket<br />-status<br /><br />**Create Genders model**<br />\- gender<br />\- id<br /><br />**Extend Player model to have**<br />\- has\_many offers<br />\- has genders<br />\- age \(int\)<br /><br />Actions to select an offer and assign it to a Player. | List of offers page<br />\- buttons to select offer<br />\- change to "chosen" label if Player has already picked the offer\.<br /><br />Maybe the ability to click into the offer details view...<br /><br />Profile Page / sign up<br />\- select Age<br />\- Select gender |



**User Story 3:** As a Player I can chose to claim an offer 

| Tech Reqs                                                    | UI                                                           |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Extend offers model<br />-belongs\_to player<br /><br />Assumption - once an offer is selected it is no longer available for other Players to select.<br /><br />Extend Player model<br />\- has\_many offers | Choose offer button on the list page or on the offer details page |

 

**User Story 4:** As a Player I should be able to view the list of the Offers I already claimed, or chose a new one   

| Tech reqs | UI                                                           |
| --------- | ------------------------------------------------------------ |
| no change | surface the list of offers with the ones the Player has chosen highlighted in some way.<br />tabbed?  top of list? add a nice shade of pink or mauve to the line items.  TBD. |



**Implementation - Create a new app with PostgresSQL db backend**

Before core development can begin the project requires PostgreSQL and other items installed and configured.

1. Install PostgresSQL

   1. For my dev env - Manjaro Linux --> *sudo pacman -S postgresql*
   2. Start PostgresSQL --> *sudo systemctl start postgresql*
   3. Enable on startup --> *sudo systemctl enable postgresql*

2. Create db and set db user and password for Rails to access

   1. CREATE USER myuser WITH PASSWORD 'mypassword';
      For my application I used **username: leroy and password: jenkins**
   2. CREATE DATABASE mydb;
      GRANT ALL PRIVILEGES ON DATABASE mydb TO myuser;
      and the database name for this project is **leroy_development**

   **Database is prepared**

3. Create Rails project with a PostgresSQL db

   1. *rails new leroy -d postgresql*

4. Open the `config/database.yml` file in your Rails project and configure it to use the PostgreSQL database, user, and password

   1. ```
      default: &default
      
        adapter: postgresql
      
        encoding: unicode
      
        pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
      
        username: leroy
      
        password: jenkins
      
        host: localhost
      
      development:
      
        <<: *default
      
        database: leroy_development
      ```

5. Create the database

   1. *rails db:create*
   2. *rails db:migrate*

6. Load the application

   1. *rails server*
   2. Open your browser and navigate to `http://localhost:3000`.

**Implementation: Application approach and decisions**

I had initially wanted to implement a REACT front end to show off my REACT skills, but I found the actual architecture and setup was slowing me down too much so I decided to move forward with a RAILS backend and frontend.

I did decide to use several industry standard libraries to help speed up my project.

1. **Devise** - I have created user login flows in the past and it is annoying and repetitive. Devise simplifies user management in Rails by providing a set of authentication features, including sign-up, login, and password recovery, out of the box. 
2. **Bootstrap** - Bootstrap is just great and I love the grid system so it was an obvious choice for me. Also because I wasn't using REACT, Bootstrap provides built in AJAX support, which I wanted to employ for the claim/drop functionality.

**Set up Devise and Player Model**

1. add gem for devise  in the gem file
   1. *gem 'devise'*
2. bundle install
3. Run the Devise installer to generate the necessary configuration files:
   1. *rails generate devise:install*
4. Setup devise views: *rails generate devise:views* (these will be modified later)
5. Generate our player model with devise: *rails generate devise Player*
6. Modify the created migration file to include gender and age

```
class AddDeviseToPlayers < ActiveRecord::Migration[6.1]
  def change
    change_table :players do |t|
      t.string :age
      t.references :gender, foreign_key: true

      # Ensure Devise modules are included
      t.datetime :remember_created_at

      # Add additional Devise fields as needed
      t.timestamps null: false
    end
  end
end

```

7. migrate it: *rails db:migrate*

8. Update Player Model

   ```
   class Player < ApplicationRecord
     # Devise modules to be used
     devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable
   
     # Associations
     belongs_to :gender, optional: true
   
     # Validations
     validates :age, presence: true
   end
   
   ```

9. Ensure your routes are configured to use Devise for authentication.

10. Modify application controller to use devise controller and also set parameters

    ```
    class ApplicationController < ActionController::Base
      before_action :configure_permitted_parameters, if: :devise_controller?
    
      protected
    
      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:age, :gender_id])
        devise_parameter_sanitizer.permit(:account_update, keys: [:age, :gender_id])
      end
    end
    
    ```

11. Test login and logout etc.

**Styling Player login flows**

At this time I spent some effort to make the login flow look better.  I implemented Bootstrap, set the grid layout the way I wanted and changed fonts etc.  I also updated the notification/alert dialog to be more pleasing.

**Offers list page setup and design:**

1. Create offers model

   ```
   class CreateOffers < ActiveRecord::Migration[6.0]
     def change
       create_table :offers do |t|
         t.string :title
         t.string :description
         t.decimal :payout, precision: 10, scale: 2
         t.string :status, array: true, default: []
         t.string :age_range, array: true, default: []
         t.references :gender, null: false, foreign_key: true
         t.references :player, foreign_key: { to_table: :players }, null: true
   
         t.timestamps
       end
     end
   end
   ```

2. Migrate it

3. Create controller - *rails generate controller Offers*

4. update the index action in the controller to return all offers

   ```
     def index
       @offers = Offer.all
     end
   ```

5. Create the view to list all offers (this page gets HEAVILY modified later)

   ```
   <h1>Offers</h1>
   
   <table>
     <thead>
       <tr>
         <th>Title</th>
         <th>Description</th>
         <th>Payout</th>
         <th>Status</th>
         <th>Age Range</th>
         <th>Gender</th>
       </tr>
     </thead>
     <tbody>
       <% @offers.each do |offer| %>
         <tr>
           <td><%= offer.title %></td>
           <td><%= offer.description %></td>
           <td><%= number_to_currency(offer.payout) %></td>
           <td><%= offer.status %></td>
           <td><%= offer.age_range %></td>
           <td><%= offer.gender&.name || 'Not specified' %></td>
         </tr>
       <% end %>
     </tbody>
   </table>
   
   ```

6. Create Seed data

   1. I did not have the seed file from Influence mobile so this provided me a lot of leeway as to WHAT offers meant.  I decided that offers meant a dungeon crawl offer to adventurers.  You may come to our app and select an adventure to go on and we will pay you for successfully completing the quest.

   2. Therefore my seed

      ```
      require "faker"
      
      # Clear existing offers
      Offer.delete_all
      
      # Fetch all Gender IDs
      gender_ids = Gender.pluck(:id)
      
      # Define an array of monster titles and their descriptions
      monsters = [
        { title: "Kobolds", description: "A dark dungeon filled with traps and treasures", payout: rand(50..150) },
        { title: "Orcs", description: "An orc camp with hidden gems and weapons", payout: rand(200..500) },
        { title: "Mind Flayers", description: "A mysterious lair with ancient artifacts and gold", payout: rand(500..1000) },
        { title: "Dragons", description: "A dragon’s mountain hoard of unimaginable wealth", payout: rand(1000..5000) },
        { title: "Ghouls", description: "An abandoned graveyard with cursed relics and eerie secrets", payout: rand(75..200) },
        { title: "Giants", description: "A towering fortress of giants with colossal treasure", payout: rand(600..1500) },
        { title: "Vampires", description: "A haunted castle filled with dark secrets and valuable artifacts", payout: rand(800..2000) },
        { title: "Liches", description: "An ancient crypt with powerful magical items and riches", payout: rand(1000..3000) },
        { title: "Beholders", description: "A hidden lair of the beholders with strange and valuable treasures", payout: rand(1200..3500) },
        { title: "Trolls", description: "A swampy hideout of trolls with strange and rare items", payout: rand(200..800) },
      ]
      
      # Create 100 offers with random attributes
      100.times do
        monster = monsters.sample
        Offer.create(
          title: monster[:title],
          description: monster[:description],
          payout: monster[:payout],
          status: ["unassigned", "claimed", "completed", "returned"].sample(1),
          age_range: ["0-18", "19-25", "25-35", "35-45", "55 and up"].sample(1),
          gender_id: gender_ids.sample,
          player_id: nil,
        )
      end
      
      ```

   3. Execute the seeding: *rails db:seed*

   4. run the Leroy app: *rails server*

   5. view your page: http://localhost:3000/offers

**Milestone check**

At this point the basic app is complete.  Let's review.

- App is setup with the PostgresSQL backend
- Player is setup with signup / login / logout functionality complete
- offers are created in the database
- offers list page is viewable.



**Additional features and briefer comments**

- Added in Navbar with bootstrap navbar class.

  - notes: nav items are shown/hidden depending on whether player is logged in or not

- Extended the funtionality of the offers/index page to handle claim and drop

  - added the claim and drop actions to the offers_controller.rb 
    example: claim action

    ```
     # Player claims an offer
      def claim
        if player_signed_in?
          @offer = Offer.find(params[:id])
          # set player id on offer, change status to claimed
          if @offer.update(player: current_player, status: ["claimed"])
            respond_to do |format|
              format.html { redirect_to offers_path, notice: "Offer was successfully claimed." }
              format.js   # This will look for a file named `claim.js.erb`
            end
          else
            respond_to do |format|
              format.html { redirect_to offers_path, alert: "Failed to claim the offer." }
              format.js { render js: "alert('Failed to claim the offer.');" }
            end
          end
        else
          redirect_to new_player_session_path, alert: "You need to sign in to claim an offer."
        end
      end
    ```

- Improved look and feel of offers list table

- Added in sorting with Bootstrap Table sorting

  - created custom money sorting function for the payout column

- Added a tabbed view to the offers/index page to show all offers and just offers for the players gender and age range.

- Updated homepage with fun image and flavor text.

- Refactored and repaired bugs.



It think that's it.



This was a fun project to create, thanks Influence Mobile for the opportunity.

