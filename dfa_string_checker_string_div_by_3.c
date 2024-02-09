#include<stdio.h>
#include<stdlib.h>

void dfa_checker(){
 char *input;
 int curr_state = 0,i;
 printf("\n This Is a Checker For DFA That Accepts string that are div by 3");
 printf("\n Enter String(0/1):");
 scanf("%s" , input);
 for(i=0;input[i]!='\0';i++){
    switch (curr_state)
    {
    case 0 :  switch (input[i]){
                case '1' :    curr_state=1; break;
                case '0' :    curr_state=0; break;
                default  :    printf("Invalid Input String!"); exit(1);
                }          
                break;
    case 1 :  switch (input[i]){
                case '1' :    curr_state=0; break;
                case '0' :    curr_state=2; break;
                default  :    printf("Invalid Input String!"); exit(1);
                }
                break;
    case 2 :  switch (input[i]){
                case '1' :    curr_state=2; break;
                case '0' :    curr_state=1; break;
                default  :    printf("Invalid Input String!"); exit(1);
                }           
                break;
    }
 }
 if(curr_state == 0)/* as state 0 is the final state */
    printf("\n ********|||| String Accepted ||||*********");
 else
    printf("\n ********|||| String Rejected ||||*********");
}
int main(){
    dfa_checker();
    return 0 ;
}