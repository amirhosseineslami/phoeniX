# Computer Organization - Spring 2024
## Iran University of Science and Technology

### Assignment 1: Assembly Code Execution on phoeniX RISC-V Core

- **Name:** AmirHossein Eslami
- **Team Members:** Ali Hendi
- **Student ID:** 400411099
- **Date:** 5/27/2024

---
## Quick Sort Explained

Quick sort is a strategy for arranging data like a game of "divide and conquer." It breaks down the data set into smaller sections, sorts each one independently, and then combines them back into a final sorted order.

### Main Program Flow ⚙️

1. We prepare a temporary storage area for later use.
2. We load the data we want to sort into memory.
3. We get everything ready for a function called `quicksort` and call it with the data.
4. Once `quicksort` finishes, we grab the sorted data from memory and store it in registers for viewing in a tool called GTKWave.
5. We clean up the temporary storage and finish the program.

### Quick Sort Function 

1. We remember the program's state before starting the sort.
2. We check if the sorting is complete. If it is, we move on.
3. We make a note of things we need to remember for later calls to `quicksort`.
4. We call another function called `partition` to split the data based on a chosen element.
5. We call `quicksort` twice, once for each half of the split data.
6. We return to the main program.

### Returning from Quick Sort 

1. We clean up any temporary storage used.
2. We go back to the main program.

### Partition Function 

1. We remember the program's state before starting.
2. We select the last element in the data as a reference point.

### Partition Loop 

1. We use two markers (`i` and `j`) to move through the data, arranging it based on the reference point.

### Conditional Swap Routine  

1. If necessary, we swap elements in the data.

### Loop Continuation Routine 

1. We continue the loop started in the partition loop section.

### Finishing the Partition 

1. We put the reference point in its correct sorted position.
2. We clean up any temporary storage and go back to the `quicksort` function.

**Note:** The images are not described as their content is not directly related to the explanation. 

---

### Integer Square Root with Binary Search 

This code calculates the square root of a whole number using a binary search approach.

### Main Routine ️

1. We load the number we want to find the square root of into a register.
2. We copy that number to another register to keep track of the upper search bound.

### Binary Search Function  

1. We check if the search range is still valid. If not, we have an estimate for the square root and exit.
2. We calculate the middle point of the search range.
3. We compare the square of the middle point with our target number and adjust the search range based on the result.

### Exact Square Root Found ✅

1. If the square of the middle point is exactly our target number, we have the perfect square root and end the program.

### Square Root Too Low Routine ⬇️

1. If the square of the middle point is less than our target number, we update the lower search bound to be one more than the middle point and repeat the binary search.

### Square Root Too High Routine ⬆️

1. If the square of the middle point is greater than our target number, we update the upper search bound to be one less than the middle point and repeat the binary search.

### Returning the Result 

1. We store the final middle point value as the calculated square root.

**Note:** Similar to quick sort, the image content is not directly related to the explanation. 
