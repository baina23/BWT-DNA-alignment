#include <iostream>
#include <cstdio>
#include <string>
#include<math.h>
#include <fstream>
#include <bitset>
using namespace std;

char trans(int x)
{
	switch (x) {
		case(0):return('A');
		case(1):return('C');
		case(2):return('G');
		case(3):return('T');
		default:return(' ');
	}

}
int main(void)
{
	int n,l,a,num;
	char temp;
	cout << "Input sequence length：";
	cin >> n;
	cout << "Input reads length：";
	cin >> l;
	cout << "Input reads starting position (0 is initial)：";
	cin >> a;
	ofstream seq("Sequence.txt");
	ofstream target("Target.txt");
	for (int i = 0 ; i < n; i++)
	{
		num = rand() % 4;
		temp = trans(num);
		cout << temp;
		seq << char(temp);
		if ((i >= a) && (i < a + l))
		{
		target<< bitset<2>(num)<<endl;
		}
		
	}
	cout << endl;
	seq.close();
	target.close();
}
















