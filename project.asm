				.data

TIME:			.space		1024	# Maximum is 10, but there'll be some error if I just use 10!
TIME_1:			.space 		1024
TIME_2:			.space		1024
day:			.space 		1024
month:			.space		1024
year:			.space		1024

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
can5:			.asciiz		" Mau"
can6:			.asciiz		"  Ky"
can7:			.asciiz		"Canh"
can8:			.asciiz		" Tan"
can9:			.asciiz		"Nham"
can10:			.asciiz		" Quy"
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
			la $a0, TIME
			la $t1, day
			la $t2, month
			la $t3, year
			jal get_time_from_keyboard

			# check valid input #

			move $a3, $v1	# $v1 is poniting to TIME 
					
			lw $a2, can
			lw $a1, chi
			jal execute_task_sixth
			li $v0, 4
			move $a0, $a2
			syscall
			li $v0, 4
			move $a0, $a1
			syscall
			j exit

raise_invalid_input:
					addi $v0, $0, 4
					la $a0, invalid_input 	
					syscall

					j get_input			# Ask for input, again!
# Arguments:
# 			$a0: char* TIME
#			$t1: .space day
# 			$t2: .space month
#			$t3: .space year
# Return value:	$v1 points to TIME(char*)
get_time_from_keyboard:
						addi $sp, $sp, -20
						sw $ra, 0($sp)	# Store the address of the next line of: jal get_time_from_keyboard
						sw $a0, 4($sp)	# Address of TIME
						sw $t1, 8($sp)
						sw $t2, 12($sp)
						sw $t3, 16($sp)
						
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
						li $t3, 2		# At most 2 characters
						jal compute_string_length
						# Check if input is a digit-string
						jal contains_only_digits
						# Store day
						sw $a0, 8($sp)

						# Get month
						li $v0, 4
						la $a0, input_month
						syscall
					
						li $v0, 8		
						lw $a0, 12($sp)	
						li $a1, 1024		
						syscall

						li $t3, 2		
						jal compute_string_length
						jal contains_only_digits
						# Store month
						sw $a0, 12($sp)
			
						# Get year
						li $v0, 4
						la $a0, input_year
						syscall
					
						li $v0, 8		
						lw $a0, 16($sp)	
						li $a1, 1024		
						syscall

						jal contains_only_digits
						# Store year
						sw $a0, 16($sp)

						# Load stored input into registers
						lw $t0, 4($sp)	

						# Convert month from char into int
						lw $t1, 8($sp)
						add $a0, $0, $t1 		# $a0 points to day 
						li $a3, 10
						jal atoi
						add $t1, $0, $v1		# Load return value from $v1 into $t1

						# Do the same thing for month 
						lw $t2, 12($sp)
						add $a0, $zero, $t2
						li $a3, 10
						jal atoi
						add $t2, $zero, $v1
					
						#  and year
						lw $t3, 16($sp)
						add $a0, $zero, $t3
						li $a3, 10
						jal atoi
						add $t3, $zero, $v1
						
						jal Date

						j get_time_from_keyboard_exit

get_time_from_keyboard_exit:
							lw $ra, 0($sp)
							lw $a0, 4($sp)	
							lw $t1, 8($sp)
							lw $t2, 12($sp)
							lw $t3, 16($sp)

							addi $sp, $sp, 20

							move $v1, $a0	# $v1 keeps the return pointer referring to TIME

							jr $ra

# Compute length of input string and raise error if the number of elements exceed a given value
# Arguments:	$a0: input from keyboard
#				$t3: maximum number of characters
compute_string_length:
						add $t0, $0, $a0		# $t0 points to $a0 containing input string
						add $a2, $zero, $t3
						li $t1, 0		# $t1 works as sum variable and initially, sum = 0
compute_string_length_loop:
						# Ref: http://davidlovesprogramming.blogspot.com/2013/01/the-following-post-is-bit-more-complex.html
						lb $t2, 0($t0)		# Load the first byte from the string that $t0 refers to

						beq $t2, 10, is_input_len_valid		# '\n' is 10
						
						addi $t1, $t1, 1
						addi $t0, $t0, 1

						j compute_string_length_loop
is_input_len_valid:
					bgt $t1, $a2, raise_invalid_input	# If sum > $a2
					jr $ra 				# Go back and execute jal contains_only_digits	

# Check if input contains only digit
# Argument:		$a0: input in char*
contains_only_digits:
						add $t0, $0, $a0		# $t0 points to $a0 contaning input string
contains_only_digits_loop:
						# Ref: http://www.cim.mcgill.ca/~langer/273/10-notes.pdf
						lb $t2, 0($t0)	
					
						beq $t2, 10, contains_only_digits_exit	# 10 is '\n'
						blt $t2, 48, raise_invalid_input		# 48 is '0' in ASCII
						bgt $t2, 57, raise_invalid_input		# 58 is '9'

						addi $t0, $t0, 1 # Move to the next byte

						j contains_only_digits_loop
contains_only_digits_exit:
						jr $ra 			# Jump to the address of an instruction after: jal contains_only_digits

print_tasks:
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
			la $a0, seventh_choice
			syscall

