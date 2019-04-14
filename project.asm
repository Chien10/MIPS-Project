				.data

TIME:			.space		1024	# Maximum is 10, but there'll be some error if I just use 10!
TIME_1:			.space 		1024
TIME_2:			.space		1024
TEMP:			.space		1024

choice: 		.word		0

new_line:		.asciiz		"\n"

input_day: 		.asciiz		"Nhap ngay DAY: "
input_month: 	.asciiz		"Nhap thang MONTH: "
input_year:		.asciiz		"Nhap nam YEAR: "
invalid_input:	.asciiz		"Gia tri nhap vao khong hop le!\n"

intro_string: 	.asciiz		"----------Ban hay chon 1 trong cac thao tac duoi day----------\n"

first_choice:	.asciiz		"1. Xuat chuoi TIME theo dinh dang DD/MM/YYYY\n"

second_choice:	.asciiz		"2. Chuyen doi chuoi TIME thanh mot trong cac dinh dang sau:\n"
sec_choice_a:	.asciiz		"			A. MM/DD/YYYY\n"
sec_choice_b:	.asciiz		"			B. Month DD, YYYY\n"
sec_choice_c:	.asciiz		"			C. DD Month, YYYY\n"

third_choice:	.asciiz		"3. Kiem tra nam trong chuoi TIME co phai la nam nhuan khong.\n"
output_leap_yr:	.asciiz		"Nam nhap vao la nam nhuan.\n"
output_n_lp_yr:	.asciiz		"Nam nhap vao khong phai la nam nhuan.\n"

fourth_choice: .asciiz		"4. Cho biet ngay vua nhap la ngay thu may trong tuan.\n"
monday:						.asciiz		"Mon.\n"
tuesday:					.asciiz		"Tues.\n"
wednesday:					.asciiz		"Wed.\n"
thursday:					.asciiz		"Thurs.\n"
friday:						.asciiz		"Fri.\n"
saturday:					.asciiz		"Sat.\n"
sunday:						.asciiz		"Sun.\n"

fifth_choice:	.asciiz		"5. Cho biet ngay vua nhap la ngay thu may ke tu ngay 1/1/1.\n"
sub_fifth_choice:			.asciiz		"Ngay vua nhap la ngay thu "

sixth_choice:	.asciiz		"6. Cho biet can chi cua nam vua nhap.\n"
can1:			.asciiz		"Giap" 
can2:			.asciiz		" At "
can3:			.asciiz		"Binh" 
can4:			.asciiz		"Dinh"
can5:			.asciiz		"Mau "
can6:			.asciiz		" Ky "
can7:			.asciiz		"Canh"
can8:			.asciiz		"Tan "
can9:			.asciiz		"Nham"
can10:			.asciiz		"Quy "
can:			.word		can1, can2, can3, can4, can5, can6, can7, can8, can9, can10

chi1:			.asciiz		" Ty "
chi2:			.asciiz		" Suu"
chi3:			.asciiz		" Dan"
chi4:			.asciiz		" Meo"
chi5:			.asciiz		"Thin"
chi6:			.asciiz		" Ty "
chi7:			.asciiz		" Ngo"
chi8:			.asciiz		" Mao"
chi9:			.asciiz		"Than"
chi10:			.asciiz		" Dau"
chi11:			.asciiz		"Tuat"
chi12:			.asciiz		" Hoi"
chi:			.word		chi1, chi2, chi3, chi4, chi5, chi6, chi7, chi8, chi9, chi10, chi11, chi12
can_chi:		.space 		1024

seventh_choice:	.asciiz		"7. Cho biet khoang thoi gian giua chuoi TIME_1 va TIME_2.\n"
sub_seventh_choice:			.asciiz		"Khoang thoi gian giua hai chuoi la: "

eighth_choice:	.asciiz		"8. Cho biet 2 nam nhuan gan nhat voi nam trong chuoi TIME.\n"
sub_eighth_choice1:			.asciiz		"Hai nam nhuan gan nhat la "
sub_eighth_choice2:			.asciiz		" va "

ninth_choice:	.asciiz		"9. Nhap input tu file input.txt xuat ket qua toan bo cac chuc nang tren ra file output.txt.\n"

input_choice:	.asciiz		"			Lua chon: "
invalid_choice:	.asciiz		"Lua chon khong hop le. Vui long nhap lai.\n"

output_result:	.asciiz		"			Ket qua: "

hooray:			.asciiz		"\nHoorayyy!\n"

				.text
main:			

get_input:
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)

	la $a0, TIME
	la $a1, TEMP	# To store day, month and year before combining them into TIME
			
	jal get_time_from_keyboard

	sw $a0, TIME	# Store result back to TIME

	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	addi $sp, $sp, 12

	jr $ra

	# check if input is valid #

print_tasks:
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $v0, 4($sp)
	sw $a0, 8($sp)
	addi $v0, $0, 4
	la $a0, intro_string
	syscall
	li $v0, 4
	la $a0, first_choice
	syscall
	addi $v0, $zero, 4
	la $a0, second_choice
	syscall
	li $v0, 4
	la $a0, sec_choice_a
	syscall
	addi $v0, $0, 4
	la $a0, sec_choice_b
	syscall
	li $v0, 4
	la $a0, sec_choice_c
	syscall
	addi $v0, $zero, 4
	la $a0, third_choice
	syscall
	li $v0, 4
	la $a0, fourth_choice
	syscall
	addi $v0, $zero, 4
	la $a0, sixth_choice
	syscall
	li $v0, 4
	la $a0, seventh_choice
	syscall
	addi $v0, $zero, 4
	la $a0, eighth_choice
	syscall
	li $v0, 4
	la $a0, ninth_choice
	syscall
	lw $ra, 0($sp)
	lw $v0, 4($sp)
	lw $a0, 8($sp)
	addi $sp, $sp, 12
	jr $ra

get_choice:
			addi $sp, $sp, -16
			sw $ra, 0($sp)
			sw $v0, 4($sp)
			sw $a0, 8($sp)
			sw $t1, 12($sp)

			li $v0, 4
			la $a0, input_choice
			syscall

			# Get choice in int type
			li $v0, 5
			syscall
			sw $v0, choice
			
			la $a0, TIME 			# Argument for all of the 9 functions
			la $a2, can
			la $a1, chi
			# Switch case structure
			# Ref: References/Kien_truc_bo_lenh_MIPS.pdf

			# $t1 and $t2 are Switch case registers.
			addi $t1, $0, 1
			bne choice, $t1, execute_task_second

# Argument: $a0: char* TIME
execute_task_first:
	li $v0, 4
	syscall
	j exit
# Argument
execute_task_second:
	addi $t2, $t0, -2
	bne $t2, $zero, execute_task_third
	# Do something #
	j exit
# Argument
execute_task_third:
	addi $t2, $t0, -3
	bne $t2, $zero, execute_task_fourth

	j exit
# Argument
execute_task_fourth:
	addi $t2, $t0, -4
	bne $t2, $0, execute_task_fifth
	j exit
# Argument
execute_task_fifth:
	addi $t2, $t0, -5
	bne $t2, $0, execute_task_sixth
	j exit
# Arguments: $a0: char* TIME
#			 $a2: can array
#            $a1: chi array
execute_task_sixth:
	addi $t2, $t0, -6
	bne $t2, $zero, execute_task_seventh
	# 6th choice #
	jal Year
	move $s0, $v0		# Store result into $s0
	# Determine can
	li $s6, 6
	add $s7, $s0, $s6
	li $s6, 10
	div $s7, $s6
	mfhi $s7		# (nam + 6) % 10
	li $s6, 5
	mult $s7, $s6
	mflo $s7
	add $a2, $a2, $s7
	# Determine chi
	li $s6, 8
	add $s7, $s0, $s6
	li $s6, 12
	div $s7, $s6
	mfhi $s7		# (nam + 8) % 12
	li $s6, 5
	mult $s7, $s6
	mflo $s7
	add $a1, $a1, $s7					
	lw $a0, can_chi
	jal standardize_can_chi_string
	j exit
# Argument
execute_task_seventh:
	addi $t2, $t0, -7
	bne $t2, $0, execute_task_eighth
	j exit
# Argument
execute_task_eighth:
	addi $t2, $t0, -8
	bne $t2, $0, execute_task_ninth
	j exit
