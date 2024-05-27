# Start of the main program
main:
    # Initialize t0 to 16 and t1 to 1
    li      t0,     49
    li      t1,       1

# Start of the sqrt_loop
sqrt_loop:
    # If t1 is less than t0, jump to sqrt_check, else set t1 to 0 and jump to sqrt_done
    blt     t1,    t0,    sqrt_check
    li      t1,     0
    j sqrt_done

# Start of the sqrt_check
sqrt_check:
    # Compute the remainder of t0/t1 and store it in t3
    rem     t3,   t0,     t1
    # If t3 is zero, jump to sqrt_check2, else increment t1 by 1 and jump back to sqrt_loop
    beqz    t3,   sqrt_check2
    addi    t1,   t1,     1
    j sqrt_loop

# Start of the sqrt_check2
sqrt_check2:
    # Divide t0 by t1 and store the result in t4
    div     t4,   t0,     t1
    # If t4 is equal to t1, jump to sqrt_done, else increment t1 by 1 and jump back to sqrt_loop
    beq     t4,   t1,     sqrt_done
    addi    t1,   t1,     1
    j sqrt_loop

# Start of the sqrt_done
sqrt_done:
    # Move the value of t1 to t5
    mv  t5, t1
    # Break the execution
    ebreak
