# mark_description "Intel(R) C Intel(R) 64 Compiler Classic for applications running on Intel(R) 64, Version 2021.5.0 Build 2021";
# mark_description "1109_000000";
# mark_description "-O0 -S";
	.file "bs1.cpp"
	.section .text._ZNSt11char_traitsIcE6lengthEPKc, "xaG",@progbits,_ZNSt11char_traitsIcE6lengthEPKc,comdat
..TXTST0:
.L_2__routine_start__ZNSt11char_traitsIcE6lengthEPKc_0:
# -- Begin  _ZNSt11char_traitsIcE6lengthEPKc
	.section .text._ZNSt11char_traitsIcE6lengthEPKc, "xaG",@progbits,_ZNSt11char_traitsIcE6lengthEPKc,comdat
# mark_begin;
       .align    2,0x90
	.weak _ZNSt11char_traitsIcE6lengthEPKc
# --- std::char_traits<char>::length(const std::char_traits<char>::char_type *)
_ZNSt11char_traitsIcE6lengthEPKc:
# parameter 1: %rdi
..B1.1:                         # Preds ..B1.0
                                # Execution count [0.00e+00]
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
..___tag_value__ZNSt11char_traitsIcE6lengthEPKc.1:
..L2:
                                                          #324.7
        pushq     %rbp                                          #324.7
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #324.7
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        subq      $16, %rsp                                     #324.7
        movq      %rdi, -16(%rbp)                               #324.7
        movq      -16(%rbp), %rax                               #329.9
        movq      %rax, %rcx                                    #329.9
        xorl      %eax, %eax                                    #329.9
..L7:                                                           #
        movzbl    (%rcx,%rax), %edx                             #329.9
        testl     %edx, %edx                                    #329.9
        je        ..L6          # Prob 50%                      #329.9
        movzbl    1(%rcx,%rax), %edx                            #329.9
        addq      $2, %rax                                      #329.9
        testl     %edx, %edx                                    #329.9
        jne       ..L7          # Prob 50%                      #329.9
        decq      %rax                                          #329.9
..L6:                                                           #
                                # LOE rax rbx rbp rsp r12 r13 r14 r15 rip
..B1.4:                         # Preds ..B1.1
                                # Execution count [0.00e+00]
        movq      %rax, -8(%rbp)                                #329.9
        movq      -8(%rbp), %rax                                #329.9
        leave                                                   #329.9
	.cfi_restore 6
        ret                                                     #329.9
        .align    2,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	_ZNSt11char_traitsIcE6lengthEPKc,@function
	.size	_ZNSt11char_traitsIcE6lengthEPKc,.-_ZNSt11char_traitsIcE6lengthEPKc
..LN_ZNSt11char_traitsIcE6lengthEPKc.0:
	.data
# -- End  _ZNSt11char_traitsIcE6lengthEPKc
	.section .text._ZNKSt5ctypeIcE5widenEc, "xaG",@progbits,_ZNKSt5ctypeIcE5widenEc,comdat
..TXTST1:
.L_2__routine_start__ZNKSt5ctypeIcE5widenEc_1:
# -- Begin  _ZNKSt5ctypeIcE5widenEc
	.section .text._ZNKSt5ctypeIcE5widenEc, "xaG",@progbits,_ZNKSt5ctypeIcE5widenEc,comdat
# mark_begin;
       .align    2,0x90
	.weak _ZNKSt5ctypeIcE5widenEc
# --- std::ctype<char>::widen(const std::ctype<char> *, char) const
_ZNKSt5ctypeIcE5widenEc:
# parameter 1: %rdi
# parameter 2: %esi
..B2.1:                         # Preds ..B2.0
                                # Execution count [0.00e+00]
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
..___tag_value__ZNKSt5ctypeIcE5widenEc.10:
..L11:
                                                         #873.7
        pushq     %rbp                                          #873.7
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #873.7
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        subq      $32, %rsp                                     #873.7
        movq      %rdi, -24(%rbp)                               #873.7
        movb      %sil, -16(%rbp)                               #873.7
        movq      -24(%rbp), %rax                               #874.6
        movsbl    56(%rax), %eax                                #874.6
        movsbq    %al, %rax                                     #874.6
        testl     %eax, %eax                                    #874.6
        je        ..B2.3        # Prob 50%                      #874.6
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B2.2:                         # Preds ..B2.1
                                # Execution count [0.00e+00]
        movsbl    -16(%rbp), %eax                               #875.47
        movsbq    %al, %rax                                     #875.47
        movzbl    %al, %eax                                     #875.11
        addq      -24(%rbp), %rax                               #875.11
        addq      $57, %rax                                     #875.11
        movsbl    (%rax), %eax                                  #875.11
        leave                                                   #875.11
	.cfi_restore 6
        ret                                                     #875.11
	.cfi_offset 6, -16
                                # LOE
..B2.3:                         # Preds ..B2.1
                                # Execution count [0.00e+00]
        movq      -24(%rbp), %rax                               #876.8
        movq      %rax, %rdi                                    #876.8
..___tag_value__ZNKSt5ctypeIcE5widenEc.17:
        call      _ZNKSt5ctypeIcE13_M_widen_initEv              #876.8
..___tag_value__ZNKSt5ctypeIcE5widenEc.18:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B2.4:                         # Preds ..B2.3
                                # Execution count [0.00e+00]
        movq      -24(%rbp), %rax                               #877.24
        movl      $6, %edx                                      #877.24
        movslq    %edx, %rdx                                    #877.24
        imulq     $8, %rdx, %rdx                                #877.24
        addq      (%rax), %rdx                                  #877.24
        movq      (%rdx), %rax                                  #877.24
        movq      -24(%rbp), %rdx                               #877.24
        movsbl    -16(%rbp), %ecx                               #877.24
        movq      %rdx, %rdi                                    #877.24
        movl      %ecx, %esi                                    #877.24
..___tag_value__ZNKSt5ctypeIcE5widenEc.19:
        call      *%rax                                         #877.24
..___tag_value__ZNKSt5ctypeIcE5widenEc.20:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip eax
..B2.8:                         # Preds ..B2.4
                                # Execution count [0.00e+00]
        movb      %al, -32(%rbp)                                #877.24
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B2.5:                         # Preds ..B2.8
                                # Execution count [0.00e+00]
        movsbl    -32(%rbp), %eax                               #877.24
        leave                                                   #877.24
	.cfi_restore 6
        ret                                                     #877.24
        .align    2,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	_ZNKSt5ctypeIcE5widenEc,@function
	.size	_ZNKSt5ctypeIcE5widenEc,.-_ZNKSt5ctypeIcE5widenEc
..LN_ZNKSt5ctypeIcE5widenEc.1:
	.data
# -- End  _ZNKSt5ctypeIcE5widenEc
	.section .text._ZNKSt6chrono8durationIlSt5ratioILl1ELl1000000000EEE5countEv, "xaG",@progbits,_ZNKSt6chrono8durationIlSt5ratioILl1ELl1000000000EEE5countEv,comdat
..TXTST2:
.L_2__routine_start__ZNKSt6chrono8durationIlSt5ratioILl1ELl1000000000EEE5countEv_2:
# -- Begin  _ZNKSt6chrono8durationIlSt5ratioILl1ELl1000000000EEE5countEv
	.section .text._ZNKSt6chrono8durationIlSt5ratioILl1ELl1000000000EEE5countEv, "xaG",@progbits,_ZNKSt6chrono8durationIlSt5ratioILl1ELl1000000000EEE5countEv,comdat
# mark_begin;
       .align    2,0x90
	.weak _ZNKSt6chrono8durationIlSt5ratioILl1ELl1000000000EEE5countEv
# --- std::chrono::duration<int64_t, std::nano>::count(const std::chrono::duration<int64_t, std::nano> *) const
_ZNKSt6chrono8durationIlSt5ratioILl1ELl1000000000EEE5countEv:
# parameter 1: %rdi
..B3.1:                         # Preds ..B3.0
                                # Execution count [0.00e+00]
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
..___tag_value__ZNKSt6chrono8durationIlSt5ratioILl1ELl1000000000EEE5countEv.23:
..L24:
                                                         #349.2
        pushq     %rbp                                          #349.2
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #349.2
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        subq      $16, %rsp                                     #349.2
        movq      %rdi, -16(%rbp)                               #349.2
        movq      -16(%rbp), %rax                               #349.11
        movq      (%rax), %rax                                  #349.11
        leave                                                   #349.11
	.cfi_restore 6
        ret                                                     #349.11
        .align    2,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	_ZNKSt6chrono8durationIlSt5ratioILl1ELl1000000000EEE5countEv,@function
	.size	_ZNKSt6chrono8durationIlSt5ratioILl1ELl1000000000EEE5countEv,.-_ZNKSt6chrono8durationIlSt5ratioILl1ELl1000000000EEE5countEv
..LN_ZNKSt6chrono8durationIlSt5ratioILl1ELl1000000000EEE5countEv.2:
	.data
# -- End  _ZNKSt6chrono8durationIlSt5ratioILl1ELl1000000000EEE5countEv
	.section .text._ZNSt6chrono8durationIlSt5ratioILl1ELl1000000000EEEC1IlvEERKT_, "xaG",@progbits,_ZNSt6chrono8durationIlSt5ratioILl1ELl1000000000EEEC1IlvEERKT_,comdat
..TXTST3:
.L_2__routine_start__ZNSt6chrono8durationIlSt5ratioILl1ELl1000000000EEEC1IlvEERKT__3:
# -- Begin  _ZNSt6chrono8durationIlSt5ratioILl1ELl1000000000EEEC1IlvEERKT_
	.section .text._ZNSt6chrono8durationIlSt5ratioILl1ELl1000000000EEEC1IlvEERKT_, "xaG",@progbits,_ZNSt6chrono8durationIlSt5ratioILl1ELl1000000000EEEC1IlvEERKT_,comdat
# mark_begin;
       .align    2,0x90
	.weak _ZNSt6chrono8durationIlSt5ratioILl1ELl1000000000EEEC1IlvEERKT_
# --- std::chrono::duration<int64_t, std::nano>::duration<signed long, void>(std::chrono::duration<int64_t, std::nano> *, const signed long &)
_ZNSt6chrono8durationIlSt5ratioILl1ELl1000000000EEEC1IlvEERKT_:
# parameter 1: %rdi
# parameter 2: %rsi
..B4.1:                         # Preds ..B4.0
                                # Execution count [0.00e+00]
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
..___tag_value__ZNSt6chrono8durationIlSt5ratioILl1ELl1000000000EEEC1IlvEERKT_.30:
..L31:
                                                         #334.35
        pushq     %rbp                                          #334.35
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #334.35
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        subq      $16, %rsp                                     #334.35
        movq      %rdi, -16(%rbp)                               #334.35
        movq      %rsi, -8(%rbp)                                #334.35
        movq      -8(%rbp), %rax                                #333.23
        movq      -16(%rbp), %rdx                               #333.23
        movq      (%rax), %rax                                  #333.23
        movq      %rax, (%rdx)                                  #333.23
        leave                                                   #334.37
	.cfi_restore 6
        ret                                                     #334.37
        .align    2,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	_ZNSt6chrono8durationIlSt5ratioILl1ELl1000000000EEEC1IlvEERKT_,@function
	.size	_ZNSt6chrono8durationIlSt5ratioILl1ELl1000000000EEEC1IlvEERKT_,.-_ZNSt6chrono8durationIlSt5ratioILl1ELl1000000000EEEC1IlvEERKT_
..LN_ZNSt6chrono8durationIlSt5ratioILl1ELl1000000000EEEC1IlvEERKT_.3:
	.data
# -- End  _ZNSt6chrono8durationIlSt5ratioILl1ELl1000000000EEEC1IlvEERKT_
	.section .text._ZNKSt6chrono10time_pointINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEEE16time_since_epochEv, "xaG",@progbits,_ZNKSt6chrono10time_pointINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEEE16time_since_epochEv,comdat
..TXTST4:
.L_2__routine_start__ZNKSt6chrono10time_pointINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEEE16time_since_epochEv_4:
# -- Begin  _ZNKSt6chrono10time_pointINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEEE16time_since_epochEv
	.section .text._ZNKSt6chrono10time_pointINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEEE16time_since_epochEv, "xaG",@progbits,_ZNKSt6chrono10time_pointINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEEE16time_since_epochEv,comdat
# mark_begin;
       .align    2,0x90
	.weak _ZNKSt6chrono10time_pointINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEEE16time_since_epochEv
# --- std::chrono::time_point<std::chrono::_V2::system_clock, std::chrono::_V2::system_clock::duration>::time_since_epoch(const std::chrono::time_point<std::chrono::_V2::system_clock, std::chrono::_V2::system_clock::duration> *) const
_ZNKSt6chrono10time_pointINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEEE16time_since_epochEv:
# parameter 1: %rdi
..B5.1:                         # Preds ..B5.0
                                # Execution count [0.00e+00]
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
..___tag_value__ZNKSt6chrono10time_pointINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEEE16time_since_epochEv.37:
..L38:
                                                         #640.2
        pushq     %rbp                                          #640.2
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #640.2
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        subq      $32, %rsp                                     #640.2
        movq      %rdi, -32(%rbp)                               #640.2
        movq      -32(%rbp), %rax                               #640.11
        movq      %rax, -24(%rbp)                               #640.11
        movq      -24(%rbp), %rax                               #640.11
        movq      %rax, -16(%rbp)                               #640.11
        movq      -16(%rbp), %rax                               #640.11
        movq      (%rax), %rax                                  #640.11
        movq      %rax, -8(%rbp)                                #640.4
        movq      -8(%rbp), %rax                                #640.4
        leave                                                   #640.4
	.cfi_restore 6
        ret                                                     #640.4
        .align    2,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	_ZNKSt6chrono10time_pointINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEEE16time_since_epochEv,@function
	.size	_ZNKSt6chrono10time_pointINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEEE16time_since_epochEv,.-_ZNKSt6chrono10time_pointINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEEE16time_since_epochEv
..LN_ZNKSt6chrono10time_pointINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEEE16time_since_epochEv.4:
	.data
# -- End  _ZNKSt6chrono10time_pointINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEEE16time_since_epochEv
	.section .text._ZNKSt6chrono8durationIlSt5ratioILl1ELl1000EEE5countEv, "xaG",@progbits,_ZNKSt6chrono8durationIlSt5ratioILl1ELl1000EEE5countEv,comdat
..TXTST5:
.L_2__routine_start__ZNKSt6chrono8durationIlSt5ratioILl1ELl1000EEE5countEv_5:
# -- Begin  _ZNKSt6chrono8durationIlSt5ratioILl1ELl1000EEE5countEv
	.section .text._ZNKSt6chrono8durationIlSt5ratioILl1ELl1000EEE5countEv, "xaG",@progbits,_ZNKSt6chrono8durationIlSt5ratioILl1ELl1000EEE5countEv,comdat
# mark_begin;
       .align    2,0x90
	.weak _ZNKSt6chrono8durationIlSt5ratioILl1ELl1000EEE5countEv
# --- std::chrono::duration<int64_t, std::milli>::count(const std::chrono::duration<int64_t, std::milli> *) const
_ZNKSt6chrono8durationIlSt5ratioILl1ELl1000EEE5countEv:
# parameter 1: %rdi
..B6.1:                         # Preds ..B6.0
                                # Execution count [0.00e+00]
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
..___tag_value__ZNKSt6chrono8durationIlSt5ratioILl1ELl1000EEE5countEv.44:
..L45:
                                                         #349.2
        pushq     %rbp                                          #349.2
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #349.2
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        subq      $16, %rsp                                     #349.2
        movq      %rdi, -16(%rbp)                               #349.2
        movq      -16(%rbp), %rax                               #349.11
        movq      (%rax), %rax                                  #349.11
        leave                                                   #349.11
	.cfi_restore 6
        ret                                                     #349.11
        .align    2,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	_ZNKSt6chrono8durationIlSt5ratioILl1ELl1000EEE5countEv,@function
	.size	_ZNKSt6chrono8durationIlSt5ratioILl1ELl1000EEE5countEv,.-_ZNKSt6chrono8durationIlSt5ratioILl1ELl1000EEE5countEv
..LN_ZNKSt6chrono8durationIlSt5ratioILl1ELl1000EEE5countEv.5:
	.data
# -- End  _ZNKSt6chrono8durationIlSt5ratioILl1ELl1000EEE5countEv
	.section .text._ZNSt6chrono8durationIlSt5ratioILl1ELl1000EEEC1IlvEERKT_, "xaG",@progbits,_ZNSt6chrono8durationIlSt5ratioILl1ELl1000EEEC1IlvEERKT_,comdat
..TXTST6:
.L_2__routine_start__ZNSt6chrono8durationIlSt5ratioILl1ELl1000EEEC1IlvEERKT__6:
# -- Begin  _ZNSt6chrono8durationIlSt5ratioILl1ELl1000EEEC1IlvEERKT_
	.section .text._ZNSt6chrono8durationIlSt5ratioILl1ELl1000EEEC1IlvEERKT_, "xaG",@progbits,_ZNSt6chrono8durationIlSt5ratioILl1ELl1000EEEC1IlvEERKT_,comdat
# mark_begin;
       .align    2,0x90
	.weak _ZNSt6chrono8durationIlSt5ratioILl1ELl1000EEEC1IlvEERKT_
# --- std::chrono::duration<int64_t, std::milli>::duration<std::chrono::duration<int64_t, std::milli>::rep, void>(std::chrono::duration<int64_t, std::milli> *, const std::chrono::duration<int64_t, std::milli>::rep &)
_ZNSt6chrono8durationIlSt5ratioILl1ELl1000EEEC1IlvEERKT_:
# parameter 1: %rdi
# parameter 2: %rsi
..B7.1:                         # Preds ..B7.0
                                # Execution count [0.00e+00]
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
..___tag_value__ZNSt6chrono8durationIlSt5ratioILl1ELl1000EEEC1IlvEERKT_.51:
..L52:
                                                         #334.35
        pushq     %rbp                                          #334.35
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #334.35
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        subq      $16, %rsp                                     #334.35
        movq      %rdi, -16(%rbp)                               #334.35
        movq      %rsi, -8(%rbp)                                #334.35
        movq      -8(%rbp), %rax                                #333.23
        movq      -16(%rbp), %rdx                               #333.23
        movq      (%rax), %rax                                  #333.23
        movq      %rax, (%rdx)                                  #333.23
        leave                                                   #334.37
	.cfi_restore 6
        ret                                                     #334.37
        .align    2,0x90
                                # LOE
	.cfi_endproc
# mark_end;
	.type	_ZNSt6chrono8durationIlSt5ratioILl1ELl1000EEEC1IlvEERKT_,@function
	.size	_ZNSt6chrono8durationIlSt5ratioILl1ELl1000EEEC1IlvEERKT_,.-_ZNSt6chrono8durationIlSt5ratioILl1ELl1000EEEC1IlvEERKT_
..LN_ZNSt6chrono8durationIlSt5ratioILl1ELl1000EEEC1IlvEERKT_.6:
	.data
# -- End  _ZNSt6chrono8durationIlSt5ratioILl1ELl1000EEEC1IlvEERKT_
	.section .text._ZNSt6chrono20__duration_cast_implINS_8durationIlSt5ratioILl1ELl1000EEEES2_ILl1ELl1000000EElLb1ELb0EE6__castIlS2_ILl1ELl1000000000EEEES4_RKNS1_IT_T0_EE, "xaG",@progbits,_ZNSt6chrono20__duration_cast_implINS_8durationIlSt5ratioILl1ELl1000EEEES2_ILl1ELl1000000EElLb1ELb0EE6__castIlS2_ILl1ELl1000000000EEEES4_RKNS1_IT_T0_EE,comdat
..TXTST7:
.L_2__routine_start__ZNSt6chrono20__duration_cast_implINS_8durationIlSt5ratioILl1ELl1000EEEES2_ILl1ELl1000000EElLb1ELb0EE6__castIlS2_ILl1ELl1000000000EEEES4_RKNS1_IT_T0_EE_7:
# -- Begin  _ZNSt6chrono20__duration_cast_implINS_8durationIlSt5ratioILl1ELl1000EEEES2_ILl1ELl1000000EElLb1ELb0EE6__castIlS2_ILl1ELl1000000000EEEES4_RKNS1_IT_T0_EE
	.section .text._ZNSt6chrono20__duration_cast_implINS_8durationIlSt5ratioILl1ELl1000EEEES2_ILl1ELl1000000EElLb1ELb0EE6__castIlS2_ILl1ELl1000000000EEEES4_RKNS1_IT_T0_EE, "xaG",@progbits,_ZNSt6chrono20__duration_cast_implINS_8durationIlSt5ratioILl1ELl1000EEEES2_ILl1ELl1000000EElLb1ELb0EE6__castIlS2_ILl1ELl1000000000EEEES4_RKNS1_IT_T0_EE,comdat
# mark_begin;
       .align    2,0x90
	.weak _ZNSt6chrono20__duration_cast_implINS_8durationIlSt5ratioILl1ELl1000EEEES2_ILl1ELl1000000EElLb1ELb0EE6__castIlS2_ILl1ELl1000000000EEEES4_RKNS1_IT_T0_EE
# --- std::chrono::__duration_cast_impl<std::chrono::milliseconds, std::ratio_divide<std::nano, std::chrono::duration<int64_t, std::milli>::period>, std::__success_type<signed long>::type, true, false>::__cast<int64_t, std::nano>(const std::chrono::duration<int64_t, std::nano> &)
_ZNSt6chrono20__duration_cast_implINS_8durationIlSt5ratioILl1ELl1000EEEES2_ILl1ELl1000000EElLb1ELb0EE6__castIlS2_ILl1ELl1000000000EEEES4_RKNS1_IT_T0_EE:
# parameter 1: %rdi
..B8.1:                         # Preds ..B8.0
                                # Execution count [0.00e+00]
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
..___tag_value__ZNSt6chrono20__duration_cast_implINS_8durationIlSt5ratioILl1ELl1000EEEES2_ILl1ELl1000000EElLb1ELb0EE6__castIlS2_ILl1ELl1000000000EEEES4_RKNS1_IT_T0_EE.58:
..L59:
                                                         #152.4
        pushq     %rbp                                          #152.4
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #152.4
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        subq      $48, %rsp                                     #152.4
        movq      %rdi, -48(%rbp)                               #152.4
        movq      -48(%rbp), %rax                               #155.29
        movq      %rax, %rdi                                    #155.29
..___tag_value__ZNSt6chrono20__duration_cast_implINS_8durationIlSt5ratioILl1ELl1000EEEES2_ILl1ELl1000000EElLb1ELb0EE6__castIlS2_ILl1ELl1000000000EEEES4_RKNS1_IT_T0_EE.63:
#       std::chrono::duration<int64_t, std::nano>::count(const std::chrono::duration<int64_t, std::nano> *) const
        call      _ZNKSt6chrono8durationIlSt5ratioILl1ELl1000000000EEE5countEv #155.29
..___tag_value__ZNSt6chrono20__duration_cast_implINS_8durationIlSt5ratioILl1ELl1000EEEES2_ILl1ELl1000000EElLb1ELb0EE6__castIlS2_ILl1ELl1000000000EEEES4_RKNS1_IT_T0_EE.64:
                                # LOE rax rbx rbp rsp r12 r13 r14 r15 rip
..B8.6:                         # Preds ..B8.1
                                # Execution count [0.00e+00]
        movq      %rax, -40(%rbp)                               #155.29
        jmp       ..B8.3        # Prob 100%                     #155.29
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B8.2:                         # Preds ..B8.3
                                # Execution count [0.00e+00]
        movq      -24(%rbp), %rax                               #154.6
        leave                                                   #154.6
	.cfi_restore 6
        ret                                                     #154.6
	.cfi_offset 6, -16
                                # LOE
..B8.3:                         # Preds ..B8.6
                                # Execution count [0.00e+00]
        movq      -40(%rbp), %rax                               #155.29
        movq      $0x431bde82d7b634db, %rdx                     #155.40
        movq      %rax, -16(%rbp)                               #155.40[spill]
        movq      %rdx, %rax                                    #155.40
        movq      -16(%rbp), %rdx                               #155.40[spill]
        imulq     %rdx                                          #155.40
        sarq      $18, %rdx                                     #155.40
        movq      -40(%rbp), %rax                               #155.29
        sarq      $63, %rax                                     #155.40
        subq      %rax, %rdx                                    #155.40
        movq      %rdx, -32(%rbp)                               #155.40
        lea       -24(%rbp), %rax                               #154.20
        lea       -32(%rbp), %rdx                               #154.20
        movq      %rax, %rdi                                    #154.20
        movq      %rdx, %rsi                                    #154.20
..___tag_value__ZNSt6chrono20__duration_cast_implINS_8durationIlSt5ratioILl1ELl1000EEEES2_ILl1ELl1000000EElLb1ELb0EE6__castIlS2_ILl1ELl1000000000EEEES4_RKNS1_IT_T0_EE.69:
#       std::chrono::duration<int64_t, std::milli>::duration<std::chrono::duration<int64_t, std::milli>::rep, void>(std::chrono::duration<int64_t, std::milli> *, const std::chrono::duration<int64_t, std::milli>::rep &)
        call      _ZNSt6chrono8durationIlSt5ratioILl1ELl1000EEEC1IlvEERKT_ #154.20
..___tag_value__ZNSt6chrono20__duration_cast_implINS_8durationIlSt5ratioILl1ELl1000EEEES2_ILl1ELl1000000EElLb1ELb0EE6__castIlS2_ILl1ELl1000000000EEEES4_RKNS1_IT_T0_EE.70:
        jmp       ..B8.2        # Prob 100%                     #154.20
        .align    2,0x90
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
	.cfi_endproc
