#include <Servo.h>
int FrontLab = A2;
Servo servoLeft, servoRight, servoGripper, servoEyes;
const float rotatespeed= 0.50 ;


//Basic functions
void Forward(){ //Forward until the calling function tells it to do something else
  servoLeft.write(98);
  servoRight.write(87);
  //Serial.println("Forward");
}

void Stop() { //Stopping until the calling function tells it to do something else
    servoLeft.write(90);
    servoRight.write(90);
}

void TurnRightD(int degrees){ //Function for turning right at a certain degree
float result;
    result = (degrees / (rotatespeed * 360)) * 1000;
    //Serial.println("Result computed: ");
    //Serial.print(result);
    //Serial.println("TurnRightD");
    delay(100);
    servoLeft.write(180);
    servoRight.write(180);
    delay(result);
}

void TurnLeft() { //Turning left until the calling function tells it to do something else
  servoLeft.write(0);
  servoRight.write(0);
  //Serial.println("TurnLeft");
}

void TurnRight(){ //Turning left until the calling function tells it to do something else
  servoLeft.write(180);
  servoRight.write(180);
  //Serial.println("TurnRight");
}

void TurnLeftD(int degrees) { //Function for turning left at a certain degree
    float result;
    result = (degrees / (rotatespeed * 360)) * 1000;
    //Serial.println("Result computed: ");
    //Serial.print(result);
    //Serial.println("TurnLeftD");
    delay(100);
    servoLeft.write(0);
    servoRight.write(0);
    delay(result);
}

//Returning functions
void SearchLab(int Sensor){
  Serial.println("A");
  int Max = 0;
  int CurrOut = 0;
  for(int i=0; i<24; i++){
    CurrOut = analogRead(Sensor);
    Serial.println(CurrOut);
    if (CurrOut > Max){
      Max = CurrOut;
      Serial.println(Max);
    }
    Stop();
    TurnLeftD(30);
    Stop();
  }
  for(int i=0; i<24; i++){
    CurrOut = analogRead(Sensor);
    if (CurrOut >=(Max-30)){
      break;
    }
    Stop();
    TurnLeftD(30);
    Stop();
  }
}

void CheckCourse(int Sensor){
  int CurrOut = 0;
  int PrevOut = 0;
  int WrongWay = 0;
  while (1){
    Forward();
    CurrOut = analogRead(Sensor);
    if(WrongWay == 3){
      Stop();
      break;
    }
    if (CurrOut < (PrevOut-30)){
      WrongWay++;
      PrevOut = CurrOut;
    }
   }
}

void ReturnLab(){
  Serial.print("JA ");
  Serial.println(analogRead(FrontLab));
while(analogRead(FrontLab)>300){
  Serial.println("Searching Lab");
  SearchLab(FrontLab);
  Serial.println("Checking Course!");
  CheckCourse(FrontLab);
  }
}

void setup() { //setting up all the servos
  servoRight.attach(13);
  servoLeft.attach(12);
  Serial.begin(9600);

}

void loop(){
  //Serial.println("DOET IE HET UBERHAUPT GODVERDOMME");
    Serial.println(analogRead(FrontLab));

  //Stop();
  //ReturnLab();
  //delay(10000);
}

