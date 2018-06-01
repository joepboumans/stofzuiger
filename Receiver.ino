void setup() {
  Serial.begin(9600);
}

void loop() {//Robot1 on the ramp robot 2 found the lab too
 int message;
  if (Serial.available()>0 && FoundLab) {
     message= Serial.write(Serial.read());
   if(message==1){
  while(message==1 )
  {stop();//robot2}
    }}

  // else 
    //if(Serial.available()>0 && !FoundLab) { //continue doing what it was doing 
     // if( no rock found)
     // search rock
     //else
     //if (no lab found)
    //ReturnLab();
    }
    
  
     
  
}


void send() {
  if (FoundLab==1) //robot2 
  { 
    Serial.println(1); //send on the lab
    delay(1000);
    
  }

  
 
  }