# mark_end;
	.type	_ZNSt6chrono20__duration_cast_implINS_8durationIlSt5ratioILl1ELl1000EEEES2_ILl1ELl1000000EElLb1ELb0EE6__castIlS2_ILl1ELl1000000000EEEES4_RKNS1_IT_T0_EE,@function
	.size	_ZNSt6chrono20__duration_cast_implINS_8durationIlSt5ratioILl1ELl1000EEEES2_ILl1ELl1000000EElLb1ELb0EE6__castIlS2_ILl1ELl1000000000EEEES4_RKNS1_IT_T0_EE,.-_ZNSt6chrono20__duration_cast_implINS_8durationIlSt5ratioILl1ELl1000EEEES2_ILl1ELl1000000EElLb1ELb0EE6__castIlS2_ILl1ELl1000000000EEEES4_RKNS1_IT_T0_EE
..LN_ZNSt6chrono20__duration_cast_implINS_8durationIlSt5ratioILl1ELl1000EEEES2_ILl1ELl1000000EElLb1ELb0EE6__castIlS2_ILl1ELl1000000000EEEES4_RKNS1_IT_T0_EE.7:
	.data
# -- End  _ZNSt6chrono20__duration_cast_implINS_8durationIlSt5ratioILl1ELl1000EEEES2_ILl1ELl1000000EElLb1ELb0EE6__castIlS2_ILl1ELl1000000000EEEES4_RKNS1_IT_T0_EE
	.section .text._ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE, "xaG",@progbits,_ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE,comdat
..TXTST8:
.L_2__routine_start__ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE_8:
# -- Begin  _ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE
	.section .text._ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE, "xaG",@progbits,_ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE,comdat
# mark_begin;

	.weak _ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE
# --- std::chrono::operator-<std::chrono::_V2::system_clock, std::chrono::_V2::system_clock::duration, std::chrono::_V2::system_clock::duration>(const std::chrono::time_point<std::chrono::_V2::system_clock, std::chrono::_V2::system_clock::duration> &, const std::chrono::time_point<std::chrono::_V2::system_clock, std::chrono::_V2::system_clock::duration> &)
_ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE:
# parameter 1: %rdi
# parameter 2: %rsi
..B9.1:                         # Preds ..B9.0
                                # Execution count [0.00e+00]
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
..___tag_value__ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE.72:
..L73:
                                                         #754.7
        pushq     %rbp                                          #754.7
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #754.7
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        subq      $48, %rsp                                     #754.7
        movq      %rdi, -48(%rbp)                               #754.7
        movq      %rsi, -40(%rbp)                               #754.7
        movq      -48(%rbp), %rax                               #754.16
        movq      %rax, %rdi                                    #754.16
..___tag_value__ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE.77:
#       std::chrono::time_point<std::chrono::_V2::system_clock, std::chrono::_V2::system_clock::duration>::time_since_epoch(const std::chrono::time_point<std::chrono::_V2::system_clock, std::chrono::_V2::system_clock::duration> *) const
        call      _ZNKSt6chrono10time_pointINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEEE16time_since_epochEv #754.16
..___tag_value__ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE.78:
                                # LOE rax rbx rbp rsp r12 r13 r14 r15 rip
..B9.7:                         # Preds ..B9.1
                                # Execution count [0.00e+00]
        movq      %rax, -32(%rbp)                               #754.16
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B9.2:                         # Preds ..B9.7
                                # Execution count [0.00e+00]
        movq      -40(%rbp), %rax                               #754.43
        movq      %rax, %rdi                                    #754.43
..___tag_value__ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE.79:
#       std::chrono::time_point<std::chrono::_V2::system_clock, std::chrono::_V2::system_clock::duration>::time_since_epoch(const std::chrono::time_point<std::chrono::_V2::system_clock, std::chrono::_V2::system_clock::duration> *) const
        call      _ZNKSt6chrono10time_pointINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEEE16time_since_epochEv #754.43
..___tag_value__ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE.80:
                                # LOE rax rbx rbp rsp r12 r13 r14 r15 rip
..B9.8:                         # Preds ..B9.2
                                # Execution count [0.00e+00]
        movq      %rax, -24(%rbp)                               #754.43
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B9.3:                         # Preds ..B9.8
                                # Execution count [0.00e+00]
        lea       -32(%rbp), %rax                               #754.43
        lea       -24(%rbp), %rdx                               #754.43
        movq      %rax, %rdi                                    #754.43
        movq      %rdx, %rsi                                    #754.43
..___tag_value__ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE.81:
        call      _ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_ #754.43
..___tag_value__ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE.82:
                                # LOE rax rbx rbp rsp r12 r13 r14 r15 rip
..B9.9:                         # Preds ..B9.3
                                # Execution count [0.00e+00]
        movq      %rax, -16(%rbp)                               #754.43
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B9.4:                         # Preds ..B9.9
                                # Execution count [0.00e+00]
        movq      -16(%rbp), %rax                               #754.9
        leave                                                   #754.9
	.cfi_restore 6
        ret                                                     #754.9
                                # LOE
	.cfi_endproc
# mark_end;
	.type	_ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE,@function
	.size	_ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE,.-_ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE
..LN_ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE.8:
	.data
# -- End  _ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE
	.section .text._ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_, "xaG",@progbits,_ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_,comdat
..TXTST9:
.L_2__routine_start__ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA__9:
# -- Begin  _ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_
	.section .text._ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_, "xaG",@progbits,_ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_,comdat
# mark_begin;

	.weak _ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_
# --- std::chrono::operator-<int64_t, std::nano, int64_t, std::nano>(const std::chrono::duration<int64_t, std::nano> &, const std::chrono::duration<int64_t, std::nano> &)
_ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_:
# parameter 1: %rdi
# parameter 2: %rsi
..B10.1:                        # Preds ..B10.0
                                # Execution count [0.00e+00]
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
..___tag_value__ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_.85:
..L86:
                                                         #467.7
        pushq     %rbp                                          #467.7
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #467.7
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        subq      $96, %rsp                                     #467.7
        movq      %rdi, -96(%rbp)                               #467.7
        movq      %rsi, -88(%rbp)                               #467.7
        movq      -96(%rbp), %rax                               #471.19
        movq      %rax, -80(%rbp)                               #471.19
        movq      -80(%rbp), %rax                               #471.19
        movq      %rax, -72(%rbp)                               #471.19
        movq      -72(%rbp), %rax                               #471.19
        movq      (%rax), %rax                                  #471.19
        movq      %rax, -64(%rbp)                               #471.26
        lea       -64(%rbp), %rax                               #471.26
        movq      %rax, %rdi                                    #471.26
..___tag_value__ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_.90:
#       std::chrono::duration<int64_t, std::nano>::count(const std::chrono::duration<int64_t, std::nano> *) const
        call      _ZNKSt6chrono8durationIlSt5ratioILl1ELl1000000000EEE5countEv #471.26
..___tag_value__ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_.91:
                                # LOE rax rbx rbp rsp r12 r13 r14 r15 rip
..B10.7:                        # Preds ..B10.1
                                # Execution count [0.00e+00]
        movq      %rax, -56(%rbp)                               #471.26
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B10.2:                        # Preds ..B10.7
                                # Execution count [0.00e+00]
        movq      -88(%rbp), %rax                               #471.41
        movq      %rax, -48(%rbp)                               #471.41
        movq      -48(%rbp), %rax                               #471.41
        movq      %rax, -40(%rbp)                               #471.41
        movq      -40(%rbp), %rax                               #471.41
        movq      (%rax), %rax                                  #471.41
        movq      %rax, -32(%rbp)                               #471.48
        lea       -32(%rbp), %rax                               #471.48
        movq      %rax, %rdi                                    #471.48
..___tag_value__ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_.92:
#       std::chrono::duration<int64_t, std::nano>::count(const std::chrono::duration<int64_t, std::nano> *) const
        call      _ZNKSt6chrono8durationIlSt5ratioILl1ELl1000000000EEE5countEv #471.48
..___tag_value__ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_.93:
                                # LOE rax rbx rbp rsp r12 r13 r14 r15 rip
..B10.8:                        # Preds ..B10.2
                                # Execution count [0.00e+00]
        movq      %rax, -24(%rbp)                               #471.48
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B10.3:                        # Preds ..B10.8
                                # Execution count [0.00e+00]
        movq      -24(%rbp), %rax                               #471.48
        negq      %rax                                          #471.48
        addq      -56(%rbp), %rax                               #471.48
        movq      %rax, -16(%rbp)                               #471.48
        lea       -8(%rbp), %rax                                #471.14
        lea       -16(%rbp), %rdx                               #471.14
        movq      %rax, %rdi                                    #471.14
        movq      %rdx, %rsi                                    #471.14
..___tag_value__ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_.94:
#       std::chrono::duration<int64_t, std::nano>::duration<signed long, void>(std::chrono::duration<int64_t, std::nano> *, const signed long &)
        call      _ZNSt6chrono8durationIlSt5ratioILl1ELl1000000000EEEC1IlvEERKT_ #471.14
..___tag_value__ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_.95:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B10.4:                        # Preds ..B10.3
                                # Execution count [0.00e+00]
        movq      -8(%rbp), %rax                                #471.2
        leave                                                   #471.2
	.cfi_restore 6
        ret                                                     #471.2
                                # LOE
	.cfi_endproc
# mark_end;
	.type	_ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_,@function
	.size	_ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_,.-_ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_
..LN_ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_.9:
	.data
# -- End  _ZNSt6chronomiIlSt5ratioILl1ELl1000000000EElS2_EENSt11common_typeIJNS_8durationIT_T0_EENS4_IT1_T2_EEEE4typeERKS7_RKSA_
	.section .text._ZNSt6chrono13duration_castINS_8durationIlSt5ratioILl1ELl1000EEEElS2_ILl1ELl1000000000EEEENSt9enable_ifIXsr3std6chrono13__is_durationIT_EE5valueES7_E4typeERKNS1_IT0_T1_EE, "xaG",@progbits,_ZNSt6chrono13duration_castINS_8durationIlSt5ratioILl1ELl1000EEEElS2_ILl1ELl1000000000EEEENSt9enable_ifIXsr3std6chrono13__is_durationIT_EE5valueES7_E4typeERKNS1_IT0_T1_EE,comdat
..TXTST10:
.L_2__routine_start__ZNSt6chrono13duration_castINS_8durationIlSt5ratioILl1ELl1000EEEElS2_ILl1ELl1000000000EEEENSt9enable_ifIXsr3std6chrono13__is_durationIT_EE5valueES7_E4typeERKNS1_IT0_T1_EE_10:
# -- Begin  _ZNSt6chrono13duration_castINS_8durationIlSt5ratioILl1ELl1000EEEElS2_ILl1ELl1000000000EEEENSt9enable_ifIXsr3std6chrono13__is_durationIT_EE5valueES7_E4typeERKNS1_IT0_T1_EE
	.section .text._ZNSt6chrono13duration_castINS_8durationIlSt5ratioILl1ELl1000EEEElS2_ILl1ELl1000000000EEEENSt9enable_ifIXsr3std6chrono13__is_durationIT_EE5valueES7_E4typeERKNS1_IT0_T1_EE, "xaG",@progbits,_ZNSt6chrono13duration_castINS_8durationIlSt5ratioILl1ELl1000EEEElS2_ILl1ELl1000000000EEEENSt9enable_ifIXsr3std6chrono13__is_durationIT_EE5valueES7_E4typeERKNS1_IT0_T1_EE,comdat
# mark_begin;

	.weak _ZNSt6chrono13duration_castINS_8durationIlSt5ratioILl1ELl1000EEEElS2_ILl1ELl1000000000EEEENSt9enable_ifIXsr3std6chrono13__is_durationIT_EE5valueES7_E4typeERKNS1_IT0_T1_EE
# --- std::chrono::duration_cast<std::chrono::milliseconds, int64_t, std::nano>(const std::chrono::duration<int64_t, std::nano> &)
_ZNSt6chrono13duration_castINS_8durationIlSt5ratioILl1ELl1000EEEElS2_ILl1ELl1000000000EEEENSt9enable_ifIXsr3std6chrono13__is_durationIT_EE5valueES7_E4typeERKNS1_IT0_T1_EE:
# parameter 1: %rdi
..B11.1:                        # Preds ..B11.0
                                # Execution count [0.00e+00]
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
..___tag_value__ZNSt6chrono13duration_castINS_8durationIlSt5ratioILl1ELl1000EEEElS2_ILl1ELl1000000000EEEENSt9enable_ifIXsr3std6chrono13__is_durationIT_EE5valueES7_E4typeERKNS1_IT0_T1_EE.98:
..L99:
                                                         #194.7
        pushq     %rbp                                          #194.7
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #194.7
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        subq      $16, %rsp                                     #194.7
        movq      %rdi, -16(%rbp)                               #194.7
        movq      -16(%rbp), %rax                               #202.22
        movq      %rax, %rdi                                    #202.22
..___tag_value__ZNSt6chrono13duration_castINS_8durationIlSt5ratioILl1ELl1000EEEElS2_ILl1ELl1000000000EEEENSt9enable_ifIXsr3std6chrono13__is_durationIT_EE5valueES7_E4typeERKNS1_IT0_T1_EE.103:
#       std::chrono::__duration_cast_impl<std::chrono::milliseconds, std::ratio_divide<std::nano, std::chrono::duration<int64_t, std::milli>::period>, std::__success_type<signed long>::type, true, false>::__cast<int64_t, std::nano>(const std::chrono::duration<int64_t, std::nano> &)
        call      _ZNSt6chrono20__duration_cast_implINS_8durationIlSt5ratioILl1ELl1000EEEES2_ILl1ELl1000000EElLb1ELb0EE6__castIlS2_ILl1ELl1000000000EEEES4_RKNS1_IT_T0_EE #202.22
