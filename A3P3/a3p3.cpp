#include <iostream>
using namespace std;

void CoutCstr(char cstr[]);
void CoutCstrNL(char cstr[]);
void CoutOneInt(int oneInt);
void PopulateArray(int a[], int* usedPtr, int cap);
void SPFN(int used1, int a1[], int* nNegPtr, int* nPosPtr);
void CopyArray(int a2[], int a1[], int n);
void BUM(int a1[], int iL, int iR, int iE, int a2[]);
void BUMS(int a1[], int a2[], int used);
void ProcArray(int used1, int a1[], int a2[], int* nNegPtr, int* nPosPtr);
void ShowArray(int a[], int used);
void ShowArrayLabeled(int a[], int used, char label[]);
void Swap(int* intPtr1, int* intPtr2);
int  Min(int int1, int int2);

int main()
{
                int a1[12],
                    a2[12];
                char reply;
                int used1,
                    nNeg,
                    nPos;
                char begA1Str[]  = "beginning a1: ";
                char procA1Str[] = "processed a1: ";
                char dacStr[]    = "Do another case? (n or N = no, others = yes) ";
                char dlStr[]     = "================================";
                char byeStr[]    = "bye...";

                reply = 'y';
                goto WTest1;
begW1:
                PopulateArray(a1, &used1, 12);
                cout << endl;
                ShowArrayLabeled(a1, used1, begA1Str);
                ProcArray(used1, a1, a2, &nNeg, &nPos);
                cout << nNeg << '-' << ' ' << nPos << '+' << endl;
                ShowArrayLabeled(a1, used1, procA1Str);
                cout << endl;
                cout << dacStr;
                cin >> reply;
WTest1:         if (reply == 'n') goto xitW1;
                if (reply != 'N') goto begW1;
endW1:
xitW1:
                cout << endl;
                cout << dlStr << '\n';
                cout << byeStr << '\n';
                cout << dlStr << '\n';

                return 0;
}

void CoutCstr(char cstr[])
{
                cout << cstr;
}

void CoutCstrNL(char cstr[])
{
                CoutCstr(cstr);
                cout << '\n';
}

void CoutOneInt(int oneInt)
{
                cout << oneInt;
}

void PopulateArray(int a[], int* usedPtr, int cap)
{
                char reply;
                char einStr[]    = "Enter integer #";
                char moStr[]     = "Max of ";
                char ieStr[]     = " ints entered...";
                char emiStr[]    = "Enter more ints? (n or N = no, others = yes) ";
                int *hopPtr;

                reply = 'y';
                *usedPtr = 0;
                hopPtr = a;
                goto WTest2;
begW2:
                CoutCstr(einStr);
                CoutOneInt(*usedPtr + 1);
                cout << ':' << ' ';
                cin >> *hopPtr;
                ++(*usedPtr);
                ++hopPtr;
                if (*usedPtr >= cap) goto else1;
begI1:
                CoutCstr(emiStr);
                cin >> reply;
                goto endI1;
else1:
                CoutCstr(moStr);
                CoutOneInt(cap);
                CoutCstr(ieStr);
                cout << endl;
                reply = 'n';
endI1:
WTest2:         if (reply == 'n') goto xitW2;
                if (reply != 'N') goto begW2;
endW2:
xitW2:
                return;
}

void ShowArray(int a[], int used)
{
                int *hopPtr;
                int *endPtr;

                if (used <= 0) goto endI2;
begI2:
                hopPtr = a;
                endPtr = a + used;
begDW1:
                cout << *hopPtr << ' ' << ' ';
                ++hopPtr;
endDW1:
DWTest1:        if (hopPtr < endPtr) goto begDW1;
endI2:
                cout << endl;
}

void ShowArrayLabeled(int a[], int used, char label[])
{
                CoutCstr(label);
                ShowArray(a, used);
}

void Swap(int* intPtr1, int* intPtr2)
{
                int temp = *intPtr1;
                *intPtr1 = *intPtr2;
                *intPtr2 = temp;
}

