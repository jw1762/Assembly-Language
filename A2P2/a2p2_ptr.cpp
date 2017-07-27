/*
Jordan Williamson
CS 2318 Assembly Language - Section 252
Assignment 2 Part 2
Description: A C++ program in which all selection,
jump, and repetition constructs have been replaced with
GoTo's.
*/
#include <iostream>
using namespace std;

int a1[12],
    a2[12];
char einStr[]    = "Enter integer #";
char moStr[]     = "Max of ";
char ieStr[]     = " ints entered...";
char emiStr[]    = "Enter more ints? (n or N = no, others = yes) ";
char begA1Str[]  = "beginning a1: ";
char negaA1Str[] = "a1 negatives: ";
char posiA1Str[] = "a1 positives: ";
char procA1Str[] = "processed a1: ";
char dacStr[]    = "Do another case? (n or N = no, others = yes) ";
char dlStr[]     = "================================";
char byeStr[]    = "bye...";

int main()
{
               char reply;
               int  used1,
                    nNeg,
                    nPos,
                    counter,
                    width,
                    min1,
                    min2,
                    i,
                    iL,
                    iR,
                    iE,
                    temp,
                   *hopPtr1,
                   *hopPtr11,
                   *hopPtr12,
                   *hopPtr2,
                   *endPtr1,
                   *endPtr11,
                   *endPtr12,
                   *endPtr2;

               reply = 'y';
               //while (reply != 'n' && reply != 'N')
               goto WTest1;
begW1:         //{
                  used1 = 0;
                  hopPtr1 = a1;
                  //while (reply != 'n' && reply != 'N')
                  goto WTest2;
begW2:            //{
                     cout << einStr;
                     cout << (used1 + 1);
                     cout << ':' << ' ';
                     cin >> *hopPtr1;
                     ++used1;
                     ++hopPtr1;
                     //if (used1 < 12)
                     if(used1 >= 12) goto elseI1;
begI1://               {
                        cout << emiStr;
                        cin >> reply;
                        goto endI1;
                     //}
                     //else
elseI1:
                     //{
                        cout << moStr << 12 << ieStr << endl;
                        reply = 'n';
                     //}
endI1:
                  //}
WTest2:           if(reply != 'n' && reply != 'N') goto begW2;

                  cout << endl;
                  cout << begA1Str;
                  //if (used1 > 0)
                  if (used1 <= 0) goto endI2;
begI2://          {
                     hopPtr1 = a1;
                     endPtr1 = a1 + used1;
begDW1:           //do
         //         {
                        cout << *hopPtr1 << ' ' << ' ';
                        ++hopPtr1;
       //           }
                  //while (hopPtr1 < endPtr1);
                  if(hopPtr1 < endPtr1) goto begDW1;
endI2:          //}
                  cout << endl;

                  hopPtr1 = a1;
                  hopPtr2 = a1 + used1 - 1;
                  counter = 0;
                  //while (hopPtr1 <= hopPtr2
                  goto WTest3;
begW3:            //{
                     //while (hopPtr1 <= hopPtr2)
                     goto WTest4;
begW4:               //{
begI3:                  if (*hopPtr1 >= 0) goto endW4;
endI3:
                        ++hopPtr1;
                        ++counter;
                     //}
WTest4:              if(hopPtr1 <= hopPtr2) goto begW4;
endW4:
begI4:               if (hopPtr1 > hopPtr2) goto endW3;
endI4://
                     //while (hopPtr2 >= hopPtr1)
                     goto WTest5;
begW5:               //{
                        //if (*hopPtr2 < 0)
begI5:                  if(*hopPtr2 >= 0) goto endI5;
                        //{
                           //if (hopPtr1 != hopPtr2)
begI6:                     if (hopPtr1 == hopPtr2) goto endI6;
                           //{
                              ++counter;
                           //}
endI6:
                           goto endW5;
                        //}
endI5:
                        --hopPtr2;
                     //}
WTest5:              if (hopPtr2 >= hopPtr1) goto begW5;
endW5:
begI7:               if (hopPtr1 > hopPtr2) goto endW3;
endI7:
                     //if (hopPtr1 != hopPtr2)
                     if (hopPtr1 == hopPtr2) goto endI8;
begI8:               //{
                        temp = *hopPtr1;
                        *hopPtr1 = *hopPtr2;
                        *hopPtr2 = temp;
                     //}
endI8:
                     ++hopPtr1;
                     --hopPtr2;
                  //}
WTest3:           if(hopPtr1 <= hopPtr2) goto begW3;
endW3:
                  nNeg = counter;
                  nPos = used1 - counter;

                  cout << negaA1Str;
                  //if (nNeg > 0)
                  if (nNeg <= 0) goto endI9;
begI9://            {
                     hopPtr1 = a1;
                     endPtr1 = a1 + nNeg;
                     //do
begDW2:              //{
                        cout << *hopPtr1 << ' ' << ' ';
                        ++hopPtr1;
                     //}
                     //while (hopPtr1 < endPtr1);
DWtest2:             if (hopPtr1 < endPtr1) goto begDW2;
                  //}
endI9:
                  cout << endl;

                  cout << posiA1Str;
                  //if (nPos > 0)
                  if (nPos <= 0) goto endIa;
begIa://            {
                     hopPtr1 = a1 + nNeg;
                     endPtr1 = hopPtr1 + nPos;
                     //do
begDW3:
                     //{
                        cout << *hopPtr1 << ' ' << ' ';
                        ++hopPtr1;
                     //}
                     //while (hopPtr1 < endPtr1);
testDW3:             if(hopPtr1 < endPtr1) goto begDW3;
                  //}
endIa:
                  cout << endl;

                  width = 1;
                  //while (width < used1)
                  goto WTest6;
begW6:
                  //{
                     i = 0;
                     //while (i < used1)
                     goto WTest7;
begW7:               //{
                        iL = i;
                        temp = i + width;
                        //if (temp < used1)
                        if (temp >= used1) goto elseIb;
begIb://                  {
                           iR = temp;
                           goto endIb;
                        //}
                        //else
elseIb:                  //{
                           iR = used1;
                        //}
endIb:
                        temp = i + 2*width;
                        //if (temp < used1)
                        if (temp >= used1) goto elseIc;
begIc://                  {
                           iE = temp;
                           goto endIc;
                        //}
                        //else
elseIc:                  //{
                           iE = used1;
                        //}
endIc:
                        hopPtr11 = a1 + iL;
                        hopPtr12 = a1 + iR;
                        endPtr11 = a1 + iR;
                        endPtr12 = a1 + iE;
                        //for (hopPtr2 = a2 + iL, endPtr2 = a2 + iE;
                        //     hopPtr2 < endPtr2; ++hopPtr2)
                        hopPtr2 = a2 + iL;
                        endPtr2 = a2 + iE;
                        goto FTest1;
begF1:                  //{
                           //if ( hopPtr11 < endPtr11 &&
                           //     (hopPtr12 >= endPtr12 || *hopPtr11 <= *hopPtr12)
                           //   )
                           if(hopPtr11 >= endPtr11 ||
                               (hopPtr12 < endPtr12 && *hopPtr11 > *hopPtr12)
                             ) goto elseId;
begId://                     {
                              *hopPtr2 = *hopPtr11;
                              ++hopPtr11;
                              goto endId;
                           //}
                           //else
elseId:                     //{
                              *hopPtr2 = *hopPtr12;
                              ++hopPtr12;
                           //}
endId:
                           ++hopPtr2;
                        //}
FTest1:                 if(hopPtr2 < endPtr2) goto begF1;
                        i = i + 2 * width;
                     //}
WTest7:              if (i < used1) goto begW7;

                     hopPtr1 = a1;
                     hopPtr2 = a2;
                     endPtr2 = a2 + used1;
                     //while(hopPtr2 < endPtr2)
                     goto WTest8;
begW8:               //{
                        *hopPtr1 = *hopPtr2;
                        ++hopPtr1;
                        ++hopPtr2;
                     //}
WTest8:              if(hopPtr2 < endPtr2) goto begW8;

                     width = 2 * width;
                  //}
WTest6:           if(width < used1) goto begW6;

                  cout << nNeg << '-' << ' ' << nPos << '+' << endl;

                  cout << procA1Str;
                  //if (used1 > 0)
                  if (used1 <= 0) goto endIe;
begIe://            {
                     hopPtr1 = a1;
                     endPtr1 = a1 + used1;
                     //do
begDW4:              //{
                        cout << *hopPtr1 << ' ' << ' ';
                        ++hopPtr1;
                     //}
                     //while (hopPtr1 < endPtr1);
                     if (hopPtr1 < endPtr1) goto begDW4;
                  //}
endIe:
                  cout << endl;

                  cout << dacStr;
                  cin >> reply;
               //}
WTest1:        if(reply != 'n' && reply != 'N') goto begW1;
               cout << endl;
               cout << dlStr << '\n';
               cout << byeStr << '\n';
               cout << dlStr << '\n';

               return 0;
}
