; ModuleID = 'return_by_pointer.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str1 = private constant [4 x i8] c"%i\0A\00", align 1 ; <[4 x i8]*> [#uses=1]

define void @getNumber(i32* nocapture %ret) nounwind {
entry:
  %num = alloca i32, align 4                      ; <i32*> [#uses=2]
  %0 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %num) nounwind ; <i32> [#uses=0]
  %1 = load i32* %num, align 4                    ; <i32> [#uses=1]
  store i32 %1, i32* %ret, align 4
  ret void
}

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind {
entry:
  %ret = alloca i32, align 4                      ; <i32*> [#uses=2]
  call void @getNumber(i32* %ret) nounwind
  %0 = load i32* %ret, align 4                    ; <i32> [#uses=1]
  %1 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %0) nounwind ; <i32> [#uses=0]
  ret i32 0
}

declare i32 @printf(i8* nocapture, ...) nounwind
