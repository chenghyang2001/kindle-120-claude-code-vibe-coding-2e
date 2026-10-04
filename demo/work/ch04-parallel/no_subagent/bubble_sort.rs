/// 氣泡排序：反覆比較相鄰元素並交換，直到整個切片有序
fn bubble_sort<T: PartialOrd>(arr: &mut [T]) {
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
        // 若本輪沒有任何交換，表示已排序完成
        if !swapped {
            break;
        }
    }
}

fn main() {
    let mut data = vec![64, 34, 25, 12, 22, 11, 90];
    println!("排序前: {:?}", data);

    bubble_sort(&mut data);

    println!("排序後: {:?}", data);
}
