; ModuleID = 'root'
source_filename = "root"

@panic_msg = private unnamed_addr constant [24 x i8] c"Panic reached! exiting!\00", align 1
@const_str = private constant [1 x i8] c"0"
@const_str.1 = private constant [1 x i8] c"1"
@const_str.2 = private constant [1 x i8] c"2"
@const_str.3 = private constant [1 x i8] c"3"
@const_str.4 = private constant [1 x i8] c"4"
@const_str.5 = private constant [1 x i8] c"5"
@const_str.6 = private constant [1 x i8] c"6"
@const_str.7 = private constant [1 x i8] c"7"
@const_str.8 = private constant [1 x i8] c"8"
@const_str.9 = private constant [1 x i8] c"9"
@const_str.10 = private constant [1 x i8] c"\0A"
@const_str.11 = private constant [10 x i8] c"fib(80) = "

declare ptr @malloc(i64)

declare void @free(ptr)

declare i32 @puts(ptr)

declare void @abort()

declare i64 @write(i32, ptr, i64)

define internal void @panic() {
entry:
  %puts = call i32 @puts(ptr @panic_msg)
  call void @abort()
  unreachable
}

define internal ptr @alloc({ i64, i64, i64 } %0) {
entry:
  %meta_size = extractvalue { i64, i64, i64 } %0, 0
  %malloc = call ptr @malloc(i64 %meta_size)
  ret ptr %malloc
}

define internal void @print({ i64, ptr } %0) {
entry:
  %len = extractvalue { i64, ptr } %0, 0
  %ptr = extractvalue { i64, ptr } %0, 1
  %write = call i64 @write(i32 1, ptr %ptr, i64 %len)
  ret void
}

define internal void @eprint({ i64, ptr } %0) {
entry:
  %len = extractvalue { i64, ptr } %0, 0
  %ptr = extractvalue { i64, ptr } %0, 1
  %write = call i64 @write(i32 2, ptr %ptr, i64 %len)
  ret void
}

define void @"manta_<init>"() {
entry:
  ret void
}

define internal i64 @fib(i64 %0) {
entry:
  %n = alloca i64, align 8
  %a = alloca i64, align 8
  %b = alloca i64, align 8
  %i = alloca i64, align 8
  %c = alloca i64, align 8
  store i64 %0, ptr %n, align 4
  %load = load i64, ptr %n, align 8
  %sle = icmp sle i64 %load, 1
  br i1 %sle, label %Block_2, label %Block_3

Block_2:                                          ; preds = %entry
  %load1 = load i64, ptr %n, align 8
  ret i64 %load1

Block_3:                                          ; preds = %entry
  store i64 0, ptr %a, align 8
  store i64 1, ptr %b, align 8
  store i64 2, ptr %i, align 8
  br label %Block_5

Block_5:                                          ; preds = %Block_9, %Block_3
  %load2 = load i64, ptr %i, align 8
  %load3 = load i64, ptr %n, align 8
  %sle4 = icmp sle i64 %load2, %load3
  %not = xor i1 %sle4, true
  br i1 %not, label %Block_6, label %Block_7

Block_6:                                          ; preds = %Block_5
  br label %Block_10

Block_7:                                          ; preds = %Block_5
  %load5 = load i64, ptr %a, align 8
  %load6 = load i64, ptr %b, align 8
  %iadd = add i64 %load5, %load6
  store i64 %iadd, ptr %c, align 8
  %load7 = load i64, ptr %b, align 8
  store i64 %load7, ptr %a, align 8
  %load8 = load i64, ptr %c, align 8
  store i64 %load8, ptr %b, align 8
  %load9 = load i64, ptr %i, align 8
  %iadd10 = add i64 %load9, 1
  store i64 %iadd10, ptr %i, align 8
  br label %Block_9

Block_9:                                          ; preds = %Block_7
  br label %Block_5

Block_10:                                         ; preds = %Block_6
  %load11 = load i64, ptr %b, align 8
  ret i64 %load11
}

