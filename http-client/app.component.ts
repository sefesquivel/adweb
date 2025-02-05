import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { CommonModule } from '@angular/common';
import { HttpClientService } from './services/http-client.service';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, CommonModule],
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'HTTP Client Demonstration';
  httpusers: any;

  constructor(private httpClientList: HttpClientService) {
    this.httpClientList.getUsersRemotely().subscribe({
      next: (data: any) => {
        this.httpusers = data;
      },
      error: (error) => console.error('Error fetching users:', error)
    });
  }
}