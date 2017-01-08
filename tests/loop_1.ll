; ModuleID = 'loop.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str1 = private constant [12 x i8] c"loop 1: %i\0A\00", align 1 ; <[12 x i8]*> [#uses=1]
@.str2 = private constant [16 x i8] c"loop 2: %i, %i\0A\00", align 1 ; <[16 x i8]*> [#uses=1]
@.str3 = private constant [12 x i8] c"loop 3: %i\0A\00", align 1 ; <[12 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind {
entry:
  %b = alloca i32, align 4                        ; <i32*> [#uses=2]
  %a = alloca i32, align 4                        ; <i32*> [#uses=5]
  %0 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %a) nounwind ; <i32> [#uses=0]
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %b) nounwind ; <i32> [#uses=0]
  %2 = load i32* %a, align 4                      ; <i32> [#uses=2]
  %3 = icmp sgt i32 %2, 0                         ; <i1> [#uses=1]
  br i1 %3, label %bb, label %bb5

bb:                                               ; preds = %bb3, %entry
  %z.112 = phi i32 [ 1, %entry ], [ %z.0.lcssa, %bb3 ] ; <i32> [#uses=3]
  %4 = phi i32 [ 0, %entry ], [ %tmp, %bb3 ]      ; <i32> [#uses=4]
  %tmp = add i32 %4, 1                            ; <i32> [#uses=2]
  %5 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([12 x i8]* @.str1, i32 0, i32 0), i32 %4, i32 %z.112) nounwind ; <i32> [#uses=0]
  %6 = icmp sgt i32 %4, 0                         ; <i1> [#uses=1]
  br i1 %6, label %bb1, label %bb3

bb1:                                              ; preds = %bb1, %bb
  %z.09 = phi i32 [ %z.112, %bb ], [ %10, %bb1 ]  ; <i32> [#uses=2]
  %7 = phi i32 [ 0, %bb ], [ %11, %bb1 ]          ; <i32> [#uses=2]
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([16 x i8]* @.str2, i32 0, i32 0), i32 %7, i32 %z.09) nounwind ; <i32> [#uses=0]
  %9 = load i32* %b, align 4                      ; <i32> [#uses=1]
  %10 = mul i32 %9, %z.09                         ; <i32> [#uses=2]
  %11 = add nsw i32 %7, 1                         ; <i32> [#uses=2]
  %exitcond = icmp eq i32 %11, %4                 ; <i1> [#uses=1]
  br i1 %exitcond, label %bb3, label %bb1

bb3:                                              ; preds = %bb1, %bb
  %z.0.lcssa = phi i32 [ %z.112, %bb ], [ %10, %bb1 ] ; <i32> [#uses=1]
  %12 = load i32* %a, align 4                     ; <i32> [#uses=2]
  %13 = icmp slt i32 %tmp, %12                    ; <i1> [#uses=1]
  br i1 %13, label %bb, label %bb5

bb5:                                              ; preds = %bb5, %entry, %bb3
  %14 = phi i32 [ %2, %entry ], [ %12, %bb3 ], [ %17, %bb5 ] ; <i32> [#uses=1]
  %15 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([12 x i8]* @.str3, i32 0, i32 0), i32 %14) nounwind ; <i32> [#uses=0]
  %16 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %17 = add i32 %16, -1                           ; <i32> [#uses=3]
  store i32 %17, i32* %a, align 4
  %18 = icmp sgt i32 %17, 0                       ; <i1> [#uses=1]
  br i1 %18, label %bb5, label %bb6

bb6:                                              ; preds = %bb5
  ret i32 0
}

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind
