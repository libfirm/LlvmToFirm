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

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %argc_addr = alloca i32                         ; <i32*> [#uses=1]
  %argv_addr = alloca i8**                        ; <i8***> [#uses=1]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %b = alloca double, align 8                     ; <double*> [#uses=6]
  %a = alloca double, align 8                     ; <double*> [#uses=8]
  %y = alloca float                               ; <float*> [#uses=2]
  %x = alloca float                               ; <float*> [#uses=2]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 %argc, i32* %argc_addr
  store i8** %argv, i8*** %argv_addr
  %1 = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  %2 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), float* %x) nounwind ; <i32> [#uses=0]
  %3 = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), float* %y) nounwind ; <i32> [#uses=0]
  %5 = call i32 @putchar(i32 10) nounwind         ; <i32> [#uses=0]
  %6 = load float* %x, align 4                    ; <float> [#uses=1]
  %7 = fpext float %6 to double                   ; <double> [#uses=1]
  store double %7, double* %a, align 8
  %8 = load float* %y, align 4                    ; <float> [#uses=1]
  %9 = fpext float %8 to double                   ; <double> [#uses=1]
  store double %9, double* %b, align 8
  %10 = load double* %a, align 8                  ; <double> [#uses=1]
  %11 = load double* %b, align 8                  ; <double> [#uses=1]
  %12 = fadd double %10, %11                      ; <double> [#uses=1]
  %13 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str3, i32 0, i32 0), double %12) nounwind ; <i32> [#uses=0]
  %14 = load double* %a, align 8                  ; <double> [#uses=1]
  %15 = fmul double %14, 2.000000e+00             ; <double> [#uses=1]
  %16 = load double* %b, align 8                  ; <double> [#uses=1]
  %17 = fsub double %15, %16                      ; <double> [#uses=1]
  %18 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str4, i32 0, i32 0), double %17) nounwind ; <i32> [#uses=0]
  %19 = load double* %a, align 8                  ; <double> [#uses=1]
  %20 = fmul double %19, 3.000000e+00             ; <double> [#uses=1]
  %21 = load double* %a, align 8                  ; <double> [#uses=1]
  %22 = load double* %b, align 8                  ; <double> [#uses=1]
  %23 = fdiv double %21, %22                      ; <double> [#uses=1]
  %24 = fadd double %20, %23                      ; <double> [#uses=1]
  %25 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str5, i32 0, i32 0), double %24) nounwind ; <i32> [#uses=0]
  %26 = load double* %a, align 8                  ; <double> [#uses=1]
  %27 = fmul double %26, 4.000000e+00             ; <double> [#uses=1]
  %28 = load double* %a, align 8                  ; <double> [#uses=1]
  %29 = fmul double %27, %28                      ; <double> [#uses=1]
  %30 = load double* %b, align 8                  ; <double> [#uses=1]
  %31 = fsub double %29, %30                      ; <double> [#uses=1]
  %32 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str6, i32 0, i32 0), double %31) nounwind ; <i32> [#uses=0]
  %33 = call i32 @putchar(i32 10) nounwind        ; <i32> [#uses=0]
  %34 = load double* %a, align 8                  ; <double> [#uses=1]
  %35 = load double* %b, align 8                  ; <double> [#uses=1]
  %36 = fdiv double %34, %35                      ; <double> [#uses=1]
  %37 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([12 x i8]* @.str7, i32 0, i32 0), double %36) nounwind ; <i32> [#uses=0]
  store i32 0, i32* %0, align 4
  %38 = load i32* %0, align 4                     ; <i32> [#uses=1]
  store i32 %38, i32* %retval, align 4
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval1
}

declare i32 @puts(i8*)

declare i32 @"\01__isoc99_scanf"(i8* noalias, ...) nounwind

declare i32 @putchar(i32)

declare i32 @printf(i8* noalias, ...) nounwind
