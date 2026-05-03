; ModuleID = 'interp'
source_filename = "interp"

@panic_msg = private unnamed_addr constant [24 x i8] c"Panic reached! exiting!\00", align 1
@const_str = private constant [14 x i8] c"Hello Interp!\0A"

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

define void @"manta_interp_<init>"() {
entry:
  ret void
}

define { i64, ptr } @manta_interp_get_msg() {
entry:
  %test = alloca { { i64, ptr }, i32 }, align 8
  store { { i64, ptr }, i32 } { { i64, ptr } { i64 14, ptr @const_str }, i32 0 }, ptr %test, align 8
  %struct_gep = getelementptr inbounds nuw { { i64, ptr }, i32 }, ptr %test, i32 0, i32 0
  %load = load { i64, ptr }, ptr %struct_gep, align 8
  ret { i64, ptr } %load
}
