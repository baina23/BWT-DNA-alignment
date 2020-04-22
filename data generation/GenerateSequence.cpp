#include <iostream>
#include <cstdio>
#include <string>
#include <algorithm>
#include <vector>
#include <ctime>
#include<math.h>
#include<bitset>
#include <streambuf>
#include <fstream>
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
	cout << "输入序列长度：";
	cin >> n;
	cout << "输入target长度：";
	cin >> l;
	cout << "输入target起始坐标(0为初始)：";
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
















