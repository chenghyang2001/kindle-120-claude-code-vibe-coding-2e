"""快速排序（Quick Sort）"""


def _partition(arr: list[int], low: int, high: int) -> int:
    """Lomuto 分割法：以最後一個元素為基準點。"""
    pivot = arr[high]
    i = low - 1
    for j in range(low, high):
        if arr[j] <= pivot:
            i += 1
            arr[i], arr[j] = arr[j], arr[i]
    arr[i + 1], arr[high] = arr[high], arr[i + 1]
    return i + 1


def _quick_sort(arr: list[int], low: int, high: int) -> None:
    if low < high:
        p = _partition(arr, low, high)
        _quick_sort(arr, low, p - 1)
        _quick_sort(arr, p + 1, high)


def quick_sort(arr: list[int]) -> list[int]:
    """回傳排序後的新串列，不修改原始資料。"""
    result = arr.copy()
    _quick_sort(result, 0, len(result) - 1)
    return result


if __name__ == "__main__":
    data = [10, 7, 8, 9, 1, 5, 3]
    print("排序前:", data)
    print("排序後:", quick_sort(data))
