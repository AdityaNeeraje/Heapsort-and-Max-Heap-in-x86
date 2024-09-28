/*
 * AUTHOR: ASHWIN ABRAHAM
 */
#ifndef HEAP_H
#define HEAP_H

#include "../actual_vector.h"
#include<stdlib.h>
#include<stdio.h>
#include<stdint.h>
#include<stddef.h>

/*
 * This is a max heap of 64 bit unsigned integers
 * The time complexities of the member functions should all be amortized O(1) (unless otherwise mentioned)
 */
typedef struct heap {
    vector arr; /* The array implementation of a heap is used, and we don't store the size of the heap explicitly, so size of heap = size of array */
} __attribute__((packed)) heap;

/*
 * This function behaves like a constructor, should always be called immediately after declaring the heap
 * It takes as argument a pointer to the heap
 */
void init_h(heap *given_heap);
// {
//     init_v(&(given_heap->arr));
// };

/*
 * This function behaves like a destructor, should always be called immediately when the heap goes out of scope
 * It takes as argument a pointer to the heap
 */
void delete_h(heap *given_heap);
// {
//     delete_v(&(given_heap->arr));
// };
/*
 * This function returns the size of the heap
 * It takes as argument a pointer to the heap
 */
uint64_t size_h(const heap *given_heap);
// {
//     return given_heap->arr.size;
// };
/* 
 * This function inserts an element into the heap
 * The first argument is a pointer to the heap and the second argument is the element to be inserted
 * This function can have time complexity O(log n)
 */
void insert_h(heap *given_heap, uint64_t element);
// {
//     uint64_t i = given_heap->arr.size;
//     resize_v(&(given_heap->arr), given_heap->arr.size + 1);
//     given_heap->arr.ptr[i] = element;
//     while (i > 0 && given_heap->arr.ptr[i] > given_heap->arr.ptr[(i - 1) / 2]){
//         uint64_t temp = given_heap->arr.ptr[i];
//         given_heap->arr.ptr[i] = given_heap->arr.ptr[(i - 1) / 2];
//         given_heap->arr.ptr[(i - 1) / 2] = temp;
//         i = (i - 1) / 2;
//     }
// };

/* 
 * This function returns the maximum element of the heap
 * It takes as argument a pointer to the heap
 */
uint64_t get_max(const heap *given_heap);
// {
//     return given_heap->arr.ptr[0];
// };
/*
 * This function removes the maximum element of the heap and returns it
 * It takes as argument a pointer to the heap
 * This function can have time complexity O(log n)
 */
uint64_t pop_max(heap *given_heap);
// {
//     uint64_t max = given_heap->arr.ptr[0];
//     given_heap->arr.ptr[0] = given_heap->arr.ptr[given_heap->arr.size - 1];
// // 10 is at the start of the array
//     resize_v(&(given_heap->arr), given_heap->arr.size - 1);
//     uint64_t i = 0;
//     while (2 * i + 1 < given_heap->arr.size){
//         uint64_t j = 2 * i + 1;
//         if (j + 1 < given_heap->arr.size && given_heap->arr.ptr[j + 1] > given_heap->arr.ptr[j]){
//             j++;
//         }
//         if (given_heap->arr.ptr[i] < given_heap->arr.ptr[j]){
//             uint64_t temp = given_heap->arr.ptr[i];
//             given_heap->arr.ptr[i] = given_heap->arr.ptr[j];
//             given_heap->arr.ptr[j] = temp;
//             i = j;
//         }
//         else {
//             break;
//         }
//     }
//     return max;
// };


/* Implementing the functions below is optional */

/*
 * This is the heapify function (converts an array into a max heap)
 * It takes as argument a pointer to the heap
 * This function should have time complexity O(n)
 * FYI: Some of you may know this as the build_heap function
 * This may not be the same as the heapify you all are used to
 * So please do take care while reading the definitions
 * The definitions of the functions in the code are final
 */
void heapify(vector *vector_pointer);
// {
//     for (uint64_t i = vector_pointer->size / 2 + 1; i > 0; i--){
//         uint64_t j = i-1;
//         while (2 * j + 1 < vector_pointer->size){
//             uint64_t k = 2 * j + 1;
//             if (k + 1 < vector_pointer->size && vector_pointer->ptr[k + 1] > vector_pointer->ptr[k]){
//                 k++;
//             }
//             if (vector_pointer->ptr[j] < vector_pointer->ptr[k]){
//                 uint64_t temp = vector_pointer->ptr[j];
//                 vector_pointer->ptr[j] = vector_pointer->ptr[k];
//                 vector_pointer->ptr[k] = temp;
//                 j = k;
//             }
//             else {
//                 break;
//             }
//         }
//     }
// };


