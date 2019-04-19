				.data

choice: 		.word		0

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

TIME:			.space		1024	# Maximum is 10, but there'll be some error if I just use 10!
TIME_1:			.space 		1024
TIME_2:			.space		1024
TEMP:			.space		1024
can_chi:		.space 		1024
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
output_leap_yr:	.asciiz		" LA NAM NHUAN.\n"
output_n_lp_yr:	.asciiz		" LA NAM THUONG.\n"

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
sub_eighth_choice1:			.asciiz		"Hai nam nhuan gan voi "
sub_eighth_choice2:                     .asciiz         " nhat la "
sub_eighth_choice3:			.asciiz		" va "

ninth_choice:	.asciiz		"9. Nhap input tu file input.txt xuat ket qua toan bo cac chuc nang tren ra file output.txt.\n"

input_choice:	.asciiz		"			Lua chon: "
invalid_choice:	.asciiz		"Lua chon khong hop le. Vui long nhap lai.\n"

output_result:	.asciiz		"			Ket qua: "

hooray:			.asciiz		"\nHoorayyy!\n"

				.text
main:			
		jal get_input
		jal print_tasks
		jal get_choice

get_input:
			addi $sp, $sp, -12
			sw $ra, 0($sp)
			sw $a0, 4($sp)
			sw $a1, 8($sp)

			la $a0, TIME
			la $a1, TEMP 		# To store day, month and year before combining them into TIME
			
			jal get_time_from_keyboard
			

			sw $a0, TIME

			lw $ra, 0($sp)
			lw $a0, 4($sp)
			lw $a1, 8($sp)
			addi $sp, $sp, 12
			
			
			move $s3,$v1
			beq $s3,$0, raise_invalid_input

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
			
			lw $t2, choice
			la $a0, TIME
			lw $a2, can
			lw $a1, chi

			# Switch case structure
			# Ref: References/Kien_truc_bo_lenh_MIPS.pdf

			# $t1 and $t2 are Switch case registers.
			addi $t1, $0, 1
			bne $t2, $t1, execute_task_second

# Argument: $a0: char* TIME
execute_task_first:
					li $v0, 4
					syscall

					j exit
# Argument
execute_task_second:
					addi $t3, $t2, -2
					bne $t3, $zero, execute_task_third

					# Do something #

					j exit

execute_task_third:
					addi $t3, $t2, -3
					bne $t3, $zero, execute_task_fourth
					#move $a0,$a3  #TIME
					
					
					jal CheckLeapYear
					li $t0,1
					beq $t0,$v1, Leap  #  t0=v1->Leap
	
	 				#  t0!=v1->output
	 				
	 				addi $a0,$a0,0  # ouput nam
	 				li $v0,1
	 				syscall
	 				
	 				
					li $v0,4         # output  
					la $a0, output_n_lp_yr
					syscall
					j exit
Leap:
					addi $a0,$a0,0  # ouput nam
	 				li $v0,1
	 				syscall
	 				
	 				
					li, $v0,4
					la,$a0, output_leap_yr
					syscall
					j exit
										
execute_task_fourth:
					addi $t3, $t2, -4
					bne $t3, $0, execute_task_fifth
					
					
					jal Weekday
					move $a0, $v0
					li $v0, 4
					syscall
					j exit

execute_task_fifth:
					addi $t3, $t2, -5
					bne $t3, $0, execute_task_sixth
					
					j exit
# Arguments: $a0: char* TIME
#			 $a2: can array
#            $a1: chi array
execute_task_sixth:
					addi $t3, $t2, -6
					bne $t3, $0, execute_task_seventh

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

					la $a0, can_chi
					jal standardize_can_chi_string

					li $v0, 4
					syscall

					j exit

execute_task_seventh:
					addi $t3, $t2, -7
					bne $t3, $0, execute_task_eighth

					j exit

