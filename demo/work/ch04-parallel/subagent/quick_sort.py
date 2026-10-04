"""快速排序 (Quick Sort)"""


def quick_sort(arr):
    """回傳一個由小到大排序的新串列，不修改原串列。"""
    if len(arr) <= 1:
        return list(arr)
    pivot = arr[len(arr) // 2]
    less = [x for x in arr if x < pivot]
    equal = [x for x in arr if x == pivot]
    greater = [x for x in arr if x > pivot]
    return quick_sort(less) + equal + quick_sort(greater)


if __name__ == "__main__":
    data = [38, 27, 43, 3, 9, 82, 10, 3]
    print("排序前:", data)
    print("排序後:", quick_sort(data))
