; ModuleID = 'error_handling'
source_filename = "error_handling"

@panic_msg = private unnamed_addr constant [24 x i8] c"Panic reached! exiting!\00", align 1
@const_str = private constant [4 x i8] c"---\0A"
@const_str.1 = private constant [8 x i8] c"success\0A"
@const_str.2 = private constant [23 x i8] c"can not divide by zero\0A"
@const_str.3 = private constant [11 x i8] c"div failed\0A"
@const_str.4 = private constant [1 x i8] c"_"

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

define internal void @manta_main() {
entry:
  %got = alloca { i8, [8 x i8] }, align 8
  %got1 = alloca i64, align 8
  %"<match target>" = alloca { i8, [8 x i8] }, align 8
  %got2 = alloca i64, align 8
  %got3 = alloca i64, align 8
  %"<match target>4" = alloca { i8, [8 x i8] }, align 8
  %got5 = alloca i64, align 8
  %panic = alloca { i8, [8 x i8] }, align 8
  call void @print({ i64, ptr } { i64 4, ptr @const_str })
  %div = call { i8, [8 x i8] } @div(i64 10, i64 5)
  store { i8, [8 x i8] } %div, ptr %got, align 1
  %load = load { i8, [8 x i8] }, ptr %got, align 1
  %ext_tag = extractvalue { i8, [8 x i8] } %load, 0
  switch i8 %ext_tag, label %Block_7 [
    i8 0, label %Block_3
    i8 1, label %Block_5
  ]

Block_2:                                          ; preds = %Block_6, %Block_4
  %div6 = call { i8, [8 x i8] } @div(i64 20, i64 5)
  store { i8, [8 x i8] } %div6, ptr %"<match target>", align 1
  %ext_tag7 = extractvalue { i8, [8 x i8] } %div6, 0
  switch i8 %ext_tag7, label %Block_11 [
    i8 0, label %Block_9
  ]

Block_3:                                          ; preds = %entry
  call void @print({ i64, ptr } { i64 8, ptr @const_str.1 })
  br label %Block_4

Block_4:                                          ; preds = %Block_3
  br label %Block_2

Block_5:                                          ; preds = %entry
  call void @print({ i64, ptr } { i64 23, ptr @const_str.2 })
  br label %Block_6

Block_6:                                          ; preds = %Block_5
  br label %Block_2

Block_7:                                          ; preds = %entry
  unreachable

Block_8:                                          ; preds = %Block_12, %Block_10
  store i64 0, ptr %got1, align 8
  %div8 = call { i8, [8 x i8] } @div(i64 0, i64 0)
  store { i8, [8 x i8] } %div8, ptr %"<match target>4", align 1
  %ext_tag9 = extractvalue { i8, [8 x i8] } %div8, 0
  switch i8 %ext_tag9, label %Block_16 [
    i8 0, label %Block_14
  ]

Block_9:                                          ; preds = %Block_2
  %ext_pay = getelementptr inbounds nuw { i8, [8 x i8] }, ptr %"<match target>", i32 0, i32 1
  %load10 = load i64, ptr %ext_pay, align 8
  store i64 %load10, ptr %got2, align 8
  %load11 = load i64, ptr %got2, align 8
  store i64 %load11, ptr %got1, align 8
  br label %Block_10

Block_10:                                         ; preds = %Block_9
  br label %Block_8

Block_11:                                         ; preds = %Block_2
  call void @print({ i64, ptr } { i64 11, ptr @const_str.3 })
  br label %Block_12

Block_12:                                         ; preds = %Block_11
  br label %Block_8

Block_13:                                         ; preds = %Block_15
  ret void

Block_14:                                         ; preds = %Block_8
  %ext_pay12 = getelementptr inbounds nuw { i8, [8 x i8] }, ptr %"<match target>4", i32 0, i32 1
  %load13 = load i64, ptr %ext_pay12, align 8
  store i64 %load13, ptr %got5, align 8
  %load14 = load i64, ptr %got5, align 8
  store i64 %load14, ptr %got3, align 8
  br label %Block_15

Block_15:                                         ; preds = %Block_14
  br label %Block_13

Block_16:                                         ; preds = %Block_8
  store { i8, [8 x i8] } %div8, ptr %panic, align 1
  call void @panic()
  unreachable
}

define i32 @main() {
entry:
  call void @"manta_<init>"()
  call void @manta_main()
  ret i32 0
}

define internal { i8, [8 x i8] } @div(i64 %0, i64 %1) {
entry:
  %tmp = alloca [8 x i8], align 1
  %a = alloca i64, align 8
  %b = alloca i64, align 8
  store i64 %0, ptr %a, align 4
  store i64 %1, ptr %b, align 4
  %load = load i64, ptr %b, align 8
  switch i64 %load, label %Block_5 [
    i64 0, label %Block_3
  ]

Block_3:                                          ; preds = %entry
  ret { i8, [8 x i8] } { i8 1, [8 x i8] undef }

Block_5:                                          ; preds = %entry
  %load1 = load i64, ptr %a, align 8
  %load2 = load i64, ptr %b, align 8
  %sdiv = sdiv i64 %load1, %load2
  store i64 %sdiv, ptr %tmp, align 8
  %load3 = load [8 x i8], ptr %tmp, align 1
  %set_pay = insertvalue { i8, [8 x i8] } { i8 0, [8 x i8] undef }, [8 x i8] %load3, 1
  ret { i8, [8 x i8] } %set_pay
}
