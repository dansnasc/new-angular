import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ButtonTesteComponent } from './button-teste.component';

describe('ButtonTesteComponent', () => {
  let component: ButtonTesteComponent;
  let fixture: ComponentFixture<ButtonTesteComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ButtonTesteComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ButtonTesteComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