execute_task_eighth:
					addi $t3, $t2, -8
					bne $t3, $0, execute_task_ninth
					
					
					#move $a0,$a3 #TIME
	
					jal CheckLeapYear
					
					li $t1,1
					beq $v1,$t1, LeapNext   #t0=0 notleap
					
					move $v1,$a0  #v1=a0
	
					li $t1,4     # t1=4
					div $v1,$t1  # year/4
					mfhi $v1     # Hi
					sub $a0,$a0,$v1 
					# 2017 mod 4=1
					# 2017-1=2016 is leapyear
					j NotLeapNext

LeapNext:
					move $t1, $a0  # t0=nam(t0=2016)
	
					#output "Hai nam nhuan gan voi "
					li $v0,4
					la $a0, sub_eighth_choice1  
					syscall
					
					
					addi $a0,$t1,0
					li $v0,1  
					syscall
					
					li $v0,4
					la $a0, sub_eighth_choice2  
					syscall
					
					li $v1,4
					sub $a0,$t1,4 # year-4
					li $v0,1
					syscall
	
	
					move $t1,$a0    # t1=a0
	
					li $v0,4
					la $a0, sub_eighth_choice3  # output "v "
					syscall
	
					addi $a0, $t1, 8 # year+4
					li $v0,1
					syscall
	
					j exit

NotLeapNext:
					move $t1, $a0  # t1=nam(t0=2016)
					#output "Hai nam nhuan gan "
					li $v0,4
					la $a0, sub_eighth_choice1  
					syscall
					
					add $a0,$t1,$v1
					li $v0,1  
					syscall
					
					move $a0,$t1
					
					li $v0,4
					la $a0, sub_eighth_choice2  
					syscall
					
					
					addi $a0,$t1,0  # year
					li $v0,1
					syscall
	
	
					move $t1,$a0    # t1=a0
	
					li $v0,4
					la $a0, sub_eighth_choice3  # output "v "
					syscall
	
					addi $a0, $t1,4 # year+4
					li $v0,1
					syscall
	
					j exit

execute_task_ninth:
					addi $t3, $t2, -9
					bne $t3, $zero, raise_invalid_choice

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
# 			$a0: .space TIME
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
						jal atoi
						
						sw $v0, 20($sp)	

						# Load back day, month, year and TIME pointer
						lw $a0, 4($sp)
						lw $a1, 12($sp)
						lw $a2, 16($sp)
						lw $a3, 20($sp)
						jal Date
						
						jal CheckDay
						
						j get_time_from_keyboard_exit

get_time_from_keyboard_exit:
							lw $ra, 0($sp)
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
						li $v0, 0		# initially, $v0 is 0 -> invalid
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
						li $v0, 0
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
	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $a0, 4($sp)
	sw $t0, 8($sp)

	li $v0, 0
atoi_loop:
	lb $t0, ($a0)
	beq $t0, 10, atoi_finish
	beq $t0, 0, atoi_finish
		
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
# Return: $v0
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
find_the_first_char_of_can:	
					lb $s1, 0($a2)

					bne $s1, 32, put_can_into_output

					addi $a2, $a2, 1

					j find_the_first_char_of_can
put_can_into_output:
					# Store character into can_chi
					lb $s1, 0($a2)
					beq $s1, $0, put_space_into_output

					sb $s1, 0($a0)

					addi $a2, $a2, 1
					addi $a0, $a0, 1

					j put_can_into_output
put_space_into_output:
						li $s1, 32			# 32 is ' ' in ASCII
						sb $s1, 0($a0)
find_the_first_char_of_chi:
					lb $s1, 0($a1)

					bne $s1, 32, put_chi_into_output

					addi $a1, $a1, 1

					j find_the_first_char_of_chi
put_chi_into_output:
					lb $s1, 0($a1)
					beq $s1, $0, standardize_can_chi_string_exit

					sb $s1, 0($a0)

					addi $a1, $a1, 1
					addi $a0, $a0, 1

					j put_chi_into_output
standardize_can_chi_string_exit:
					sb $0, 0($a0)

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

