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

raise_invalid_input:
					addi $v0, $0, 4
					la $a0, invalid_input 	
					syscall

					j get_input			# Ask for input, again!
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
						lw $t3, 16($sp)
						lw $t2, 12($sp)
						lw $t1, 8($sp)
						lw $t0, 4($sp)	
						jal Date

						j exit

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

Date:
	# $t0 points to TIME
	# Convert day from char into int
	add $a0, $0, $t1 		# $a0 points to day 
	jal atoi
	add $s1, $0, $v1		# Load return value from $v1 into $t1

	addi $s3, $0, 47	# 47 is '/' in ASCII

	# Let put it ... lazily into TIME
	addi $s2, $0, 10
	div $s1, $s2
	mflo $s1 		# quotient
	addi $s1, $s1, 48	# Convert into integer: int = char + '0' (48)
	mfhi $s2 		# remainder
	addi $s2, $s2, 48
	
	sb $s1, 0($t0)	# TIME[0] = $t1
	sb $s2, 1($t0)
	sb $s3, 2($t0)
	
	# Do the same thing for month 
	add $a0, $zero, $t2
	jal atoi
	add $s1, $zero, $v1
	# Put month
	addi $s2, $0, 10
	div $s1, $s2
	mflo $s1 		
	addi $s1, $s1, 48
	mfhi $s2 		
	addi $s2, $s2, 48

	sb $s1, 3($t0)	
	sb $s2, 4($t0)
	sb $s3, 5($t0)

	# ... and year
	add $a0, $zero, $t3
	jal atoi
	add $s1, $zero, $v1
	# Put year (lazily!)
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

	li $v0, 4
	move $a0, $t0
	syscall

	j exit

atoi:
		li $v1, 0	# $v1 is a result
		add $a1, $zero, $a0 # $a1 refers to argument $a0
atoi_loop:
		lb $a2, 0($a1)

		beq $a2, 10, atoi_finish
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

exit:
	li $v0, 4
	la $a0, hooray
	syscall

	li $v0, 10
	syscall