#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <Servo.h>

// LCD setup (Change 0x27 to your LCD's I2C address if needed)
LiquidCrystal_I2C lcd(0x27, 16, 2);

// Servo
Servo myServo;

// Pins
#define TRIG_PIN D5
#define ECHO_PIN D6
#define BUZZER_PIN D7
#define SERVO_PIN D4

// Distance threshold
#define DISTANCE_THRESHOLD 5  // in cm

void setup() {
  // Initialize LCD
  lcd.init();
  lcd.backlight();
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Initializing...");

  // Initialize pins
  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  pinMode(BUZZER_PIN, OUTPUT);

  // Servo setup
  myServo.attach(SERVO_PIN);
  myServo.write(0); // Start at 0 degrees

  delay(500);
  lcd.clear();
}

void loop() {
  // Get distance
  float distance = getDistance();

  // Display distance
  lcd.setCursor(0, 0);
  lcd.print("Dist: ");
  lcd.print(distance);
  lcd.print(" cm   ");

  if (distance < DISTANCE_THRESHOLD) {
    // Rotate servo to 180 degrees and turn on buzzer
    myServo.write(180);
    digitalWrite(BUZZER_PIN, LOW);

    // Update LCD
    lcd.setCursor(0, 1);
    lcd.print("Servo:90 Buzz:ON");
  } else {
    // Rotate servo to 0 degrees and turn off buzzer
    myServo.write(0);
    digitalWrite(BUZZER_PIN, HIGH);

    // Update LCD
    lcd.setCursor(0, 1);
    lcd.print("Servo:0 Buzz:OFF");
  }

  delay(500); // Read every 0.5 seconds
}

// Function to measure distance from ultrasonic sensor
float getDistance() {
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);

  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);

  long duration = pulseIn(ECHO_PIN, HIGH);
  float distance = duration * 0.0343 / 2; // Convert to cm
  return distance;
}
