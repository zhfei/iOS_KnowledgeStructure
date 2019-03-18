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
#endif /* GeneralArithmetic_h */
