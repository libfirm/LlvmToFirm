; ModuleID = 'switch.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str1 = private constant [4 x i8] c"%i\0A\00", align 1 ; <[4 x i8]*> [#uses=1]

define i32 @main() nounwind {
entry:
  %a = alloca i32, align 4                        ; <i32*> [#uses=6]
  br label %bb

bb:                                               ; preds = %bb32, %entry
  %0 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %a) nounwind ; <i32> [#uses=0]
  %1 = load i32* %a, align 4                      ; <i32> [#uses=1]
  %cond = icmp eq i32 %1, -2                      ; <i1> [#uses=1]
  %b.0 = select i1 %cond, i32 -2, i32 0           ; <i32> [#uses=1]
  %2 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %b.0) nounwind ; <i32> [#uses=0]
  %3 = load i32* %a, align 4                      ; <i32> [#uses=1]
  switch i32 %3, label %bb5 [
    i32 -2, label %bb3
    i32 2, label %bb4
  ]

bb3:                                              ; preds = %bb
  br label %bb5

bb4:                                              ; preds = %bb
  br label %bb5

bb5:                                              ; preds = %bb, %bb4, %bb3
  %b.1 = phi i32 [ 2, %bb4 ], [ -2, %bb3 ], [ 0, %bb ] ; <i32> [#uses=2]
  %4 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %b.1) nounwind ; <i32> [#uses=0]
  %5 = load i32* %a, align 4                      ; <i32> [#uses=1]
  switch i32 %5, label %bb18 [
    i32 -2, label %bb19
    i32 2, label %bb7
    i32 3, label %bb8
    i32 5, label %bb9
    i32 7, label %bb10
    i32 11, label %bb11
    i32 13, label %bb12
    i32 17, label %bb13
    i32 19, label %bb14
    i32 23, label %bb15
    i32 29, label %bb16
    i32 30, label %bb17
  ]

bb7:                                              ; preds = %bb5
  br label %bb19

bb8:                                              ; preds = %bb5
  br label %bb19

bb9:                                              ; preds = %bb5
  br label %bb19

bb10:                                             ; preds = %bb5
  br label %bb19

bb11:                                             ; preds = %bb5
  br label %bb19

bb12:                                             ; preds = %bb5
  br label %bb19

bb13:                                             ; preds = %bb5
  br label %bb19

bb14:                                             ; preds = %bb5
  br label %bb19

bb15:                                             ; preds = %bb5
  br label %bb19

bb16:                                             ; preds = %bb5
  br label %bb19

bb17:                                             ; preds = %bb5
  br label %bb18

bb18:                                             ; preds = %bb5, %bb17
  %b.3 = phi i32 [ 30, %bb17 ], [ %b.1, %bb5 ]    ; <i32> [#uses=2]
  %6 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %b.3) nounwind ; <i32> [#uses=0]
  br label %bb19

bb19:                                             ; preds = %bb5, %bb18, %bb16, %bb15, %bb14, %bb13, %bb12, %bb11, %bb10, %bb9, %bb8, %bb7
  %b.2 = phi i32 [ %b.3, %bb18 ], [ 29, %bb16 ], [ 23, %bb15 ], [ 19, %bb14 ], [ 17, %bb13 ], [ 13, %bb12 ], [ 11, %bb11 ], [ 7, %bb10 ], [ 5, %bb9 ], [ 3, %bb8 ], [ 2, %bb7 ], [ -2, %bb5 ] ; <i32> [#uses=1]
  %7 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %b.2) nounwind ; <i32> [#uses=0]
  %8 = load i32* %a, align 4                      ; <i32> [#uses=1]
  switch i32 %8, label %bb31 [
    i32 2, label %bb32
    i32 3, label %bb21
    i32 5, label %bb22
    i32 7, label %bb23
    i32 11, label %bb24
    i32 13, label %bb25
    i32 17, label %bb26
    i32 19, label %bb27
    i32 23, label %bb28
    i32 29, label %bb29
    i32 30, label %bb30
  ]

bb21:                                             ; preds = %bb19
  br label %bb32

bb22:                                             ; preds = %bb19
  br label %bb32

bb23:                                             ; preds = %bb19
  br label %bb32

bb24:                                             ; preds = %bb19
  br label %bb32

bb25:                                             ; preds = %bb19
  br label %bb32

bb26:                                             ; preds = %bb19
  br label %bb32

bb27:                                             ; preds = %bb19
  br label %bb32

bb28:                                             ; preds = %bb19
  br label %bb32

bb29:                                             ; preds = %bb19
  br label %bb32

bb30:                                             ; preds = %bb19
  br label %bb31

bb31:                                             ; preds = %bb19, %bb30
  %b.5 = phi i32 [ 30, %bb30 ], [ 0, %bb19 ]      ; <i32> [#uses=2]
  %9 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %b.5) nounwind ; <i32> [#uses=0]
  br label %bb32

bb32:                                             ; preds = %bb19, %bb31, %bb29, %bb28, %bb27, %bb26, %bb25, %bb24, %bb23, %bb22, %bb21
  %b.4 = phi i32 [ %b.5, %bb31 ], [ 29, %bb29 ], [ 23, %bb28 ], [ 19, %bb27 ], [ 17, %bb26 ], [ 13, %bb25 ], [ 11, %bb24 ], [ 7, %bb23 ], [ 5, %bb22 ], [ 3, %bb21 ], [ 2, %bb19 ] ; <i32> [#uses=1]
  %10 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %b.4) nounwind ; <i32> [#uses=0]
  %11 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %12 = icmp eq i32 %11, -1                       ; <i1> [#uses=1]
  br i1 %12, label %bb33, label %bb

bb33:                                             ; preds = %bb32
  ret i32 0
}

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind
