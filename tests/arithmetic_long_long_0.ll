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

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %argc_addr = alloca i32                         ; <i32*> [#uses=1]
  %argv_addr = alloca i8**                        ; <i8***> [#uses=1]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %d = alloca i64, align 8                        ; <i64*> [#uses=3]
  %c = alloca i64, align 8                        ; <i64*> [#uses=3]
  %b = alloca i64, align 8                        ; <i64*> [#uses=8]
  %a = alloca i64, align 8                        ; <i64*> [#uses=10]
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
  %16 = add i32 %13, %15                          ; <i32> [#uses=1]
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str3, i32 0, i32 0), i32 %16) nounwind ; <i32> [#uses=0]
  %18 = load i64* %a, align 8                     ; <i64> [#uses=1]
  %19 = mul i64 %18, 2                            ; <i64> [#uses=1]
  %20 = trunc i64 %19 to i32                      ; <i32> [#uses=1]
  %21 = load i64* %b, align 8                     ; <i64> [#uses=1]
  %22 = trunc i64 %21 to i32                      ; <i32> [#uses=1]
  %23 = sub i32 %20, %22                          ; <i32> [#uses=1]
  %24 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str4, i32 0, i32 0), i32 %23) nounwind ; <i32> [#uses=0]
  %25 = load i64* %a, align 8                     ; <i64> [#uses=1]
  %26 = mul i64 %25, 3                            ; <i64> [#uses=1]
  %27 = trunc i64 %26 to i32                      ; <i32> [#uses=1]
  %28 = load i64* %a, align 8                     ; <i64> [#uses=1]
  %29 = load i64* %b, align 8                     ; <i64> [#uses=1]
  %30 = sdiv i64 %28, %29                         ; <i64> [#uses=1]
  %31 = trunc i64 %30 to i32                      ; <i32> [#uses=1]
  %32 = add i32 %27, %31                          ; <i32> [#uses=1]
  %33 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str5, i32 0, i32 0), i32 %32) nounwind ; <i32> [#uses=0]
  %34 = load i64* %a, align 8                     ; <i64> [#uses=1]
  %35 = load i64* %a, align 8                     ; <i64> [#uses=1]
  %36 = mul i64 %34, %35                          ; <i64> [#uses=1]
  %37 = mul i64 %36, 4                            ; <i64> [#uses=1]
  %38 = trunc i64 %37 to i32                      ; <i32> [#uses=1]
  %39 = load i64* %b, align 8                     ; <i64> [#uses=1]
  %40 = trunc i64 %39 to i32                      ; <i32> [#uses=1]
  %41 = sub i32 %38, %40                          ; <i32> [#uses=1]
  %42 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str6, i32 0, i32 0), i32 %41) nounwind ; <i32> [#uses=0]
  %43 = call i32 @putchar(i32 10) nounwind        ; <i32> [#uses=0]
  %44 = load i64* %a, align 8                     ; <i64> [#uses=1]
  %45 = load i64* %b, align 8                     ; <i64> [#uses=1]
  %46 = sdiv i64 %44, %45                         ; <i64> [#uses=1]
  %47 = trunc i64 %46 to i32                      ; <i32> [#uses=1]
  %48 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([22 x i8]* @.str7, i32 0, i32 0), i32 %47) nounwind ; <i32> [#uses=0]
  %49 = load i64* %a, align 8                     ; <i64> [#uses=1]
  %50 = load i64* %b, align 8                     ; <i64> [#uses=1]
  %51 = srem i64 %49, %50                         ; <i64> [#uses=1]
  %52 = trunc i64 %51 to i32                      ; <i32> [#uses=1]
  %53 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([23 x i8]* @.str8, i32 0, i32 0), i32 %52) nounwind ; <i32> [#uses=0]
  %54 = load i64* %c, align 8                     ; <i64> [#uses=1]
  %55 = load i64* %d, align 8                     ; <i64> [#uses=1]
  %56 = udiv i64 %54, %55                         ; <i64> [#uses=1]
  %57 = trunc i64 %56 to i32                      ; <i32> [#uses=1]
  %58 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([22 x i8]* @.str9, i32 0, i32 0), i32 %57) nounwind ; <i32> [#uses=0]
  %59 = load i64* %c, align 8                     ; <i64> [#uses=1]
  %60 = load i64* %d, align 8                     ; <i64> [#uses=1]
  %61 = urem i64 %59, %60                         ; <i64> [#uses=1]
  %62 = trunc i64 %61 to i32                      ; <i32> [#uses=1]
  %63 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([23 x i8]* @.str10, i32 0, i32 0), i32 %62) nounwind ; <i32> [#uses=0]
  store i32 0, i32* %0, align 4
  %64 = load i32* %0, align 4                     ; <i32> [#uses=1]
  store i32 %64, i32* %retval, align 4
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval1
}

declare i32 @puts(i8*)

declare i32 @"\01__isoc99_scanf"(i8* noalias, ...) nounwind

declare i32 @putchar(i32)

declare i32 @printf(i8* noalias, ...) nounwind
