// 泡沫排序 (Bubble Sort)
// 編譯: rustc bubble_sort.rs

/// 對整數切片進行原地泡沫排序（遞增）。
/// 若某一輪沒有任何交換，表示已排序完成，提前結束。
fn bubble_sort(arr: &mut [i32]) {
    let n = arr.len();
    if n < 2 {
        return;
    }
    for i in 0..n - 1 {
        let mut swapped = false;
        for j in 0..n - 1 - i {
            if arr[j] > arr[j + 1] {
                arr.swap(j, j + 1);
                swapped = true;
            }
        }
        if !swapped {
            break;
        }
    }
}

fn main() {
    let mut numbers = [64, 34, 25, 12, 22, 11, 90, -5, 0, 34];

    println!("排序前: {:?}", numbers);
    bubble_sort(&mut numbers);
    println!("排序後: {:?}", numbers);
}
