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
monday:						.asciiz		" la thu hai\n"
tuesday:					.asciiz		" la thu ba\n"
wednesday:					.asciiz		" la thu tu\n"
thursday:					.asciiz		" la thu nam\n"
friday:						.asciiz		" la thu sau\n"
saturday:					.asciiz		" la thu bay\n"
sunday:						.asciiz		" la chu nhat\n"

fifth_choice:	.asciiz		"5. Cho biet ngay vua nhap la ngay thu may ke tu ngay 1/1/1.\n"
sub_fifth_choice:			.asciiz		"Ngay vua nhap la ngay thu "

sixth_choice:	.asciiz		"6. Cho biet can chi cua nam vua nhap.\n"
output_can_chi:				.asciiz		" la nam "

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
#Dat###################################################################################################
	day:	.space 1024
	month:	.space 1024
	year:	.space 1024
	option:	.space	4
	comma:	.word	','
	slash:	.word	'/'
	space:	.word	' '
	MM_1:	.asciiz	"01"
	MM_2:	.asciiz	"02"
	MM_3:	.asciiz	"03"
	MM_4:	.asciiz	"04"
	MM_5:	.asciiz	"05"
	MM_6:	.asciiz	"06"
	MM_7:	.asciiz	"07"
	MM_8:	.asciiz	"08"
	MM_9:	.asciiz	"09"
	MM_10:	.asciiz	"10"
	MM_11:	.asciiz	"11"
	MM_12:	.asciiz	"12"
	Month_1:	.asciiz	"January"
	Month_2:	.asciiz	"Febuaray"
	Month_3:	.asciiz	"March"
	Month_4:	.asciiz	"April"
	Month_5:	.asciiz	"May"
	Month_6:	.asciiz	"June"
	Month_7:	.asciiz	"July"
	Month_8:	.asciiz	"August"
	Month_9:	.asciiz	"September"
	Month_10:	.asciiz	"October"
	Month_11:	.asciiz	"November"
	Month_12:	.asciiz	"December"
	ntf_2:	.asciiz	"Chuyen chuoi thanh 1 trong cac dinh dang sau:\n\tA. MM/DD/YYYY\n\tB. Month DD, YYYY\n\tC. DD Month, YYYY\n"

##############################################################################

				.text
main:			
		jal get_input
		move $a3,$v1
		beq $v1,$0,output_invalid_input     # checkday
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
					jal convert_format_time
					li $v0, 4
					syscall

					j exit

execute_task_third:
					addi $t3, $t2, -3
					bne $t3, $zero, execute_task_fourth
					
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
					
					la $a0,TIME
					li $v0, 4 # output dd/mm/yyyy
					syscall
					
					jal Weekday
					move $a0, $v0
					li $v0, 4
					syscall
					
					j exit	
					
execute_task_fifth:
					addi $t3, $t2, -5
					bne $t3, $0, execute_task_sixth
					jal NumberDay
					move $t0,$v0
					li $v0,1
					la $a0,($t0)
					syscall

					j exit
# Arguments: $a0: char* TIME
#			 $a2: can array
#            $a1: chi array
execute_task_sixth:
					addi $t3, $t2, -6
					bne $t3, $0, execute_task_seventh

					addi $sp, $sp, -20
					sw $s0, ($sp)
					sw $a0, 4($sp)
					sw $v0, 8($sp)
					sw $s6, 12($sp)
					sw $s7, 16($sp)

					# 6th choice #
					jal Year
					move $s0, $v0		# Store result into $s0

					li $v0, 1
					move $a0, $s0
					syscall

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
					move $s0, $a0

					li $v0, 4
					la $a0, output_can_chi
					syscall

					li $v0, 4
					move $a0, $s0
					syscall

					sw $s0, ($sp)
					sw $a0, 4($sp)
					sw $v0, 8($sp)
					sw $s6, 12($sp)
					sw $s7, 16($sp)
					addi $sp, $sp, 20

					j exit