..___tag_value__ZNSt6chrono13duration_castINS_8durationIlSt5ratioILl1ELl1000EEEElS2_ILl1ELl1000000000EEEENSt9enable_ifIXsr3std6chrono13__is_durationIT_EE5valueES7_E4typeERKNS1_IT0_T1_EE.104:
                                # LOE rax rbx rbp rsp r12 r13 r14 r15 rip
..B11.5:                        # Preds ..B11.1
                                # Execution count [0.00e+00]
        movq      %rax, -8(%rbp)                                #202.22
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B11.2:                        # Preds ..B11.5
                                # Execution count [0.00e+00]
        movq      -8(%rbp), %rax                                #202.2
        leave                                                   #202.2
	.cfi_restore 6
        ret                                                     #202.2
                                # LOE
	.cfi_endproc
# mark_end;
	.type	_ZNSt6chrono13duration_castINS_8durationIlSt5ratioILl1ELl1000EEEElS2_ILl1ELl1000000000EEEENSt9enable_ifIXsr3std6chrono13__is_durationIT_EE5valueES7_E4typeERKNS1_IT0_T1_EE,@function
	.size	_ZNSt6chrono13duration_castINS_8durationIlSt5ratioILl1ELl1000EEEElS2_ILl1ELl1000000000EEEENSt9enable_ifIXsr3std6chrono13__is_durationIT_EE5valueES7_E4typeERKNS1_IT0_T1_EE,.-_ZNSt6chrono13duration_castINS_8durationIlSt5ratioILl1ELl1000EEEElS2_ILl1ELl1000000000EEEENSt9enable_ifIXsr3std6chrono13__is_durationIT_EE5valueES7_E4typeERKNS1_IT0_T1_EE
..LN_ZNSt6chrono13duration_castINS_8durationIlSt5ratioILl1ELl1000EEEElS2_ILl1ELl1000000000EEEENSt9enable_ifIXsr3std6chrono13__is_durationIT_EE5valueES7_E4typeERKNS1_IT0_T1_EE.10:
	.data
# -- End  _ZNSt6chrono13duration_castINS_8durationIlSt5ratioILl1ELl1000EEEElS2_ILl1ELl1000000000EEEENSt9enable_ifIXsr3std6chrono13__is_durationIT_EE5valueES7_E4typeERKNS1_IT0_T1_EE
	.section .text._ZStorSt12_Ios_IostateS_, "xaG",@progbits,_ZStorSt12_Ios_IostateS_,comdat
..TXTST11:
.L_2__routine_start__ZStorSt12_Ios_IostateS__11:
# -- Begin  _ZStorSt12_Ios_IostateS_
	.section .text._ZStorSt12_Ios_IostateS_, "xaG",@progbits,_ZStorSt12_Ios_IostateS_,comdat
# mark_begin;

	.weak _ZStorSt12_Ios_IostateS_
# --- std::operator|(std::_Ios_Iostate, std::_Ios_Iostate)
_ZStorSt12_Ios_IostateS_:
# parameter 1: %edi
# parameter 2: %esi
..B12.1:                        # Preds ..B12.0
                                # Execution count [0.00e+00]
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
..___tag_value__ZStorSt12_Ios_IostateS_.107:
..L108:
                                                        #170.3
        pushq     %rbp                                          #170.3
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #170.3
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        subq      $16, %rsp                                     #170.3
        movl      %edi, -16(%rbp)                               #170.3
        movl      %esi, -8(%rbp)                                #170.3
        movl      -8(%rbp), %eax                                #170.66
        orl       -16(%rbp), %eax                               #170.66
        leave                                                   #170.66
	.cfi_restore 6
        ret                                                     #170.66
                                # LOE
	.cfi_endproc
# mark_end;
	.type	_ZStorSt12_Ios_IostateS_,@function
	.size	_ZStorSt12_Ios_IostateS_,.-_ZStorSt12_Ios_IostateS_
..LN_ZStorSt12_Ios_IostateS_.11:
	.data
# -- End  _ZStorSt12_Ios_IostateS_
	.section .text._ZSt13__check_facetISt5ctypeIcEERKT_PS3_, "xaG",@progbits,_ZSt13__check_facetISt5ctypeIcEERKT_PS3_,comdat
..TXTST12:
.L_2__routine_start__ZSt13__check_facetISt5ctypeIcEERKT_PS3__12:
# -- Begin  _ZSt13__check_facetISt5ctypeIcEERKT_PS3_
	.section .text._ZSt13__check_facetISt5ctypeIcEERKT_PS3_, "xaG",@progbits,_ZSt13__check_facetISt5ctypeIcEERKT_PS3_,comdat
# mark_begin;

	.weak _ZSt13__check_facetISt5ctypeIcEERKT_PS3_
# --- std::__check_facet<std::basic_ios<char, std::char_traits<char>>::__ctype_type>(const std::basic_ios<char, std::char_traits<char>>::__ctype_type *)
_ZSt13__check_facetISt5ctypeIcEERKT_PS3_:
# parameter 1: %rdi
..B13.1:                        # Preds ..B13.0
                                # Execution count [0.00e+00]
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
..___tag_value__ZSt13__check_facetISt5ctypeIcEERKT_PS3_.114:
..L115:
                                                        #48.5
        pushq     %rbp                                          #48.5
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #48.5
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        subq      $16, %rsp                                     #48.5
        movq      %rdi, -16(%rbp)                               #48.5
        movq      -16(%rbp), %rax                               #49.12
        testq     %rax, %rax                                    #49.12
        jne       ..B13.3       # Prob 50%                      #49.12
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B13.2:                        # Preds ..B13.1
                                # Execution count [0.00e+00]
..___tag_value__ZSt13__check_facetISt5ctypeIcEERKT_PS3_.119:
        call      _ZSt16__throw_bad_castv                       #50.2
..___tag_value__ZSt13__check_facetISt5ctypeIcEERKT_PS3_.120:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B13.3:                        # Preds ..B13.1
                                # Execution count [0.00e+00]
        movq      -16(%rbp), %rax                               #51.15
        leave                                                   #51.15
	.cfi_restore 6
        ret                                                     #51.15
                                # LOE
	.cfi_endproc
# mark_end;
	.type	_ZSt13__check_facetISt5ctypeIcEERKT_PS3_,@function
	.size	_ZSt13__check_facetISt5ctypeIcEERKT_PS3_,.-_ZSt13__check_facetISt5ctypeIcEERKT_PS3_
..LN_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.12:
	.data
# -- End  _ZSt13__check_facetISt5ctypeIcEERKT_PS3_
	.text
..TXTST13:
.L_2__routine_start__Z10cdf_normalf_13:
# -- Begin  _Z10cdf_normalf
	.section .rodata, "a"
	.align 16
	.align 16
.L_2il0floatpacket.11:
	.long	0x80000000,0x00000000,0x00000000,0x00000000
	.type	.L_2il0floatpacket.11,@object
	.size	.L_2il0floatpacket.11,16
	.align 8
.L_2il0floatpacket.8:
	.long	0x00000000,0x3fe00000
	.type	.L_2il0floatpacket.8,@object
	.size	.L_2il0floatpacket.8,8
	.align 8
.L_2il0floatpacket.9:
	.long	0x40000000,0x3fd98845
	.type	.L_2il0floatpacket.9,@object
	.size	.L_2il0floatpacket.9,8
	.align 8
.L_2il0floatpacket.10:
	.long	0x00000000,0x3ff00000
	.type	.L_2il0floatpacket.10,@object
	.size	.L_2il0floatpacket.10,8
	.align 4
.L_2il0floatpacket.1:
	.long	0x3ea385fa
	.type	.L_2il0floatpacket.1,@object
	.size	.L_2il0floatpacket.1,4
	.align 4
.L_2il0floatpacket.2:
	.long	0xbeb68f87
	.type	.L_2il0floatpacket.2,@object
	.size	.L_2il0floatpacket.2,4
	.align 4
.L_2il0floatpacket.3:
	.long	0x3fe40778
	.type	.L_2il0floatpacket.3,@object
	.size	.L_2il0floatpacket.3,4
	.align 4
.L_2il0floatpacket.4:
	.long	0xbfe91eea
	.type	.L_2il0floatpacket.4,@object
	.size	.L_2il0floatpacket.4,4
	.align 4
.L_2il0floatpacket.5:
	.long	0x3faa466f
	.type	.L_2il0floatpacket.5,@object
	.size	.L_2il0floatpacket.5,4
	.align 4
.L_2il0floatpacket.6:
	.long	0x3e6d3389
	.type	.L_2il0floatpacket.6,@object
	.size	.L_2il0floatpacket.6,4
	.align 4
.L_2il0floatpacket.7:
	.long	0x3ecc422a
	.type	.L_2il0floatpacket.7,@object
	.size	.L_2il0floatpacket.7,4
	.text
# mark_begin;

	.globl _Z10cdf_normalf
# --- cdf_normal(float)
_Z10cdf_normalf:
# parameter 1: %xmm0
..B14.1:                        # Preds ..B14.0
                                # Execution count [0.00e+00]
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
..___tag_value__Z10cdf_normalf.123:
..L124:
                                                        #6.1
        pushq     %rbp                                          #6.1
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #6.1
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        subq      $64, %rsp                                     #6.1
        movss     %xmm0, -24(%rbp)                              #6.1
        movss     .L_2il0floatpacket.1(%rip), %xmm0             #7.20
        movss     %xmm0, -64(%rbp)                              #7.20
        movss     .L_2il0floatpacket.2(%rip), %xmm0             #8.20
        movss     %xmm0, -60(%rbp)                              #8.20
        movss     .L_2il0floatpacket.3(%rip), %xmm0             #9.20
        movss     %xmm0, -56(%rbp)                              #9.20
        movss     .L_2il0floatpacket.4(%rip), %xmm0             #10.20
        movss     %xmm0, -52(%rbp)                              #10.20
        movss     .L_2il0floatpacket.5(%rip), %xmm0             #11.20
        movss     %xmm0, -48(%rbp)                              #11.20
        movss     .L_2il0floatpacket.6(%rip), %xmm0             #12.19
        movss     %xmm0, -44(%rbp)                              #12.19
        movss     .L_2il0floatpacket.7(%rip), %xmm0             #13.19
        movss     %xmm0, -40(%rbp)                              #13.19
        movss     -24(%rbp), %xmm0                              #15.9
        pxor      %xmm1, %xmm1                                  #15.5
        comiss    %xmm1, %xmm0                                  #15.14
        jb        ..B14.4       # Prob 50%                      #15.14
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B14.2:                        # Preds ..B14.1
                                # Execution count [0.00e+00]
        movsd     .L_2il0floatpacket.10(%rip), %xmm0            #17.36
        movss     .L_2il0floatpacket.6(%rip), %xmm1             #17.32
        movss     -24(%rbp), %xmm2                              #17.36
        mulss     %xmm2, %xmm1                                  #17.36
        cvtss2sd  %xmm1, %xmm1                                  #17.36
        movsd     .L_2il0floatpacket.10(%rip), %xmm2            #17.36
        addsd     %xmm2, %xmm1                                  #17.36
        divsd     %xmm1, %xmm0                                  #17.36
        cvtsd2ss  %xmm0, %xmm0                                  #17.36
        movss     %xmm0, -36(%rbp)                              #17.17
        movss     -24(%rbp), %xmm0                              #18.27
        xorps     .L_2il0floatpacket.11(%rip), %xmm0            #18.27
        movss     -24(%rbp), %xmm1                              #18.27
        mulss     %xmm1, %xmm0                                  #18.27
        cvtss2sd  %xmm0, %xmm0                                  #18.27
        movsd     .L_2il0floatpacket.8(%rip), %xmm1             #18.27
        mulsd     %xmm1, %xmm0                                  #18.27
..___tag_value__Z10cdf_normalf.128:
#       exp(double)
        call      exp                                           #18.27
