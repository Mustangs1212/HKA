#include <iostream>
#include <string>
#include <vector>

using namespace std;

#include "vm.h"
#include "exp.h"

int IntExp::eval() {
	return val;
}

int PlusExp::eval() {
	return e1->eval() + e2->eval();
}

int MultExp::eval() {
	return e1->eval() * e2->eval();
}


// TODO
vector<Code> IntExp::compile() {
	vector<Code> v;
	v.push_back(newPush(val));
	return v;
}


// TODO
vector<Code> PlusExp::compile() {
	vector<Code> v;
	auto l = e1->compile();
	auto r = e2->compile();

	v.insert(v.end(), l.begin(), l.end());
	v.insert(v.end(), r.begin(), r.end());
	v.push_back(newPlus());
	return v;
}

// TODO
vector<Code> MultExp::compile() {
	vector<Code> v;
	auto l = e1->compile();
	auto r = e2->compile();

	v.insert(v.end(), l.begin(), l.end());
	v.insert(v.end(), r.begin(), r.end());
	v.push_back(newMult());
	return v;
}


EXP newInt(int i) {
	return std::make_shared<IntExp>(i);
}

EXP newPlus(EXP l, EXP r) {
	return std::make_shared<PlusExp>(l,r);
}

EXP newMult(EXP l, EXP r) {
	return std::make_shared<MultExp>(l,r);
}


string IntExp::pretty() {
	return to_string(val);
}

string PlusExp::pretty() {
	string s(e1->pretty());
	s.append("+");
	s.append(e2->pretty());
	return s;
}

string MultExp::pretty() {
	string s("");
	if (typeid(*e1) == typeid(PlusExp)) {
		s.append("(");
		s.append(e1->pretty());
		s.append(")");
	}
	else {
		s.append(e1->pretty());
	}
	s.append("*");
	if (typeid(*e2) == typeid(PlusExp)) {
		s.append("(");
		s.append(e2->pretty());
		s.append(")");

	}
	else {
		s.append(e2->pretty());
	}
	return s;
}