execute_task_seventh:
					addi $t3, $t2, -7
					bne $t3, $0, execute_task_eighth
					jal GetTime
					move $t0,$v0
					li $v0,1
					la $a0,($t0)
					syscall

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
output_invalid_input:   #checkday
					li $v0,4
					la $a0,	invalid_input  # output 
					syscall
					j exit	
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
	sw $s0, 4($sp)
	sw $t0, 8($sp)

	move $s0, $a0
	li $v0, 0
atoi_loop:
	lb $t0, ($s0)
	beq $t0, 10, atoi_finish
	beq $t0, 0, atoi_finish
	beq $t0, 47, atoi_finish
		
	mul $v0, $v0, 10
	addi $t0, $t0, -48	
	add $v0, $v0, $t0
	addi $s0, $s0, 1
	j atoi_loop
atoi_finish:
	#Restore
	lw $ra, ($sp)
	lw $s0, 4($sp)
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
	addi $s1, $s1, 48	# Convert into char: char = int + '0' (48)
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
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal atoi
Day_finish:
			lw $ra, 0($sp)
			addi $sp, $sp, 4

			jr $ra

# Argument: $a0 char *TIME
# Return:	$v0
Month:
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a0, 4($sp)

	addi $a0, $a0, 3
	jal atoi
Month_finish:
			lw $ra, 0($sp)
			lw $a0, 4($sp)
			addi $sp, $sp, 8

			jr $ra

# Argument: $a0: char* TIME
# Return: $v1
Year:
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a0, 4($sp)

	addi $a0, $a0, 6
	jal atoi
Year_finish:
			lw $ra, 0($sp)
			lw $a0, 4($sp)
			addi $sp, $sp, 8

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
	#input $a0 TIME
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
	

	li $t3, 3
	slt $t3,$t1,$t3          # month<3
	beq $t3,$0, XacDinhThu   # month>3 ->XacDinhThu
	addi $t1,$t1,12          # month=month+12  
	li $t3,1
	sub $t2,$t2,$t3	         # year=year-1
XacDinhThu:
	move $s0,$t0               # s0=day
	
	li,$t3,2
	mult $t1,$t3               # month*2
	mflo $t4                   # t4=month*2
	add $s0,$s0, $t4           # s0= day+month*2
	addi $t1,$t1,1             # month+1
	li $t3,3
	mult $t1,$t3               # 3*(month+1)
	mflo $t1                   # t1=3*(month+1)
	li $t3,5
	div $t1,$t3                # 3*(month+1) div 5
	mflo $t1                   # t1=3*(month+1)div 5
	
	
	add $s0,$s0, $t1           # s0=day+month+3*(month+1)div 5
	
	add $s0,$s0,$t2            # s0=day+month+3*(month+1)div 5+ year
	
	li $t3, 4
	div $t2,$t3                # year div 4
	mflo $t2                   # t2=year div 4
	
	add $s0,$s0,$t2            # s0=day+month+3*(month+1)div 5+ year+ year div 4
	
	
	li $t3, 7
	div $s0, $t3               # s0 mod 7 
	mfhi $s0                   # s0=s0/7
	
	
	
	li $t3,0
	beq $s0,$t3, sun
	li $t3,1
	beq $s0,$t3, mon
	li $t3,2
	beq $s0,$t3, tue
	li $t3,3
	beq $s0,$t3, wed
	li $t3,4
	beq $s0,$t3, thurs
	li $t3,5
	beq $s0,$t3, fri
	li $t3,6
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
#Dat###################################################################################################################
#LIST FUNCTIONS:
#	+ fill_blank_string(): fill blank string
#	+ atoi():	convert string to int
#	+ convert_MM_to_Month():	convert MM to Month
#	+ push_string_to_string(): str1 = str1 + str2
#	+ convert_format_string(): FEATURE 2 OF PROJECT