..___tag_value__Z10cdf_normalf.129:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip xmm0
..B14.8:                        # Preds ..B14.2
                                # Execution count [0.00e+00]
        movsd     %xmm0, -16(%rbp)                              #18.27
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B14.3:                        # Preds ..B14.8
                                # Execution count [0.00e+00]
        movsd     .L_2il0floatpacket.10(%rip), %xmm0            #18.93
        movsd     .L_2il0floatpacket.9(%rip), %xmm1             #18.23
        movsd     -16(%rbp), %xmm2                              #18.27
        mulsd     %xmm2, %xmm1                                  #18.27
        movss     -36(%rbp), %xmm2                              #18.47
        cvtss2sd  %xmm2, %xmm2                                  #18.47
        mulsd     %xmm2, %xmm1                                  #18.47
        movss     -36(%rbp), %xmm2                              #18.52
        movss     -36(%rbp), %xmm3                              #18.56
        movss     -36(%rbp), %xmm4                              #18.61
        movss     -36(%rbp), %xmm5                              #18.66
        movss     .L_2il0floatpacket.5(%rip), %xmm6             #18.70
        mulss     %xmm6, %xmm5                                  #18.70
        movss     .L_2il0floatpacket.4(%rip), %xmm6             #18.75
        addss     %xmm6, %xmm5                                  #18.75
        mulss     %xmm5, %xmm4                                  #18.75
        movss     .L_2il0floatpacket.3(%rip), %xmm5             #18.81
        addss     %xmm5, %xmm4                                  #18.81
        mulss     %xmm4, %xmm3                                  #18.81
        movss     .L_2il0floatpacket.2(%rip), %xmm4             #18.87
        addss     %xmm4, %xmm3                                  #18.87
        mulss     %xmm3, %xmm2                                  #18.87
        movss     .L_2il0floatpacket.1(%rip), %xmm3             #18.93
        addss     %xmm3, %xmm2                                  #18.93
        cvtss2sd  %xmm2, %xmm2                                  #18.93
        mulsd     %xmm2, %xmm1                                  #18.93
        subsd     %xmm1, %xmm0                                  #18.93
        cvtsd2ss  %xmm0, %xmm0                                  #18.93
        leave                                                   #18.93
	.cfi_restore 6
        ret                                                     #18.93
	.cfi_offset 6, -16
                                # LOE
..B14.4:                        # Preds ..B14.1
                                # Execution count [0.00e+00]
        movsd     .L_2il0floatpacket.10(%rip), %xmm0            #22.36
        movsd     .L_2il0floatpacket.10(%rip), %xmm1            #22.36
        movss     .L_2il0floatpacket.6(%rip), %xmm2             #22.32
        movss     -24(%rbp), %xmm3                              #22.36
        mulss     %xmm3, %xmm2                                  #22.36
        cvtss2sd  %xmm2, %xmm2                                  #22.36
        subsd     %xmm2, %xmm1                                  #22.36
        divsd     %xmm1, %xmm0                                  #22.36
        cvtsd2ss  %xmm0, %xmm0                                  #22.36
        movss     %xmm0, -32(%rbp)                              #22.17
        movss     -24(%rbp), %xmm0                              #23.21
        xorps     .L_2il0floatpacket.11(%rip), %xmm0            #23.21
        movss     -24(%rbp), %xmm1                              #23.21
        mulss     %xmm1, %xmm0                                  #23.21
        cvtss2sd  %xmm0, %xmm0                                  #23.21
        movsd     .L_2il0floatpacket.8(%rip), %xmm1             #23.21
        mulsd     %xmm1, %xmm0                                  #23.21
..___tag_value__Z10cdf_normalf.132:
#       exp(double)
        call      exp                                           #23.21
..___tag_value__Z10cdf_normalf.133:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip xmm0
..B14.9:                        # Preds ..B14.4
                                # Execution count [0.00e+00]
        movsd     %xmm0, -8(%rbp)                               #23.21
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B14.5:                        # Preds ..B14.9
                                # Execution count [0.00e+00]
        movsd     .L_2il0floatpacket.9(%rip), %xmm0             #23.17
        movsd     -8(%rbp), %xmm1                               #23.21
        mulsd     %xmm1, %xmm0                                  #23.21
        movss     -32(%rbp), %xmm1                              #23.41
        cvtss2sd  %xmm1, %xmm1                                  #23.41
        mulsd     %xmm1, %xmm0                                  #23.41
        movss     -32(%rbp), %xmm1                              #23.46
        movss     -32(%rbp), %xmm2                              #23.50
        movss     -32(%rbp), %xmm3                              #23.55
        movss     -32(%rbp), %xmm4                              #23.60
        movss     .L_2il0floatpacket.5(%rip), %xmm5             #23.64
        mulss     %xmm5, %xmm4                                  #23.64
        movss     .L_2il0floatpacket.4(%rip), %xmm5             #23.69
        addss     %xmm5, %xmm4                                  #23.69
        mulss     %xmm4, %xmm3                                  #23.69
        movss     .L_2il0floatpacket.3(%rip), %xmm4             #23.75
        addss     %xmm4, %xmm3                                  #23.75
        mulss     %xmm3, %xmm2                                  #23.75
        movss     .L_2il0floatpacket.2(%rip), %xmm3             #23.81
        addss     %xmm3, %xmm2                                  #23.81
        mulss     %xmm2, %xmm1                                  #23.81
        movss     .L_2il0floatpacket.1(%rip), %xmm2             #23.87
        addss     %xmm2, %xmm1                                  #23.87
        cvtss2sd  %xmm1, %xmm1                                  #23.87
        mulsd     %xmm1, %xmm0                                  #23.87
        cvtsd2ss  %xmm0, %xmm0                                  #23.87
        leave                                                   #23.87
	.cfi_restore 6
        ret                                                     #23.87
                                # LOE
	.cfi_endproc
# mark_end;
	.type	_Z10cdf_normalf,@function
	.size	_Z10cdf_normalf,.-_Z10cdf_normalf
..LN_Z10cdf_normalf.13:
	.data
# -- End  _Z10cdf_normalf
	.text
.L_2__routine_start__Z10call_pricePfS_S_S_S_S_i_14:
# -- Begin  _Z10call_pricePfS_S_S_S_S_i
	.text
# mark_begin;

	.globl _Z10call_pricePfS_S_S_S_S_i
# --- call_price(float *, float *, float *, float *, float *, float *, int)
_Z10call_pricePfS_S_S_S_S_i:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %rcx
# parameter 5: %r8
# parameter 6: %r9
# parameter 7: 16 + %rbp
..B15.1:                        # Preds ..B15.0
                                # Execution count [0.00e+00]
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
..___tag_value__Z10call_pricePfS_S_S_S_S_i.136:
..L137:
                                                        #30.1
        pushq     %rbp                                          #30.1
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #30.1
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        subq      $128, %rsp                                    #30.1
        movq      %rdi, -96(%rbp)                               #30.1
        movq      %rsi, -88(%rbp)                               #30.1
        movq      %rdx, -80(%rbp)                               #30.1
        movq      %rcx, -72(%rbp)                               #30.1
        movq      %r8, -64(%rbp)                                #30.1
        movq      %r9, -56(%rbp)                                #30.1
        movl      $0, -128(%rbp)                                #31.16
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B15.2:                        # Preds ..B15.10 ..B15.1
                                # Execution count [0.00e+00]
        movl      -128(%rbp), %eax                              #31.21
        movl      16(%rbp), %edx                                #31.25
        cmpl      %edx, %eax                                    #31.25
        jge       ..B15.11      # Prob 50%                      #31.25
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B15.3:                        # Preds ..B15.2
                                # Execution count [0.00e+00]
        movl      -128(%rbp), %eax                              #34.14
        movslq    %eax, %rax                                    #34.14
        imulq     $4, %rax, %rax                                #34.14
        addq      -96(%rbp), %rax                               #34.14
        movss     (%rax), %xmm0                                 #34.14
        movl      -128(%rbp), %eax                              #34.14
        movslq    %eax, %rax                                    #34.14
        imulq     $4, %rax, %rax                                #34.14
        addq      -88(%rbp), %rax                               #34.14
        movss     (%rax), %xmm1                                 #34.14
        divss     %xmm1, %xmm0                                  #34.14
        cvtss2sd  %xmm0, %xmm0                                  #34.14
..___tag_value__Z10call_pricePfS_S_S_S_S_i.141:
#       log(double)
        call      log                                           #34.14
..___tag_value__Z10call_pricePfS_S_S_S_S_i.142:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip xmm0
..B15.14:                       # Preds ..B15.3
                                # Execution count [0.00e+00]
        movsd     %xmm0, -48(%rbp)                              #34.14
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B15.4:                        # Preds ..B15.14
                                # Execution count [0.00e+00]
        movl      -128(%rbp), %eax                              #34.77
        movslq    %eax, %rax                                    #34.77
        imulq     $4, %rax, %rax                                #34.77
        addq      -80(%rbp), %rax                               #34.77
        movss     (%rax), %xmm0                                 #34.77
        cvtss2sd  %xmm0, %xmm0                                  #34.77
..___tag_value__Z10call_pricePfS_S_S_S_S_i.143:
#       sqrt(double)
        call      sqrt                                          #34.77
..___tag_value__Z10call_pricePfS_S_S_S_S_i.144:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip xmm0
..B15.15:                       # Preds ..B15.4
                                # Execution count [0.00e+00]
        movsd     %xmm0, -40(%rbp)                              #34.77
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B15.5:                        # Preds ..B15.15
                                # Execution count [0.00e+00]
        movl      -128(%rbp), %eax                              #34.37
        movslq    %eax, %rax                                    #34.35
        imulq     $4, %rax, %rax                                #34.35
        addq      -64(%rbp), %rax                               #34.35
        movss     (%rax), %xmm0                                 #34.35
        cvtss2sd  %xmm0, %xmm0                                  #34.35
        movsd     .L_2il0floatpacket.8(%rip), %xmm1             #34.42
        movl      -128(%rbp), %eax                              #34.48
        movslq    %eax, %rax                                    #34.46
        imulq     $4, %rax, %rax                                #34.46
        addq      -72(%rbp), %rax                               #34.46
        movss     (%rax), %xmm2                                 #34.46
        cvtss2sd  %xmm2, %xmm2                                  #34.46
        mulsd     %xmm2, %xmm1                                  #34.46
        movl      -128(%rbp), %eax                              #34.55
        movslq    %eax, %rax                                    #34.53
        imulq     $4, %rax, %rax                                #34.53
        addq      -72(%rbp), %rax                               #34.53
        movss     (%rax), %xmm2                                 #34.53
        cvtss2sd  %xmm2, %xmm2                                  #34.53
        mulsd     %xmm2, %xmm1                                  #34.53
        addsd     %xmm1, %xmm0                                  #34.53
        movl      -128(%rbp), %eax                              #34.63
        movslq    %eax, %rax                                    #34.61
        imulq     $4, %rax, %rax                                #34.61
        addq      -80(%rbp), %rax                               #34.61
        movss     (%rax), %xmm1                                 #34.61
        cvtss2sd  %xmm1, %xmm1                                  #34.61
        mulsd     %xmm1, %xmm0                                  #34.61
        movsd     -48(%rbp), %xmm1                              #34.14
        addsd     %xmm0, %xmm1                                  #34.61
        movl      -128(%rbp), %eax                              #34.72
        movslq    %eax, %rax                                    #34.70
        imulq     $4, %rax, %rax                                #34.70
        addq      -72(%rbp), %rax                               #34.70
        movss     (%rax), %xmm0                                 #34.70
        cvtss2sd  %xmm0, %xmm0                                  #34.70
        movsd     -40(%rbp), %xmm2                              #34.77
        mulsd     %xmm2, %xmm0                                  #34.77
        divsd     %xmm0, %xmm1                                  #34.77
        cvtsd2ss  %xmm1, %xmm1                                  #34.77
        movss     %xmm1, -124(%rbp)                             #33.18
        movl      -128(%rbp), %eax                              #36.14
        movslq    %eax, %rax                                    #36.14
        imulq     $4, %rax, %rax                                #36.14
        addq      -96(%rbp), %rax                               #36.14
        movss     (%rax), %xmm0                                 #36.14
        movl      -128(%rbp), %eax                              #36.14
        movslq    %eax, %rax                                    #36.14
        imulq     $4, %rax, %rax                                #36.14
        addq      -88(%rbp), %rax                               #36.14
        movss     (%rax), %xmm1                                 #36.14
        divss     %xmm1, %xmm0                                  #36.14
        cvtss2sd  %xmm0, %xmm0                                  #36.14
..___tag_value__Z10call_pricePfS_S_S_S_S_i.145:
#       log(double)
        call      log                                           #36.14
..___tag_value__Z10call_pricePfS_S_S_S_S_i.146:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip xmm0
..B15.16:                       # Preds ..B15.5
                                # Execution count [0.00e+00]
        movsd     %xmm0, -32(%rbp)                              #36.14
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B15.6:                        # Preds ..B15.16
                                # Execution count [0.00e+00]
        movl      -128(%rbp), %eax                              #36.77
        movslq    %eax, %rax                                    #36.77
        imulq     $4, %rax, %rax                                #36.77
        addq      -80(%rbp), %rax                               #36.77
        movss     (%rax), %xmm0                                 #36.77
        cvtss2sd  %xmm0, %xmm0                                  #36.77
..___tag_value__Z10call_pricePfS_S_S_S_S_i.147:
#       sqrt(double)
        call      sqrt                                          #36.77