# Argument
execute_task_ninth:
	addi $t2, $t0, -9
	bne $t2, $zero, raise_invalid_choice
raise_invalid_choice:
	li $v0, 4
	la $a0, input_choice
	syscall
	j get_choice
raise_invalid_input:
	addi $v0, $0, 4
	la $a0, invalid_input 	
	syscall
	j get_input			# Ask for input, again!
	

# Arguments:
# 			$a0: char* TIME
#			$a1: .space TEMP to strore day, month, year transiently
# Return value:	$a0 points to TIME(char*)
get_time_from_keyboard:
	addi $sp, $sp, -32
	sw $ra, 0($sp)	# Store the address of the next line of: jal get_time_from_keyboard
	sw $a0, 4($sp)	# Address of TIME
	sw $a1, 8($sp)	# Address of TEMP
	sw $v0, 24($sp)
	sw $a3, 28($sp)
	# 12($sp), 16($sp) and 20($sp) are used to store day, month, year in int type
						
	# Get day
	li $v0, 4
	la $a0, input_day
	syscall
	# this is how to get day as a string
	li $v0, 8		# 8 is to read_string
	lw $a0, 8($sp)	# Input is stored in 8($sp) but we need to load its address into $a0
	li $a1, 1024		# $a1 determines the maximum number of characters stored, 1024 bytes
					# input will have a form (day: '10'): |'1'|'0'|'\n'|'\0'|
	syscall

	# Check if the day has at most 2 characters (ignore '\n' and '\0')
	li $a3, 2		# At most 2 characters
	jal compute_string_length
	beq $v0, $0, raise_invalid_input		# Invalid input if $v0 == $0
	# Check if input is a digit-string
	jal contains_only_digits
	beq $v0, $0, raise_invalid_input		# Invalid input if $v0 == $0
	# Convert month from char into int
	li $a3, 10
	jal atoi
	# Store day (int type) into stack
	sw $v0, 12($sp)		

	# Get month
	li $v0, 4
	la $a0, input_month
	syscall
					
	li $v0, 8		
	lw $a0, 8($sp)	
	li $a1, 1024		
	syscall

	li $a3, 2		
	jal compute_string_length
	beq $v0, $0, raise_invalid_input
	jal contains_only_digits
	beq $v0, $0, raise_invalid_input
	# Convert month from char into int and store into stack
	li $a3, 10
	jal atoi
						
	sw $v0, 16($sp)	

	# Get year
	li $v0, 4
	la $a0, input_year
	syscall
					
	li $v0, 8		
	lw $a0, 8($sp)	
	li $a1, 1024		
	syscall

	jal contains_only_digits
	beq $v0, $0, raise_invalid_input
	# Convert and store for year
	li $a3, 10
	jal atoi
						
	sw $v0, 20($sp)	

	# Load back day, month, year and TIME pointer
	lw $a0, 4($sp)
	lw $a1, 12($sp)
	lw $a2, 16($sp)
	lw $a3, 20($sp)
	jal Date

	j get_time_from_keyboard_exit

get_time_from_keyboard_exit:
	lw $ra, 0($sp)
	lw $a0, 4($sp)	
	lw $a1, 8($sp)
	lw $v0, 24($sp)
	lw $a3, 28($sp)
	addi $sp, $sp, 32
	jr $ra


# Compute length of input string and raise error if the number of elements exceed a given value
# Arguments:	$a0: input from keyboard
#				$a3: maximum number of characters
# Return: $v0
compute_string_length:
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $t0, 4($sp)
	sw $t3, 8($sp)
	sw $t1, 12($sp)
	sw $t2, 16($sp)
	add $t0, $0, $a0		# $t0 points to $a0 containing input string
	add $t3, $zero, $a3
	li $t1, 0		# $t1 works as sum variable and initially, sum = 0
	li $v0, $0		# initially, $v0 is 0 -> invalid
	compute_string_length_loop:
		# Ref: http://davidlovesprogramming.blogspot.com/2013/01/the-following-post-is-bit-more-complex.html
		lb $t2, 0($t0)		# Load the first byte from the string that $t0 refers to
		beq $t2, 10, is_input_len_valid		# '\n' is 10
		addi $t1, $t1, 1
		addi $t0, $t0, 1
		j compute_string_length_loop
	is_input_len_valid:
		bgt $t1, $t3, compute_string_length_exit	# If sum > $a2
		beq $t1, $0, compute_string_length_exit
		li $v0, 1
	compute_string_length_exit:
		lw $ra, 0($sp)
		lw $t0, 4($sp)
		lw $t3, 8($sp)
		lw $t1, 12($sp)
		lw $t2, 16($sp)
		addi $sp, $sp, 20
		jr $ra 				# Go back and execute jal contains_only_digits	