#Function to fill blank string
#INPUT:	$a0: save address of string need to fill blank
#OUTPUT:	$a0: save address of string after filling blank
fill_blank_string:
	#Backup
	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $a0, 4($sp)
	sw $t0, 8($sp)
	#Loop fill '\0'
	fill_blank_string.loop:
	lb $t0, ($a0)
	beq $t0, '\n', fill_blank_string.exit
	beq $t0, '\0', fill_blank_string.exit
	li $t0, 0
	sb $t0, ($a0)
	addi $a0, $a0, 1
	j fill_blank_string.loop
	#Exit loop
	fill_blank_string.exit:
	#Restore
	lw $ra, ($sp)
	lw $a0, 4($sp)
	lw $t0, 8($sp)
	addi $sp, $sp, 12
	#Back
	jr $ra
#End function fill_blank_string()


#Function to convert string to number
#INPUT: $a0: save address of string
#OUTPUT: $v0: save value into int
atoi_D:
#Backup
	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $a0, 4($sp)
	sw $t0, 8($sp)
	li $v0, 0
atoi_loop_D:
	
	lb $t0, ($a0)
	beq $t0, '\n', atoi_finish
	beq $t0, '\0', atoi_finish
		
	mul $v0, $v0, 10
	addi $t0, $t0, -48	
	add $v0, $v0, $t0
	addi $a0, $a0, 1
	j atoi_loop_D
atoi_finish_D:
	#Restore
	lw $ra, ($sp)
	lw $a0, 4($sp)
	lw $t0, 8($sp)
	addi $sp, $sp, 12
	jr $ra
#End function atoi()


#Convert string month "DD" format to "Month" format
#INUPPUT:	$a0: save address of string month
#OUTPUT:	$a0: save address of string month after convert
convert_MM_to_Month:
	#Backup
	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $a0, 4($sp)
	sw $t0, 8($sp)
	#Covert string month to int
	la $a0, month
	jal atoi_D
	#Empty string month before call function push_string_to_string()
	la $a0, month
	jal fill_blank_string
	#Branch month value to convert
	beq $v0, 1, convert_MM_to_Month.convert_01
	beq $v0, 2, convert_MM_to_Month.convert_02
	beq $v0, 3, convert_MM_to_Month.convert_03
	beq $v0, 4, convert_MM_to_Month.convert_04
	beq $v0, 5, convert_MM_to_Month.convert_05
	beq $v0, 6, convert_MM_to_Month.convert_06
	beq $v0, 7, convert_MM_to_Month.convert_07
	beq $v0, 8, convert_MM_to_Month.convert_08
	beq $v0, 9, convert_MM_to_Month.convert_09
	beq $v0, 10, convert_MM_to_Month.convert_10
	beq $v0, 11, convert_MM_to_Month.convert_11
	beq $v0, 12, convert_MM_to_Month.convert_12
	convert_MM_to_Month.convert_01:
		la $a1, Month_1
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_02:
		la $a1, Month_2
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_03:
		la $a1, Month_3
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_04:
		la $a1, Month_4
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_05:
		la $a1, Month_5
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_06:
		la $a1, Month_6
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_07:
		la $a1, Month_7
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_08:
		la $a1, Month_8
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_09:
		la $a1, Month_9
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_10:
		la $a1, Month_10
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_11:
		la $a1, Month_11
		j convert_MM_to_Month.exit
	convert_MM_to_Month.convert_12:
		la $a1, Month_12
		j convert_MM_to_Month.exit
	convert_MM_to_Month.exit:
	jal push_string_to_string
	#Restore
	lw $ra, ($sp)
	lw $a0, 4($sp)
	lw $t0, 8($sp)
	addi $sp, $sp, 12
	#Back
	jr $ra
