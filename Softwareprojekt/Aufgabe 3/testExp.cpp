#include <iostream>
#include <string>

using namespace std;

#include "exp.h"





void testTree(EXP e)
{
  cout << e->pretty() <<  " = " << e->eval() << "\n";
  auto vm = VM(e->compile());
  vm.runAndPrint();
  cout << "\nEvaluation : " << e->eval();

}


void testExp() {


  EXP e1 = newPlus (newInt(2),newMult( newInt(1), newInt(4))); 
  testTree(e1);
  
  cout << "\n" << "********************" << "\n";
  EXP e2 = newMult(e1,e1);
  testTree(e2);


  cout << "\n" << "********************" << "\n";
  EXP e3 = newPlus (newInt(2),e2);
  testTree(e3);
}


int main() {

  testExp();

  return 1;
}