# Computer Organization - Spring 2024
## Iran University of Science and Technology

### Assignment 1: Assembly Code Execution on phoeniX RISC-V Core

- **Name:** Rasa Ghorbanalizadeh
- **Team Members:** Parsa Amiri, Mohammad Amin Mirzaabbasi
- **Student ID:** 400413152
- **Date:** 5/24/2024

---

## Report 📝

### Quick Sort 

Quick sort is a divide-and-conquer algorithm that sorts an array by partitioning it into sub-arrays, which are then recursively sorted.

#### Main Routine 🛠️

1. Initialize the stack for future use.
2. Store the input array into memory.
3. Set up call arguments for the `quicksort` routine and call it.
4. After returning from the `quicksort` routine, store the results from memory into registers (`s2` to `s6`) to view them in the GTKWave application.
5. Restore registers and end.

#### Quicksort Routine 🔄

1. Store the previous state of the program.
2. Check condition `low >= high`. If true, go to the `qs_return` routine.
3. Save arguments for recursive calls.
4. Call the `partition` routine to partition the array with its pivot index in `a0`.
5. Perform two recursive calls to `quicksort`: one for the left array and another for the right array.
6. Go to the `qs_return` routine, which then takes us to the `main` routine.

#### QS Return Routine 🔙

1. Restore registers.
2. Return to the `main` routine.

#### Partition Routine 📦

1. Save the previous state.
2. Choose the pivot as the last element of the array.

#### Partition Loop Routine 🔁

1. Use two pointers (`i` and `j`) initialized in the `partition` routine to arrange the array based on the pivot.

#### Partition If Routine 🔄

1. Perform the swapping.

#### Partition Continue Routine 🔄

1. Complete the loop created in the `partition_loop` routine.

#### Partition End Routine 🏁

1. Place the pivot in its correct position.
2. Restore registers and return to the `quicksort` routine.

![Quick Sort Image](https://github.com/amirhosseineslami/phoeniX/blob/main/quick_sort.png)

---

### Integer Square Root using Binary Search 

This code performs an integer square root calculation using a binary search algorithm.

#### Main Routine 🛠️

1. Load the input number into the `a0` register.
2. Copy `a0` into `t1`, which will be our `high`.

#### Binary Search Routine 🔍

1. Check condition `low < high`. If `low > high`, an approximate square root is found and exit.
2. Find the `mid` of the input.
3. Compare the square of `mid` with the input and take action based on the result.

#### Mid is Exact Routine ✅

1. If the square of `mid` is exactly the input, the exact square root is found, and the program ends.

#### Mid is Too Low Routine ⬇️

1. If the square of `mid` is lower than the input, set `low` to `mid + 1` and redo the `binary_search` routine.

#### Mid is Too High Routine ⬆️

1. If the square of `mid` is higher than the input, set `high` to `mid - 1` and redo the `binary_search` routine.

#### Finish Routine 🏁

1. Store the last `mid` into `a0` as the result.

![sqrt image](https://github.com/amirhosseineslami/phoeniX/blob/main/square16.png)
![sqrt image](https://github.com/amirhosseineslami/phoeniX/blob/main/square49.png)


---
