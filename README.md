## INSTALL ALL DEPENDENCIES

Node Package Manager essentials
npm install

Angular Material
ng add @angular/material


## STEP 1: FRONTEND
  - Create a new angular project with name FinalsActivity
  - Generate the following components inside the components folder: add-book, book-detail, books-list
  - Generate the service inside the service folder, call it 'crud'
  - Still inside the service folder, create a new file Book.ts

## STEP 2: BACKEND
Inside src create a new folder 'node-backend'
  - install an instance of mongoose, initialize npm
  - npm install --save body-parser cors express mongoose

Create a file called index.js
  - This is where expressjs, mongoose are integrated. 
  - Routes are also set here.

Create 3 folders - database, model, routes
  - Inside database folder, create db.js
  - Inside model folder, create Book.js
  - Inside routes folder, book.routes.js

## STEP 3: Testing

Run the following:

Run Mongodb
C:\Program Files\MongoDB\Server\6.0\bin>mongod

Run the app
D:\angular\mean-crud>ng serve

Run the backend
Check PATH -> C:\>node-rest-api\node-backend>node index.js
