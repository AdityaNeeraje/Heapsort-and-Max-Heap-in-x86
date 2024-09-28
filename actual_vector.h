/*
 * AUTHOR: ASHWIN ABRAHAM
 */
#ifndef VECTOR_H
#define VECTOR_H

#include<stdlib.h>
#include<stdio.h>
#include<stdint.h>
#include<stddef.h>

/* 
 * This is a vector of 64 bit unsigned integers
 * The time complexities of the member functions should all be amortized O(1) (unless otherwise mentioned)
 */
typedef struct vector {
    uint64_t buff_size; /* This stores the size of the buffer (should be initialized to 0) */ 
    uint64_t size; /* This stores the number of elements in the vector (should be initialized to 0) */
    uint64_t *ptr; /* This is a pointer to the buffer storing the integers (should be initialized to NULL) */
} __attribute__((packed)) vector;

/*
 * This function behaves like a constructor, should always be called immediately after declaring the vector
 * It takes as argument a pointer to the vector
 */
// void init_v(vector * vector_pointer){
    // vector_pointer->buff_size = 0;
    // vector_pointer->size = 0;
    // vector_pointer->ptr = NULL;
// };
void init_v(vector *vector_pointer);
// {
//     vector_pointer->buff_size = 0;
//     vector_pointer->size = 0;
//     vector_pointer->ptr = NULL;
// };

/*
 * This function behaves like a destructor, should always be called immediately when the vector goes out of scope
 * It takes as argument a pointer to the vector 
 */
void delete_v(vector * vector_pointer);
// void delete_v(vector * vector_pointer){
//     free(vector_pointer->ptr);
//     vector_pointer->buff_size = 0;
//     vector_pointer->size = 0;
//     vector_pointer->ptr = NULL;
// };

/*
 * This function resizes the amount of memory allocated to the buffer of the vector
 * It takes as argument a pointer to the vector 
 * You can use the realloc function to resize the buffer (freeing the original pointer and using malloc to get a new pointer is also an option)
 * This function can have time complexity O(n)
 */
void resize_v(vector * vector_pointer, uint64_t size);
// void resize_v(vector * vector_pointer, uint64_t size){
//     if (vector_pointer == NULL){
//         vector_pointer->ptr = (u_int64_t*) malloc(size * sizeof(uint64_t));
//     }
//     else {
//         vector_pointer->ptr = (u_int64_t*) realloc(vector_pointer->ptr, size * sizeof(uint64_t));
//     }
//     vector_pointer->buff_size = size;
// };

/*
 * This function returns a pointer to the ith element of the vector
 * Bounds checking is not required
 * The first argument is the vector, and the second argument is the index of the element to be accessed
 */
uint64_t *get_element_v(const vector * vector_pointer, uint64_t index);
// {
//     return vector_pointer->ptr + index;
// };

/*
 * This function inserts an element into the back of the vector
 * The first argument is a pointer to the vector, and the second argument is the element to be inserted
 * 
 * You may need to resize the vector if the buffer was full (You can use the resize_v function)
 * If the original size of the buffer was s, the new size should be 2*s + 1 (so that insertion is amortized O(1))
 */
void push_v(vector * vector_pointer, uint64_t element);
// {
//     if (vector_pointer->size == vector_pointer->buff_size){
//         resize_v(vector_pointer, 2 * vector_pointer->buff_size + 1);
//     }
//     vector_pointer->ptr[vector_pointer->size] = element;
//     vector_pointer->size++;
// };

// /*
//  * This function removes the last element from the back of the vector and returns it
//  * No need to decrease the size of the buffer
//  * The only argument is a pointer to the vector
//  */
uint64_t pop_v(vector *vector_pointer);
// {    
//     vector_pointer->size--;
//     return vector_pointer->ptr[vector_pointer->size];
// };

// /*
//  * This function returns the size of the vector
//  * It takes as argument a pointer to the vector
//  */
uint64_t size_v(const vector *vector_pointer);
// {
//     return vector_pointer->size;
// };

// int testing(){
//     vector v;
//     init_v(&v);
//     printf("Buffer Size: %lu\n", v.buff_size);
//     printf("Size: %lu\n", v.size);
//     printf("Buffer Size: %lu\n", v.buff_size);
//     push_v(&v, 7);
//     printf("%llu\n", (unsigned long long)*get_element_v(&v, 0));
//     printf("Size: %lu\n", v.size);
//     push_v(&v, 6);
//     printf("%llu\n", (unsigned long long)*get_element_v(&v, 1));
//     pop_v(&v);
//     printf("Size: %lu\n", v.size);
//     push_v(&v, 5);
//     printf("%llu\n", (unsigned long long)*get_element_v(&v, 1));
//     printf("Buffer Size: %lu\n", v.buff_size);
//     delete_v(&v);
// }

#endif