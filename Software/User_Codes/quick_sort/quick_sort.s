# Increase stack pointer to make space for variables
addi sp, sp, 1000

# Assign input array
addi a0, x0, 0

# Assign values to the input array
addi t0, x0, 9
sw t0, 0(a0) 
addi t0, x0, 3
sw t0, 4(a0)
addi t0, x0, 7
sw t0, 8(a0)
addi t0, x0, 6
sw t0, 12(a0)
addi t0, x0, 6
sw t0, 16(a0)

# Initialize parameters for quicksort
addi a1, x0, 0 
addi a2, x0, 6 

# Call the quicksort algorithm
jal ra, quick_sort
jal ra, end

# Quick Sort Algorithm
quick_sort:
    # Save registers on stack
    addi sp, sp, -20
    sw ra, 16(sp)
    sw s3, 12(sp)
    sw s2, 8(sp)
    sw s1, 4(sp)
    sw s0, 0(sp)

    # Initialize variables
    addi s0, a0, 0
    addi s1, a1, 0
    addi s2, a2, 0

    # Base case: if array size <= 1, return
    blt a2, a1, st_gt_end

    # Partition the array
    jal ra, partition
    addi s3, a0, 0   

    # Recursive calls for left and right partitions
    addi a0, s0, 0
    addi a1, s1, 0
    addi a2, s3, -1
    jal ra, quick_sort  
    
    addi a0, s0, 0
    addi a1, s3, 1
    addi a2, s2, 0
    jal ra, quick_sort  

st_gt_end:
    # Restore registers and return
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20
    jalr x0, ra, 0

# Partition subroutine
partition:
    # Save return address
    addi sp, sp, -4
    sw ra, 0(sp)

    # Calculate pivot index and value
    slli t0, a2, 2   
    add t0, t0, a0  
    lw t0, 0(t0)     

    # Initialize loop variables
    addi t1, a1, -1  
    addi t2, a1, 0   

loop:
    # Loop until reaching the end of the partition
    beq t2, a2, loop_DONE   
    slli t3, t2, 2   
    add a6, t3, a0   
    lw t3, 0(a6)     

    # Compare current element with pivot
    addi t0, t0, 1   
    blt t0, t3, currr_element_gte_pivot  

    # Swap elements
    addi t1, t1, 1   
    slli t5, t1, 2  
    add a7, t5, a0   
    lw t5, 0(a7)     
    sw t5, 0(a6)
    sw t3, 0(a7)     

currr_element_gte_pivot:
    addi t2, t2, 1   
    beq x0, x0, loop

loop_DONE:
    # Swap pivot with the element at the correct position
    addi t5, t1, 1   
    addi a5, t5, 0   
    slli t5, t5, 2  
    add a7, t5, a0   
    lw t5, 0(a7)     
    slli t3, a2, 2   
    add a6, t3, a0   
    lw t3, 0(a6)     
    sw t5, 0(a6)
    sw t3, 0(a7)     

    # Update parameters for next recursive calls
    addi a0, a5, 0   
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, ra, 0

# End of program
end:
    ebreak

