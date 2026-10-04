#include <stdio.h>

/* 泡沫排序：由小到大排序整數陣列 */
void bubble_sort(int arr[], int n)
{
    int i, j, tmp, swapped;

    for (i = 0; i < n - 1; i++) {
        swapped = 0;
        for (j = 0; j < n - 1 - i; j++) {
            if (arr[j] > arr[j + 1]) {
                tmp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = tmp;
                swapped = 1;
            }
        }
        /* 若這一輪沒有任何交換，代表已排序完成 */
        if (!swapped) {
            break;
        }
    }
}

void print_array(const char *label, const int arr[], int n)
{
    int i;

    printf("%s", label);
    for (i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

int main(void)
{
    int data[] = {64, 34, 25, 12, 22, 11, 90, 5};
    int n = sizeof(data) / sizeof(data[0]);

    print_array("排序前: ", data, n);
    bubble_sort(data, n);
    print_array("排序後: ", data, n);

    return 0;
}
