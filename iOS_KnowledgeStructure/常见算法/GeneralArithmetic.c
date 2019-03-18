//
//  GeneralArithmetic.c
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2019/3/18.
//  Copyright © 2019年 zhf. All rights reserved.
//

#include "GeneralArithmetic.h"
#include <stdlib.h>


#pragma mark - 七种排序算法
//冒泡
void bubbling_sort(int array[], int count) {
    
    for (int i = 0; i < count-1; i++) {
        
        for (int j = count-1; j < i; j--) {
            
            if (array[j] < array[j-1]) {
                swap_my(&array[j], &array[j-1]);
            }
            
        }
        
    }
    
}

//选择
void select_sort(int array[], int count) {
    
    for (int i = 0; i < count -1 ; i++) {
        
        int target = i;
        for (int j = count -1; j > i; j--) {
            if (array[j] < array[target]) {
                target = j;
            }
        }
        
        if (target != i) {
            swap_my(&array[target], &array[i]);
        }
    }
}

//插入
void insert_sort(int array[], int count) {
    for (int i = 1; i < count; i++) {
        
        int sortedIndex = i-1;
        if (array[sortedIndex] > array[i]) {
            
            for (int j = sortedIndex; j > 0; j--) {
                if (array[i] < array[j]) {
                    array[j+1] = array[j];
                } else {
                    array[j+1] = array[i];
                }
            }
        }
    }
}

//希尔
void shell_sort(int array[], int count) {
    
    int tag = count;
    while (tag > 1) {
        tag = (tag/3)+1;
        
        for (int i = tag; i < count; i+=tag) {
            
            int sortedIndex = i-tag;
            if (array[sortedIndex] > array[i]) {
                
                for (int j = sortedIndex; j > 0; j-=tag) {
                    if (array[i] < array[j]) {
                        array[j+tag] = array[j];
                    } else {
                        array[j+tag] = array[i];
                    }
                }
            }
        }
        
    }
    
}

//快排
void quick_sort(int array[], int start, int end) {
    
    if (start < end) {
        int target = array[0];
        int startT = start;
        int endT = end;
        
        while (startT < endT) {
            
            while (array[startT] < target) {
                startT++;
            }
            while (array[endT] > target) {
                endT--;
            }
            swap_my(&array[startT], &array[endT]);
        }
        
        quick_sort(array, start, startT-1);
        quick_sort(array, startT+1, end);
    }
}

//归并排序
int * merger_sort(int leftArray[], int leftCount, int rightArray[], int rightCount) {
    int total = leftCount + rightCount;
    int *result = (int *)malloc(sizeof(int)*total);
    
    int leftT = 0, rightT = 0, resultT = 0;
    
    while (leftT < leftCount && rightT < rightCount) {
        result[resultT++] = leftArray[leftT] < rightArray[rightT] ?  leftArray[leftT++] : rightArray[rightT++];
    }
    
    while (leftT < leftCount) {
        result[resultT++] = leftArray[leftT++];
    }
    
    while (rightT < rightCount) {
        result[resultT++] = rightArray[rightT++];
    }
    
    free(result);
    return result;
}

int * merger_sort_main(int array[], int count) {
    if (count <= 1) {
        return array;
    }
    
    int leftCount = count/2;
    int *leftArray = array;
    int rightCount = count - leftCount;
    int *rightArray = array+leftCount;
    
    merger_sort_main(leftArray, leftCount);
    merger_sort_main(rightArray, rightCount);
    
    int *result = merger_sort(leftArray, leftCount, rightArray, rightCount);
    return result;
}

