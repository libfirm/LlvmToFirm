; ModuleID = 'bitwise_short.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [4 x i8] c"a =\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str1 = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str2 = private constant [4 x i8] c"b =\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str3 = private constant [24 x i8] c"a ^ b             = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str4 = private constant [24 x i8] c"a | b             = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str5 = private constant [24 x i8] c"a & b             = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str6 = private constant [24 x i8] c"a << 7            = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str7 = private constant [24 x i8] c"a << 12           = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str8 = private constant [24 x i8] c"Signed: a >> 7    = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str9 = private constant [24 x i8] c"Signed: a >> 12   = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str10 = private constant [24 x i8] c"Unsigned: a >> 7  = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str11 = private constant [24 x i8] c"Unsigned: a >> 12 = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str12 = private constant [24 x i8] c"(a & b) ^ (a | b) = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind {
entry:
  %y = alloca i32, align 4                        ; <i32*> [#uses=2]
  %x = alloca i32, align 4                        ; <i32*> [#uses=2]
  %0 = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), i32* %x) nounwind ; <i32> [#uses=0]
  %2 = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  %3 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), i32* %y) nounwind ; <i32> [#uses=0]
  %4 = call i32 @putchar(i32 10) nounwind         ; <i32> [#uses=0]
  %5 = load i32* %x, align 4                      ; <i32> [#uses=4]
  %6 = trunc i32 %5 to i16                        ; <i16> [#uses=6]
  %7 = load i32* %y, align 4                      ; <i32> [#uses=3]
  %8 = xor i32 %7, %5                             ; <i32> [#uses=1]
  %9 = trunc i32 %8 to i16                        ; <i16> [#uses=1]
  %10 = sext i16 %9 to i32                        ; <i32> [#uses=2]
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str3, i32 0, i32 0), i32 %10) nounwind ; <i32> [#uses=0]
  %12 = or i32 %7, %5                             ; <i32> [#uses=1]
  %13 = trunc i32 %12 to i16                      ; <i16> [#uses=1]
  %14 = sext i16 %13 to i32                       ; <i32> [#uses=1]
  %15 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str4, i32 0, i32 0), i32 %14) nounwind ; <i32> [#uses=0]
  %16 = and i32 %7, %5                            ; <i32> [#uses=1]
  %17 = trunc i32 %16 to i16                      ; <i16> [#uses=1]
  %18 = sext i16 %17 to i32                       ; <i32> [#uses=1]
  %19 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str5, i32 0, i32 0), i32 %18) nounwind ; <i32> [#uses=0]
  %20 = shl i16 %6, 7                             ; <i16> [#uses=1]
  %21 = sext i16 %20 to i32                       ; <i32> [#uses=1]
  %22 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str6, i32 0, i32 0), i32 %21) nounwind ; <i32> [#uses=0]
  %23 = shl i16 %6, 12                            ; <i16> [#uses=1]
  %24 = sext i16 %23 to i32                       ; <i32> [#uses=1]
  %25 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str7, i32 0, i32 0), i32 %24) nounwind ; <i32> [#uses=0]
  %26 = ashr i16 %6, 7                            ; <i16> [#uses=1]
  %27 = sext i16 %26 to i32                       ; <i32> [#uses=1]
  %28 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str8, i32 0, i32 0), i32 %27) nounwind ; <i32> [#uses=0]
  %29 = ashr i16 %6, 12                           ; <i16> [#uses=1]
  %30 = sext i16 %29 to i32                       ; <i32> [#uses=1]
  %31 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str9, i32 0, i32 0), i32 %30) nounwind ; <i32> [#uses=0]
  %32 = lshr i16 %6, 7                            ; <i16> [#uses=1]
  %33 = zext i16 %32 to i32                       ; <i32> [#uses=1]
  %34 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str10, i32 0, i32 0), i32 %33) nounwind ; <i32> [#uses=0]
  %35 = lshr i16 %6, 12                           ; <i16> [#uses=1]
  %36 = zext i16 %35 to i32                       ; <i32> [#uses=1]
  %37 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str11, i32 0, i32 0), i32 %36) nounwind ; <i32> [#uses=0]
  %38 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str12, i32 0, i32 0), i32 %10) nounwind ; <i32> [#uses=0]
  ret i32 0
}

declare i32 @puts(i8* nocapture) nounwind

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind

declare i32 @putchar(i32) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind
