				.data

choice:			.word 		0
result:			.word 		0

TIME:			.space		12			# 3 * (4 bytes) <--> three memory words (blocks) to store day, month and year

TIME_1:			.space		12
TIME_2:			.space		12

new_line:		.asciiz		"\n"

input_day: 		.asciiz		"Nhap ngay DAY: "
input_month: 	.asciiz		"Nhap thang MONTH: "
input_year:		.asciiz		"Nhap nam YEAR: "

intro_string: 	.asciiz		"----------Ban hay chon 1 trong cac thao tac duoi day----------\n"

first_choice:	.asciiz		"1. Xuat chuoi TIME theo dinh dang DD/MM/YYYY\n"

second_choice:	.asciiz		"2. Chuyen doi chuoi TIME thanh mot trong cac dinh dang sau:\n"
sec_choice_a:	.asciiz		"			A. MM/DD/YYYY\n"
sec_choice_b:	.asciiz		"			B. Month DD, YYYY\n"
sec_choice_c:	.asciiz		"			C. DD Month, YYYY\n"

third_choice:	.asciiz		"3. Cho biet ngay vua nhap la ngay thu may trong tuan.\n"
sub_output1_third_choice:	.asciiz 	"Ngay vua nhap la ngay thu "
sub_output2_third_choice:	.asciiz		" trong tuan.\n"

fourth_choice:	.asciiz		"4. Kiem tra nam trong chuoi TIME co phai la nam nhuan khong.\n"
output_leap_yr:	.asciiz		"Nam nhap vao la nam nhuan.\n"
output_n_lp_yr:	.asciiz		"Nam nhap vao khong phai la nam nhuan.\n"

fifth_choice:	.asciiz		"5. Cho biet khoang thoi gian giua chuoi TIME_1 va TIME_2.\n"
output1_fifth_choice:		.asciiz		"Khoang thoi gian giua hai chuoi "
and_str:					.asciiz		" va "
output3_fifth_choice:		.asciiz		" la: "

sixth_choice:	.asciiz		"6. Cho biet 2 nam nhuan gan nhat voi nam trong chuoi TIME.\n"
output1_sixth_choice:		.asciiz		"Hai nam nhuan gan nhat voi nam "
output2_sixth_choice:		.asciiz		" la: "


seventh_choice:	.asciiz		"7. Kiem tra bo du lieu dau vao khi nhap, neu du lieu khong hop le thi yeu cau nguoi dung nhap lai.\n"
output_valid_date:			.asciiz		"Bo du lieu nhap vao hop le.\n"
output_invalid_date:		.asciiz		"Bo du lieu nhap vao khong hop le.\n"

input_choice:	.asciiz		"			Lua chon: "
invalid_choice:	.asciiz		"Lua chon khong hop le. Vui long nhap lai.\n"

output_result:	.asciiz		"			Ket qua: "

				.text
main:	

print_tasks:
			li $v0, 4
			la $a0, intro_string
			syscall

			li $v0, 4
			la $a0, first_choice
			syscall			

			li $v0, 4
			la $a0, second_choice
			syscall 
			li $v0, 4
			la $a0, sec_choice_a
			syscall
			li $v0, 4
			la $a0, sec_choice_b
			syscall
			li $v0, 4
			la $a0, sec_choice_c
			syscall

			li $v0, 4
			la $a0, third_choice
			syscall

			li $v0, 4
			la $a0, fourth_choice
			syscall

			li $v0, 4
			la $a0, fifth_choice
			syscall

			li $v0, 4
			la $a0, sixth_choice
			syscall			

			li $v0, 4
			la $a0, seventh_choice
			syscall

get_task:
			li $v0, 4
			la $a0, input_choice
			syscall

			li $v0, 5
			syscall
			# Whats about task 2?

			sw $v0, choice 		# Save user's input into choice variable

perform_equivalent_request:
							# Switch case statement
							# Reference: Kien_truc_bo_lenh_mips.pdf
							lw $a1, choice

							ble $a1, $0, report_invalid_input		# Check if choice < 0

							addi, $t0, $0, 7
							bgt $a1, $t0, report_invalid_input		# Check if choice > 7

							j print_string_in_ddmmyyyy_format
print_string_in_ddmmyyyy_format:
								addi $t0, $a1, -1
								bne $t0, $0, print 
								# To be continued...
report_invalid_input:
						li $v0, 4
						la $a0, invalid_choice
						syscall
						j get_task

exit:
			li $v0, 10
			syscall			