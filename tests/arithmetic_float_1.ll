; ModuleID = 'arithmetic_float.c'
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
  %b = alloca float, align 4                      ; <float*> [#uses=6]
  %a = alloca float, align 4                      ; <float*> [#uses=6]
  %0 = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), float* %a) nounwind ; <i32> [#uses=0]
  %2 = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  %3 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), float* %b) nounwind ; <i32> [#uses=0]
  %4 = call i32 @putchar(i32 10) nounwind         ; <i32> [#uses=0]
  %5 = load float* %a, align 4                    ; <float> [#uses=1]
  %6 = load float* %b, align 4                    ; <float> [#uses=1]
  %7 = fadd float %5, %6                          ; <float> [#uses=1]
  %8 = fpext float %7 to double                   ; <double> [#uses=1]
  %9 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str3, i32 0, i32 0), double %8) nounwind ; <i32> [#uses=0]
  %10 = load float* %a, align 4                   ; <float> [#uses=1]
  %11 = fmul float %10, 2.000000e+00              ; <float> [#uses=1]
  %12 = load float* %b, align 4                   ; <float> [#uses=1]
  %13 = fsub float %11, %12                       ; <float> [#uses=1]
  %14 = fpext float %13 to double                 ; <double> [#uses=1]
  %15 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str4, i32 0, i32 0), double %14) nounwind ; <i32> [#uses=0]
  %16 = load float* %a, align 4                   ; <float> [#uses=2]
  %17 = fmul float %16, 3.000000e+00              ; <float> [#uses=1]
  %18 = load float* %b, align 4                   ; <float> [#uses=1]
  %19 = fdiv float %16, %18                       ; <float> [#uses=1]
  %20 = fadd float %17, %19                       ; <float> [#uses=1]
  %21 = fpext float %20 to double                 ; <double> [#uses=1]
  %22 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str5, i32 0, i32 0), double %21) nounwind ; <i32> [#uses=0]
  %23 = load float* %a, align 4                   ; <float> [#uses=2]
  %24 = fmul float %23, 4.000000e+00              ; <float> [#uses=1]
  %25 = fmul float %24, %23                       ; <float> [#uses=1]
  %26 = load float* %b, align 4                   ; <float> [#uses=1]
  %27 = fsub float %25, %26                       ; <float> [#uses=1]
  %28 = fpext float %27 to double                 ; <double> [#uses=1]
  %29 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str6, i32 0, i32 0), double %28) nounwind ; <i32> [#uses=0]
  %30 = call i32 @putchar(i32 10) nounwind        ; <i32> [#uses=0]
  %31 = load float* %a, align 4                   ; <float> [#uses=1]
  %32 = load float* %b, align 4                   ; <float> [#uses=1]
  %33 = fdiv float %31, %32                       ; <float> [#uses=1]
  %34 = fpext float %33 to double                 ; <double> [#uses=1]
  %35 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([12 x i8]* @.str7, i32 0, i32 0), double %34) nounwind ; <i32> [#uses=0]
  ret i32 0
}

declare i32 @puts(i8* nocapture) nounwind

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind

declare i32 @putchar(i32) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind
