#include<windows.h> 
#include<iostream>
#include<cstring>
#include<fstream>
#include<cstdlib>
void Note(char s[]);
void Main();
using namespace std;
int main()//判断是否进行循环 
{
	char s;
	do
	{
		cout<<"是否继续程序？y继续，n退出\t";
		cin>>s;
		if(s=='y')
		{
			Main();
			system("pause");
			system("cls");//清屏 
		} 	
		if(s=='n')
			cout<<"程序结束";
	}while(s=='y');
	return 0; 
}
void Find(string s)//定义的查找函数 
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
void Note(char s[])//定义的往本地txt文件录入信息的函数1 
{ 
	char s1[80],s2[80],s4[80];
	int select; 
	cout<<"请输入具体位置："<<endl;
	cin>>s1;
	strcat(s,s1);
	strcat(s,"捡到") ; 
	cout<<"请选择捡到的物品："<<endl;
	cout<<"1.耳机  ";
	cout<<"2.饭卡  ";
	cout<<"3.优盘  "<<endl;
	cout<<"4.课本  ";
	cout<<"5.钥匙  ";
	cout<<"6.雨伞  "<<endl;
	cout<<"7.其他物品"<<endl;
	cin>>select;
	cin.sync();
	switch(select)
	{
		case 1:
			strcpy(s2,"耳机");
			break;
		case 2:
			strcpy(s2,"饭卡");
			break;
		case 3:
			strcpy(s2,"优盘");
			break;
		case 4:
			strcpy(s2,"课本");
			break;
		case 5:
			strcpy(s2,"钥匙");
			break;
		case 6:
			strcpy(s2,"伞");
			break;
		case 7:
			cout<<"请输入捡到的物品："<<endl;
			cin>>s2;
			strcat(s2,"(其他物品)"); 
			break;	
	}
	strcat(s,s2); 
	char s3[]=" QQ:";
	strcat(s,s3);
	cout<<"请输入QQ,便于失主联系："<<endl;
	cin>>s4;
	strcat(s,s4);
	cout<<s<<endl;
	ofstream outfile("f.txt",ios::app);
	outfile<<s;
	outfile<<endl;
	outfile.close();
}
void Note1(char s[])//定义的往本地txt文件录入信息的函数2
{
	char s1[80],s2[80];
	int select;
	strcat(s,"捡到") ;
	cout<<"请选择捡到的物品："<<endl;
	cout<<"1.耳机  ";
	cout<<"2.饭卡  ";
	cout<<"3.优盘  "<<endl;
	cout<<"4.课本  ";
	cout<<"5.钥匙  ";
	cout<<"6.雨伞  "<<endl;
	cout<<"7.其他物品"<<endl;
	cin>>select;
	cin.sync();
	switch(select)
	{
		case 1:
			strcpy(s1,"耳机");
			break;
		case 2:
			strcpy(s1,"饭卡");
			break;
		case 3:
			strcpy(s1,"优盘");
			break;
		case 4:
			strcpy(s1,"课本");
			break;
		case 5:
			strcpy(s1,"钥匙");
			break;
		case 6:
			strcpy(s1,"伞");
			break;
		case 7:
			cout<<"请输入捡到的物品："<<endl;
			cin>>s1;
			strcat(s1,"(其他物品)");
			break;
	}
	strcat(s,s1);
	char s3[]=" QQ:";
	strcat(s,s3);
	cout<<"请输入QQ,便于失主联系："<<endl;
	cin>>s2;
	strcat(s,s2);
	cout<<s<<endl;
	ofstream outfile("f.txt",ios::app);
	outfile<<s;
	outfile<<endl;
	outfile.close();
}
void Main()//进行功能选项的主程序 
{
	int select;
	cout<<"请选择你要使用的功能："<<endl;
	cout<<"1.拾物招领"<<"  ";
	cout<<"2.失物寻找"<<endl;
	cin>>select;
	cin.sync();
	switch(select)
	{
	case 1:
		{SYSTEMTIME sys;
		GetLocalTime(&sys);
		ofstream outfile("f.txt",ios::app);
		outfile<< sys.wYear << "年" << sys.wMonth << "月" << sys.wDay
		<< "日" << sys.wHour << ":" << sys.wMinute<<"  ";//将系统时间录入到本地 
		outfile.close();
		int select;
		cout<<"请选择捡到物品的区域："<<endl;
		cout<<"1.西区生活区"<<endl; 
		cout<<"2.中心教学区"<<endl;
		cout<<"3.东区生活区"<<endl;
		cin>>select;
		cin.sync();
		switch(select)
		{
			int select;
			case 1: 
				cout<<"请选择捡到物品的位置："<<endl;
				cout<<"1.兰园食堂  ";
				cout<<"2.竹园食堂  "; 
				cout<<"3.宿舍  ";
				cout<<"4.超市  ";
				cout<<"5.道路上  ";
				cout<<"6.大学生活动中心  "<<endl;
				cin>>select;
				cin.sync();
				switch(select)
				{
					char s[80];
					case 1:
						strcpy(s,"西区生活区兰园食堂"); 
						Note(s);
						break;
					case 2:
						strcpy(s,"西区生活区竹园食堂");
						Note(s);
						break; 
					case 3:
						strcpy(s,"西区生活区宿舍");
						Note(s);
						break;
					case 4:
						strcpy(s,"西区生活区超市");
						Note(s);
						break;
					case 5:
						strcpy(s,"西区生活区道路上");
						Note1(s);
						break;
					case 6:
						strcpy(s,"西区生活区大学生活动中心");
						Note(s);
						break;
				}
				break;
			case 2: 
				cout<<"请选择捡到物品的位置："<<endl;
				cout<<"1.图书馆  ";
				cout<<"2.教学楼  ";
				cout<<"3.会堂  ";
				cout<<"4.道路上  "<<endl;
				cin>>select;
				cin.sync();
				switch(select)
				{
					char s[80];
					case 1:
						strcpy(s,"中心教学区图书馆") ;
						Note(s);
						break;
					case 2:
						strcpy(s,"中心教学区教学楼");
						Note(s);
						break;
					case 3:
						strcpy(s,"中心教学区会堂");
						Note(s);
						break;
					case 4:
						strcpy(s,"中心教学区道路上");
						Note1(s);
						break; 
				}
				break;
			case 3:
				cout<<"请选择捡到物品的位置："<<endl;
				cout<<"1.梅园食堂  ";
				cout<<"2.菊园食堂  "; 
				cout<<"3.宿舍  ";
				cout<<"4.超市  ";
				cout<<"5.道路上  ";
				cout<<"6.大学生活动中心  "<<endl; 
				cin>>select;
				cin.sync();
				switch(select)
				{
					char s[80];
					case 1:
						strcpy(s,"东区生活区梅园食堂"); 
						Note(s);
						break;
					case 2:
						strcpy(s,"东区生活区菊园食堂");
						Note(s);
						break; 
					case 3:
						strcpy(s,"东区生活区宿舍");
						Note(s);
						break;
					case 4:
						strcpy(s,"东区生活区超市");
						Note(s);
						break;
					case 5:
						strcpy(s,"东区生活区道路上");
						Note1(s);
						break;
					case 6:
						strcpy(s,"东区生活区大学生活动中心");
						Note(s);
						break;
				}
				break;
		}
		break;}
	case 2:
		cout<<"请选择丢失的物品："<<endl;
		cout<<"1.耳机  ";
		cout<<"2.饭卡  ";
		cout<<"3.优盘  "<<endl;
		cout<<"4.课本  ";
		cout<<"5.钥匙  ";
		cout<<"6.雨伞  "<<endl;
		cout<<"7.其他物品"<<endl;
		cin>>select;
		cin.sync();
		string s;
		switch(select)
		{
			case 1:
				s="耳机";
				Find(s);
				break;
			case 2:
				s="饭卡";
				Find(s);
				break;
			case 3:
				s="优盘";
				Find(s);
				break;
			case 4:
				s="课本";
				Find(s);
				break;
			case 5:
				s="钥匙";
				Find(s);
				break;
			case 6:
				s="伞";
				Find(s);
				break;
			case 7:
				s="(其他物品)";
				Find(s); 
				break;	
		}	
		break;
	}
}

