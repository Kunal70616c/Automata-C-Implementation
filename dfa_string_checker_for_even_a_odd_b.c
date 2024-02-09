#include<stdio.h>
#include<stdlib.h>

void dfa_checker(){
 char *input;
 int curr_state = 0,i;
 printf("\n This Is a Checker For DFA That Accepts string that Has Even 'a' And Odd 'b' ");
 printf("\n Enter String(a/b):");
 scanf("%s" , input);
 for(i=0;input[i]!='\0';i++){
    switch (curr_state)
    {
    case 0 :  switch (input[i]){
                case 'a' :    curr_state=1; break;
                case 'b' :    curr_state=3; break;
                default  :    printf("Invalid Input String!"); exit(1);
                }          
                break;
    case 1 :  switch (input[i]){
                case 'a' :    curr_state=0; break;
                case 'b' :    curr_state=2; break;
                default  :    printf("Invalid Input String!"); exit(1);
                }
                break;
    case 2 :  switch (input[i]){
                case 'a' :    curr_state=3; break;
                case 'b' :    curr_state=1; break;
                default  :    printf("Invalid Input String!"); exit(1);
                }           
                break;
    case 3 :  switch (input[i]){
                case 'a' :    curr_state=2; break;
                case 'b' :    curr_state=0; break;
                default  :    printf("Invalid Input String!"); exit(1);
                }
                 break;
    }
 }
 if(curr_state == 3)/* as state 3 is the final state */
    printf("\n ********|||| String Accepted ||||*********");
 else
    printf("\n ********|||| String Rejected ||||*********");
}
int main(){
    dfa_checker();
    return 0 ;
}