int  Min(int int1, int int2)
{
                if (int1 < int2)
                {
                   return int1;
                }
                else
                {
                   return int2;
                }
}

void SPFN(int used1, int a1[], int* nNegPtr, int* nPosPtr)
{
                int* hopPtr1;
                int* hopPtr2;
                int counter;

                hopPtr1 = a1;
                hopPtr2 = a1 + used1 - 1;
                counter = 0;
                while (hopPtr1 <= hopPtr2)
                {
                   while (hopPtr1 <= hopPtr2)
                   {
                      if (*hopPtr1 >= 0) break;
                      ++hopPtr1;
                      ++counter;
                   }
                   if (hopPtr1 > hopPtr2) break;
                   while (hopPtr2 >= hopPtr1)
                   {
                      if (*hopPtr2 < 0)
                      {
                         if (hopPtr1 != hopPtr2)
                         {
                            ++counter;
                         }
                         break;
                      }
                      --hopPtr2;
                   }
                   if (hopPtr1 > hopPtr2) break;
                   if (hopPtr1 != hopPtr2)
                   {
                      Swap(hopPtr1, hopPtr2);
                   }
                   ++hopPtr1;
                   --hopPtr2;
                }
                *nNegPtr = counter;
                *nPosPtr = used1 - counter;
}

// Sort array in non-decreasing order
// a1[] has items to sort; a2[] is work array
void BUMS(int a1[], int a2[], int used)
{
                int i;
                int width;
                int min1;
                int min2;

                width = 1;
                while (width < used)
                {
                   i = 0;
                   while (i < used)
                   {
                      min1 = Min(i+width, used);
                      min2 = Min(i+2*width, used);
                      BUM(a1, i, min1, min2, a2);
                      i = i + 2 * width;
                   }
                   CopyArray(a2, a1, used);
                   width = 2 * width;
                }
}

// Combine (sub-)arrays:
//   Left  run is a1[iL :iR-1]
//   Right run is a1[iR :iE-1]
void BUM(int a1[], int iL, int iR, int iE, int a2[])
{
                int *hopPtr11;
                int *hopPtr12;
                int *hopPtr2;
                int *endPtr11;
                int *endPtr12;
                int *endPtr2;

                hopPtr11 = a1 + iL;
                hopPtr12 = a1 + iR;
                endPtr11 = a1 + iR;
                endPtr12 = a1 + iE;

                for (hopPtr2 = a2 + iL, endPtr2 = a2 + iE;
                     hopPtr2 < endPtr2; ++hopPtr2)
                {
                   if ( hopPtr11 < endPtr11 &&
                        (hopPtr12 >= endPtr12 || *hopPtr11 <= *hopPtr12)
                      )
                   {
                      *hopPtr2 = *hopPtr11;
                      ++hopPtr11;
                   }
                   else
                   {
                      *hopPtr2 = *hopPtr12;
                      ++hopPtr12;
                   }
                }
}

// Copy a2[0]...a2[numEle2 - 1]
//   to a1[0]...a1[numEle2 - 1]
void CopyArray(int a2[], int a1[], int numEle2)
{
                int *hopPtr1;
                int *hopPtr2;
                int *endPtr2;

                hopPtr1 = a1;
                hopPtr2 = a2;
                endPtr2 = a2 + numEle2;
                while(hopPtr2 < endPtr2)
                {
                   *hopPtr1 = *hopPtr2;
                   ++hopPtr1;
                   ++hopPtr2;
                }
}

void ProcArray(int used1, int a1[], int a2[], int* nNegPtr, int* nPosPtr)
{
                char negaA1Str[] = "a1 negatives: ";
                char posiA1Str[] = "a1 positives: ";
                SPFN(used1, a1, nNegPtr, nPosPtr);
                ShowArrayLabeled(a1, *nNegPtr, negaA1Str);
                ShowArrayLabeled(a1 + *nNegPtr, *nPosPtr, posiA1Str);
                BUMS(a1, a2, used1);
                return;
}
