
#include "InternetButton/InternetButton.h"


InternetButton b = InternetButton();

bool rainbow_mode = false;

int turnRed(String command);

void setup() 
{
    Particle.subscribe("aBcK9anskFasd", lightCtl);
    b.begin();
}

void lightCtl(const char *event, const char *data)
{
    ledAllOnRemote(data);
}

void loop(){

    if(b.allButtonsOn()) {
        buttonPush();
    }
    
    if (b.buttonOn(1)) {
        buttonPush();
    }
    
    if (b.buttonOn(2)) {
        buttonPush();
    }
    
    if (b.buttonOn(3)) {
        buttonPush();
    }
    
    if (b.buttonOn(4)) {
        buttonPush();
    }

}

int buttonPush(){
    b.allLedsOn(0, 0, 0);
    Particle.publish("aBcK9anskFasd", "off");
    return 1;
}


int ledAllOnRemote(String command){
    if(command.equals("red")){
        b.allLedsOn(150,0,0);
    }
    else if(command.equals("green")){
        b.allLedsOn(0,150,0);
    }
    else if(command.equals("off")){
        b.allLedsOn(0,0,0);
    }
    else if(command.equals("blue")){
        b.allLedsOn(0,0,150);
    }
    else if(command.equals("white")){
        b.allLedsOn(150,150,150);
    }
    else {
        
        char inputStr[20];
        command.toCharArray(inputStr,20);
        char *p = strtok(inputStr,",");
        int red = atoi(p);
        p = strtok(NULL,",");
        int grn = atoi(p);
        p = strtok(NULL,",");
        int blu = atoi(p);
        p = strtok(NULL,",");
        b.allLedsOn(red,grn,blu);
    }
    return 1;
}

