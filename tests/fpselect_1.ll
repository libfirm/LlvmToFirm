; ModuleID = 'fpselect.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str1 = private constant [4 x i8] c"%lf\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str2 = private constant [4 x i8] c"%f\0A\00", align 1 ; <[4 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind {
entry:
  %c = alloca double, align 8                     ; <double*> [#uses=2]
  %b = alloca double, align 8                     ; <double*> [#uses=2]
  %a = alloca i32, align 4                        ; <i32*> [#uses=2]
  %0 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %a) nounwind ; <i32> [#uses=0]
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), double* %b) nounwind ; <i32> [#uses=0]
  %2 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), double* %c) nounwind ; <i32> [#uses=0]
  %3 = load i32* %a, align 4                      ; <i32> [#uses=1]
  %4 = icmp sgt i32 %3, 9                         ; <i1> [#uses=1]
  %c.val = load double* %c, align 8               ; <double> [#uses=1]
  %b.val = load double* %b, align 8               ; <double> [#uses=1]
  %iftmp.17.0 = select i1 %4, double %c.val, double %b.val ; <double> [#uses=1]
  %5 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0), double %iftmp.17.0) nounwind ; <i32> [#uses=0]
  ret i32 0
}

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind
