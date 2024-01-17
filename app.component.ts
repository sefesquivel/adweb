import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink, RouterOutlet } from '@angular/router';
import { FormsModule } from '@angular/forms'; //ngModel
import { ProductDetailsComponent } from './product-details/product-details.component';
import { ProductListingComponent } from './product-listing/product-listing.component';



@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterOutlet, FormsModule, ProductDetailsComponent, ProductListingComponent, RouterLink],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {



//Interpolation
title = 'Your title here';
name: string = 'Your name here';
appName = 'ADWEB Interpolation Demonstration!'; 

//Numeric 
num1=9
num2=30 
sum=0 
diff=0 
quo=0 
prod=0 


//Property Binding 
isRaining:boolean = false;
isDisabled=true;
allowNewServer = false;


//Style Binding 
appliedCSSClass="green"; 
nonappliedCSSClass="false"; 
myColor='red'; 

//Two-way data binding demo 
showData($event:any){ 
  console.log("Button is Clicked!"); 
} 

// Functions and using alert 
getMessage(msg:any) 
{ 
  alert(msg) 
} 

//Console Warning 
  getMessage2(msg2:any) { 
    console.warn(msg2) 
  } 

//Console Warning 
  getData(data:any) 
  { 
  console.warn(data) 
  } 
  
//Two way data binding using ngModel (you will need to import FormsModule)
studName="" 
prelim=0 
midterm=0 
final=0 
average = (this.prelim + this.midterm +this.final)/3 
  
itemList: string[] = ['item1', 'item2', 'item3', 'item4'];
grade1: number = 0;
grade2: number = 0;
grade3: number = 0;
average2: number = 0;


calculateAverage() {
  this.average = (this.grade1 + this.grade2 + this.grade3) / 3;
}

searchValue: string = '';

//Event binding
clickCount=0
  clickMe() {
    this.clickCount++;
  }

  resetClickCount() {
    this.clickCount = 0;
  }

//Using ngIf to toggle text display
showText: boolean = false;
toggleText() {
    this.showText = !this.showText;
  }


//Image interpolation/binding
imageUrl:string="assets/logo.png"; 
imageW: number = 110;
imageH: number = 100;

//Using *ngIf
isLogIn:boolean=true; 
isLogOut:boolean=false; 

// *ngfor example 

staff = [ 
{ firstName: 'Joseph', lastName: 'Diaz', email: 'joseph.diaz@test.com', role: 'User' },   
{ firstName: 'James', lastName: 'Reynolds', email: 'james.reynolds@test.com', role: 'Admin' }, 
{ firstName: 'Djoan', lastName: 'Jaworski', email: 'djoan.jaworski@test.com', role: 'Admin' }, 
{ firstName: 'Maria', lastName: 'Garcia', email: 'maria.garcia@test.com', role: 'User' }, 
{ firstName: 'Jay', lastName: 'Bernardo', email: 'jay.bernardo@test.com', role: 'User' } 
];

// Another *ngfor example 
products = [
  { imageUrl: 'https://dummyimage.com/450x300/dee2e6/6c757d.jpg', name: 'Fancy Product 1', price: '$40.00 - $80.00' },
  { imageUrl: 'https://dummyimage.com/450x300/dee2e6/6c757d.jpg', name: 'Fancy Product 2', price: '$50.00 - $90.00' },
  { imageUrl: 'https://dummyimage.com/450x300/dee2e6/6c757d.jpg', name: 'Fancy Product 3', price: '$60.00 - $100.00' },
  // Add more product items as needed
];

}



 