//堆排序
//1.初始化大顶堆时，自下而上
//2.交换堆顶与堆尾后，从上往下
//parentNode:非叶子节点；arrayEndIndex数组结束下标。
void exchange_up2down(int array[], int parentNode, int arrayEndIndex) {
    //当列表下标从0开始时，节点下标：i；左孩子下标:2*i + 1; 右孩子下标：2*i + 2;(通常用这个)
    //当列表下标从1开始时，节点下标：i; 左孩子下标：2*i； 右孩子下标：2*i + 1;
    while (1) {
        
        int left_child = 2*parentNode + 1;
        if (left_child > arrayEndIndex) {
            return;
        }
        
        if (left_child + 1 < arrayEndIndex &&  array[left_child+1] > array[left_child]) {
            //如果右孩子存在，且右孩子>左孩子
            left_child += 1;
        }
        //与父节点交互
        if (array[parentNode] < array[left_child]) {
            swap_my(&array[parentNode], &array[left_child]);
            
            //左孩子节点大值与父节点的小值交换后
            //在左孩子节点上的小值 构成的“完全二叉树”有可能不符合完全二叉树的规则，需要重新构建
            parentNode = left_child;
        } else {
            break;
        }
    }
    
    printf("节点交互");
}
//堆排序
void heap_sort(int array[], int count) {
    //初始化大顶堆
    //获取倒数第一个非叶子节点
    int lastParentNode = count/2 - 1;
    for (int i = lastParentNode; i >= 0; i--) {
        exchange_up2down(array, i, count-1);
    }
    printf("构建大顶堆完成");
    
    //开始交换排序
    for (int i = count-1; i > 0; i--) {
        swap_my(&array[0], &array[i]);
        exchange_up2down(array, 0, i-1);
    }
    printf("堆排序完成...");
}

#pragma mark - 查找算法
//二分查找
int binary_search(int array[], int target) {
    int count = sizeof(array);
    
    int start = 0;
    int end = count-1;
    int targetIndex = 0;
    
    while (start < end) {
        targetIndex = (start+end)/2;
        
        if (array[targetIndex] == target) {
            return targetIndex;
        }
        
        if (target > array[targetIndex]) {
            start = targetIndex + 1;
        }
        
        if (target < array[targetIndex]) {
            end = targetIndex-1;
        }
    }
    return start;
}


#pragma mark - 链表算法
//链表创建
pNode createList(int num) {
    pNode header = (pNode)malloc(sizeof(Node));
    pNode curr = header;
    for (int i = 0; i < num; i++) {
        pNode node = (pNode)malloc(sizeof(Node));
        node->var = i;
        node->next = NULL;
        
        curr->next = node;
        curr = node;
    }
    return header;
}

//链表反转(递归)
pNode reversalList_recursion(pNode root) {
    if (root == NULL || root->next == NULL) {
        return root;
    } else {
        pNode newHeader = reversalList_recursion(root->next);
        
        root->next->next = root;
        root->next = NULL;
        return newHeader;
    }
}

//链表反转
pNode reversalList(pNode root) {
    if (root == NULL || root->next == NULL) {
        return root;
    }
    pNode result = NULL;
    pNode curr = root;
    pNode prev = NULL;
    pNode next;
    
    while (curr != NULL) {
        next = curr->next;
        if (next == NULL) {
            result = root;
        } else {
            curr->next = prev;
            prev = curr;
            curr = next;
        }
    }
    return result;
}

//链表是否有环
int haveLoopInList(pNode root) {
    if (root == NULL || root->next == NULL) {
        return 0;
    }
    
    pNode fast = root;
    pNode slow = root;
    
    while (slow != NULL && fast->next != NULL) {
        slow = slow->next;
        fast = fast->next->next;
        
        if (slow == fast) {
            return 1;
        }
    }
    return 0;
}

#pragma mark - 二叉树算法
//先序遍历
void treeSort_before(pNode root) {
    if (root == NULL) {
        return;
    }
    
    printf("data:%d",root->var);
    treeSort_before(root->leftChild);
    treeSort_before(root->rightChild);
}
//中序遍历
void treeSort_middle(pNode root) {
    if (root == NULL) {
        return;
    }
    
    treeSort_middle(root->leftChild);
    printf("data:%d",root->var);
    treeSort_middle(root->rightChild);
}
//后序遍历
void treeSort_after(pNode root) {
    if (root == NULL) {
        return;
    }
    
    treeSort_after(root->leftChild);
    treeSort_after(root->rightChild);
    printf("data:%d",root->var);
}

//二叉树反转
void reversalTree(pNode root) {
    if (root == NULL) {
        return;
    }
    
    if (root->leftChild == NULL || root->rightChild == NULL) {
        return;
    }
    
    pNode leftN = root->leftChild;
    root->leftChild = root->rightChild;
    root->rightChild = leftN;
    
    reversalTree(root->leftChild);
    reversalTree(root->rightChild);
}













