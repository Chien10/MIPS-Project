.data

TIME:			.space		1024	# Maximum is 10, but there'll be some error if I just use 10!
TIME_1:			.space 		1024
TIME_2:			.space		1024
TEMP:			.space		1024

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
const1: 					.float 2.6
const2: 					.float 0.2

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
			la $a1, TEMP 		# To store day, month and year before combining them into TIME
			jal get_time_from_keyboard
			add $a3, $0, $v1	# Assign return value to $a3
			
			# check if input is valid #

			jal print_tasks
			
get_choice:
			li $v0, 4
			la $a0, input_choice
			syscall

			# Get choice in int type
			li $v0, 5
			syscall
			move $t0, $v0
			# Switch case structure
			# Ref: References/Kien_truc_bo_lenh_MIPS.pdf
			addi $t1, $0, 1
			bne $t0, $t1, execute_task_second
# Argument: $a3: char* TIME
execute_task_first:
					move $a0, $a3
					li $v0, 4
					syscall

					j exit
# Argument
execute_task_second:
					addi $t2, $t0, -2
					bne $t2, $zero, execute_task_third
					j exit

					
execute_task_third:
# input $a3 TIME
# output information
					addi $t2, $t0, -3
					bne $t2, $zero, execute_task_fourth
					move $a0,$a3  #TIME
	
					jal CheckLeapYear
					li $t0,1
					beq $t0,$v1, Leap  #  t0=v1->Leap
	
	 				#  t0!=v1->output
					li $v0,4          
					la $a0, output_n_lp_yr
					syscall
					j exit
Leap:
					li, $v0,4
					la,$a0, output_leap_yr
					syscall
					j exit

execute_task_fourth:
# input $a3 TIME
# output weekday
					addi $t2, $t0, -4
					bne $t2, $0, execute_task_fifth
					move $a0,$a3 #TIME
					jal Weekday
					move $a0, $v0
					li $v0, 4
					syscall
					j exit

execute_task_fifth:
					addi $t2, $t0, -5
					bne $t2, $0, execute_task_sixth

					j exit
# Arguments: $a3: char* TIME
#			 $a2: can array
#            $a1: chi array
# Return : $v0: can, $v1: chi
execute_task_sixth:
					addi $t2, $t0, -6
					bne $t2, $zero, execute_task_seventh

					# 6th choice #
					addi $sp, $sp, -4
					sw $ra, 0($sp)

					move $a0, $a3
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

					add $a2, $a2, $s7
					
					move $v0, $a2		# Store pointer of can into $v0

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

					add $v1, $0, $a1
		
					lw $ra, 0($sp)
					addi $sp, $sp, 4

					jr $ra

					j exit

execute_task_seventh:
					addi $t2, $t0, -7
					bne $t2, $0, execute_task_eighth

					j exit

execute_task_eighth:
# input $a0(TIME)
# output $a0
					addi $t2, $t0, -8
					bne $t2, $0, execute_task_ninth
					move $a0,$a3 #TIME
	
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
					j LeapNext

LeapNext:
					move $t1, $a0  # t0=nam(t0=2016)
	
					#output "Hai nam nhuan gan nhat la "
					li $v0,4
					la $a0, sub_eighth_choice1  
					syscall
	
	
					addi $a0,$t1,4  # year+4
					li $v0,1
					syscall
	
	
					move $t1,$a0    # t1=a0
	
					li $v0,4
					la $a0, sub_eighth_choice2  # output "và"
					syscall
	
					addi $a0, $t1,4 # year+4
					li $v0,1
					syscall
	
					j exit
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
#			$t1: .space day
# 			$t2: .space month
#			$t3: .space year
# Return value:	$v1 points to TIME(char*)
get_time_from_keyboard:
						addi $sp, $sp, -24
						sw $ra, 0($sp)	# Store the address of the next line of: jal get_time_from_keyboard
						sw $a0, 4($sp)	# Address of TIME
						sw $a1, 8($sp)	# Address of TEMP
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
						# Check if input is a digit-string
						jal contains_only_digits
						# Convert month from char into int
						li $a3, 10
						jal atoi
						# Store day (int type) into stack
						sw $v1, 12($sp)		

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
						jal contains_only_digits
						# Convert month from char into int and store into stack
						li $a3, 10
						jal atoi
						
						sw $v1, 16($sp)	

						# Get year
						li $v0, 4
						la $a0, input_year
						syscall
					
						li $v0, 8		
						lw $a0, 8($sp)	
						li $a1, 1024		
						syscall

						jal contains_only_digits
						# Convert and store for year
						li $a3, 10
						jal atoi
						
						sw $v1, 20($sp)	

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
							
							addi $sp, $sp, 20

							jr $ra

# Compute length of input string and raise error if the number of elements exceed a given value
# Arguments:	$a0: input from keyboard
#				$a3: maximum number of characters
compute_string_length:
						add $t0, $0, $a0		# $t0 points to $a0 containing input string
						add $a2, $zero, $a3
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
					beq $t1, $0, raise_invalid_input
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
			la $a0, ninth_choice
			syscall

			jr $ra

# Arguments: 
#			day: int    -> $a1
#			month: int  -> $a2
#			year: int   -> $a3
#			TIME: char* -> $a0
# Return value: $v1
Date:
	move $v1, $a0
	addi $s3, $0, 47	# 47 is '/' in ASCII

	# Let put day ... lazily into TIME
	move $s1, $a1

	addi $s2, $0, 10
	div $s1, $s2
	mflo $s1 		# quotient
	addi $s1, $s1, 48	# Convert into integer: int = char + '0' (48)
	mfhi $s2 		# remainder
	addi $s2, $s2, 48
	
	sb $s1, 0($v1)	# TIME[0] = $s1
	sb $s2, 1($v1)
	sb $s3, 2($v1)
	
	# Put month
	move $s1, $a2

	addi $s2, $0, 10
	div $s1, $s2
	mflo $s1 		
	addi $s1, $s1, 48
	mfhi $s2 		
	addi $s2, $s2, 48

	sb $s1, 3($v1)	
	sb $s2, 4($v1)
	sb $s3, 5($v1)

	# Put year (lazily!)
	move $s1, $a3

	addi $s2, $0, 1000			
	div $s1, $s2 				
	mflo $s3						
	addi $s3, $s3, 48	
	mfhi $s1			

	sb $s3, 6($v1)		

	addi $s2, $zero, 100
	div $s1, $s2
	mflo $s3		
	addi $s3, $s3, 48
	mfhi $s1		

	sb $s3, 7($v1)		

	addi $s2, $0, 10
	div $s1, $s2
	mflo $s3
	addi $s3, $s3, 48
	mfhi $s1		
	addi $s1, $s1, 48

	sb $s3, 8($v1)		
	sb $s1, 9($v1)		

	sb $zero, 10($v1) # '\0' at the end of TIME_1

	jr $ra

# Argument: $a0: char* TIME, $a3: character to terminate
# Return: $v1
atoi:
		li $v1, 0	# $v1 is a result
atoi_loop:
		lb $a2, 0($a0)

		beq $a2, $a3, atoi_finish
		# Convert char into int: int = char - '0'
		addi $a2, $a2, -48	
		# $v0 = $v0 * 10
		addi $v0, $0, 10
		mult $v1, $v0
		mflo $v1
		
		add $v1, $v1, $a2

		addi $a0, $a0, 1

		j atoi_loop
atoi_finish:
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
	move $a0,$v1
	jal LeapYear
	
	#restore stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
Weekday:
	#input  TIME
	#output $v0
	addi $sp,$sp,-28   
	sw $t0, 0($sp) 
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp) 
	sw $s0, 16($sp)
	sw $a0, 20($sp)  #save time
	sw $ra, 24($sp)
	
	jal Year
	move $t2, $v1    #t2=year
	
	jal Day
	move $t0, $v1    #t0=day
	
	
	jal Month
	move $t1, $v1    #t1=month
	
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
XacDinhThu:
	move $s0,$t0               # s0=day
	li,$t3,2
	sub $t1,$t1,$t3            # m=m-2
	l.s $f0,const1             # f0=2.6
	l.s $f1,const2             # f1=0.2
	mtc1 $t1,$f2               # f2=t1
	cvt.s.w $f3,$f2            # int->float
	mul.s $f2,$f3,$f0          # 2.6*m
	sub.s $f2,$f2,$f1          # 2.6*m-0.2
	cvt.w.s $f3,$f2            # float ->int
	mfc1 $t1,$f3               # t1=2.6*m-0.2 int
	add $s0,$s0, $t1           # s0=(2.6*m-0.2)+d
	
	li $t3, 100
	div $t2,$t3                # nam/100
	mflo $t0                   # First 2 digits
	mfhi $t1                   # Last 2 digits
	add $s0,$s0,$t1            # s0=(2.6*m-0.2)+d+y
	
	
	li $t3, 4
	div $t1, $t3               # ydiv4
	mflo $t1                   # lo
	div $t0,$t3                # cdiv4
	mflo $t0                   # lo
	add $s0,$s0,$t1            # s0=(2.6*m-0.2)+d+ydiv4+y
	add $s0,$s0,$t0            # s0=(2.6*m-0.2)+d+ydiv4+y+cdiv4
	
	
	
	li $t3, 100
	div $t2,$t3                # nam/100
	mflo $t0                   # lo
	li $t3,2
	mult $t0,$t3               # 2*c
	mflo $t0
	sub $s0,$s0,$t0            # s0=(2.6*m-0.2)+d+ydiv4+cdiv4+y-2*c
	
	
	j FOR
	li $s1,0
FOR:
	slt $t3,$s0,$s1
	beq $t3,$0, Stop
	addi $s0,$s0,7
	j FOR
Stop:	
	
	li $t3,7
	div $s0,$t3
	mfhi $s0                   # s0=((2.6*m-0.2)+d+ydiv4+cdiv4+y-2*c)mod 7
	
	
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
	lw $t0, 0($sp) 
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	lw $t3, 12($sp) 
	lw $s0, 16($sp)
	lw $a3, 20($sp) 
	lw $ra, 24($sp)	
	
	addi $sp,$sp,28
	
	jr $ra	
	