# Check if input contains only digit
# Argument:		$a0: input in char*
# Return $v0
contains_only_digits:
						addi $sp, $sp, -12
						sw $ra, 0($sp)
						sw $t0, 4($sp)
						sw $t2, 8($sp)

						add $t0, $0, $a0		# $t0 points to $a0 contaning input string
						li $v0, $0
contains_only_digits_loop:
						# Ref: http://www.cim.mcgill.ca/~langer/273/10-notes.pdf
						lb $t2, 0($t0)	
					
						beq $t2, 10, set_valid_input	# 10 is '\n'
						blt $t2, 48, contains_only_digits_exit		# 48 is '0' in ASCII
						bgt $t2, 57, contains_only_digits_exit		# 58 is '9'

						addi $t0, $t0, 1 # Move to the next byte

						j contains_only_digits_loop
set_valid_input:
				li $v0, 1
contains_only_digits_exit:
						lw $ra, 0($sp)
						lw $t0, 4($sp)
						lw $t2, 8($sp)
						addi $sp, $sp, 12

						jr $ra 			# Jump to the address of an instruction after: jal contains_only_digits

#Function to convert string to number
#INPUT: $a0: save address of string
#OUTPUT: $v0: save value into int
atoi:
	li $v0, 0
atoi_loop:
	#Backup
	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $a0, 4($sp)
	sw $t0, 8($sp)
	
	lb $t0, ($a0)
	beq $t0, '\n', atoi_finish
	beq $t0, '\0', atoi_finish
		
	mul $v0, $v0, 10
	addi $t0, $t0, -48	
	add $v0, $v0, $t0
	addi $a0, $a0, 1
	j atoi_loop
atoi_finish:
	#Restore
	lw $ra, ($sp)
	lw $a0, 4($sp)
	lw $t0, 8($sp)
	addi $sp, $sp, 12
	jr $ra

# Arguments: 
#			day: int    -> $a1
#			month: int  -> $a2
#			year: int   -> $a3
#			TIME: char* -> $a0
# Return value: $a0
Date:
	addi $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s2, 12($sp)

	addi $s3, $0, 47	# 47 is '/' in ASCII

	# Let put day ... lazily into TIME
	move $s1, $a1

	addi $s2, $0, 10
	div $s1, $s2
	mflo $s1 		# quotient
	addi $s1, $s1, 48	# Convert into integer: int = char + '0' (48)
	mfhi $s2 		# remainder
	addi $s2, $s2, 48
	
	sb $s1, 0($a0)	# TIME[0] = $s1
	sb $s2, 1($a0)
	sb $s3, 2($a0)
	
	# Put month
	move $s1, $a2

	addi $s2, $0, 10
	div $s1, $s2
	mflo $s1 		
	addi $s1, $s1, 48
	mfhi $s2 		
	addi $s2, $s2, 48

	sb $s1, 3($a0)	
	sb $s2, 4($a0)
	sb $s3, 5($a0)

	# Put year (lazily!)
	move $s1, $a3

	addi $s2, $0, 1000			
	div $s1, $s2 				
	mflo $s3						
	addi $s3, $s3, 48	
	mfhi $s1			

	sb $s3, 6($a0)		

	addi $s2, $zero, 100
	div $s1, $s2
	mflo $s3		
	addi $s3, $s3, 48
	mfhi $s1		

	sb $s3, 7($a0)		

	addi $s2, $0, 10
	div $s1, $s2
	mflo $s3
	addi $s3, $s3, 48
	mfhi $s1		
	addi $s1, $s1, 48

	sb $s3, 8($a0)		
	sb $s1, 9($a0)		

	sb $zero, 10($a0) # '\0' at the end of TIME_1

	lw $ra, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s2, 12($sp)
	addi $sp, $sp, 16

	jr $ra