LeapYear: 
	li $t1, 400        # t1=400
	div $a0, $t1       # year/400
	mfhi $t1           # Hi
	beq $t1, $0, True  # year%400==0 -> true
	
	li $t1, 4
	div $a0, $t1       # year/4
	mfhi $t1           # Hi
	bne $t1, $0, False # year%4!=0-> false
	
	li $t1, 100
	div $a0, $t1  # year/100
	mfhi $t1      # Hi
	beq $t1, $0, False #year%4==0 && year%100==0 ->False 
	
	
True:
	li $v1, 1 #true -> 1
	jr $ra
	
	
False:
	li $v1, 0 #false ->0
	jr $ra
	
	
# input $a0 TIME
# output $v1 la 0_notleap , 1_leap
CheckLeapYear:
	addi $sp,$sp,-4
	sw $ra,0($sp)
	
	jal Year  
	move $a0,$v0
	jal LeapYear
	
	#restore stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
	
	
Weekday:
	#input  TIME
	#output $v0
	addi $sp,$sp,-16
	sw $ra, 12($sp)
	sw $t2, 8($sp)
	sw $t1, 4($sp)
	sw $t0, 0($sp) 
	
	
	jal Year
	move $t2, $v0    #t2=year
	
	jal Day
	move $t0, $v0    #t0=day
	
	jal Month
	move $t1, $v0    #t1=month
	

	li $t3, 1
	beq $t3,$t1, DinhDangNam1
	li $t3,2
	beq $t3,$t1, DinhDangNam2
	j XacDinhThu
DinhDangNam1:
	li $t3, 1
	sub $t2,$t2,$t3 #nam--
	li $t1,13
	j XacDinhThu
DinhDangNam2:
	li $t3, 1
	sub $t2,$t2,$t3 #nam--
	li $t1,14
	j XacDinhThu	
XacDinhThu:
	move $s0,$t0               # s0=day
	
	li,$t3,1
	add $t1,$t1,$t3            # m=m+1
	li $t3,13
	mult $t1,$t3               # 13*(m+1)
	mflo $t1                   # t1=13*(m+1)
	li $t3,5
	div $t1,$t3                # 13/5*(m+1)
	mflo $t1                   # t1=13/5*(m+1)
	
	
	add $s0,$s0, $t1           # s0=13/5*(m+1)+d
	
	li $t3, 100
	div $t2,$t3                # nam/100
	mflo $t0                   # First 2 digits
	mfhi $t1                   # Last 2 digits
	add $s0,$s0,$t1            # s0=13/5*(m+1)+d+y
	
	
	li $t3, 4
	div $t1, $t3               # ydiv4
	mflo $t1                   # lo
	div $t0,$t3                # cdiv4
	mflo $t0                   # lo
	add $s0,$s0,$t1            # s0=13/5*(m+1)+d+ydiv4+y
	add $s0,$s0,$t0            # s0=13/5*(m+1)+d+ydiv4+y+cdiv4
	
	
	
	li $t3, 100
	div $t2,$t3                # nam/100
	mflo $t0                   # lo
	li $t3,2
	mult $t0,$t3               # 2*c
	mflo $t0
	sub $s0,$s0,$t0            # s0=13/5*(m+1)+d+ydiv4+cdiv4+y-2*c


	li $t3,7
	div $s0,$t3
	mfhi $s0                   # s0=(13/5*(m+1)+d+ydiv4+cdiv4+y-2*c)mod 7
	
	
	li $t3,1
	beq $s0,$t3, sun
	li $t3,2
	beq $s0,$t3, mon
	li $t3,3
	beq $s0,$t3, tue
	li $t3,4
	beq $s0,$t3, wed
	li $t3,5
	beq $s0,$t3, thurs
	li $t3,6
	beq $s0,$t3, fri
	li $t3,7
	beq $s0,$t3, sat
sun:
	la $v0, sunday
	j end
mon:
	la $v0, monday
	j end
