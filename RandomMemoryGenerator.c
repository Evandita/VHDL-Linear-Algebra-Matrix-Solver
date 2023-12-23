#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void printBinary(int num) {
    for (int i = 7; i >= 0; i--) {
        printf("%d", (num & (1 << i)) ? 1 : 0);
    }
}

int main() {
    int i, j, k;
    system("cls");
    srand(time(NULL));
    for (i = 1; i <= 3;i++){
        for (j = 1;j <= 3;j++){
            printf("signal registers_%d%d : RegisterArray:= (\n\t", i, j);
            for (k = 1; k <= 32; k++) {
                int random_number = rand() % 10;
                printf("\"");
                printBinary(random_number);
                if (k != 32) printf("\", ");
                else {
                    printf("\"\n");
                    break;
                }
                if (k % 4 == 0) printf("\n\t");
            }
            printf(");\n\n");
        }
    }
    return 0;
}