/*
 * This is the heapsort function (sorts an array by converting it into a max heap and repeatedly popping the max element)
 * It takes as argument a pointer to the heap
 * This function should have time complexity O(n log n)
 */
void heapsort(vector *vector_pointer);
// {
//     heapify(vector_pointer);
//     for (uint64_t i = vector_pointer->size - 1; i > 0; i--){
//         uint64_t temp = vector_pointer->ptr[0];
//         vector_pointer->ptr[0] = vector_pointer->ptr[i];
//         vector_pointer->ptr[i] = temp;
//         uint64_t j = 0;
//         while (2 * j + 1 < i){
//             uint64_t k = 2 * j + 1;
//             if (k + 1 < right_size && vector_pointer->ptr[k + 1] > vector_pointer->ptr[k]){
//                 k++;
//             }
//             if (vector_pointer->ptr[j] < vector_pointer->ptr[k]){
//                 uint64_t temp = vector_pointer->ptr[j];
//                 vector_pointer->ptr[j] = vector_pointer->ptr[k];
//                 vector_pointer->ptr[k] = temp;
//                 j = k;
//             }
//             else {
//                 break;
//             }
//         }
//     }
// };

void heapsort_reverse(vector *vector_pointer);
// {
//     // heapify(vector_pointer);
//     for (uint64_t i = 0; i < vector_pointer->size - 1; i++){
//             // i goes up and all elements to the left of i are sorted descending
//             uint64_t right_size = vector_pointer->size - i;
//             for (uint64_t x = i + right_size / 2 + 1; x > i; x--){
//                 uint64_t j = x-1-i;
//                 while (2 * j + 1 < right_size){
//                     uint64_t k = 2 * j + 1;
//                     if (k + 1 < right_size && vector_pointer->ptr[k + 1 + i] > vector_pointer->ptr[k + i]){
//                         k++;
//                     }
//                     if (vector_pointer->ptr[j + i] < vector_pointer->ptr[k + i]){
//                         uint64_t temp = vector_pointer->ptr[j + i];
//                         vector_pointer->ptr[j + i] = vector_pointer->ptr[k + i];
//                         vector_pointer->ptr[k + i] = temp;
//                         j = k;
//                     }
//                     else {
//                         break;
//                     }
//             }
//         }
//     }
//     // for (uint64_t i = 1; i + 1 < vector_pointer->size; i++){
//     //     uint64_t temp = vector_pointer->ptr[i];

//     //     vector_pointer->ptr[i] = vector_pointer->ptr[vector_pointer->size-1];
//     //     vector_pointer->ptr[vector_pointer->size-1] = temp;
//     //     uint64_t j = i;
//     //     while (2 * j + 1 < vector_pointer->size){
//     //         uint64_t k = 2 * j + 1;
//     //         if (k + 1 < i && vector_pointer->ptr[k + 1] > vector_pointer->ptr[k]){
//     //             k++;
//     //         }
//     //         if (vector_pointer->ptr[j] < vector_pointer->ptr[k]){
//     //             uint64_t temp = vector_pointer->ptr[j];
//     //             vector_pointer->ptr[j] = vector_pointer->ptr[k];
//     //             vector_pointer->ptr[k] = temp;
//     //             j = k;
//     //         }
//     //         else {
//     //             break;
//     //         }
//     //     }
//     // }
// };

int main(){
    vector v;
    init_v(&v);
    uint64_t n = 1; scanf("%lu", &n);
    for (uint64_t i = 0; i < n; i++){
        push_v(&v, i);
    }
    // heapify(&v);
    // for (uint64_t i = 0; i < n; i++){
    //     printf("%lu\n", *get_element_v(&v, i));
    // }
    // printf("\n\n");  
    // heapsort_reverse(&v);
    // for (uint64_t i = 0; i < n; i++){
    //     printf("%lu\n", *get_element_v(&v, i));
    // }
    // heap h;
    // init_h(&h);
    // uint64_t p; scanf("%lu", &p);
    // for (uint64_t i = 0; i < p; i++){
    //     uint64_t x; scanf("%lu", &x);
    //     insert_h(&h, x);
    // }
    // for (uint64_t i = 0; i < p; i++){
    //     printf("Element %lu, %lu \n", i+1, *get_element_v(&(h.arr), i));
    // }
    // printf("Max: %lu\n", pop_max(&h));
    // for (uint64_t i=0; i < p - 1; i++){
    //     printf("Element %lu, %lu \n", i+1, *get_element_v(&(h.arr), i));
    // }
}

#endif
