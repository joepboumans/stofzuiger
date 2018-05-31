void setup() {
  Serial.begin(9600);
}

void loop() {//Robot1 on the ramp robot 2 found the lab too
 int message1;
  if (Serial.available()>0 && FoundLab) {
     message1= Serial.write(Serial.read());
   if(message1==1){
  while(message1==1 )
  {stop(Robot2);}
    }}

   else 
    if(Serial.available()>0 && !FoundLab) { //continue doing what it was doing 
      
    }
    
  
     
  
}


void send() {
  if (FoundLab==1) //robot2 
  { 
    Serial.println(1); //send on the lab
    delay(1000);
    
  }

  
 
  }