# Arguments: 
#			day: int    -> $t1
#			month: int  -> $t2
#			year: int   -> $t3
#			TIME: char* -> $t0
# Return value: $t0
Date:
	addi $s3, $0, 47	# 47 is '/' in ASCII

	# Let put day ... lazily into TIME
	move $s1, $t1

	addi $s2, $0, 10
	div $s1, $s2
	mflo $s1 		# quotient
	addi $s1, $s1, 48	# Convert into integer: int = char + '0' (48)
	mfhi $s2 		# remainder
	addi $s2, $s2, 48
	
	sb $s1, 0($t0)	# TIME[0] = $t1
	sb $s2, 1($t0)
	sb $s3, 2($t0)
	
	# Put month
	move $s1, $t2

	addi $s2, $0, 10
	div $s1, $s2
	mflo $s1 		
	addi $s1, $s1, 48
	mfhi $s2 		
	addi $s2, $s2, 48

	sb $s1, 3($t0)	
	sb $s2, 4($t0)
	sb $s3, 5($t0)

	# Put year (lazily!)
	move $s1, $t3

	addi $s2, $0, 1000			#t1 = s2
	div $s1, $s2 				#t0 = s1
	mflo $s3					#t2 = s3	
	addi $s3, $s3, 48	
	mfhi $s1			

	sb $s3, 6($t0)		

	addi $s2, $zero, 100
	div $s1, $s2
	mflo $s3		
	addi $s3, $s3, 48
	mfhi $s1		

	sb $s3, 7($t0)		

	addi $s2, $0, 10
	div $s1, $s2
	mflo $s3
	addi $s3, $s3, 48
	mfhi $s1		
	addi $s1, $s1, 48

	sb $s3, 8($t0)		
	sb $s1, 9($t0)		

	sb $zero, 10($t0) # '\0' at the end of TIME_1

	jr $ra

# Argument: $a1: char* TIME, $a3: character to terminate
atoi:
		li $v1, 0	# $v1 is a result
		add $a1, $zero, $a0 # $a1 refers to argument $a0
atoi_loop:
		lb $a2, 0($a1)

		beq $a2, $a3, atoi_finish
		# Convert char into int: int = char - '0'
		addi $a2, $a2, -48	
		# $v0 = $v0 * 10
		addi $v0, $0, 10
		mult $v1, $v0
		mflo $v1
		
		add $v1, $v1, $a2

		addi $a1, $a1, 1

		j atoi_loop
atoi_finish:
		jr $ra

# Arguments: $a3: char* TIME
#			 $a2: can array
#            $a1: chi array
execute_task_sixth:
					addi $sp, $sp, -16
					sw $ra, 0($sp)
					sw $a3, 4($sp)		# TIME
					sw $a2, 8($sp)		# can
					sw $a1, 12($sp)		# chi

					lw $a0, 4($sp)
					jal Year
					move $s0, $v1		# Store result into $s0
					
					# Determine can
					li $s6, 6
					add $s7, $s0, $s6
					li $s6, 10
					div $s7, $s6
					mfhi $s7		# (nam + 6) % 10

					li $s6, 5
					mult $s7, $s6
					mflo $s7

					lw $a0, 8($sp)
					add $a0, $a0, $s7
					
					sw $a0, 8($sp)		# Store result in corresponding block

					# Determine chi
					li $s6, 8
					add $s7, $s0, $s6
					li $s6, 12
					div $s7, $s6
					mfhi $s7		# (nam + 8) % 12

					li $s6, 5
					mult $s7, $s6
					mflo $s7

					lw $a0, 12($sp)
					add $a0, $a0, $s7

					sw $a0, 12($sp)
					
					lw $ra, 0($sp)
					lw $a3, 4($sp)		
					lw $a2, 8($sp)		
					lw $a1, 12($sp)		

					addi $sp, $sp, 16

					jr $ra

# Argument: $a0 char *TIME
# Return:	$v1
Day:
	move $s0, $a0
	li $v1, 0
	li $s4, 47
Day_loop:
		lb $s1, 0($s0)

		beq $s1, $s4, Day_finish

		addi $s1, $s1, -48

		li $s2, 10
		mult $v1, $s2
		mflo $v1

		add $v1, $v1, $s1

		addi $s0, $s0, 1

		j Day_loop
Day_finish:
			jr $ra

# Argument: $a0 char *TIME
# Return:	$v1
Month:
	move $s0, $a0
	addi $s0, $s0, 3
	li $v1, 0
	li $s4, 47
Month_loop:
		lb $s1, 0($s0)

		beq $s1, $s4, Month_finish

		addi $s1, $s1, -48

		li $s2, 10
		mult $v1, $s2
		mflo $v1

		add $v1, $v1, $s1

		addi $s0, $s0, 1

		j Day_loop
Month_finish:
			jr $ra

# Argument: $a0: char* TIME
# Return: $v1
Year:
	move $s0, $a0
	addi $s0, $s0, 6
	li $v1, 0		# return value
Year_loop:
			lb $s1, 0($s0)
			
			beq $s1, $0, Year_finish

			addi $s1, $s1, -48

			li $s2, 10
			mult $v1, $s2
			mflo $v1

			add $v1, $v1, $s1

			addi $s0, $s0, 1

			j Year_loop
Year_finish:
			jr $ra

exit:
	li $v0, 4
	la $a0, hooray
	syscall

	li $v0, 10
	syscall