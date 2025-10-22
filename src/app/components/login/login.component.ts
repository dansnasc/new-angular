import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

// PrimeNG Modules
import { ButtonModule } from 'primeng/button';
import { InputTextModule } from 'primeng/inputtext';
import { PasswordModule } from 'primeng/password';
import { CardModule } from 'primeng/card';
import { DividerModule } from 'primeng/divider';

@Component({
  selector: 'app-login',
  imports: [
    CommonModule, 
    ReactiveFormsModule, 
    FormsModule,
    ButtonModule,
    InputTextModule,
    PasswordModule,
    CardModule,
    DividerModule
  ],
  templateUrl: './login.component.html',
  styleUrl: './login.component.scss'
})
export class LoginComponent {
  loginForm: FormGroup;
  showPassword = false;

  constructor(private fb: FormBuilder) {
    this.loginForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(6)]]
    });
  }

  togglePasswordVisibility() {
    this.showPassword = !this.showPassword;
  }

  onSubmit() {
    if (this.loginForm.valid) {
      console.log('Form submitted:', this.loginForm.value);
      // Aqui você implementaria a lógica de login
    } else {
      console.log('Form is invalid');
    }
  }

  onMicrosoftLogin() {
    console.log('Microsoft login clicked');
    // Implementar login com Microsoft
  }

  onForgotPassword(event?: Event) {
    if (event) {
      event.preventDefault();
    }
    console.log('Forgot password clicked');
    // Implementar recuperação de senha
  }

  onCreateAccount(event?: Event) {
    if (event) {
      event.preventDefault();
    }
    console.log('Create account clicked');
    // Navegar para página de criação de conta
  }
}
