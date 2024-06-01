%{
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void yyerror(const char *s);
int yylex(void);

int await = 0;

enum feature {
    TETRIS_OPT,
    ANIMATION_OPT
};

enum feature selection;
%}

%token HELLO GOODBYE TIME TETRIS ANIMATION CUBE COFFIN DIAMONDS YES NO

%%

chatbot : greeting
        | farewell
        | query
        | tetris
        | animation
        | response
        ;

greeting : HELLO { printf("Chatbot: Hello! How can I help you today?\n"); }
         ;

farewell : GOODBYE { printf("Chatbot: Goodbye! Have a great day!\n"); }
         ;

query : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);
            printf("Chatbot: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
       ;

tetris : TETRIS {
            printf("Sure! Tetris is a nice game. Would you like to play it?\n");
            selection = TETRIS_OPT;
            await = 1;
        }
        ;

animation : ANIMATION {
            printf("I have some interesting animations! Would you like to see the available animations?\n");
            selection = ANIMATION_OPT;
            await = 1;
        }
        ;

response : yes
        | no
        | cube
        | coffin
        | diamonds
        ;

yes : YES {
        if(await){
            switch(selection){
                case TETRIS_OPT:
                    printf("Starting Tetris\n");

                    const char* TETRIS_EXE = "./tetris";
                    const int exeResult = system(TETRIS_EXE);
                    if(exeResult != 0) printf("Error executing Tetris.\n");
                    else await = 0;

                    break;
                case ANIMATION_OPT:
                    printf("- Cube\n");
                    printf("- Coffin\n");
                    printf("- Diamonds\n");

                    break;
            }
        }
    }
    ;

no : NO {
        printf("Ok, ;_;\n");
    }
    ;

cube : CUBE {
        if(await){
            const char* CUBE_EXE = "./demos/01_spinning_cube";
            const int exeResult = system(CUBE_EXE);
            if(exeResult != 0) printf("Exit Cube.\n");
            else await = 0;
        }
    }
    ;

coffin : COFFIN {
        if(await){
            const char* COFFIN_EXE = "./demos/02_spinning_coffin";
            const int exeResult = system(COFFIN_EXE);
            if(exeResult != 0) printf("Exit Coffin.\n");
            else await = 0;
        }
    }
    ;

diamonds : DIAMONDS {
        if(await){
            const char* DIAMONDS_EXE = "./demos/03_3_diamonds";
            const int exeResult = system(DIAMONDS_EXE);
            if(exeResult != 0) printf("Exit Diamonds.\n");
            else await = 0;
        }
    }
    ;

%%
/*
<================================================================>
Athor: Vicente Javier Viera Guízar
ID: A01639784
Description:
I added three more features to the proyect repo homework.
Created a command to play tetris from the command line. Credits to: https://github.com/anthepro/terminal-tetris
To play, you can ask the chatbot: do you have tetris
Then, simpy answer yes to the question! If you answer no to the chatbot he is going to get sad :(

The rest of the features are related. Is a series of 3D ASCII animations. Credits to: https://github.com/leonmavr/retrocube
You can ask the chatbot:
what animations do you have
The chatbot is going to answer with a list of available animations. You can choose from the following possible answers:
cube
coffin
diamonds
To exit the visualization just press ctrl + c


Build:
To build the proyect you can just use the makefile in the source directory using the command make.
<================================================================>
 */
int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, or say goodbye.\n");
    do{

    }while(yyparse() == 0);
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}