tue:
	la $v0, tuesday
	j end
wed:
	la $v0, wednesday
	j end	
thurs:
	la $v0, thursday
	j end	
fri:
	la $v0, friday
	j end	
sat:
	la $v0, saturday
	j end
end:
	lw $ra, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp) 
	
	addi $sp,$sp,16
	
	jr $ra	
CheckDay:
# output v0
	addi $sp,$sp,-16
	sw $ra ,12($sp)
	sw $t4, 8($sp)
	sw $t2, 4($sp)
	sw $t1, 0($sp)
	
	#Check_Year
	jal Year
	move $t4,$v0
	slti $t0,$t4,1                   #t4<1->t0=1
	bne $t0,$0, FalseDate            #t0!=0->t0=1->false
	
	#Check_Month
	jal Month
	move $t1,$v0  	                 #t1=month
	li $t3,1
	slt $t0,$t1,$t3	                 # if month<1 -> $t0=1
	bne $t0,$0, FalseDate            # $t0!=0->$t0=1->false
	li $t3,13  
	slt $t0,$t1,$t3                  # if month<13 -> $t0=1
	beq $t0,$0, FalseDate            # $t0=0 -> false-> month>=13
	
	
	#Check_Day
	jal Day 
	move $t2,$v0                     # t2=day
	
	li $t3,1
	beq $t3,$t1, Check_31_day
	li $t3,2
	beq $t3,$t1, Check_Month_2
	li $t3,3
	beq $t3,$t1, Check_31_day
	li $t3,4
	beq $t3,$t1, Check_30_day
	li $t3,5
	beq $t3,$t1, Check_31_day
	li $t3,6
	beq $t3,$t1, Check_30_day
	li $t3,7
	beq $t3,$t1, Check_31_day
	li $t3,8
	beq $t3,$t1, Check_31_day
	li $t3,9
	beq $t3,$t1, Check_30_day
	li $t3,10
	beq $t3,$t1, Check_31_day
	li $t3,11
	beq $t3,$t1, Check_30_day
	li $t3,12
	beq $t3,$t1, Check_31_day
Check_31_day:
	li $t3,1
	slt $t0,$t2,$t3                  # t2<1->t0=1
	bne $t0,$0, FalseDate            # t0!=0->t0=1->false
	li $t3,32 
	slt $t0,$t2,$t3                  # t2<32->t0=1
	beq $t0,$0, FalseDate            # t0=0->t2>=32->false
	j TrueDate
Check_30_day:
	li $t3,1
	slt $t0,$t2,$t3                  # t2<1->t0=1
	bne $t0,$0, FalseDate            # t0!=0->t0=1->false
	li $t3,31
	slt $t0,$t2,$t3                  # t2<31->t0=1
	beq $t0,$0, FalseDate            # t0=0->t2>=31->false
	j TrueDate
Check_Month_2:
	li $t3,1
	slt $t0,$t2,$t3                  # t2<1->t0=1
	bne $t0,$0, FalseDate            # t0!=0->t0=1->false
	li $t3,30
	slt $t0,$t2,$t3                  # t2<30->t0=1
	beq $t0,$0, FalseDate            # t0=0->t2>=30->false
	jal CheckLeapYear
	move $t3,$v1                     # t3=v1 v1=0 ->not leap, v2=1->leap
	li $t0,0                         # t0=0
	beq $t3,$t0, Check_Month_2_Not_Leap
	j TrueDate
Check_Month_2_Not_Leap:
	li $t3,29                        # t3=28
	beq $t2,$t3, FalseDate
	j TrueDate
TrueDate:
	li $v1,1                         # v0=1->true
	j CheckDayExit
FalseDate:
	li $v1,0                      # v0=0->false
	j CheckDayExit
CheckDayExit:
	lw $ra, 12($sp)
	lw $t4, 8($sp)
	lw $t2, 4($sp)
	lw $t1, 0($sp)
	
	addi $sp,$sp,16
	jr $ra	