..___tag_value__Z10call_pricePfS_S_S_S_S_i.148:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip xmm0
..B15.17:                       # Preds ..B15.6
                                # Execution count [0.00e+00]
        movsd     %xmm0, -24(%rbp)                              #36.77
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B15.7:                        # Preds ..B15.17
                                # Execution count [0.00e+00]
        movl      -128(%rbp), %eax                              #36.37
        movslq    %eax, %rax                                    #36.35
        imulq     $4, %rax, %rax                                #36.35
        addq      -64(%rbp), %rax                               #36.35
        movss     (%rax), %xmm0                                 #36.35
        cvtss2sd  %xmm0, %xmm0                                  #36.35
        movsd     .L_2il0floatpacket.8(%rip), %xmm1             #36.42
        movl      -128(%rbp), %eax                              #36.48
        movslq    %eax, %rax                                    #36.46
        imulq     $4, %rax, %rax                                #36.46
        addq      -72(%rbp), %rax                               #36.46
        movss     (%rax), %xmm2                                 #36.46
        cvtss2sd  %xmm2, %xmm2                                  #36.46
        mulsd     %xmm2, %xmm1                                  #36.46
        movl      -128(%rbp), %eax                              #36.55
        movslq    %eax, %rax                                    #36.53
        imulq     $4, %rax, %rax                                #36.53
        addq      -72(%rbp), %rax                               #36.53
        movss     (%rax), %xmm2                                 #36.53
        cvtss2sd  %xmm2, %xmm2                                  #36.53
        mulsd     %xmm2, %xmm1                                  #36.53
        subsd     %xmm1, %xmm0                                  #36.53
        movl      -128(%rbp), %eax                              #36.63
        movslq    %eax, %rax                                    #36.61
        imulq     $4, %rax, %rax                                #36.61
        addq      -80(%rbp), %rax                               #36.61
        movss     (%rax), %xmm1                                 #36.61
        cvtss2sd  %xmm1, %xmm1                                  #36.61
        mulsd     %xmm1, %xmm0                                  #36.61
        movsd     -32(%rbp), %xmm1                              #36.14
        addsd     %xmm0, %xmm1                                  #36.61
        movl      -128(%rbp), %eax                              #36.72
        movslq    %eax, %rax                                    #36.70
        imulq     $4, %rax, %rax                                #36.70
        addq      -72(%rbp), %rax                               #36.70
        movss     (%rax), %xmm0                                 #36.70
        cvtss2sd  %xmm0, %xmm0                                  #36.70
        movsd     -24(%rbp), %xmm2                              #36.77
        mulsd     %xmm2, %xmm0                                  #36.77
        divsd     %xmm0, %xmm1                                  #36.77
        cvtsd2ss  %xmm1, %xmm1                                  #36.77
        movss     %xmm1, -120(%rbp)                             #35.18
        movss     -124(%rbp), %xmm0                             #38.21
..___tag_value__Z10call_pricePfS_S_S_S_S_i.149:
#       cdf_normal(float)
        call      _Z10cdf_normalf                               #38.21
..___tag_value__Z10call_pricePfS_S_S_S_S_i.150:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip xmm0
..B15.18:                       # Preds ..B15.7
                                # Execution count [0.00e+00]
        movss     %xmm0, -116(%rbp)                             #38.21
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B15.8:                        # Preds ..B15.18
                                # Execution count [0.00e+00]
        movss     -116(%rbp), %xmm0                             #38.21
        movss     %xmm0, -112(%rbp)                             #38.19
        movss     -120(%rbp), %xmm0                             #39.21
..___tag_value__Z10call_pricePfS_S_S_S_S_i.151:
#       cdf_normal(float)
        call      _Z10cdf_normalf                               #39.21
..___tag_value__Z10call_pricePfS_S_S_S_S_i.152:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip xmm0
..B15.19:                       # Preds ..B15.8
                                # Execution count [0.00e+00]
        movss     %xmm0, -108(%rbp)                             #39.21
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B15.9:                        # Preds ..B15.19
                                # Execution count [0.00e+00]
        movss     -108(%rbp), %xmm0                             #39.21
        movss     %xmm0, -104(%rbp)                             #39.19
        movl      -128(%rbp), %eax                              #41.37
        movslq    %eax, %rax                                    #41.37
        imulq     $4, %rax, %rax                                #41.37
        addq      -64(%rbp), %rax                               #41.37
        movss     (%rax), %xmm0                                 #41.37
        xorps     .L_2il0floatpacket.11(%rip), %xmm0            #41.37
        movl      -128(%rbp), %eax                              #41.37
        movslq    %eax, %rax                                    #41.37
        imulq     $4, %rax, %rax                                #41.37
        addq      -80(%rbp), %rax                               #41.37
        movss     (%rax), %xmm1                                 #41.37
        mulss     %xmm1, %xmm0                                  #41.37
        cvtss2sd  %xmm0, %xmm0                                  #41.37
..___tag_value__Z10call_pricePfS_S_S_S_S_i.153:
#       exp(double)
        call      exp                                           #41.37
..___tag_value__Z10call_pricePfS_S_S_S_S_i.154:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip xmm0
..B15.20:                       # Preds ..B15.9
                                # Execution count [0.00e+00]
        movsd     %xmm0, -16(%rbp)                              #41.37
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B15.10:                       # Preds ..B15.20
                                # Execution count [0.00e+00]
        movl      -128(%rbp), %eax                              #41.19
        movslq    %eax, %rax                                    #41.16
        imulq     $4, %rax, %rax                                #41.16
        addq      -96(%rbp), %rax                               #41.16
        movss     (%rax), %xmm0                                 #41.16
        movss     -112(%rbp), %xmm1                             #41.24
        mulss     %xmm1, %xmm0                                  #41.24
        cvtss2sd  %xmm0, %xmm0                                  #41.24
        movl      -128(%rbp), %eax                              #41.32
        movslq    %eax, %rax                                    #41.30
        imulq     $4, %rax, %rax                                #41.30
        addq      -88(%rbp), %rax                               #41.30
        movss     (%rax), %xmm1                                 #41.30
        cvtss2sd  %xmm1, %xmm1                                  #41.30
        movsd     -16(%rbp), %xmm2                              #41.37
        mulsd     %xmm2, %xmm1                                  #41.37
        movss     -104(%rbp), %xmm2                             #41.55
        cvtss2sd  %xmm2, %xmm2                                  #41.55
        mulsd     %xmm2, %xmm1                                  #41.55
        subsd     %xmm1, %xmm0                                  #41.55
        cvtsd2ss  %xmm0, %xmm0                                  #41.55
        movl      -128(%rbp), %eax                              #41.11
        movslq    %eax, %rax                                    #41.9
        imulq     $4, %rax, %rax                                #41.9
        addq      -56(%rbp), %rax                               #41.9
        movss     %xmm0, (%rax)                                 #41.9
        movl      $1, %eax                                      #31.39
        addl      -128(%rbp), %eax                              #31.39
        movl      %eax, -128(%rbp)                              #31.39
        jmp       ..B15.2       # Prob 100%                     #31.39
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B15.11:                       # Preds ..B15.2
                                # Execution count [0.00e+00]
        leave                                                   #43.1
	.cfi_restore 6
        ret                                                     #43.1
                                # LOE
	.cfi_endproc
# mark_end;
	.type	_Z10call_pricePfS_S_S_S_S_i,@function
	.size	_Z10call_pricePfS_S_S_S_S_i,.-_Z10call_pricePfS_S_S_S_S_i
..LN_Z10call_pricePfS_S_S_S_S_i.14:
	.data
# -- End  _Z10call_pricePfS_S_S_S_S_i
	.text
.L_2__routine_start__Z11random_dataff_15:
# -- Begin  _Z11random_dataff
	.section .rodata, "a"
	.align 4
.L_2il0floatpacket.12:
	.long	0x30000000
	.type	.L_2il0floatpacket.12,@object
	.size	.L_2il0floatpacket.12,4
	.text
# mark_begin;

	.globl _Z11random_dataff
# --- random_data(float, float)
_Z11random_dataff:
# parameter 1: %xmm0
# parameter 2: %xmm1
..B16.1:                        # Preds ..B16.0
                                # Execution count [0.00e+00]
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
..___tag_value__Z11random_dataff.157:
..L158:
                                                        #49.1
        pushq     %rbp                                          #49.1
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #49.1
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        subq      $32, %rsp                                     #49.1
        movss     %xmm0, -24(%rbp)                              #49.1
        movss     %xmm1, -16(%rbp)                              #49.1
..___tag_value__Z11random_dataff.162:
#       rand()
        call      rand                                          #50.22
..___tag_value__Z11random_dataff.163:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip eax
..B16.5:                        # Preds ..B16.1
                                # Execution count [0.00e+00]
        movl      %eax, -32(%rbp)                               #50.22
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B16.2:                        # Preds ..B16.5
                                # Execution count [0.00e+00]
        movl      -32(%rbp), %eax                               #50.22
        cvtsi2ss  %eax, %xmm0                                   #50.22
        movss     .L_2il0floatpacket.12(%rip), %xmm1            #50.31
        mulss     %xmm1, %xmm0                                  #50.31
        movss     %xmm0, -28(%rbp)                              #50.13
        movss     -28(%rbp), %xmm0                              #51.18
        movss     -16(%rbp), %xmm1                              #51.23
        movss     -24(%rbp), %xmm2                              #51.28
        subss     %xmm2, %xmm1                                  #51.28
        mulss     %xmm1, %xmm0                                  #51.28
        movss     -24(%rbp), %xmm1                              #51.12
        addss     %xmm0, %xmm1                                  #51.28
        movaps    %xmm1, %xmm0                                  #51.28
        leave                                                   #51.28
	.cfi_restore 6
        ret                                                     #51.28
                                # LOE
	.cfi_endproc
# mark_end;
	.type	_Z11random_dataff,@function
	.size	_Z11random_dataff,.-_Z11random_dataff
..LN_Z11random_dataff.15:
	.data
# -- End  _Z11random_dataff
	.text
.L_2__routine_start_main_16:
# -- Begin  main
	.section .rodata, "a"
	.align 4
.L_2il0floatpacket.13:
	.long	0x43480000
	.type	.L_2il0floatpacket.13,@object
	.size	.L_2il0floatpacket.13,4
	.align 4
.L_2il0floatpacket.14:
	.long	0x42480000
	.type	.L_2il0floatpacket.14,@object
	.size	.L_2il0floatpacket.14,4
	.align 4
.L_2il0floatpacket.15:
	.long	0x43160000
	.type	.L_2il0floatpacket.15,@object
	.size	.L_2il0floatpacket.15,4
	.align 4
.L_2il0floatpacket.16:
	.long	0x3c23d70a
	.type	.L_2il0floatpacket.16,@object
	.size	.L_2il0floatpacket.16,4
	.align 4
.L_2il0floatpacket.17:
	.long	0x3f7d70a4
	.type	.L_2il0floatpacket.17,@object
	.size	.L_2il0floatpacket.17,4
	.align 4
.L_2il0floatpacket.18:
	.long	0x3f666666
	.type	.L_2il0floatpacket.18,@object
	.size	.L_2il0floatpacket.18,4
	.align 4
.L_2il0floatpacket.19:
	.long	0x40000000
	.type	.L_2il0floatpacket.19,@object
	.size	.L_2il0floatpacket.19,4
	.align 4
.L_2__STRING.0:
	.long	1885432901
	.long	543450483
	.long	1701669204
	.word	8250
	.byte	0
	.type	.L_2__STRING.0,@object
	.size	.L_2__STRING.0,15
	.space 1, 0x00 	# pad
	.align 4
.L_2__STRING.1:
	.long	7564576
	.type	.L_2__STRING.1,@object
	.size	.L_2__STRING.1,4
	.text
# mark_begin;

	.globl main
# --- main()
main:
..B17.1:                        # Preds ..B17.0
                                # Execution count [0.00e+00]
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
..___tag_value_main.166:
..L167:
                                                        #55.1
        pushq     %rbp                                          #55.1
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #55.1
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        subq      $224, %rsp                                    #55.1
        movq      %rbx, -16(%rbp)                               #55.1[spill]
        movl      $4000000, %eax                                #58.11
        movq      %rax, %rdi                                    #58.11
..___tag_value_main.172:
#       operator new[](std::size_t)
        call      _Znam                                         #58.11
..___tag_value_main.173:
	.cfi_offset 3, -32
                                # LOE rax rbp rsp r12 r13 r14 r15 rip
..B17.28:                       # Preds ..B17.1
                                # Execution count [0.00e+00]
        movq      %rax, -200(%rbp)                              #58.11
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.2:                        # Preds ..B17.28
                                # Execution count [0.00e+00]
        movq      -200(%rbp), %rax                              #58.11
        movq      %rax, -192(%rbp)                              #58.11
        movl      $4000000, %eax                                #59.11
        movq      %rax, %rdi                                    #59.11
..___tag_value_main.175:
#       operator new[](std::size_t)
        call      _Znam                                         #59.11
..___tag_value_main.176:
                                # LOE rax rbp rsp r12 r13 r14 r15 rip
..B17.29:                       # Preds ..B17.2
                                # Execution count [0.00e+00]
        movq      %rax, -184(%rbp)                              #59.11
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.3:                        # Preds ..B17.29
                                # Execution count [0.00e+00]
        movq      -184(%rbp), %rax                              #59.11
        movq      %rax, -176(%rbp)                              #59.11
        movl      $4000000, %eax                                #60.11
        movq      %rax, %rdi                                    #60.11
..___tag_value_main.177:
#       operator new[](std::size_t)
        call      _Znam                                         #60.11
