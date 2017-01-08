; ModuleID = 'test.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [4 x i8] c"%i\0A\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str1 = private constant [4 x i8] c"%f\0A\00", align 1 ; <[4 x i8]*> [#uses=1]

define void @foo(i32 %a, ...) nounwind {
entry:
  %y = alloca i8*, align 4
  %x = alloca i8*, align 4
  %ya = bitcast i8** %y to i8*
  %xa = bitcast i8** %x to i8*
  call void @llvm.va_start(i8* %ya)
  call void @llvm.va_start(i8* %xa)

  %0 = va_arg i8* %xa, i32
  %1 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %0) nounwind

  %2 = va_arg i8* %xa, double
  %3 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), double %2) nounwind

  call void @llvm.va_copy(i8* %xa, i8* %ya)

  %4 = va_arg i8* %xa, i32
  %5 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %4) nounwind

  call void @llvm.va_end(i8* %xa)

  %6 = va_arg i8* %ya, i32
  %7 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %6) nounwind

  %8 = va_arg i8* %ya, double
  %9 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), double %8) nounwind

  %10 = va_arg i8* %ya, i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %10) nounwind

  call void @llvm.va_end(i8* %ya)
  ret void
}

declare void @llvm.va_start(i8*) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind

declare void @llvm.va_copy(i8*, i8*) nounwind

declare void @llvm.va_end(i8*) nounwind

define i32 @main() nounwind {
entry:
  tail call void (i32, ...)* @foo(i32 0, i32 1, double 2.900000e+00, i32 3) nounwind
  ret i32 0
}