define internal void @print_num(i64 %0) {
entry:
  %n = alloca i64, align 8
  %divisor = alloca i64, align 8
  store i64 %0, ptr %n, align 4
  store i64 1, ptr %divisor, align 8
  br label %Block_2

Block_2:                                          ; preds = %Block_6, %entry
  %load = load i64, ptr %divisor, align 8
  %imul = mul i64 %load, 10
  %load1 = load i64, ptr %n, align 8
  %sle = icmp sle i64 %imul, %load1
  %not = xor i1 %sle, true
  br i1 %not, label %Block_3, label %Block_4

Block_3:                                          ; preds = %Block_2
  br label %Block_7

Block_4:                                          ; preds = %Block_2
  %load2 = load i64, ptr %divisor, align 8
  %imul3 = mul i64 %load2, 10
  store i64 %imul3, ptr %divisor, align 8
  br label %Block_6

Block_6:                                          ; preds = %Block_4
  br label %Block_2

Block_7:                                          ; preds = %Block_3
  br label %Block_8

Block_8:                                          ; preds = %Block_34, %Block_7
  %load4 = load i64, ptr %divisor, align 8
  %sgt = icmp sgt i64 %load4, 0
  %not5 = xor i1 %sgt, true
  br i1 %not5, label %Block_9, label %Block_10

Block_9:                                          ; preds = %Block_8
  br label %Block_35

Block_10:                                         ; preds = %Block_8
  %load6 = load i64, ptr %n, align 8
  %load7 = load i64, ptr %divisor, align 8
  %sdiv = sdiv i64 %load6, %load7
  %srem = srem i64 %sdiv, 10
  switch i64 %srem, label %Block_33 [
    i64 0, label %Block_13
    i64 1, label %Block_15
    i64 2, label %Block_17
    i64 3, label %Block_19
    i64 4, label %Block_21
    i64 5, label %Block_23
    i64 6, label %Block_25
    i64 7, label %Block_27
    i64 8, label %Block_29
    i64 9, label %Block_31
  ]

Block_12:                                         ; preds = %Block_32, %Block_30, %Block_28, %Block_26, %Block_24, %Block_22, %Block_20, %Block_18, %Block_16, %Block_14
  %load8 = load i64, ptr %divisor, align 8
  %sdiv9 = sdiv i64 %load8, 10
  store i64 %sdiv9, ptr %divisor, align 8
  br label %Block_34

Block_13:                                         ; preds = %Block_10
  call void @print({ i64, ptr } { i64 1, ptr @const_str })
  br label %Block_14

Block_14:                                         ; preds = %Block_13
  br label %Block_12

Block_15:                                         ; preds = %Block_10
  call void @print({ i64, ptr } { i64 1, ptr @const_str.1 })
  br label %Block_16

Block_16:                                         ; preds = %Block_15
  br label %Block_12

Block_17:                                         ; preds = %Block_10
  call void @print({ i64, ptr } { i64 1, ptr @const_str.2 })
  br label %Block_18

Block_18:                                         ; preds = %Block_17
  br label %Block_12

Block_19:                                         ; preds = %Block_10
  call void @print({ i64, ptr } { i64 1, ptr @const_str.3 })
  br label %Block_20

Block_20:                                         ; preds = %Block_19
  br label %Block_12

Block_21:                                         ; preds = %Block_10
  call void @print({ i64, ptr } { i64 1, ptr @const_str.4 })
  br label %Block_22

Block_22:                                         ; preds = %Block_21
  br label %Block_12

Block_23:                                         ; preds = %Block_10
  call void @print({ i64, ptr } { i64 1, ptr @const_str.5 })
  br label %Block_24

Block_24:                                         ; preds = %Block_23
  br label %Block_12

Block_25:                                         ; preds = %Block_10
  call void @print({ i64, ptr } { i64 1, ptr @const_str.6 })
  br label %Block_26

Block_26:                                         ; preds = %Block_25
  br label %Block_12

Block_27:                                         ; preds = %Block_10
  call void @print({ i64, ptr } { i64 1, ptr @const_str.7 })
  br label %Block_28

Block_28:                                         ; preds = %Block_27
  br label %Block_12

Block_29:                                         ; preds = %Block_10
  call void @print({ i64, ptr } { i64 1, ptr @const_str.8 })
  br label %Block_30

Block_30:                                         ; preds = %Block_29
  br label %Block_12

Block_31:                                         ; preds = %Block_10
  call void @print({ i64, ptr } { i64 1, ptr @const_str.9 })
  br label %Block_32

Block_32:                                         ; preds = %Block_31
  br label %Block_12

Block_33:                                         ; preds = %Block_10
  unreachable

Block_34:                                         ; preds = %Block_12
  br label %Block_8

Block_35:                                         ; preds = %Block_9
  call void @print({ i64, ptr } { i64 1, ptr @const_str.10 })
  ret void
}

define internal void @manta_main() {
entry:
  %n = alloca i64, align 8
  %fib = call i64 @fib(i64 80)
  store i64 %fib, ptr %n, align 8
  call void @print({ i64, ptr } { i64 10, ptr @const_str.11 })
  %load = load i64, ptr %n, align 8
  call void @print_num(i64 %load)
  ret void
}

define i32 @main() {
entry:
  call void @"manta_<init>"()
  call void @manta_main()
  ret i32 0
}
