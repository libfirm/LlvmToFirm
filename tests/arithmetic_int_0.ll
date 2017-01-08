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

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %argc_addr = alloca i32                         ; <i32*> [#uses=1]
  %argv_addr = alloca i8**                        ; <i8***> [#uses=1]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %d = alloca i32                                 ; <i32*> [#uses=3]
  %c = alloca i32                                 ; <i32*> [#uses=3]
  %b = alloca i32                                 ; <i32*> [#uses=8]
  %a = alloca i32                                 ; <i32*> [#uses=10]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 %argc, i32* %argc_addr
  store i8** %argv, i8*** %argv_addr
  %1 = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  %2 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), i32* %a) nounwind ; <i32> [#uses=0]
  %3 = call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), i32* %b) nounwind ; <i32> [#uses=0]
  %5 = call i32 @putchar(i32 10) nounwind         ; <i32> [#uses=0]
  %6 = load i32* %a, align 4                      ; <i32> [#uses=1]
  store i32 %6, i32* %c, align 4
  %7 = load i32* %b, align 4                      ; <i32> [#uses=1]
  store i32 %7, i32* %d, align 4
  %8 = load i32* %a, align 4                      ; <i32> [#uses=1]
  %9 = load i32* %b, align 4                      ; <i32> [#uses=1]
  %10 = add nsw i32 %8, %9                        ; <i32> [#uses=1]
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str3, i32 0, i32 0), i32 %10) nounwind ; <i32> [#uses=0]
  %12 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %13 = mul i32 %12, 2                            ; <i32> [#uses=1]
  %14 = load i32* %b, align 4                     ; <i32> [#uses=1]
  %15 = sub i32 %13, %14                          ; <i32> [#uses=1]
  %16 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str4, i32 0, i32 0), i32 %15) nounwind ; <i32> [#uses=0]
  %17 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %18 = mul i32 %17, 3                            ; <i32> [#uses=1]
  %19 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %20 = load i32* %b, align 4                     ; <i32> [#uses=1]
  %21 = sdiv i32 %19, %20                         ; <i32> [#uses=1]
  %22 = add nsw i32 %18, %21                      ; <i32> [#uses=1]
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str5, i32 0, i32 0), i32 %22) nounwind ; <i32> [#uses=0]
  %24 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %25 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %26 = mul i32 %24, %25                          ; <i32> [#uses=1]
  %27 = mul i32 %26, 4                            ; <i32> [#uses=1]
  %28 = load i32* %b, align 4                     ; <i32> [#uses=1]
  %29 = sub i32 %27, %28                          ; <i32> [#uses=1]
  %30 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str6, i32 0, i32 0), i32 %29) nounwind ; <i32> [#uses=0]
  %31 = call i32 @putchar(i32 10) nounwind        ; <i32> [#uses=0]
  %32 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %33 = load i32* %b, align 4                     ; <i32> [#uses=1]
  %34 = sdiv i32 %32, %33                         ; <i32> [#uses=1]
  %35 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([22 x i8]* @.str7, i32 0, i32 0), i32 %34) nounwind ; <i32> [#uses=0]
  %36 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %37 = load i32* %b, align 4                     ; <i32> [#uses=1]
  %38 = srem i32 %36, %37                         ; <i32> [#uses=1]
  %39 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([23 x i8]* @.str8, i32 0, i32 0), i32 %38) nounwind ; <i32> [#uses=0]
  %40 = load i32* %c, align 4                     ; <i32> [#uses=1]
  %41 = load i32* %d, align 4                     ; <i32> [#uses=1]
  %42 = udiv i32 %40, %41                         ; <i32> [#uses=1]
  %43 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([22 x i8]* @.str9, i32 0, i32 0), i32 %42) nounwind ; <i32> [#uses=0]
  %44 = load i32* %c, align 4                     ; <i32> [#uses=1]
  %45 = load i32* %d, align 4                     ; <i32> [#uses=1]
  %46 = urem i32 %44, %45                         ; <i32> [#uses=1]
  %47 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([23 x i8]* @.str10, i32 0, i32 0), i32 %46) nounwind ; <i32> [#uses=0]
  store i32 0, i32* %0, align 4
  %48 = load i32* %0, align 4                     ; <i32> [#uses=1]
  store i32 %48, i32* %retval, align 4
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval1
}

declare i32 @puts(i8*)

declare i32 @"\01__isoc99_scanf"(i8* noalias, ...) nounwind

declare i32 @putchar(i32)

declare i32 @printf(i8* noalias, ...) nounwind
