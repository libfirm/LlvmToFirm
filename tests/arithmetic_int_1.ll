; ModuleID = 'arithmetic_int.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [4 x i8] c"a =\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str1 = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str2 = private constant [4 x i8] c"b =\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str3 = private constant [24 x i8] c"    a     + b     = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str4 = private constant [24 x i8] c"2 * a     - b     = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str5 = private constant [24 x i8] c"3 * a     + a / b = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str6 = private constant [24 x i8] c"4 * a * a - b     = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str7 = private constant [22 x i8] c"Signed:   a / b = %i\0A\00", align 1 ; <[22 x i8]*> [#uses=1]
@.str8 = private constant [23 x i8] c"Signed:   a %% b = %i\0A\00", align 1 ; <[23 x i8]*> [#uses=1]
@.str9 = private constant [22 x i8] c"Unsigned: a / b = %i\0A\00", align 1 ; <[22 x i8]*> [#uses=1]
@.str10 = private constant [23 x i8] c"Unsigned: a %% b = %i\0A\00", align 1 ; <[23 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind {
entry:
  %b = alloca i32, align 4                        ; <i32*> [#uses=7]
  %a = alloca i32, align 4                        ; <i32*> [#uses=7]
  %0 = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), i32* %a) nounwind ; <i32> [#uses=0]
  %2 = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  %3 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), i32* %b) nounwind ; <i32> [#uses=0]
  %4 = call i32 @putchar(i32 10) nounwind         ; <i32> [#uses=0]
  %5 = load i32* %a, align 4                      ; <i32> [#uses=3]
  %6 = load i32* %b, align 4                      ; <i32> [#uses=3]
  %7 = add nsw i32 %6, %5                         ; <i32> [#uses=1]
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str3, i32 0, i32 0), i32 %7) nounwind ; <i32> [#uses=0]
  %9 = load i32* %a, align 4                      ; <i32> [#uses=1]
  %10 = shl i32 %9, 1                             ; <i32> [#uses=1]
  %11 = load i32* %b, align 4                     ; <i32> [#uses=1]
  %12 = sub i32 %10, %11                          ; <i32> [#uses=1]
  %13 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str4, i32 0, i32 0), i32 %12) nounwind ; <i32> [#uses=0]
  %14 = load i32* %a, align 4                     ; <i32> [#uses=2]
  %15 = mul i32 %14, 3                            ; <i32> [#uses=1]
  %16 = load i32* %b, align 4                     ; <i32> [#uses=1]
  %17 = sdiv i32 %14, %16                         ; <i32> [#uses=1]
  %18 = add nsw i32 %17, %15                      ; <i32> [#uses=1]
  %19 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str5, i32 0, i32 0), i32 %18) nounwind ; <i32> [#uses=0]
  %20 = load i32* %a, align 4                     ; <i32> [#uses=2]
  %21 = shl i32 %20, 2                            ; <i32> [#uses=1]
  %22 = mul i32 %21, %20                          ; <i32> [#uses=1]
  %23 = load i32* %b, align 4                     ; <i32> [#uses=1]
  %24 = sub i32 %22, %23                          ; <i32> [#uses=1]
  %25 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str6, i32 0, i32 0), i32 %24) nounwind ; <i32> [#uses=0]
  %26 = call i32 @putchar(i32 10) nounwind        ; <i32> [#uses=0]
  %27 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %28 = load i32* %b, align 4                     ; <i32> [#uses=1]
  %29 = sdiv i32 %27, %28                         ; <i32> [#uses=1]
  %30 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([22 x i8]* @.str7, i32 0, i32 0), i32 %29) nounwind ; <i32> [#uses=0]
  %31 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %32 = load i32* %b, align 4                     ; <i32> [#uses=1]
  %33 = srem i32 %31, %32                         ; <i32> [#uses=1]
  %34 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([23 x i8]* @.str8, i32 0, i32 0), i32 %33) nounwind ; <i32> [#uses=0]
  %35 = udiv i32 %5, %6                           ; <i32> [#uses=1]
  %36 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([22 x i8]* @.str9, i32 0, i32 0), i32 %35) nounwind ; <i32> [#uses=0]
  %37 = urem i32 %5, %6                           ; <i32> [#uses=1]
  %38 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([23 x i8]* @.str10, i32 0, i32 0), i32 %37) nounwind ; <i32> [#uses=0]
  ret i32 0
}

declare i32 @puts(i8* nocapture) nounwind

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind

declare i32 @putchar(i32) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind
