// Factorial of n = 1*2*3*...*n

#include <iostream>
using namespace std;

int factorial(int, int);

int main()
{
  int n, result, a = 1;

  cout << "Enter a non-negative number: ";
  cin >> n;

  result = factorial(a, n);
  cout << "Factorial of " << n << " = " << result;
  return 0;
}

int factorial(int a, int n)
{
  if (n > a)
  {
    return a * n * factorial(a, n - 1);
  }
  else
  {
    return a;
  }
}