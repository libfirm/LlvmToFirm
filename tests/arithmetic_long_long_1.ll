; ModuleID = 'arithmetic_long_long.c'
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
  %y = alloca i32, align 4                        ; <i32*> [#uses=2]
  %x = alloca i32, align 4                        ; <i32*> [#uses=2]
  %0 = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), i32* %x) nounwind ; <i32> [#uses=0]
  %2 = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  %3 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), i32* %y) nounwind ; <i32> [#uses=0]
  %4 = call i32 @putchar(i32 10) nounwind         ; <i32> [#uses=0]
  %5 = load i32* %x, align 4                      ; <i32> [#uses=6]
  %6 = sext i32 %5 to i64                         ; <i64> [#uses=4]
  %7 = load i32* %y, align 4                      ; <i32> [#uses=4]
  %8 = sext i32 %7 to i64                         ; <i64> [#uses=4]
  %9 = add i32 %7, %5                             ; <i32> [#uses=1]
  %10 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str3, i32 0, i32 0), i32 %9) nounwind ; <i32> [#uses=0]
  %11 = shl i32 %5, 1                             ; <i32> [#uses=1]
  %12 = sub i32 %11, %7                           ; <i32> [#uses=1]
  %13 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str4, i32 0, i32 0), i32 %12) nounwind ; <i32> [#uses=0]
  %14 = mul i32 %5, 3                             ; <i32> [#uses=1]
  %15 = sdiv i64 %6, %8                           ; <i64> [#uses=1]
  %16 = trunc i64 %15 to i32                      ; <i32> [#uses=2]
  %17 = add i32 %16, %14                          ; <i32> [#uses=1]
  %18 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str5, i32 0, i32 0), i32 %17) nounwind ; <i32> [#uses=0]
  %19 = shl i32 %5, 2                             ; <i32> [#uses=1]
  %20 = mul i32 %19, %5                           ; <i32> [#uses=1]
  %21 = sub i32 %20, %7                           ; <i32> [#uses=1]
  %22 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str6, i32 0, i32 0), i32 %21) nounwind ; <i32> [#uses=0]
  %23 = call i32 @putchar(i32 10) nounwind        ; <i32> [#uses=0]
  %24 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([22 x i8]* @.str7, i32 0, i32 0), i32 %16) nounwind ; <i32> [#uses=0]
  %25 = srem i64 %6, %8                           ; <i64> [#uses=1]
  %26 = trunc i64 %25 to i32                      ; <i32> [#uses=1]
  %27 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([23 x i8]* @.str8, i32 0, i32 0), i32 %26) nounwind ; <i32> [#uses=0]
  %28 = udiv i64 %6, %8                           ; <i64> [#uses=1]
  %29 = trunc i64 %28 to i32                      ; <i32> [#uses=1]
  %30 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([22 x i8]* @.str9, i32 0, i32 0), i32 %29) nounwind ; <i32> [#uses=0]
  %31 = urem i64 %6, %8                           ; <i64> [#uses=1]
  %32 = trunc i64 %31 to i32                      ; <i32> [#uses=1]
  %33 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([23 x i8]* @.str10, i32 0, i32 0), i32 %32) nounwind ; <i32> [#uses=0]
  ret i32 0
}

declare i32 @puts(i8* nocapture) nounwind

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind

declare i32 @putchar(i32) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind
