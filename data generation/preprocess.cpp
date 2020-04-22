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

struct PAIR
{
	string str;
	int num;
};

int C[4] = {};
int Occ[1024][4];

int Interpre(char a);
bool COMP(struct PAIR A, struct PAIR B);

int main(void)
{
	//initialization
	string ref;
	ifstream infile;
	infile.open("C:/Users/yujie/Desktop/zyj_work/GenerateSequence/GenerateSequence/Sequence.txt", ios::in);
	while (!infile.eof())
	{
		infile >> ref;
	}
	cout << "¶ÁÈëÍê±Ï\n";
	infile.close();
	int n = ref.size();
	int count[4] = {};
	int D[100] = {};
	PAIR* str_matrix = new struct PAIR[n];
	vector<int> I;
	int* W = new int[n];
	for (int i = 0; i < n; i++)
		W[i] = Interpre(ref[i]);


	//BWT PART
	for (int i = 0; i < n; i++)
	{
		count[Interpre(ref[i])]++;

		int j = n - i;
		str_matrix[i].num = i;
		str_matrix[i].str = ref.substr(i, j) + ref.substr(0, i);

	}

	sort(str_matrix, str_matrix + n, COMP);//sort
	for (int i = 1; i < 4; i++)//generate C[]
		C[i] = C[i - 1] + count[i - 1];

	for (int i = 0; i < 4; i++)
		count[i] = 0;


	for (int i = 0; i < n; i++)//generate Occ[]
	{
		count[Interpre(str_matrix[i].str[n - 1])]++;
		for (int j = 0; j < 4; j++)
			Occ[i][j] = count[j];
	}

	ofstream sa("SA.txt");
	for (int i = 0; i < n; i++)
	{
		printf("[%02d(%02d)]", i, str_matrix[i].num);
		cout //<< str_matrix[i].str << ' '
			<< Occ[i][0] << ' '
			<< Occ[i][1] << ' '
			<< Occ[i][2] << ' '
			<< Occ[i][3] << endl;
		sa << bitset<10>(str_matrix[i].num) << endl;
	}
	sa.close();

	cout << endl << "C[i]:";

	ofstream oo("C.txt");
	for (int i = 0; i < 4; i++)
	{
		cout << C[i] << ' ';
		oo << bitset<10>(C[i]) << endl;
	}
	oo.close();
	cout << endl;

	ofstream mycout0("OCCA.txt");
	ofstream mycout1("OCCC.txt");
	ofstream mycout2("OCCG.txt");
	ofstream mycout3("OCCT.txt");
	for (int i = 0; i < 4; i++)
	{
		switch (i) {
		case(0): {
			for (int j = 0; j < n; j++)
				mycout0 << bitset<10>(Occ[j][i]) << endl;
			break; }
		case(1): {
			for (int j = 0; j < n; j++)
				mycout1 << bitset<10>(Occ[j][i]) << endl;
			break; }
		case(2): {
			for (int j = 0; j < n; j++)
				mycout2 << bitset<10>(Occ[j][i]) << endl;
			break; }
		case(3): {
			for (int j = 0; j < n; j++)
				mycout3 << bitset<10>(Occ[j][i]) << endl;
			break; }
		}

	}
	mycout0.close();
	mycout1.close();
	mycout2.close();
	mycout3.close();
}






int Interpre(char a)//string to array of int
{
	switch (a)
	{
	case 'A':return 0;
	case 'C': return 1;
	case 'G': return 2;
	case 'T': return 3;
		//case '$': return 0;
	default: return 5;
	}
}

bool COMP(struct PAIR A, struct PAIR B)//comp function for sort()
{
	return A.str < B.str;
}



