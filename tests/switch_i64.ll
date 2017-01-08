; ModuleID = 'test.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str1 = private constant [2 x i8] c"0\00", align 1 ; <[2 x i8]*> [#uses=1]
@.str2 = private constant [2 x i8] c"1\00", align 1 ; <[2 x i8]*> [#uses=1]
@.str3 = private constant [4 x i8] c"def\00", align 1 ; <[4 x i8]*> [#uses=1]

define i32 @main() nounwind {
entry:
  %a = alloca i32, align 4                        ; <i32*> [#uses=3]
  br label %bb

bb:                                               ; preds = %bb4, %entry
  %0 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %a) nounwind ; <i32> [#uses=0]
  %1 = load i32* %a, align 4                      ; <i32> [#uses=1]
  %b = zext i32 %1 to i64
  switch i64 %b, label %bb3 [
    i64 0, label %bb1
    i64 1, label %bb2
  ]

bb1:                                              ; preds = %bb
  %2 = call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @.str1, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  br label %bb4

bb2:                                              ; preds = %bb
  %3 = call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @.str2, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  br label %bb4

bb3:                                              ; preds = %bb
  %4 = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @.str3, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  br label %bb4

bb4:                                              ; preds = %bb3, %bb2, %bb1
  %5 = load i32* %a, align 4                      ; <i32> [#uses=1]
  %6 = icmp eq i32 %5, -1                         ; <i1> [#uses=1]
  br i1 %6, label %bb5, label %bb

bb5:                                              ; preds = %bb4
  ret i32 0
}

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind

declare i32 @puts(i8* nocapture) nounwind
