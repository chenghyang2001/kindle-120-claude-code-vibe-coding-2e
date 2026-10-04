/// Lomuto 分割法：以最後一個元素為基準點，回傳基準點最終位置
fn partition<T: PartialOrd>(arr: &mut [T]) -> usize {
    let high = arr.len() - 1;
    let mut i = 0;
    for j in 0..high {
        if arr[j] <= arr[high] {
            arr.swap(i, j);
            i += 1;
        }
    }
    arr.swap(i, high);
    i
}

/// 快速排序：分割後遞迴排序左右兩段
fn quick_sort<T: PartialOrd>(arr: &mut [T]) {
    if arr.len() <= 1 {
        return;
    }
    let p = partition(arr);
    let (left, right) = arr.split_at_mut(p);
    quick_sort(left);
    quick_sort(&mut right[1..]);
}

fn main() {
    let mut data = vec![10, 7, 8, 9, 1, 5, 3];
    println!("排序前: {:?}", data);

    quick_sort(&mut data);

    println!("排序後: {:?}", data);
}
