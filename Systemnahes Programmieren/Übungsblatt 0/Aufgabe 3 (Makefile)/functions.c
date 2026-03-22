//
// Created by enesercan on 22.03.26.
//

#include <stdio.h>
#include "functions.h"

void table(int t[10][10])
{

    for (int i = 0; i < 10; ++i) {
        for (int j = 0; j < 10; ++j)
        {
            t[i][j] = (i + 1) * (j + 1);
        }
    }

}

void printTable(int t[10][10]) {
    for (int i = 0; i < 10; ++i) {
        for (int j = 0; j < 10; ++j)
        {
            printf("%d ", t[i][j]);
        }
        printf("\n");
    }
}
