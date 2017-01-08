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

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %argc_addr = alloca i32                         ; <i32*> [#uses=1]
  %argv_addr = alloca i8**                        ; <i8***> [#uses=1]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %b = alloca float                               ; <float*> [#uses=6]
  %a = alloca float                               ; <float*> [#uses=8]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 %argc, i32* %argc_addr
  store i8** %argv, i8*** %argv_addr
  %1 = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  %2 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), float* %a) nounwind ; <i32> [#uses=0]
  %3 = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), float* %b) nounwind ; <i32> [#uses=0]
  %5 = call i32 @putchar(i32 10) nounwind         ; <i32> [#uses=0]
  %6 = load float* %a, align 4                    ; <float> [#uses=1]
  %7 = load float* %b, align 4                    ; <float> [#uses=1]
  %8 = fadd float %6, %7                          ; <float> [#uses=1]
  %9 = fpext float %8 to double                   ; <double> [#uses=1]
  %10 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str3, i32 0, i32 0), double %9) nounwind ; <i32> [#uses=0]
  %11 = load float* %a, align 4                   ; <float> [#uses=1]
  %12 = fmul float %11, 2.000000e+00              ; <float> [#uses=1]
  %13 = load float* %b, align 4                   ; <float> [#uses=1]
  %14 = fsub float %12, %13                       ; <float> [#uses=1]
  %15 = fpext float %14 to double                 ; <double> [#uses=1]
  %16 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str4, i32 0, i32 0), double %15) nounwind ; <i32> [#uses=0]
  %17 = load float* %a, align 4                   ; <float> [#uses=1]
  %18 = fmul float %17, 3.000000e+00              ; <float> [#uses=1]
  %19 = load float* %a, align 4                   ; <float> [#uses=1]
  %20 = load float* %b, align 4                   ; <float> [#uses=1]
  %21 = fdiv float %19, %20                       ; <float> [#uses=1]
  %22 = fadd float %18, %21                       ; <float> [#uses=1]
  %23 = fpext float %22 to double                 ; <double> [#uses=1]
  %24 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str5, i32 0, i32 0), double %23) nounwind ; <i32> [#uses=0]
  %25 = load float* %a, align 4                   ; <float> [#uses=1]
  %26 = fmul float %25, 4.000000e+00              ; <float> [#uses=1]
  %27 = load float* %a, align 4                   ; <float> [#uses=1]
  %28 = fmul float %26, %27                       ; <float> [#uses=1]
  %29 = load float* %b, align 4                   ; <float> [#uses=1]
  %30 = fsub float %28, %29                       ; <float> [#uses=1]
  %31 = fpext float %30 to double                 ; <double> [#uses=1]
  %32 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str6, i32 0, i32 0), double %31) nounwind ; <i32> [#uses=0]
  %33 = call i32 @putchar(i32 10) nounwind        ; <i32> [#uses=0]
  %34 = load float* %a, align 4                   ; <float> [#uses=1]
  %35 = load float* %b, align 4                   ; <float> [#uses=1]
  %36 = fdiv float %34, %35                       ; <float> [#uses=1]
  %37 = fpext float %36 to double                 ; <double> [#uses=1]
  %38 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([12 x i8]* @.str7, i32 0, i32 0), double %37) nounwind ; <i32> [#uses=0]
  store i32 0, i32* %0, align 4
  %39 = load i32* %0, align 4                     ; <i32> [#uses=1]
  store i32 %39, i32* %retval, align 4
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval1
}

declare i32 @puts(i8*)

declare i32 @"\01__isoc99_scanf"(i8* noalias, ...) nounwind

declare i32 @putchar(i32)

declare i32 @printf(i8* noalias, ...) nounwind
