main:
        # Initialize input number and binary search bounds
        addi a0, a0, 23  # Load input number (23) into a0
        li t0, 0         # t0 = low = 0 (initialize low bound)
        mv t1, a0        # t1 = high = a0 (initialize high bound to input number)
        li t2, 0         # t2 = mid (initialize mid to 0)
        li t3, 0         # t3 = mid * mid (initialize to 0)

binary_search:
        # Check if low is greater than high
        bgt t0, t1, finish          # if low > high, exit the loop and finish the search

        # Calculate mid = (low + high) / 2
        add t2, t0, t1              # t2 = low + high
        srai t2, t2, 1              # t2 = mid = (low + high) / 2 (shift right arithmetic by 1)

        # Compare mid*mid with the input number
        mul t3, t2, t2              # t3 = mid * mid
        blt t3, a0, mid_is_too_low  # if mid * mid < input number, search in the upper half
        bgt t3, a0, mid_is_too_high # if mid * mid > input number, search in the lower half

mid_is_exact:
        mv t1, t2       # if mid * mid == input number, set result to mid
        j finish        # exit the loop and finish the search

mid_is_too_low:
        addi t0, t2, 1  # if mid * mid < input number, set low = mid + 1
        j binary_search # repeat the binary search

mid_is_too_high:
        addi t1, t2, -1 # if mid * mid > input number, set high = mid - 1
        j binary_search # repeat the binary search

finish:
        mv a0, t1       # result = high (integer square root)
        ebreak          # end of program (trigger a breakpoint)