# Argument: $a0 char *TIME
# Return:	$v0
Day:
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s4, 8($sp)
	sw $s2, 12($sp)
	sw $s1, 16($sp)

	move $s0, $a0
	li $v0, 0
	li $s4, 47
Day_loop:
		lb $s1, 0($s0)

		beq $s1, $s4, Day_finish

		addi $s1, $s1, -48

		li $s2, 10
		mult $v0, $s2
		mflo $v0

		add $v0, $v0, $s1

		addi $s0, $s0, 1

		j Day_loop
Day_finish:
			lw $ra, 0($sp)
			lw $s0, 4($sp)
			lw $s4, 8($sp)
			lw $s2, 12($sp)
			lw $s1, 16($sp)
			addi $sp, $sp, 20

			jr $ra

# Argument: $a0 char *TIME
# Return:	$v0
Month:
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s4, 8($sp)
	sw $s2, 12($sp)
	sw $s1, 16($sp)

	move $s0, $a0
	addi $s0, $s0, 3
	li $v0, 0
	li $s4, 47
Month_loop:
		lb $s1, 0($s0)

		beq $s1, $s4, Month_finish

		addi $s1, $s1, -48

		li $s2, 10
		mult $v0, $s2
		mflo $v0

		add $v0, $v0, $s1

		addi $s0, $s0, 1

		j Month_loop
Month_finish:
			lw $ra, 0($sp)
			lw $s0, 4($sp)
			lw $s4, 12($sp)
			lw $s2, 16($sp)
			lw $s1, 20($sp)
			addi $sp, $sp, 20

			jr $ra

# Argument: $a0: char* TIME
# Return: $v1
Year:
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s4, 8($sp)
	sw $s2, 12($sp)
	sw $s1, 16($sp)

	move $s0, $a0
	addi $s0, $s0, 6
	li $v0, 0		# return value
Year_loop:
			lb $s1, 0($s0)
			
			beq $s1, $0, Year_finish

			addi $s1, $s1, -48

			li $s2, 10
			mult $v0, $s2
			mflo $v0

			add $v0, $v0, $s1

			addi $s0, $s0, 1

			j Year_loop
Year_finish:
			lw $ra, 0($sp)
			lw $s0, 4($sp)
			lw $s4, 8($sp)
			lw $s2, 12($sp)
			lw $s1, 16($sp)
			addi $sp, $sp, 20

			jr $ra

# Argument: $a2: can, $a1: chi, $a0: can_chi to store output
# Return: $a0
standardize_can_chi_string:
							addi $sp, $sp, -12
							sw $ra, 0($sp)
							sw $s1, 4($sp)
							sw $a0, 8($sp)

							la $a0, can_chi
find_the_first_char_of_can:	
					lb $s1, 0($a2)

					bne $s1, ' ', put_can_into_output

					addi $a2, $a2, 1

					j find_the_first_char_of_can
put_can_into_output:
					# Load character into can_chi
					sb $a2, 0($a0)

					beq $a2, $0, put_space_into_output

					addi $a2, $a2, 1
					addi $a0, $a0, 1

					j put_can_into_output
put_space_into_output:
						addi $a0, $a0, 1
						li $s1, 32			# 32 is ' ' in ASCII
						sb $s1, $a0
						addi $a0, $a0, 1
find_the_first_char_of_chi:
					lb $s1, 0($a1)

					bne $s1, ' ', put_chi_into_output

					addi $a1, $a1, 1

					j find_the_first_char_of_chi
put_chi_into_output:
					sb $a1, 0($a0)

					beq $a1, $0, standardize_can_chi_string_exit

					addi $a1, $a1, 1
					addi $a0, $a0, 1

					j put_chi_into_output
standardize_can_chi_string_exit:
					lw $ra, 0($sp)
					lw $s1, 4($sp)
					lw $a0, 8($sp)
					addi $sp, $sp, 12

					jr $ra
exit:
	li $v0, 4
	la $a0, hooray
	syscall

	li $v0, 10
	syscall
