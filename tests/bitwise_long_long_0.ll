; ModuleID = 'bitwise_long_long.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [4 x i8] c"a =\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str1 = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str2 = private constant [4 x i8] c"b =\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str3 = private constant [24 x i8] c"a ^ b             = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str4 = private constant [24 x i8] c"a | b             = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str5 = private constant [24 x i8] c"a & b             = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str6 = private constant [24 x i8] c"a << 12           = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str7 = private constant [24 x i8] c"a << 41           = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str8 = private constant [24 x i8] c"Signed: a >> 12   = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str9 = private constant [24 x i8] c"Signed: a >> 41   = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str10 = private constant [24 x i8] c"Unsigned: a >> 12 = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str11 = private constant [24 x i8] c"Unsigned: a >> 41 = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str12 = private constant [24 x i8] c"(a & b) ^ (a | b) = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %argc_addr = alloca i32                         ; <i32*> [#uses=1]
  %argv_addr = alloca i8**                        ; <i8***> [#uses=1]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %d = alloca i64, align 8                        ; <i64*> [#uses=1]
  %c = alloca i64, align 8                        ; <i64*> [#uses=3]
  %b = alloca i64, align 8                        ; <i64*> [#uses=7]
  %a = alloca i64, align 8                        ; <i64*> [#uses=11]
  %y = alloca i32                                 ; <i32*> [#uses=2]
  %x = alloca i32                                 ; <i32*> [#uses=2]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 %argc, i32* %argc_addr
  store i8** %argv, i8*** %argv_addr
  %1 = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  %2 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), i32* %x) nounwind ; <i32> [#uses=0]
  %3 = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), i32* %y) nounwind ; <i32> [#uses=0]
  %5 = call i32 @putchar(i32 10) nounwind         ; <i32> [#uses=0]
  %6 = load i32* %x, align 4                      ; <i32> [#uses=1]
  %7 = sext i32 %6 to i64                         ; <i64> [#uses=1]
  store i64 %7, i64* %a, align 8
  %8 = load i32* %y, align 4                      ; <i32> [#uses=1]
  %9 = sext i32 %8 to i64                         ; <i64> [#uses=1]
  store i64 %9, i64* %b, align 8
  %10 = load i64* %a, align 8                     ; <i64> [#uses=1]
  store i64 %10, i64* %c, align 8
  %11 = load i64* %b, align 8                     ; <i64> [#uses=1]
  store i64 %11, i64* %d, align 8
  %12 = load i64* %a, align 8                     ; <i64> [#uses=1]
  %13 = trunc i64 %12 to i32                      ; <i32> [#uses=1]
  %14 = load i64* %b, align 8                     ; <i64> [#uses=1]
  %15 = trunc i64 %14 to i32                      ; <i32> [#uses=1]
  %16 = xor i32 %13, %15                          ; <i32> [#uses=1]
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str3, i32 0, i32 0), i32 %16) nounwind ; <i32> [#uses=0]
  %18 = load i64* %a, align 8                     ; <i64> [#uses=1]
  %19 = trunc i64 %18 to i32                      ; <i32> [#uses=1]
  %20 = load i64* %b, align 8                     ; <i64> [#uses=1]
  %21 = trunc i64 %20 to i32                      ; <i32> [#uses=1]
  %22 = or i32 %19, %21                           ; <i32> [#uses=1]
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str4, i32 0, i32 0), i32 %22) nounwind ; <i32> [#uses=0]
  %24 = load i64* %a, align 8                     ; <i64> [#uses=1]
  %25 = trunc i64 %24 to i32                      ; <i32> [#uses=1]
  %26 = load i64* %b, align 8                     ; <i64> [#uses=1]
  %27 = trunc i64 %26 to i32                      ; <i32> [#uses=1]
  %28 = and i32 %25, %27                          ; <i32> [#uses=1]
  %29 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str5, i32 0, i32 0), i32 %28) nounwind ; <i32> [#uses=0]
  %30 = load i64* %a, align 8                     ; <i64> [#uses=1]
  %31 = shl i64 %30, 12                           ; <i64> [#uses=1]
  %32 = trunc i64 %31 to i32                      ; <i32> [#uses=1]
  %33 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str6, i32 0, i32 0), i32 %32) nounwind ; <i32> [#uses=0]
  %34 = load i64* %a, align 8                     ; <i64> [#uses=1]
  %35 = shl i64 %34, 41                           ; <i64> [#uses=1]
  %36 = trunc i64 %35 to i32                      ; <i32> [#uses=1]
  %37 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str7, i32 0, i32 0), i32 %36) nounwind ; <i32> [#uses=0]
  %38 = load i64* %a, align 8                     ; <i64> [#uses=1]
  %39 = ashr i64 %38, 12                          ; <i64> [#uses=1]
  %40 = trunc i64 %39 to i32                      ; <i32> [#uses=1]
  %41 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str8, i32 0, i32 0), i32 %40) nounwind ; <i32> [#uses=0]
  %42 = load i64* %a, align 8                     ; <i64> [#uses=1]
  %43 = ashr i64 %42, 41                          ; <i64> [#uses=1]
  %44 = trunc i64 %43 to i32                      ; <i32> [#uses=1]
  %45 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str9, i32 0, i32 0), i32 %44) nounwind ; <i32> [#uses=0]
  %46 = load i64* %c, align 8                     ; <i64> [#uses=1]
  %47 = lshr i64 %46, 12                          ; <i64> [#uses=1]
  %48 = trunc i64 %47 to i32                      ; <i32> [#uses=1]
  %49 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str10, i32 0, i32 0), i32 %48) nounwind ; <i32> [#uses=0]
  %50 = load i64* %c, align 8                     ; <i64> [#uses=1]
  %51 = lshr i64 %50, 41                          ; <i64> [#uses=1]
  %52 = trunc i64 %51 to i32                      ; <i32> [#uses=1]
  %53 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str11, i32 0, i32 0), i32 %52) nounwind ; <i32> [#uses=0]
  %54 = load i64* %a, align 8                     ; <i64> [#uses=1]
  %55 = trunc i64 %54 to i32                      ; <i32> [#uses=1]
  %56 = load i64* %b, align 8                     ; <i64> [#uses=1]
  %57 = trunc i64 %56 to i32                      ; <i32> [#uses=1]
  %58 = and i32 %55, %57                          ; <i32> [#uses=1]
  %59 = load i64* %a, align 8                     ; <i64> [#uses=1]
  %60 = trunc i64 %59 to i32                      ; <i32> [#uses=1]
  %61 = load i64* %b, align 8                     ; <i64> [#uses=1]
  %62 = trunc i64 %61 to i32                      ; <i32> [#uses=1]
  %63 = or i32 %60, %62                           ; <i32> [#uses=1]
  %64 = xor i32 %58, %63                          ; <i32> [#uses=1]
  %65 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str12, i32 0, i32 0), i32 %64) nounwind ; <i32> [#uses=0]
  store i32 0, i32* %0, align 4
  %66 = load i32* %0, align 4                     ; <i32> [#uses=1]
  store i32 %66, i32* %retval, align 4
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval1
}

declare i32 @puts(i8*)

declare i32 @"\01__isoc99_scanf"(i8* noalias, ...) nounwind

declare i32 @putchar(i32)

declare i32 @printf(i8* noalias, ...) nounwind
