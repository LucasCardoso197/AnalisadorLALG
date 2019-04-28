#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <string.h>
#include <time.h>

enum {
	FALSE,
	TRUE
};

typedef unsigned char bool;

typedef struct {
	int key;
	unsigned char flag:1;
	void *content;
} HASH_ENTRY;

typedef struct {
	int nelements;
	HASH_ENTRY *entries;
} HASH_TABLE;

char *palavra_reservada[]={"begin","const","do",
							"end","else","for","if",
							"integer","procedure","program",
							"real","read","while","write"};


void hash_destroy(HASH_TABLE *table) {
	if (table != NULL) {
		free(table->entries);
		// content
		free(table);
	}
}

bool hash_put(HASH_TABLE *table, int key, void *content) {
	int position, i = 1;
	
	// aplicar funcao de espalhamento
	position = key % table->nelements;

	while (table->entries[position].flag && i < table->nelements) {
		position = ((key % table->nelements) + i) % table->nelements;
		i++;
	}

	if (!table->entries[position].flag) {
		table->entries[position].flag = TRUE;
		table->entries[position].key = key;
		table->entries[position].content = content;
		return TRUE;
	}

	return FALSE;
}

void *hash_get(HASH_TABLE *table, int key) {
	int position, i = 1;
	
	// aplicar funcao de espalhamento
	position = key % table->nelements;

	while (table->entries[position].key != key && table->entries[position].flag && i < table->nelements) {
		position = ((key % table->nelements) + i) % table->nelements;
		i++;
	}

	if (table->entries[position].key == key &&
			table->entries[position].flag) {
		//return table->(entries+position)->content;
		return table->entries[position].content;
	}

	return NULL;
}

int get_key(char *s){
	/*
	* hash(s)=s[0]+s[1]⋅p+s[2]⋅p2+...+s[n−1]⋅pn−1modm
	* =∑(i=0 ate n−1)s[i]⋅p^i mod m,
	*/
	int index=0,c,flag=0, i=0, lenght = strlen(s);
	int ppower=0,p=3,m=97;

	for (i = 0; i < lenght; ++i){
		ppower = pow(p,i+1);
		c=s[i]*ppower;
		index += c;
	}
	index = index % m;
	return index;
}

HASH_TABLE *hash_create( ) {
	int i=0, n=17,key=0;
	HASH_TABLE *table = (HASH_TABLE *)malloc(sizeof(HASH_TABLE));
	table->nelements = n;
	table->entries = (HASH_ENTRY *) calloc(n, sizeof(HASH_ENTRY));
	for (i = 0; i < 14; i++) {
		key = get_key(palavra_reservada[i]);
		hash_put(table, key, palavra_reservada[i]);
	}
	return table;
}
