"""泡沫排序 (Bubble Sort)"""


def bubble_sort(arr):
    """回傳一個由小到大排序的新串列，不修改原串列。"""
    result = list(arr)
    n = len(result)
    for i in range(n - 1):
        swapped = False
        for j in range(n - 1 - i):
            if result[j] > result[j + 1]:
                result[j], result[j + 1] = result[j + 1], result[j]
                swapped = True
        if not swapped:  # 已經排好，提前結束
            break
    return result


if __name__ == "__main__":
    data = [64, 34, 25, 12, 22, 11, 90, 5]
    print("排序前:", data)
    print("排序後:", bubble_sort(data))
