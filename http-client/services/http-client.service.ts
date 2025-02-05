import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class HttpClientService {
  constructor(private http: HttpClient) { }
  
  getUsersRemotely(): Observable<any> {
    return this.http.get('https://jsonplaceholder.typicode.com/users');
  }
}