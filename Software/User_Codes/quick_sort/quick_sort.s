# Increase stack pointer by 1000
addi sp, sp, 1000

# Initialize a0 to 0
addi a0, x0, 0

# Assign input values
addi t0, x0, 3
sw t0, 0(a0) 
addi t0, x0, 5
sw t0, 4(a0)
addi t0, x0, 2
sw t0, 8(a0)
addi t0, x0, 1
sw t0, 12(a0)
addi t0, x0, 6
sw t0, 16(a0)
addi t0, x0, 4
sw t0, 20(a0)
addi t0, x0, 7
sw t0, 24(a0)

# Initialize a1 and a2 to 0 and 6 respectively
addi a1, x0, 0 
addi a2, x0, 6 

# Call quick_sort and end functions
jal ra, quick_sort
jal ra, end

quick_sort:
    # Save registers and initialize s0, s1, s2
    addi sp, sp, -20
    sw ra, 16(sp)
    sw s3, 12(sp)
    sw s2, 8(sp)
    sw s1, 4(sp)
    sw s0, 0(sp)
    addi s0, a0, 0
    addi s1, a1, 0
    addi s2, a2, 0

    # If a2 < a1, skip to st_gt_end
    blt a2, a1, st_gt_end

    # Call partition function
    jal ra, partition

    # Save a0 to s3
    addi s3, a0, 0   

    # Recursive calls to quick_sort
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

partition:
    # Save ra register
    addi sp, sp, -4
    sw ra, 0(sp)

    # Initialize t0, t1, t2
    slli t0, a2, 2   
    add t0, t0, a0  
    lw t0, 0(t0)     
    addi t1, a1, -1  
    addi t2, a1, 0   

loop:
    # If t2 == a2, skip to loop_DONE
    beq t2, a2, loop_DONE   

    # Load value at address a6 into t3
    slli t3, t2, 2   
    add a6, t3, a0   
    lw t3, 0(a6)     

    # If t0 < t3, skip to currr_element_gte_pivot
    addi t0, t0, 1   
    blt t0, t3, currr_element_gte_pivot  

    # Swap values at addresses a6 and a7
    addi t1, t1, 1   
    slli t5, t1, 2  
    add a7, t5, a0   
    lw t5, 0(a7)     
    sw t5, 0(a6)
    sw t3, 0(a7)     

currr_element_gte_pivot:
    # Increment t2
    addi t2, t2, 1   

    # Repeat loop
    beq x0, x0, loop

loop_DONE:
    # Swap values at addresses a6 and a7
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

    # Set a0 to a5 and restore ra register
    addi a0, a5, 0   
    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, ra, 0

end:
    # Break execution
    ebreak
