/******************************
  This is a Bison Input File for HOC programming 
  Languge adapted for Windows NT from unix programming Environment
  By Praseed Pai KT
     Visionics India PVT LTD.
************************************************/
%{
#define YYSTYPE double
#define alloca _alloca
#define WIN32
%}
%token  NUMERIC_VALUE
%left   '+' '-'   
%left   '*' '/' '%'
%left   UNARY_MINUS
%%
list:  /*  do noth       */
       | list '\n'
       | list expr '\n'
        {
          printf("%g\n",$2);
        };
expr:    NUMERIC_VALUE 
         {
           $$ = $1;
         }     
         | '-' expr %prec UNARY_MINUS
           {
              $$ = - $2;    
             
           }    
         | '+' expr %prec UNARY_MINUS
           {
              $$ = $2;
           }  
         | expr '+' expr 
          {
             $$ = $1 + $3;
          } 
         | expr '-' expr
          {
            $$ = $1 + $3; 
          }  
         | expr '*' expr
          {
            $$ = $1 * $3;  
          } 
         | expr '%' expr
          {
              $$ =(int)$1% (int)$3;
          }
         | expr '/' expr
           {
             if ( $3 == 0 ) 
              {
                printf("Divide By Zero Error\n");
                
              }
              else {
             $$ = $1 / $3; 
            }
     
          }
         |  '(' expr ')' {
              $$ = $2;
         }
         ;
%%
 
#include <stdio.h>
#include <ctype.h>
#include <stdarg.h>

void yyerror(char *s , ... )
{
   va_list v1;

   va_start( v1, s );
   va_end( v1 );
}


/*
  

*/

char *progname;
int lineno=1;

void main( int argc, char **argv )
{
    progname = argv[0];

    yyparse();
}


 

int yylex()
{
   int c;

   while ((c=getchar()) == ' ' || c == '\t' )
             ;

   if ( c == EOF )
        return 0;


     if ( c == '.' || isdigit(c) ) {
            ungetc(c,stdin);
            scanf("%lf",&yylval);
            return NUMERIC_VALUE;
     }

    if ( c == '\n' )
       lineno++;


    return c;
         
  




}


  