#End function convert_MM_to_Month()
	
	
#Pushing string 2 to end-of-line of string 1	(Code C: str1 = str1 + str2)
#INPUT:
#	$a0 save address of string 1
#	$a1 save address of string 2
#OUTPUT:	$a0 save address of string 1 after pushing string 2
push_string_to_string:
	#Backup
	addi $sp, $sp, -12
	sw $ra, ($sp)
	sw $a0, 4($sp)
	sw $t0, 8($sp)
	#Moving index of string 1 to end-of-line
	push_string_to_string.string1.moveEOL.loop:
	lb $t0, ($a0)
	beq $t0, '\0', push_string_to_string.string1.moveEOL.exit
	beq $t0, '\n', push_string_to_string.string1.moveEOL.exit
	addi $a0, $a0, 1	#Increase index
	j push_string_to_string.string1.moveEOL.loop
	push_string_to_string.string1.moveEOL.exit:
	#Pushing 
	push_string_to_string.string2.push.loop:
	lb $t0, ($a1)
	beq $t0, '\0', push_string_to_string.string2.push.exit
	beq $t0, '\n', push_string_to_string.string2.push.exit
	sb $t0, ($a0)	#push letter
	addi $a0, $a0, 1	# address str_1 ++
	addi $a1, $a1, 1	# address str_2 ++
	j push_string_to_string.string2.push.loop
	push_string_to_string.string2.push.exit:
	#Restore
	lw $ra, ($sp)
	lw $a0, 4($sp)
	lw $t0, 8($sp)
	addi $sp, $sp, 12
	#Back
	jr $ra
#End function push_string_to_string()


#Function to format string time
#INPUT: $a0: save address of string time
#OUTPUT: $a0: save address of string time after coverting
convert_format_time:
	#Backup
	addi $sp, $sp, -16
	sw $ra, ($sp)
	sw $t0, 4($sp)
	sw $a0, 8($sp)
	sw $a1, 12($sp)
	#Get day string (to string 'day')
	lb $t0, ($a0)
	sb $t0, day+0
	lb $t0, 1($a0)
	sb $t0, day+1
	li $t0, '\n'
	sb $t0, day+2
	#Get month string (to string 'month')
	lb $t0, 3($a0)
	sb $t0, month+0
	lb $t0, 4($a0)
	sb $t0, month+1
	li $t0, '\n'
	sb $t0, month+2
	#Get year string (to string 'year')
	lb $t0, 6($a0)
	sb $t0, year+0
	lb $t0, 7($a0)
	sb $t0, year+1
	lb $t0, 8($a0)
	sb $t0, year+2
	lb $t0, 9($a0)
	sb $t0, year+3
	li $t0, '\n'
	sb $t0, year+4
	#Show notification of feature 2
	li $v0, 4
	la $a0, ntf_2
	syscall
	#Read option convert
	li $v0, 8
	la $a0, option
	la $a1, 4
	syscall
	#Branch option format
	lb $t0, option
	beq $t0, 'A', convert_format_time.format_A
	beq $t0, 'B', convert_format_time.format_B
	beq $t0, 'C', convert_format_time.format_C
	#Convert to format A
	convert_format_time.format_A:
		la $a0, TIME
		jal fill_blank_string
		la $a1, month
		jal push_string_to_string
		la $a1, slash
		jal push_string_to_string
		la $a1, day
		jal push_string_to_string
		la $a1, slash
		jal push_string_to_string
		la $a1, year
		jal push_string_to_string
		#Exit
		j convert_format_time.exit
	#Convert to format B
	convert_format_time.format_B:
		la $a0, month
		jal convert_MM_to_Month
		move $a1, $a0
		la $a0, TIME
		jal fill_blank_string
		jal push_string_to_string
		la $a1, space
		jal push_string_to_string
		la $a1, day
		jal push_string_to_string
		la $a1, comma
		jal push_string_to_string
		la $a1, space
		jal push_string_to_string
		la $a1, year
		jal push_string_to_string
		#Exit
		j convert_format_time.exit
	#Convert to format C
	convert_format_time.format_C:
		la $a0, TIME
		jal fill_blank_string
		la $a1, day
		jal push_string_to_string
		la $a1, space
		jal push_string_to_string
		la $a0, month
		jal convert_MM_to_Month
		move $a1, $a0
		la $a0, TIME
		jal push_string_to_string
		la $a1, comma
		jal push_string_to_string
		la $a1, space
		jal push_string_to_string
		la $a1, year
		jal push_string_to_string
		#Exit
		j convert_format_time.exit
	#Exit function convert_format_time()
	convert_format_time.exit:
	#Restore
	lw $ra, ($sp)
	lw $t0, 4($sp)
	lw $a0, 8($sp)
	lw $a1, 12($sp)
	addi $sp, $sp, 16
	#Back
	jr $ra
