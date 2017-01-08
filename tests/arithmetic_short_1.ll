; ModuleID = 'arithmetic_short.c'
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
  %5 = load i32* %x, align 4                      ; <i32> [#uses=1]
  %6 = trunc i32 %5 to i16                        ; <i16> [#uses=7]
  %7 = load i32* %y, align 4                      ; <i32> [#uses=1]
  %8 = trunc i32 %7 to i16                        ; <i16> [#uses=6]
  %9 = add i16 %8, %6                             ; <i16> [#uses=1]
  %10 = sext i16 %9 to i32                        ; <i32> [#uses=1]
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str3, i32 0, i32 0), i32 %10) nounwind ; <i32> [#uses=0]
  %12 = shl i16 %6, 1                             ; <i16> [#uses=1]
  %13 = sub i16 %12, %8                           ; <i16> [#uses=1]
  %14 = sext i16 %13 to i32                       ; <i32> [#uses=1]
  %15 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str4, i32 0, i32 0), i32 %14) nounwind ; <i32> [#uses=0]
  %16 = sext i16 %6 to i32                        ; <i32> [#uses=3]
  %17 = mul i32 %16, 3                            ; <i32> [#uses=1]
  %18 = sext i16 %8 to i32                        ; <i32> [#uses=2]
  %19 = sdiv i32 %16, %18                         ; <i32> [#uses=2]
  %20 = add i32 %19, %17                          ; <i32> [#uses=1]
  %21 = trunc i32 %20 to i16                      ; <i16> [#uses=1]
  %22 = sext i16 %21 to i32                       ; <i32> [#uses=1]
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str5, i32 0, i32 0), i32 %22) nounwind ; <i32> [#uses=0]
  %24 = shl i16 %6, 2                             ; <i16> [#uses=1]
  %25 = mul i16 %24, %6                           ; <i16> [#uses=1]
  %26 = sub i16 %25, %8                           ; <i16> [#uses=1]
  %27 = sext i16 %26 to i32                       ; <i32> [#uses=1]
  %28 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str6, i32 0, i32 0), i32 %27) nounwind ; <i32> [#uses=0]
  %29 = call i32 @putchar(i32 10) nounwind        ; <i32> [#uses=0]
  %30 = trunc i32 %19 to i16                      ; <i16> [#uses=1]
  %31 = sext i16 %30 to i32                       ; <i32> [#uses=1]
  %32 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([22 x i8]* @.str7, i32 0, i32 0), i32 %31) nounwind ; <i32> [#uses=0]
  %33 = srem i32 %16, %18                         ; <i32> [#uses=1]
  %34 = trunc i32 %33 to i16                      ; <i16> [#uses=1]
  %35 = sext i16 %34 to i32                       ; <i32> [#uses=1]
  %36 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([23 x i8]* @.str8, i32 0, i32 0), i32 %35) nounwind ; <i32> [#uses=0]
  %37 = udiv i16 %6, %8                           ; <i16> [#uses=1]
  %38 = zext i16 %37 to i32                       ; <i32> [#uses=1]
  %39 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([22 x i8]* @.str9, i32 0, i32 0), i32 %38) nounwind ; <i32> [#uses=0]
  %40 = urem i16 %6, %8                           ; <i16> [#uses=1]
  %41 = zext i16 %40 to i32                       ; <i32> [#uses=1]
  %42 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([23 x i8]* @.str10, i32 0, i32 0), i32 %41) nounwind ; <i32> [#uses=0]
  ret i32 0
}

declare i32 @puts(i8* nocapture) nounwind

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind

declare i32 @putchar(i32) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind
