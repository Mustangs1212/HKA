#ifndef __DYNARR__
#define __DYNARR__

#include <iostream>
using namespace std;

template<typename T>
void copy_(T* s, int n, T* t) {
	int i = 0;
	while(i < n) {
		t[i] = s[i];
		i++;
	}
}


template<typename T>
class DynArr {
	int len;      // menge der Elemente
	T* p;         // Zeiger auf das Feld m it allen ellementen

public:

// Standard "leerer" Constructor
	DynArr() {
		this->len = 0;      // no ellements so lenght ist 0
		this->p = nullptr;  // no elements and no elements table
	}

	//
	DynArr(T x, int size) {
		this->len = size;       //  GrC6Ce des Arrays setzen
		this->p = new T[size];  // neue Tabelle fC<r n Elemente erstellen

		for(int i=0; i<size; i++) { // fC<r alle Elemente
			this->p[i] = x;           // Elemente kopieren
		}
	}

	// Copy Constructor
	// TODO
	// 3.5 Kopieren von Objekten (einfC<hrungs...pdf)
	// 3.5.1 Flache Kopie.
	// 3.5.2 Tiefe Kopie
	DynArr(const DynArr<T>& src) {
		this->len = src.len;
		if (src.len == 0) {
			this->p = nullptr;
		} else {
			this->p = new T[src.len];
			copy_(src.p, src.len, this->p);
		}
	}


	// Copy Zuweisungsoperator
	// TODO
	// Was passiert wen kopie von sich selbst ?
	// Speicherplatz reservieren & elemente Kopieren
	DynArr<T>& operator=(const DynArr<T>& src) {
		if (this == &src) return *this;   // Selbstzuweisung

		delete[] this->p;

		this->len = src.len;
		if (src.len == 0) {
			this->p = nullptr;
		} else {
			this->p = new T[src.len];
			copy_(src.p, src.len, this->p);
		}

		return *this;
	}

	// move constructor
	// TODO
	// elemente der Quelle "klauen"
	// 3.5.4 Move Semantik
	//  3.5.4.1 VollstC$ndigkeit einer Verschiebung !!
	DynArr(DynArr<T>&& src) {
		this->len = src.len;
		this->p = src.p;

		src.len = 0;
		src.p = nullptr;
	}
	// move = Operator
	// Was passiert wenn kverschiebung von sich selbst ?
	// Elemente aus der Quelle verschieben
	//
	DynArr<T>& operator=(DynArr<T>&& src) {
		if (this == &src) return *this;

		delete[] this->p;

		this->len = src.len;
		this->p = src.p;

		src.len = 0;
		src.p = nullptr;

		return *this;
	}

// Destructor
	~DynArr() {
		delete[] p; // LC6sche Tabelle mit Elementen

	}

//
	T& operator[](int index) {
		return p[index];
	}

//
	int size() const {
		return this->len;
	}

	string show() {
		string s;
		for(int i=0; i<this->len; i++) {
			s = s + to_string(p[i]);
		}
		return s;
	}

// TODO
	// Platz fC<r alle Elemente reservieren
	// Elemente umkopieren
	// neuen element hinzufC<gen
	// altes Zeugs entsorgen

	// Alternative -> append verwenden (nach entsprechenden Vorbereitung)
	void add(T x) {
		DynArr<T> tmp(x, 1);
		append(tmp);
	}

// TODO
	// fC<r die hC$lfte der ellementen
	// Elemet(anfang) holen und tmp speichern
	// Element (anfang) mit Element (ende) ersetzen
	// Element(ende) = tmp
	void reverse() {
		for (int i = 0; i < len / 2; i++) {
			T tmp = p[i];
			p[i] = p[len - 1 - i];
			p[len - 1 - i] = tmp;
		}
	}



// TODO
	// Platz fC<r alle Elemente reservieren
	// Elemente umkopieren
	// neue elemente hinzufC<gen
	// altes Zeugs entsorgen
	void append(const DynArr<T>& src) {
		if (src.len == 0) return;

		T* neu = new T[this->len + src.len];

		// alte Elemente kopieren
		copy_(this->p, this->len, neu);

		// src-Elemente anhC$ngen
		for (int i = 0; i < src.len; i++) {
			neu[this->len + i] = src.p[i];
		}

		delete[] this->p;
		this->p = neu;
		this->len += src.len;
	}

};


#endif