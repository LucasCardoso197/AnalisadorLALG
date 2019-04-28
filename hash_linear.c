#include <stdlib.h>
#include <stdio.h>
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

HASH_TABLE *hash_create(int n) {
	HASH_TABLE *table = (HASH_TABLE *)malloc(sizeof(HASH_TABLE));
	table->nelements = n;
	table->entries = (HASH_ENTRY *) calloc(n, sizeof(HASH_ENTRY));
	return table;
}

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

	while (table->entries[position].flag &&
			i < table->nelements) {
		position = ((key % table->nelements) + i) %
				table->nelements;
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

	while (table->entries[position].key != key &&
			table->entries[position].flag &&
			i < table->nelements) {
		position = ((key % table->nelements) + i) %
				table->nelements;
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
	int index=0,c, i, lenght = strlen(s);
	for (i = 0; i < lenght; ++i){
		c=s[i];
		index += c;
		//printf("%d   %c ; ",c,s[i] );
	}
	return index;
}