..___tag_value_main.178:
                                # LOE rax rbp rsp r12 r13 r14 r15 rip
..B17.30:                       # Preds ..B17.3
                                # Execution count [0.00e+00]
        movq      %rax, -168(%rbp)                              #60.11
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.4:                        # Preds ..B17.30
                                # Execution count [0.00e+00]
        movq      -168(%rbp), %rax                              #60.11
        movq      %rax, -160(%rbp)                              #60.11
        movl      $4000000, %eax                                #61.11
        movq      %rax, %rdi                                    #61.11
..___tag_value_main.179:
#       operator new[](std::size_t)
        call      _Znam                                         #61.11
..___tag_value_main.180:
                                # LOE rax rbp rsp r12 r13 r14 r15 rip
..B17.31:                       # Preds ..B17.4
                                # Execution count [0.00e+00]
        movq      %rax, -152(%rbp)                              #61.11
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.5:                        # Preds ..B17.31
                                # Execution count [0.00e+00]
        movq      -152(%rbp), %rax                              #61.11
        movq      %rax, -144(%rbp)                              #61.11
        movl      $4000000, %eax                                #62.11
        movq      %rax, %rdi                                    #62.11
..___tag_value_main.181:
#       operator new[](std::size_t)
        call      _Znam                                         #62.11
..___tag_value_main.182:
                                # LOE rax rbp rsp r12 r13 r14 r15 rip
..B17.32:                       # Preds ..B17.5
                                # Execution count [0.00e+00]
        movq      %rax, -136(%rbp)                              #62.11
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.6:                        # Preds ..B17.32
                                # Execution count [0.00e+00]
        movq      -136(%rbp), %rax                              #62.11
        movq      %rax, -128(%rbp)                              #62.11
        movl      $4000000, %eax                                #63.11
        movq      %rax, %rdi                                    #63.11
..___tag_value_main.183:
#       operator new[](std::size_t)
        call      _Znam                                         #63.11
..___tag_value_main.184:
                                # LOE rax rbp rsp r12 r13 r14 r15 rip
..B17.33:                       # Preds ..B17.6
                                # Execution count [0.00e+00]
        movq      %rax, -120(%rbp)                              #63.11
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.7:                        # Preds ..B17.33
                                # Execution count [0.00e+00]
        movq      -120(%rbp), %rax                              #63.11
        movq      %rax, -112(%rbp)                              #63.11
        movl      $0, -224(%rbp)                                #65.13
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.8:                        # Preds ..B17.14 ..B17.7
                                # Execution count [0.00e+00]
        movl      -224(%rbp), %eax                              #65.18
        cmpl      $1000000, %eax                                #65.22
        jge       ..B17.15      # Prob 50%                      #65.22
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.9:                        # Preds ..B17.8
                                # Execution count [0.00e+00]
        pxor      %xmm0, %xmm0                                  #67.10
        movss     .L_2il0floatpacket.13(%rip), %xmm1            #67.10
..___tag_value_main.185:
#       random_data(float, float)
        call      _Z11random_dataff                             #67.10
..___tag_value_main.186:
                                # LOE rbp rsp r12 r13 r14 r15 rip xmm0
..B17.34:                       # Preds ..B17.9
                                # Execution count [0.00e+00]
        movss     %xmm0, -220(%rbp)                             #67.10
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.10:                       # Preds ..B17.34
                                # Execution count [0.00e+00]
        movl      -224(%rbp), %eax                              #67.5
        movslq    %eax, %rax                                    #67.3
        imulq     $4, %rax, %rax                                #67.3
        addq      -192(%rbp), %rax                              #67.3
        movss     -220(%rbp), %xmm0                             #67.10
        movss     %xmm0, (%rax)                                 #67.3
        movss     .L_2il0floatpacket.14(%rip), %xmm0            #68.10
        movss     .L_2il0floatpacket.15(%rip), %xmm1            #68.10
..___tag_value_main.187:
#       random_data(float, float)
        call      _Z11random_dataff                             #68.10
..___tag_value_main.188:
                                # LOE rbp rsp r12 r13 r14 r15 rip xmm0
..B17.35:                       # Preds ..B17.10
                                # Execution count [0.00e+00]
        movss     %xmm0, -216(%rbp)                             #68.10
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.11:                       # Preds ..B17.35
                                # Execution count [0.00e+00]
        movl      -224(%rbp), %eax                              #68.5
        movslq    %eax, %rax                                    #68.3
        imulq     $4, %rax, %rax                                #68.3
        addq      -176(%rbp), %rax                              #68.3
        movss     -216(%rbp), %xmm0                             #68.10
        movss     %xmm0, (%rax)                                 #68.3
        movss     .L_2il0floatpacket.16(%rip), %xmm0            #69.10
        movss     .L_2il0floatpacket.17(%rip), %xmm1            #69.10
..___tag_value_main.189:
#       random_data(float, float)
        call      _Z11random_dataff                             #69.10
..___tag_value_main.190:
                                # LOE rbp rsp r12 r13 r14 r15 rip xmm0
..B17.36:                       # Preds ..B17.11
                                # Execution count [0.00e+00]
        movss     %xmm0, -212(%rbp)                             #69.10
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.12:                       # Preds ..B17.36
                                # Execution count [0.00e+00]
        movl      -224(%rbp), %eax                              #69.5
        movslq    %eax, %rax                                    #69.3
        imulq     $4, %rax, %rax                                #69.3
        addq      -160(%rbp), %rax                              #69.3
        movss     -212(%rbp), %xmm0                             #69.10
        movss     %xmm0, (%rax)                                 #69.3
        movss     .L_2il0floatpacket.16(%rip), %xmm0            #70.10
        movss     .L_2il0floatpacket.18(%rip), %xmm1            #70.10
..___tag_value_main.191:
#       random_data(float, float)
        call      _Z11random_dataff                             #70.10
..___tag_value_main.192:
                                # LOE rbp rsp r12 r13 r14 r15 rip xmm0
..B17.37:                       # Preds ..B17.12
                                # Execution count [0.00e+00]
        movss     %xmm0, -208(%rbp)                             #70.10
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.13:                       # Preds ..B17.37
                                # Execution count [0.00e+00]
        movl      -224(%rbp), %eax                              #70.5
        movslq    %eax, %rax                                    #70.3
        imulq     $4, %rax, %rax                                #70.3
        addq      -144(%rbp), %rax                              #70.3
        movss     -208(%rbp), %xmm0                             #70.10
        movss     %xmm0, (%rax)                                 #70.3
        movss     .L_2il0floatpacket.16(%rip), %xmm0            #71.10
        movss     .L_2il0floatpacket.19(%rip), %xmm1            #71.10
..___tag_value_main.193:
#       random_data(float, float)
        call      _Z11random_dataff                             #71.10
..___tag_value_main.194:
                                # LOE rbp rsp r12 r13 r14 r15 rip xmm0
..B17.38:                       # Preds ..B17.13
                                # Execution count [0.00e+00]
        movss     %xmm0, -204(%rbp)                             #71.10
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.14:                       # Preds ..B17.38
                                # Execution count [0.00e+00]
        movl      -224(%rbp), %eax                              #71.5
        movslq    %eax, %rax                                    #71.3
        imulq     $4, %rax, %rax                                #71.3
        addq      -128(%rbp), %rax                              #71.3
        movss     -204(%rbp), %xmm0                             #71.10
        movss     %xmm0, (%rax)                                 #71.3
        pxor      %xmm0, %xmm0                                  #73.3
        movl      -224(%rbp), %eax                              #73.5
        movslq    %eax, %rax                                    #73.3
        imulq     $4, %rax, %rax                                #73.3
        addq      -112(%rbp), %rax                              #73.3
        movss     %xmm0, (%rax)                                 #73.3
        movl      $1, %eax                                      #65.27
        addl      -224(%rbp), %eax                              #65.27
        movl      %eax, -224(%rbp)                              #65.27
        jmp       ..B17.8       # Prob 100%                     #65.27
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.15:                       # Preds ..B17.8
                                # Execution count [0.00e+00]
..___tag_value_main.195:
        call      _ZNSt6chrono3_V212system_clock3nowEv          #77.12
..___tag_value_main.196:
                                # LOE rax rbp rsp r12 r13 r14 r15 rip
..B17.39:                       # Preds ..B17.15
                                # Execution count [0.00e+00]
        movq      %rax, -104(%rbp)                              #77.12
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.16:                       # Preds ..B17.39
                                # Execution count [0.00e+00]
        addq      $-16, %rsp                                    #79.2
        movq      -192(%rbp), %rax                              #79.2
        movq      -176(%rbp), %rdx                              #79.2
        movq      -128(%rbp), %rcx                              #79.2
        movq      -160(%rbp), %rbx                              #79.2
        movq      -144(%rbp), %rsi                              #79.2
        movq      -112(%rbp), %rdi                              #79.2
        movl      $1000000, (%rsp)                              #79.2
        movq      %rdi, -32(%rbp)                               #79.2[spill]
        movq      %rax, %rdi                                    #79.2
        movq      %rsi, -24(%rbp)                               #79.2[spill]
        movq      %rdx, %rsi                                    #79.2
        movq      %rcx, %rdx                                    #79.2
        movq      %rbx, %rcx                                    #79.2
        movq      -24(%rbp), %rax                               #79.2[spill]
        movq      %rax, %r8                                     #79.2
        movq      -32(%rbp), %rax                               #79.2[spill]
        movq      %rax, %r9                                     #79.2
..___tag_value_main.201:
#       call_price(float *, float *, float *, float *, float *, float *, int)
        call      _Z10call_pricePfS_S_S_S_S_i                   #79.2
..___tag_value_main.202:
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.40:                       # Preds ..B17.16
                                # Execution count [0.00e+00]
        addq      $16, %rsp                                     #79.2
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.17:                       # Preds ..B17.40
                                # Execution count [0.00e+00]
..___tag_value_main.203:
        call      _ZNSt6chrono3_V212system_clock3nowEv          #81.12
..___tag_value_main.204:
                                # LOE rax rbp rsp r12 r13 r14 r15 rip
..B17.41:                       # Preds ..B17.17
                                # Execution count [0.00e+00]
        movq      %rax, -96(%rbp)                               #81.12
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.18:                       # Preds ..B17.41
                                # Execution count [0.00e+00]
        movl      $_ZSt4cout, %eax                              #83.12
        movl      $.L_2__STRING.0, %edx                         #83.12
        movq      %rax, %rdi                                    #83.12
        movq      %rdx, %rsi                                    #83.12
..___tag_value_main.205:
#       std::operator<<<std::char_traits<char>>(std::basic_ostream<char, std::char_traits<char>> &, const char *)
        call      _ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc #83.12
..___tag_value_main.206:
                                # LOE rax rbp rsp r12 r13 r14 r15 rip
..B17.42:                       # Preds ..B17.18
                                # Execution count [0.00e+00]
        movq      %rax, -88(%rbp)                               #83.12
        jmp       ..B17.20      # Prob 100%                     #83.12
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.19:                       # Preds ..B17.46
                                # Execution count [0.00e+00]
        movq      -88(%rbp), %rax                               #83.32
        movq      -64(%rbp), %rdx                               #83.32
        movq      %rax, %rdi                                    #83.32
        movq      %rdx, %rsi                                    #83.32
..___tag_value_main.207:
#       std::basic_ostream<char, std::char_traits<char>>::operator<<(std::basic_ostream<char, std::char_traits<char>> *, long)
        call      _ZNSolsEl                                     #83.32
..___tag_value_main.208:
                                # LOE rax rbp rsp r12 r13 r14 r15 rip
..B17.43:                       # Preds ..B17.19
                                # Execution count [0.00e+00]
        movq      %rax, -56(%rbp)                               #83.32
        jmp       ..B17.23      # Prob 100%                     #83.32
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.20:                       # Preds ..B17.42
                                # Execution count [0.00e+00]
        lea       -96(%rbp), %rax                               #84.36
        lea       -104(%rbp), %rdx                              #84.36
        movq      %rax, %rdi                                    #84.36
        movq      %rdx, %rsi                                    #84.36
..___tag_value_main.209:
#       std::chrono::operator-<std::chrono::_V2::system_clock, std::chrono::_V2::system_clock::duration, std::chrono::_V2::system_clock::duration>(const std::chrono::time_point<std::chrono::_V2::system_clock, std::chrono::_V2::system_clock::duration> &, const std::chrono::time_point<std::chrono::_V2::system_clock, std::chrono::_V2::system_clock::duration> &)
        call      _ZNSt6chronomiINS_3_V212system_clockENS_8durationIlSt5ratioILl1ELl1000000000EEEES6_EENSt11common_typeIJT0_T1_EE4typeERKNS_10time_pointIT_S8_EERKNSC_ISD_S9_EE #84.36
..___tag_value_main.210:
                                # LOE rax rbp rsp r12 r13 r14 r15 rip
..B17.44:                       # Preds ..B17.20
                                # Execution count [0.00e+00]
        movq      %rax, -80(%rbp)                               #84.36
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.21:                       # Preds ..B17.44
                                # Execution count [0.00e+00]
        lea       -80(%rbp), %rax                               #84.31
        movq      %rax, %rdi                                    #84.31
..___tag_value_main.211:
#       std::chrono::duration_cast<std::chrono::milliseconds, int64_t, std::nano>(const std::chrono::duration<int64_t, std::nano> &)
        call      _ZNSt6chrono13duration_castINS_8durationIlSt5ratioILl1ELl1000EEEElS2_ILl1ELl1000000000EEEENSt9enable_ifIXsr3std6chrono13__is_durationIT_EE5valueES7_E4typeERKNS1_IT0_T1_EE #84.31
..___tag_value_main.212:
                                # LOE rax rbp rsp r12 r13 r14 r15 rip
..B17.45:                       # Preds ..B17.21
                                # Execution count [0.00e+00]
        movq      %rax, -72(%rbp)                               #84.31
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.22:                       # Preds ..B17.45
                                # Execution count [0.00e+00]
        lea       -72(%rbp), %rax                               #84.40
        movq      %rax, %rdi                                    #84.40
..___tag_value_main.213:
#       std::chrono::duration<int64_t, std::milli>::count(const std::chrono::duration<int64_t, std::milli> *) const
        call      _ZNKSt6chrono8durationIlSt5ratioILl1ELl1000EEE5countEv #84.40
..___tag_value_main.214:
                                # LOE rax rbp rsp r12 r13 r14 r15 rip
..B17.46:                       # Preds ..B17.22
                                # Execution count [0.00e+00]
        movq      %rax, -64(%rbp)                               #84.40
        jmp       ..B17.19      # Prob 100%                     #84.40
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.23:                       # Preds ..B17.43
                                # Execution count [0.00e+00]
        movq      -56(%rbp), %rax                               #84.48
        movl      $.L_2__STRING.1, %edx                         #84.48
        movq      %rax, %rdi                                    #84.48
        movq      %rdx, %rsi                                    #84.48
..___tag_value_main.215:
#       std::operator<<<std::char_traits<char>>(std::basic_ostream<char, std::char_traits<char>> &, const char *)
        call      _ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc #84.48
..___tag_value_main.216:
                                # LOE rax rbp rsp r12 r13 r14 r15 rip
..B17.47:                       # Preds ..B17.23
                                # Execution count [0.00e+00]
        movq      %rax, -48(%rbp)                               #84.48
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.24:                       # Preds ..B17.47
                                # Execution count [0.00e+00]
        movq      -48(%rbp), %rax                               #85.9
        movl      $_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_, %edx #85.9
        movq      %rax, %rdi                                    #85.9
        movq      %rdx, %rsi                                    #85.9
..___tag_value_main.217:
#       std::basic_ostream<char, std::char_traits<char>>::operator<<(std::basic_ostream<char, std::char_traits<char>> *, std::basic_ostream<char, std::char_traits<char>>::__ostream_type &(*)(std::basic_ostream<char, std::char_traits<char>>::__ostream_type &))
        call      _ZNSolsEPFRSoS_E                              #85.9
..___tag_value_main.218:
                                # LOE rax rbp rsp r12 r13 r14 r15 rip
..B17.48:                       # Preds ..B17.24
                                # Execution count [0.00e+00]
        movq      %rax, -40(%rbp)                               #85.9
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B17.25:                       # Preds ..B17.48
                                # Execution count [0.00e+00]
        movl      $0, %eax                                      #87.1
        movq      -16(%rbp), %rbx                               #87.1[spill]
	.cfi_restore 3
        leave                                                   #87.1
	.cfi_restore 6
        ret                                                     #87.1
                                # LOE
	.cfi_endproc
# mark_end;
	.type	main,@function
	.size	main,.-main
..LNmain.16:
	.data
# -- End  main
	.text
.L_2__routine_start___sti__$E_17:
# -- Begin  __sti__$E
	.bss
	.align 4
	.align 1
_ZN17_INTERNAL6a3cff1aSt8__ioinitE:
	.type	_ZN17_INTERNAL6a3cff1aSt8__ioinitE,@object
	.size	_ZN17_INTERNAL6a3cff1aSt8__ioinitE,1
	.space 1	# pad
	.section .ctors, "wa"
	.align 8
__init_0:
	.type	__init_0,@object
	.size	__init_0,8
	.quad	__sti__$E
	.text
# mark_begin;

# --- __sti__$E()
__sti__$E:
..B18.1:                        # Preds ..B18.0
                                # Execution count [0.00e+00]
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
..___tag_value___sti__$E.223:
..L224:
                                                        #
        pushq     %rbp                                          #
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        subq      $16, %rsp                                     #
        movl      $_ZN17_INTERNAL6a3cff1aSt8__ioinitE, %eax     #74.25
        movq      %rax, %rdi                                    #74.25
..___tag_value___sti__$E.228:
#       std::ios_base::Init::Init(std::ios_base::Init *)
        call      _ZNSt8ios_base4InitC1Ev                       #74.25
..___tag_value___sti__$E.229:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B18.2:                        # Preds ..B18.1
                                # Execution count [0.00e+00]
        movl      $_ZNSt8ios_base4InitD1Ev, %eax                #74.25
        movl      $_ZN17_INTERNAL6a3cff1aSt8__ioinitE, %edx     #74.25
        movl      $__dso_handle, %ecx                           #74.25
        movq      %rax, %rdi                                    #74.25
        movq      %rdx, %rsi                                    #74.25
        movq      %rcx, %rdx                                    #74.25
..___tag_value___sti__$E.230:
        call      __cxa_atexit                                  #74.25
..___tag_value___sti__$E.231:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip eax
..B18.6:                        # Preds ..B18.2
                                # Execution count [0.00e+00]
        movl      %eax, -16(%rbp)                               #74.25
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B18.3:                        # Preds ..B18.6
                                # Execution count [0.00e+00]
        leave                                                   #74.25
	.cfi_restore 6
        ret                                                     #74.25
                                # LOE
	.cfi_endproc
# mark_end;
	.type	__sti__$E,@function
	.size	__sti__$E,.-__sti__$E
..LN__sti__$E.17:
	.data
# -- End  __sti__$E
	.section .data._ZNSt14numeric_limitsIcE9is_signedE, "waG",@progbits,_ZNSt14numeric_limitsIcE9is_signedE,comdat
	.align 1
	.weak _ZNSt14numeric_limitsIcE9is_signedE
_ZNSt14numeric_limitsIcE9is_signedE:
	.type	_ZNSt14numeric_limitsIcE9is_signedE,@object
	.size	_ZNSt14numeric_limitsIcE9is_signedE,1
	.byte	1
	.section .data._ZNSt14numeric_limitsIwE9is_signedE, "waG",@progbits,_ZNSt14numeric_limitsIwE9is_signedE,comdat
	.align 1
	.weak _ZNSt14numeric_limitsIwE9is_signedE
_ZNSt14numeric_limitsIwE9is_signedE:
	.type	_ZNSt14numeric_limitsIwE9is_signedE,@object
	.size	_ZNSt14numeric_limitsIwE9is_signedE,1
	.byte	1
	.section .data._ZNSt14numeric_limitsIDsE9is_signedE, "waG",@progbits,_ZNSt14numeric_limitsIDsE9is_signedE,comdat
	.align 1
	.weak _ZNSt14numeric_limitsIDsE9is_signedE
_ZNSt14numeric_limitsIDsE9is_signedE:
	.type	_ZNSt14numeric_limitsIDsE9is_signedE,@object
	.size	_ZNSt14numeric_limitsIDsE9is_signedE,1
	.byte	0
	.section .data._ZNSt14numeric_limitsIDiE9is_signedE, "waG",@progbits,_ZNSt14numeric_limitsIDiE9is_signedE,comdat
	.align 1
	.weak _ZNSt14numeric_limitsIDiE9is_signedE
_ZNSt14numeric_limitsIDiE9is_signedE:
	.type	_ZNSt14numeric_limitsIDiE9is_signedE,@object
	.size	_ZNSt14numeric_limitsIDiE9is_signedE,1
	.byte	0
	.section .data._ZNSt14numeric_limitsIfE12has_infinityE, "waG",@progbits,_ZNSt14numeric_limitsIfE12has_infinityE,comdat
	.align 1
	.weak _ZNSt14numeric_limitsIfE12has_infinityE
_ZNSt14numeric_limitsIfE12has_infinityE:
	.type	_ZNSt14numeric_limitsIfE12has_infinityE,@object
	.size	_ZNSt14numeric_limitsIfE12has_infinityE,1
	.byte	1
	.section .data._ZNSt14numeric_limitsIfE13has_quiet_NaNE, "waG",@progbits,_ZNSt14numeric_limitsIfE13has_quiet_NaNE,comdat
	.align 1
	.weak _ZNSt14numeric_limitsIfE13has_quiet_NaNE
_ZNSt14numeric_limitsIfE13has_quiet_NaNE:
	.type	_ZNSt14numeric_limitsIfE13has_quiet_NaNE,@object
	.size	_ZNSt14numeric_limitsIfE13has_quiet_NaNE,1
	.byte	1
	.section .data._ZNSt14numeric_limitsIfE10has_denormE, "waG",@progbits,_ZNSt14numeric_limitsIfE10has_denormE,comdat
	.align 4
	.weak _ZNSt14numeric_limitsIfE10has_denormE
_ZNSt14numeric_limitsIfE10has_denormE:
	.type	_ZNSt14numeric_limitsIfE10has_denormE,@object
	.size	_ZNSt14numeric_limitsIfE10has_denormE,4
	.long	1
	.section .data._ZNSt14numeric_limitsIdE12has_infinityE, "waG",@progbits,_ZNSt14numeric_limitsIdE12has_infinityE,comdat
	.align 1
	.weak _ZNSt14numeric_limitsIdE12has_infinityE
_ZNSt14numeric_limitsIdE12has_infinityE:
	.type	_ZNSt14numeric_limitsIdE12has_infinityE,@object
	.size	_ZNSt14numeric_limitsIdE12has_infinityE,1
	.byte	1
	.section .data._ZNSt14numeric_limitsIdE13has_quiet_NaNE, "waG",@progbits,_ZNSt14numeric_limitsIdE13has_quiet_NaNE,comdat
	.align 1
	.weak _ZNSt14numeric_limitsIdE13has_quiet_NaNE
_ZNSt14numeric_limitsIdE13has_quiet_NaNE:
	.type	_ZNSt14numeric_limitsIdE13has_quiet_NaNE,@object
	.size	_ZNSt14numeric_limitsIdE13has_quiet_NaNE,1
	.byte	1
	.section .data._ZNSt14numeric_limitsIdE10has_denormE, "waG",@progbits,_ZNSt14numeric_limitsIdE10has_denormE,comdat
	.align 4
	.weak _ZNSt14numeric_limitsIdE10has_denormE
_ZNSt14numeric_limitsIdE10has_denormE:
	.type	_ZNSt14numeric_limitsIdE10has_denormE,@object
	.size	_ZNSt14numeric_limitsIdE10has_denormE,4
	.long	1
	.section .data._ZNSt14numeric_limitsIeE12has_infinityE, "waG",@progbits,_ZNSt14numeric_limitsIeE12has_infinityE,comdat
	.align 1
	.weak _ZNSt14numeric_limitsIeE12has_infinityE
_ZNSt14numeric_limitsIeE12has_infinityE:
	.type	_ZNSt14numeric_limitsIeE12has_infinityE,@object
	.size	_ZNSt14numeric_limitsIeE12has_infinityE,1
	.byte	1
	.section .data._ZNSt14numeric_limitsIeE13has_quiet_NaNE, "waG",@progbits,_ZNSt14numeric_limitsIeE13has_quiet_NaNE,comdat
	.align 1
	.weak _ZNSt14numeric_limitsIeE13has_quiet_NaNE
_ZNSt14numeric_limitsIeE13has_quiet_NaNE:
	.type	_ZNSt14numeric_limitsIeE13has_quiet_NaNE,@object
	.size	_ZNSt14numeric_limitsIeE13has_quiet_NaNE,1
	.byte	1
	.section .data._ZNSt14numeric_limitsIeE10has_denormE, "waG",@progbits,_ZNSt14numeric_limitsIeE10has_denormE,comdat
	.align 4
	.weak _ZNSt14numeric_limitsIeE10has_denormE
_ZNSt14numeric_limitsIeE10has_denormE:
	.type	_ZNSt14numeric_limitsIeE10has_denormE,@object
	.size	_ZNSt14numeric_limitsIeE10has_denormE,4
	.long	1
	.data
	.hidden __dso_handle
# mark_proc_addr_taken __sti__$E;
	.set _ZNSt6chrono13duration_castINS_8durationIlSt5ratioILl1ELl1000EEEElS2_ILl1ELl1000000000EEEENSt9enable_ifIXsrNS_13__is_durationIT_EE5valueES8_E4typeERKNS1_IT0_T1_EE,_ZNSt6chrono13duration_castINS_8durationIlSt5ratioILl1ELl1000EEEElS2_ILl1ELl1000000000EEEENSt9enable_ifIXsr3std6chrono13__is_durationIT_EE5valueES7_E4typeERKNS1_IT0_T1_EE
	.section .note.GNU-stack, ""
# End
