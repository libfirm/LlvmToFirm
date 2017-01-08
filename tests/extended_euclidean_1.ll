; ModuleID = 'extended_euclidean.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str1 = private constant [20 x i8] c"%i*%i + %i*%i = %i\0A\00", align 1 ; <[20 x i8]*> [#uses=1]

define i32 @egcd(i32 %a, i32 %b, i32* nocapture %r, i32* nocapture %s) nounwind {
entry:
  %0 = icmp eq i32 %b, 0                          ; <i1> [#uses=1]
  br i1 %0, label %bb2, label %bb

bb:                                               ; preds = %bb, %entry
  %a_addr.09 = phi i32 [ %a, %entry ], [ %b_addr.08, %bb ] ; <i32> [#uses=2]
  %b_addr.08 = phi i32 [ %b, %entry ], [ %2, %bb ] ; <i32> [#uses=4]
  %x.07 = phi i32 [ 0, %entry ], [ %4, %bb ]      ; <i32> [#uses=3]
  %lastx.06 = phi i32 [ 1, %entry ], [ %x.07, %bb ] ; <i32> [#uses=1]
  %y.05 = phi i32 [ 1, %entry ], [ %6, %bb ]      ; <i32> [#uses=3]
  %lasty.04 = phi i32 [ 0, %entry ], [ %y.05, %bb ] ; <i32> [#uses=1]
  %1 = sdiv i32 %a_addr.09, %b_addr.08            ; <i32> [#uses=2]
  %2 = srem i32 %a_addr.09, %b_addr.08            ; <i32> [#uses=2]
  %3 = mul i32 %1, %x.07                          ; <i32> [#uses=1]
  %4 = sub i32 %lastx.06, %3                      ; <i32> [#uses=1]
  %5 = mul i32 %1, %y.05                          ; <i32> [#uses=1]
  %6 = sub i32 %lasty.04, %5                      ; <i32> [#uses=1]
  %phitmp = icmp eq i32 %2, 0                     ; <i1> [#uses=1]
  br i1 %phitmp, label %bb2, label %bb

bb2:                                              ; preds = %bb, %entry
  %a_addr.0.lcssa = phi i32 [ %a, %entry ], [ %b_addr.08, %bb ] ; <i32> [#uses=1]
  %lastx.0.lcssa = phi i32 [ 1, %entry ], [ %x.07, %bb ] ; <i32> [#uses=1]
  %lasty.0.lcssa = phi i32 [ 0, %entry ], [ %y.05, %bb ] ; <i32> [#uses=1]
  store i32 %lastx.0.lcssa, i32* %r, align 4
  store i32 %lasty.0.lcssa, i32* %s, align 4
  ret i32 %a_addr.0.lcssa
}

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind {
entry:
  %s = alloca i32, align 4                        ; <i32*> [#uses=2]
  %r = alloca i32, align 4                        ; <i32*> [#uses=2]
  %b = alloca i32, align 4                        ; <i32*> [#uses=3]
  %a = alloca i32, align 4                        ; <i32*> [#uses=3]
  %0 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %a) nounwind ; <i32> [#uses=0]
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %b) nounwind ; <i32> [#uses=0]
  %2 = load i32* %b, align 4                      ; <i32> [#uses=1]
  %3 = load i32* %a, align 4                      ; <i32> [#uses=1]
  %4 = call i32 @egcd(i32 %3, i32 %2, i32* %r, i32* %s) nounwind ; <i32> [#uses=1]
  %5 = load i32* %b, align 4                      ; <i32> [#uses=1]
  %6 = load i32* %s, align 4                      ; <i32> [#uses=1]
  %7 = load i32* %a, align 4                      ; <i32> [#uses=1]
  %8 = load i32* %r, align 4                      ; <i32> [#uses=1]
  %9 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @.str1, i32 0, i32 0), i32 %8, i32 %7, i32 %6, i32 %5, i32 %4) nounwind ; <i32> [#uses=0]
  ret i32 0
}

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind
