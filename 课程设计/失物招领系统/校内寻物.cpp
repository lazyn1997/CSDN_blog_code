#include<windows.h> 
#include<iostream>
#include<cstring>
#include<fstream>
#include<cstdlib>
void Note(char s[]);
void Main();
using namespace std;
int main()//�ж��Ƿ����ѭ�� 
{
	char s;
	do
	{
		cout<<"�Ƿ��������y������n�˳�\t";
		cin>>s;
		if(s=='y')
		{
			Main();
			system("pause");
			system("cls");//���� 
		} 	
		if(s=='n')
			cout<<"�������";
	}while(s=='y');
	return 0; 
}
void Find(string s)//����Ĳ��Һ��� 
{
	int n;
	char s1[80];
	string s2,s3;
	ifstream infile("f.txt",ios::in);
	infile.getline(s1,80);
	while(!infile.eof())
	{
		s2=s1;
		n=s2.find(s);
		if(n!=-1)
			cout<<s2<<endl; 
		infile.getline(s1,80);
	}
}
void Note(char s[])//�����������txt�ļ�¼����Ϣ�ĺ���1 
{ 
	char s1[80],s2[80],s4[80];
	int select; 
	cout<<"���������λ�ã�"<<endl;
	cin>>s1;
	strcat(s,s1);
	strcat(s,"��") ; 
	cout<<"��ѡ��񵽵���Ʒ��"<<endl;
	cout<<"1.����  ";
	cout<<"2.����  ";
	cout<<"3.����  "<<endl;
	cout<<"4.�α�  ";
	cout<<"5.Կ��  ";
	cout<<"6.��ɡ  "<<endl;
	cout<<"7.������Ʒ"<<endl;
	cin>>select;
	cin.sync();
	switch(select)
	{
		case 1:
			strcpy(s2,"����");
			break;
		case 2:
			strcpy(s2,"����");
			break;
		case 3:
			strcpy(s2,"����");
			break;
		case 4:
			strcpy(s2,"�α�");
			break;
		case 5:
			strcpy(s2,"Կ��");
			break;
		case 6:
			strcpy(s2,"ɡ");
			break;
		case 7:
			cout<<"������񵽵���Ʒ��"<<endl;
			cin>>s2;
			strcat(s2,"(������Ʒ)"); 
			break;	
	}
	strcat(s,s2); 
	char s3[]=" QQ:";
	strcat(s,s3);
	cout<<"������QQ,����ʧ����ϵ��"<<endl;
	cin>>s4;
	strcat(s,s4);
	cout<<s<<endl;
	ofstream outfile("f.txt",ios::app);
	outfile<<s;
	outfile<<endl;
	outfile.close();
}
void Note1(char s[])//�����������txt�ļ�¼����Ϣ�ĺ���2
{
	char s1[80],s2[80];
	int select;
	strcat(s,"��") ;
	cout<<"��ѡ��񵽵���Ʒ��"<<endl;
	cout<<"1.����  ";
	cout<<"2.����  ";
	cout<<"3.����  "<<endl;
	cout<<"4.�α�  ";
	cout<<"5.Կ��  ";
	cout<<"6.��ɡ  "<<endl;
	cout<<"7.������Ʒ"<<endl;
	cin>>select;
	cin.sync();
	switch(select)
	{
		case 1:
			strcpy(s1,"����");
			break;
		case 2:
			strcpy(s1,"����");
			break;
		case 3:
			strcpy(s1,"����");
			break;
		case 4:
			strcpy(s1,"�α�");
			break;
		case 5:
			strcpy(s1,"Կ��");
			break;
		case 6:
			strcpy(s1,"ɡ");
			break;
		case 7:
			cout<<"������񵽵���Ʒ��"<<endl;
			cin>>s1;
			strcat(s1,"(������Ʒ)");
			break;
	}
	strcat(s,s1);
	char s3[]=" QQ:";
	strcat(s,s3);
	cout<<"������QQ,����ʧ����ϵ��"<<endl;
	cin>>s2;
	strcat(s,s2);
	cout<<s<<endl;
	ofstream outfile("f.txt",ios::app);
	outfile<<s;
	outfile<<endl;
	outfile.close();
}
void Main()//���й���ѡ��������� 
{
	int select;
	cout<<"��ѡ����Ҫʹ�õĹ��ܣ�"<<endl;
	cout<<"1.ʰ������"<<"  ";
	cout<<"2.ʧ��Ѱ��"<<endl;
	cin>>select;
	cin.sync();
	switch(select)
	{
	case 1:
		{SYSTEMTIME sys;
		GetLocalTime(&sys);
		ofstream outfile("f.txt",ios::app);
		outfile<< sys.wYear << "��" << sys.wMonth << "��" << sys.wDay
		<< "��" << sys.wHour << ":" << sys.wMinute<<"  ";//��ϵͳʱ��¼�뵽���� 
		outfile.close();
		int select;
		cout<<"��ѡ�����Ʒ������"<<endl;
		cout<<"1.����������"<<endl; 
		cout<<"2.���Ľ�ѧ��"<<endl;
		cout<<"3.����������"<<endl;
		cin>>select;
		cin.sync();
		switch(select)
		{
			int select;
			case 1: 
				cout<<"��ѡ�����Ʒ��λ�ã�"<<endl;
				cout<<"1.��԰ʳ��  ";
				cout<<"2.��԰ʳ��  "; 
				cout<<"3.����  ";
				cout<<"4.����  ";
				cout<<"5.��·��  ";
				cout<<"6.��ѧ�������  "<<endl;
				cin>>select;
				cin.sync();
				switch(select)
				{
					char s[80];
					case 1:
						strcpy(s,"������������԰ʳ��"); 
						Note(s);
						break;
					case 2:
						strcpy(s,"������������԰ʳ��");
						Note(s);
						break; 
					case 3:
						strcpy(s,"��������������");
						Note(s);
						break;
					case 4:
						strcpy(s,"��������������");
						Note(s);
						break;
					case 5:
						strcpy(s,"������������·��");
						Note1(s);
						break;
					case 6:
						strcpy(s,"������������ѧ�������");
						Note(s);
						break;
				}
				break;
			case 2: 
				cout<<"��ѡ�����Ʒ��λ�ã�"<<endl;
				cout<<"1.ͼ���  ";
				cout<<"2.��ѧ¥  ";
				cout<<"3.����  ";
				cout<<"4.��·��  "<<endl;
				cin>>select;
				cin.sync();
				switch(select)
				{
					char s[80];
					case 1:
						strcpy(s,"���Ľ�ѧ��ͼ���") ;
						Note(s);
						break;
					case 2:
						strcpy(s,"���Ľ�ѧ����ѧ¥");
						Note(s);
						break;
					case 3:
						strcpy(s,"���Ľ�ѧ������");
						Note(s);
						break;
					case 4:
						strcpy(s,"���Ľ�ѧ����·��");
						Note1(s);
						break; 
				}
				break;
			case 3:
				cout<<"��ѡ�����Ʒ��λ�ã�"<<endl;
				cout<<"1.÷԰ʳ��  ";
				cout<<"2.��԰ʳ��  "; 
				cout<<"3.����  ";
				cout<<"4.����  ";
				cout<<"5.��·��  ";
				cout<<"6.��ѧ�������  "<<endl; 
				cin>>select;
				cin.sync();
				switch(select)
				{
					char s[80];
					case 1:
						strcpy(s,"����������÷԰ʳ��"); 
						Note(s);
						break;
					case 2:
						strcpy(s,"������������԰ʳ��");
						Note(s);
						break; 
					case 3:
						strcpy(s,"��������������");
						Note(s);
						break;
					case 4:
						strcpy(s,"��������������");
						Note(s);
						break;
					case 5:
						strcpy(s,"������������·��");
						Note1(s);
						break;
					case 6:
						strcpy(s,"������������ѧ�������");
						Note(s);
						break;
				}
				break;
		}
		break;}
	case 2:
		cout<<"��ѡ��ʧ����Ʒ��"<<endl;
		cout<<"1.����  ";
		cout<<"2.����  ";
		cout<<"3.����  "<<endl;
		cout<<"4.�α�  ";
		cout<<"5.Կ��  ";
		cout<<"6.��ɡ  "<<endl;
		cout<<"7.������Ʒ"<<endl;
		cin>>select;
		cin.sync();
		string s;
		switch(select)
		{
			case 1:
				s="����";
				Find(s);
				break;
			case 2:
				s="����";
				Find(s);
				break;
			case 3:
				s="����";
				Find(s);
				break;
			case 4:
				s="�α�";
				Find(s);
				break;
			case 5:
				s="Կ��";
				Find(s);
				break;
			case 6:
				s="ɡ";
				Find(s);
				break;
			case 7:
				s="(������Ʒ)";
				Find(s); 
				break;	
		}	
		break;
	}
}

