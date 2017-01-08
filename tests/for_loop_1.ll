; ModuleID = 'for_loop.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str1 = private constant [9 x i8] c"loop %i\0A\00", align 1 ; <[9 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind {
entry:
  %num = alloca i32, align 4                      ; <i32*> [#uses=3]
  %0 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %num) nounwind ; <i32> [#uses=0]
  %1 = load i32* %num, align 4                    ; <i32> [#uses=1]
  %2 = icmp sgt i32 %1, 0                         ; <i1> [#uses=1]
  br i1 %2, label %bb, label %bb2

bb:                                               ; preds = %bb, %entry
  %3 = phi i32 [ 0, %entry ], [ %5, %bb ]         ; <i32> [#uses=2]
  %4 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([9 x i8]* @.str1, i32 0, i32 0), i32 %3) nounwind ; <i32> [#uses=0]
  %5 = add nsw i32 %3, 1                          ; <i32> [#uses=2]
  %6 = load i32* %num, align 4                    ; <i32> [#uses=1]
  %7 = icmp slt i32 %5, %6                        ; <i1> [#uses=1]
  br i1 %7, label %bb, label %bb2

bb2:                                              ; preds = %bb, %entry
  ret i32 0
}

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind
