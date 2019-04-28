#ifndef _HASH_LINEAR_H_
#define _HASH_LINEAR_H_

typedef unsigned char bool;
typedef struct HASH_TABLE HASH_TABLE;
HASH_TABLE *hash_create();
void hash_destroy(HASH_TABLE *table);
bool hash_put(HASH_TABLE *table, int key, void *content);
void *hash_get(HASH_TABLE *table, int key);
int get_key(char *s);


#endif