#End function convert_format_time()
##############################################################################################
#Dong########################################################################################
Convert_Time_To_DMY:
	#backup
	addi $sp,$sp,-4
	sw $ra,($sp)
	#Get day string (to string 'day')
	lb $t6, ($a0)
	sb $t6, day+0
	lb $t6, 1($a0)
	sb $t6, day+1
	li $t6, '\n'
	sb $t6, day+2
	
	#Get month string (to string 'month')
	lb $t6, 3($a0)
	sb $t6, month+0
	lb $t6, 4($a0)
	sb $t6, month+1
	li $t6, '\n'
	sb $t6, month+2
	
	#Get year string (to string 'year')
	lb $t6, 6($a0)
	sb $t6, year+0
	lb $t6, 7($a0)
	sb $t6, year+1
	lb $t6, 8($a0)
	sb $t6, year+2
	lb $t6, 9($a0)
	sb $t6, year+3
	li $t6, '\n'
	sb $t6, year+4
Convert_Time_To_DMY.Exit:
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
DMY_To_Int:
	#Retore s0=day(int),s1=month(int),s2(year)
	#backup
	addi $sp,$sp,-4
	sw $ra,($sp)
	
	la $a0,day
	jal atoi_D
	move $s0,$v0
	
	la $a0,month
	jal atoi_D
	move $s1,$v0
	
	la $a0,year
	jal atoi_D
	move $s2,$v0
DMY.Exit:
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
	
#End function atoi()
NumberDay:
#Input a0<-TIME
#Output SoNgay t? 1/1/1
	#backup
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $t0,16($sp)
	sw $t4,20($sp)
	sw $t5,24($sp)
	sw $t6,28($sp)
	jal Convert_Time_To_DMY
	jal DMY_To_Int
	

	bge $s1,3,NumberDay.Do #thang >=3
	addi $s2,$s2,-1
	addi $s1,$s1,12 
	NumberDay.Do:
	li $t5,365
	mul $t0,$s2,$t5 #t0=year *365
	mflo $t0
	li $t5,4
	div $s2,$t5 #year/4
	mflo $t1 #t1=year/4
	li $t5,100
	div $s2,$t5
	mflo $t2 #t2=year/100
	li $t5,400
	div $s2,$t5
	mflo $t3 #t3=year/400
	li $t5,153
	mul $s1,$s1,$t5
	mflo $s1
	subi $t4,$s1,457
	li $t5,5
	div $t4,$t5
	mflo $t4 #t4=(153*month-457)/5
	####Tong ngay
	add $t0,$t0,$t1
	sub $t0,$t0,$t2
	add $t0,$t0,$t3
	add $t0,$t0,$t4
	add $t0,$t0,$s0 
	subi $t0,$t0,306
	addi $t0,$t0,-1	
	move $v0,$t0
	j NumberDay.Exit
	#exit
	NumberDay.Exit:
	lw $t4,20($sp)
	lw $t5,24($sp)
	lw $t6,28($sp)
	lw $t0,16($sp)	
	lw $s0,12($sp)
	lw $s1,8($sp)
	lw $s2,4($sp)
	lw $ra,($sp)
	addi $sp,$sp,32
	jr $ra
	
GetTime:
	#backup
	addi $sp,$sp,-16
	sw $ra,($sp)
	sw $a0,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	
	jal NumberDay
	move $t0,$v0
	
	jal get_input
	la $a0,TIME
	jal NumberDay
	move $t1,$v0
	
	sub $v0,$t1,$t0
	
	GetTime.Exit:
	lw $ra,($sp)
	lw $a0,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)
	addi $sp,$sp,16
	jr $ra
	
#############################################################################################
