; ModuleID = '/home/olaf/Projekte/testing/test.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [4 x i8] c"%lf\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str1 = private constant [4 x i8] c"%f\0A\00", align 1 ; <[4 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind {
entry:
  %b = alloca double, align 8                     ; <double*> [#uses=2]
  %a = alloca double, align 8                     ; <double*> [#uses=2]
  %0 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), double* %a) nounwind ; <i32> [#uses=0]
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), double* %b) nounwind ; <i32> [#uses=0]
  %2 = load double* %a, align 8                   ; <double> [#uses=1]
  %3 = load double* %b, align 8                   ; <double> [#uses=1]
  %4 = frem double %2, %3                         ; <double> [#uses=1]
  %5 = fptrunc double %2 to float
  %6 = fptrunc double %3 to float
  %7 = frem float %5, %6
  %8 = fpext double %2 to x86_fp80
  %9 = fpext double %3 to x86_fp80
  %10 = frem x86_fp80 %8, %9
  %11 = fpext float %7 to double
  %12 = fptrunc x86_fp80 %10 to double
  %13 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), double %4) nounwind ; <i32> [#uses=0]
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), double %11) nounwind ; <i32> [#uses=0]
  %15 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), double %12) nounwind ; <i32> [#uses=0]
  ret i32 0
}

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind
