main:
    li    sp, 0x2000        # Initialize stack pointer to a larger stack space
    # Create stack space
    addi  sp, sp, -64       # Allocate stack space (64 bytes)
    # Save s0
    sw    s0, 60(sp)        # Save s0 register to stack
    # Update s0
    addi  s0, sp, 64        # Set s0 to the top of the allocated stack

    # Initialize arr[] in memory
    li    a5, 6
    sw    a5, -48(s0)       # arr[0] = 6
    li    a5, 6
    sw    a5, -44(s0)       # arr[1] = 6
    li    a5, 1
    sw    a5, -40(s0)       # arr[2] = 1
    li    a5, 2
    sw    a5, -36(s0)       # arr[3] = 2
    li    a5, 4
    sw    a5, -32(s0)       # arr[4] = 4

    # Set up arguments for quickSort call
    addi  a0, s0, -48       # a0 = base address of array
    li    a1, 0             # a1 = low index (0)
    li    a2, 4             # a2 = high index (4)

    # Call quickSort
    jal   ra, quicksort     # Jump and link to quicksort function

    # Load sorted elements back to registers for inspection
    lw s2, -48(s0)  # Load arr[0] into s2
    lw s3, -44(s0)  # Load arr[1] into s3
    lw s4, -40(s0)  # Load arr[2] into s4
    lw s5, -36(s0)  # Load arr[3] into s5
    lw s6, -32(s0)  # Load arr[4] into s6

    # Restore registers and exit
    lw    s0, 60(sp)        # Restore s0
    addi  sp, sp, 64        # Deallocate stack space
    ebreak                 # End of program

quicksort:
    # Function prologue
    addi sp, sp, -40         # Allocate stack space (40 bytes)
    sw ra, 36(sp)            # Save return address
    sw s0, 32(sp)            # Save s0
    sw s1, 28(sp)            # Save s1
    sw s2, 24(sp)            # Save s2
    sw s3, 20(sp)            # Save s3
    sw s4, 16(sp)            # Save s4
    sw s5, 12(sp)            # Save s5
    sw s6, 8(sp)             # Save s6
    sw s7, 4(sp)             # Save s7

    # Base case: if low >= high, return
    bge a1, a2, qs_return

    # Save arguments for recursive calls
    mv s0, a0                # Save base address of array
    mv s1, a1                # Save low index
    mv s2, a2                # Save high index

    # Call partition function
    jal ra, partition        # Partition the array, pivot index in a0
    mv s3, a0                # Save pivot index

    # Recursive call to quicksort for left part
    mv a0, s0                # Base address of array
    mv a1, s1                # Low index
    addi a2, s3, -1          # High index (pi - 1)
    jal ra, quicksort        # Recursive call

    # Recursive call to quicksort for right part
    mv a0, s0                # Base address of array
    addi a1, s3, 1           # Low index (pi + 1)
    mv a2, s2                # High index
    jal ra, quicksort        # Recursive call

qs_return:
    # Function epilogue
    lw ra, 36(sp)            # Restore return address
    lw s0, 32(sp)            # Restore s0
    lw s1, 28(sp)            # Restore s1
    lw s2, 24(sp)            # Restore s2
    lw s3, 20(sp)            # Restore s3
    lw s4, 16(sp)            # Restore s4
    lw s5, 12(sp)            # Restore s5
    lw s6, 8(sp)             # Restore s6
    lw s7, 4(sp)             # Restore s7
    addi sp, sp, 40          # Deallocate stack space
    jr ra                    # Return to caller

partition:
    # Function prologue
    addi sp, sp, -32         # Allocate stack space (32 bytes)
    sw ra, 28(sp)            # Save return address
    sw s0, 24(sp)            # Save s0
    sw s1, 20(sp)            # Save s1
    sw s2, 16(sp)            # Save s2
    sw s3, 12(sp)            # Save s3
    sw t0, 8(sp)             # Save t0
    sw t1, 4(sp)             # Save t1
    sw t2, 0(sp)             # Save t2

    # Pivot is array[high]
    slli t0, a2, 2           # t0 = high * 4 (convert index to offset)
    add t0, a0, t0           # t0 = base address + high * 4
    lw t1, 0(t0)             # t1 = pivot value (array[high])

    addi s0, a1, -1          # i = low - 1

    add s1, a1, zero         # j = low

partition_loop:
    bge s1, a2, partition_end   # if j > high, exit loop

    # Load array[j] into t3
    slli t2, s1, 2           # t2 = j * 4
    add t2, a0, t2           # t2 = base address + j * 4
    lw t3, 0(t2)             # t3 = array[j]

    ble t3, t1, partition_if # if array[j] <= pivot, go to partition_if
    j partition_continue

partition_if:
    addi s0, s0, 1           # i++
    slli t4, s0, 2           # t4 = i * 4
    add t4, a0, t4           # t4 = base address + i * 4
    lw t5, 0(t4)             # t5 = array[i]
    sw t5, 0(t2)             # array[j] = array[i]
    sw t3, 0(t4)             # array[i] = array[j] (t3)

partition_continue:
    addi s1, s1, 1           # j++
    j partition_loop         # Repeat the loop

partition_end:
    addi s0, s0, 1           # i++
    slli t4, s0, 2           # t4 = i * 4
    add t4, a0, t4           # t4 = base address + i * 4
    lw t3, 0(t4)             # t3 = array[i]
    slli t5, a2, 2           # t5 = high * 4
    add t5, a0, t5           # t5 = base address + high * 4
    lw t6, 0(t5)             # t6 = array[high]
    sw t3, 0(t5)             # array[high] = array[i]
    sw t6, 0(t4)             # array[i] = array[high] (t6)

    mv a0, s0                # return i (pivot index)

    # Function epilogue
    lw ra, 28(sp)            # Restore return address
    lw s0, 24(sp)            # Restore s0
    lw s1, 20(sp)            # Restore s1
    lw s2, 16(sp)            # Restore s2
    lw s3, 12(sp)            # Restore s3
    lw t0, 8(sp)             # Restore t0
    lw t1, 4(sp)             # Restore t1
    lw t2, 0(sp)             # Restore t2
    addi sp, sp, 32          # Deallocate stack space
    jr ra                    # Return to caller