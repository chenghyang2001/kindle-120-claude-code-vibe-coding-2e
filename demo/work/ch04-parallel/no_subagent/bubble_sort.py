"""氣泡排序（Bubble Sort）"""


def bubble_sort(arr: list[int]) -> list[int]:
    """反覆比較相鄰元素並交換，回傳排序後的新串列。"""
    result = arr.copy()
    n = len(result)
    for i in range(n - 1):
        swapped = False
        for j in range(n - 1 - i):
            if result[j] > result[j + 1]:
                result[j], result[j + 1] = result[j + 1], result[j]
                swapped = True
        # 若本輪沒有任何交換，表示已排序完成
        if not swapped:
            break
    return result


if __name__ == "__main__":
    data = [64, 34, 25, 12, 22, 11, 90]
    print("排序前:", data)
    print("排序後:", bubble_sort(data))
