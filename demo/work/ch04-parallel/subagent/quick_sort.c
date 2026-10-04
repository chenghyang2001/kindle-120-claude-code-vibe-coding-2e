#include <stdio.h>

static void swap(int *a, int *b)
{
    int tmp = *a;
    *a = *b;
    *b = tmp;
}

/* Lomuto 分割法：以最後一個元素為樞紐 (pivot) */
static int partition(int arr[], int low, int high)
{
    int pivot = arr[high];
    int i = low - 1;
    int j;

    for (j = low; j < high; j++) {
        if (arr[j] <= pivot) {
            i++;
            swap(&arr[i], &arr[j]);
        }
    }
    swap(&arr[i + 1], &arr[high]);
    return i + 1;
}

/* 快速排序：由小到大排序 arr[low..high] */
void quick_sort(int arr[], int low, int high)
{
    if (low < high) {
        int p = partition(arr, low, high);
        quick_sort(arr, low, p - 1);
        quick_sort(arr, p + 1, high);
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
    quick_sort(data, 0, n - 1);
    print_array("排序後: ", data, n);

    return 0;
}
