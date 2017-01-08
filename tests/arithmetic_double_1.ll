; ModuleID = 'arithmetic_double.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [4 x i8] c"a =\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str1 = private constant [3 x i8] c"%f\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str2 = private constant [4 x i8] c"b =\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str3 = private constant [24 x i8] c"    a     + b     = %f\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str4 = private constant [24 x i8] c"2 * a     - b     = %f\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str5 = private constant [24 x i8] c"3 * a     + a / b = %f\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str6 = private constant [24 x i8] c"4 * a * a - b     = %f\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str7 = private constant [12 x i8] c"a / b = %f\0A\00", align 1 ; <[12 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind {
entry:
  %y = alloca float, align 4                      ; <float*> [#uses=2]
  %x = alloca float, align 4                      ; <float*> [#uses=2]
  %0 = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), float* %x) nounwind ; <i32> [#uses=0]
  %2 = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  %3 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), float* %y) nounwind ; <i32> [#uses=0]
  %4 = call i32 @putchar(i32 10) nounwind         ; <i32> [#uses=0]
  %5 = load float* %x, align 4                    ; <float> [#uses=1]
  %6 = fpext float %5 to double                   ; <double> [#uses=6]
  %7 = load float* %y, align 4                    ; <float> [#uses=1]
  %8 = fpext float %7 to double                   ; <double> [#uses=4]
  %9 = fadd double %6, %8                         ; <double> [#uses=1]
  %10 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str3, i32 0, i32 0), double %9) nounwind ; <i32> [#uses=0]
  %11 = fmul double %6, 2.000000e+00              ; <double> [#uses=1]
  %12 = fsub double %11, %8                       ; <double> [#uses=1]
  %13 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str4, i32 0, i32 0), double %12) nounwind ; <i32> [#uses=0]
  %14 = fmul double %6, 3.000000e+00              ; <double> [#uses=1]
  %15 = fdiv double %6, %8                        ; <double> [#uses=2]
  %16 = fadd double %14, %15                      ; <double> [#uses=1]
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str5, i32 0, i32 0), double %16) nounwind ; <i32> [#uses=0]
  %18 = fmul double %6, 4.000000e+00              ; <double> [#uses=1]
  %19 = fmul double %18, %6                       ; <double> [#uses=1]
  %20 = fsub double %19, %8                       ; <double> [#uses=1]
  %21 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str6, i32 0, i32 0), double %20) nounwind ; <i32> [#uses=0]
  %22 = call i32 @putchar(i32 10) nounwind        ; <i32> [#uses=0]
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([12 x i8]* @.str7, i32 0, i32 0), double %15) nounwind ; <i32> [#uses=0]
  ret i32 0
}

declare i32 @puts(i8* nocapture) nounwind

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind

declare i32 @putchar(i32) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind
