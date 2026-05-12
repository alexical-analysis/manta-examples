; ModuleID = 'defer_stmt'
source_filename = "defer_stmt"

@panic_msg = private unnamed_addr constant [24 x i8] c"Panic reached! exiting!\00", align 1
@const_str = private constant [4 x i8] c"---\0A"
@const_str.1 = private constant [16 x i8] c"enter the block\0A"
@const_str.2 = private constant [13 x i8] c"in the block\0A"
@const_str.3 = private constant [24 x i8] c"in the block in a block\0A"
@const_str.4 = private constant [42 x i8] c"defer: from inside a block inside a block\0A"
@const_str.5 = private constant [27 x i8] c"defer: from inside a block\0A"
@const_str.6 = private constant [13 x i8] c"main is done\0A"
@const_str.7 = private constant [30 x i8] c"defer: this is second to last\0A"
@const_str.8 = private constant [20 x i8] c"defer: this is last\0A"

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
  call void @print({ i64, ptr } { i64 4, ptr @const_str })
  call void @print({ i64, ptr } { i64 16, ptr @const_str.1 })
  call void @print({ i64, ptr } { i64 13, ptr @const_str.2 })
  call void @print({ i64, ptr } { i64 24, ptr @const_str.3 })
  br label %Block_8

Block_8:                                          ; preds = %entry
  call void @print({ i64, ptr } { i64 42, ptr @const_str.4 })
  br label %Block_9

Block_9:                                          ; preds = %Block_8
  br label %Block_20

Block_20:                                         ; preds = %Block_9
  br label %Block_21

Block_21:                                         ; preds = %Block_20
  call void @print({ i64, ptr } { i64 27, ptr @const_str.5 })
  br label %Block_22

Block_22:                                         ; preds = %Block_21
  br label %Block_33

Block_33:                                         ; preds = %Block_22
  call void @print({ i64, ptr } { i64 13, ptr @const_str.6 })
  br label %Block_38

Block_38:                                         ; preds = %Block_33
  call void @print({ i64, ptr } { i64 30, ptr @const_str.7 })
  br label %Block_39

Block_39:                                         ; preds = %Block_38
  br label %Block_46

Block_46:                                         ; preds = %Block_39
  call void @print({ i64, ptr } { i64 20, ptr @const_str.8 })
  br label %Block_47

Block_47:                                         ; preds = %Block_46
  br label %Block_53

Block_53:                                         ; preds = %Block_47
  ret void
}

define i32 @main() {
entry:
  call void @"manta_<init>"()
  call void @manta_main()
  ret i32 0
}
