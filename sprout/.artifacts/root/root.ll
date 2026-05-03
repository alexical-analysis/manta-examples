; ModuleID = 'root'
source_filename = "root"

@panic_msg = private unnamed_addr constant [24 x i8] c"Panic reached! exiting!\00", align 1

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

declare {} @manta_parser_new_parser()

declare { i64, ptr } @manta_interp_get_msg()

define internal void @manta_main() {
entry:
  %p = alloca {}, align 8
  %msg = alloca { i64, ptr }, align 8
  %new_parser = call {} @manta_parser_new_parser()
  store {} %new_parser, ptr %p, align 1
  %get_msg = call { i64, ptr } @manta_interp_get_msg()
  store { i64, ptr } %get_msg, ptr %msg, align 8
  %load = load { i64, ptr }, ptr %msg, align 8
  call void @a({ i64, ptr } %load)
  ret void
}

define i32 @main() {
entry:
  call void @"manta_<init>"()
  call void @manta_main()
  ret i32 0
}

define internal void @a({ i64, ptr } %0) {
entry:
  %msg = alloca { i64, ptr }, align 8
  store { i64, ptr } %0, ptr %msg, align 8
  %load = load { i64, ptr }, ptr %msg, align 8
  call void @b({ i64, ptr } %load)
  ret void
}

define internal void @b({ i64, ptr } %0) {
entry:
  %msg = alloca { i64, ptr }, align 8
  store { i64, ptr } %0, ptr %msg, align 8
  %load = load { i64, ptr }, ptr %msg, align 8
  call void @print({ i64, ptr } %load)
  ret void
}
