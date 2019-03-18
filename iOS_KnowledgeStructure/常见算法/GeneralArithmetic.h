//
//  GeneralArithmetic.h
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/3/18.
//  Copyright © 2019年 zhf. All rights reserved.
//

#ifndef GeneralArithmetic_h
#define GeneralArithmetic_h
#include <stdio.h>


#pragma mark - tools;
void swap_my(int *a, int *b) {
    int tmp = *a;
    *a = *b;
    *b = tmp;
}

typedef struct Node {
    int var;
    //链表
    struct Node *next;
    //二叉树
    struct Node *leftChild;
    struct Node *rightChild;
}Node, *pNode;

int max_my(int a, int b) {
    return a > b ? a : b;
}


#pragma mark - 七种排序算法
//冒泡
void bubbling_sort(int array[], int count) ;
//选择
void select_sort(int array[], int count);
//插入
void insert_sort(int array[], int count);
//希尔
void shell_sort(int array[], int count) ;
//快排
void quick_sort(int array[], int start, int end);
//归并排序
int * merger_sort(int leftArray[], int leftCount, int rightArray[], int rightCount);
//堆排序
void heap_sort(int array[], int count);

#pragma mark - 查找算法
//二分查找
int binary_search(int array[], int target);

#pragma mark - 链表算法
//链表反转(递归)
pNode reversalList_recursion(pNode root);
//链表反转
pNode reversalList(pNode root);
//链表是否有环
int haveLoopInList(pNode root);

#pragma mark - 二叉树算法
//先序遍历
void treeSort_before(pNode root);
//中序遍历
void treeSort_middle(pNode root);
//后序遍历
void treeSort_after(pNode root);
//二叉树反转
void reversalTree(pNode root) ;

#pragma mark - 动态规划
//递归opt
int rec_opt(int array[], int targetIndex);
//动态规划opt
void dp_opt(int array[]);
#endif /* GeneralArithmetic_h */
