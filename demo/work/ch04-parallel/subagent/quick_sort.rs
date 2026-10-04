// 快速排序 (Quick Sort)
// 編譯: rustc quick_sort.rs

/// 對整數切片進行原地快速排序（遞增）。
fn quick_sort(arr: &mut [i32]) {
    if arr.len() < 2 {
        return;
    }
    let p = partition(arr);
    let (left, right) = arr.split_at_mut(p);
    quick_sort(left);
    quick_sort(&mut right[1..]);
}

/// Lomuto 分割法：取中間元素作為 pivot 並移到尾端，
/// 回傳 pivot 最終所在的索引。
fn partition(arr: &mut [i32]) -> usize {
    let last = arr.len() - 1;
    let mid = arr.len() / 2;
    arr.swap(mid, last);
    let pivot = arr[last];

    let mut store = 0;
    for i in 0..last {
        if arr[i] < pivot {
            arr.swap(i, store);
            store += 1;
        }
    }
    arr.swap(store, last);
    store
}

fn main() {
    let mut numbers = [64, 34, 25, 12, 22, 11, 90, -5, 0, 34];

    println!("排序前: {:?}", numbers);
    quick_sort(&mut numbers);
    println!("排序後: {:?}", numbers);
}
