#include <iostream>
using namespace std

int main ()
{
	int foo [] = {16, 2, 77, 40, 12071};
	int n, result=0;

 	for ( n=0 ; n<5 ; ++n )
 	{
 		result += foo[n];
 	}
 	cout << result;
 	return 0;
}