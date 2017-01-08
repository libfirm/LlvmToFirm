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

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %argc_addr = alloca i32                         ; <i32*> [#uses=1]
  %argv_addr = alloca i8**                        ; <i8***> [#uses=1]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %d = alloca i16                                 ; <i16*> [#uses=3]
  %c = alloca i16                                 ; <i16*> [#uses=3]
  %b = alloca i16                                 ; <i16*> [#uses=8]
  %a = alloca i16                                 ; <i16*> [#uses=10]
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
  %7 = trunc i32 %6 to i16                        ; <i16> [#uses=1]
  store i16 %7, i16* %a, align 2
  %8 = load i32* %y, align 4                      ; <i32> [#uses=1]
  %9 = trunc i32 %8 to i16                        ; <i16> [#uses=1]
  store i16 %9, i16* %b, align 2
  %10 = load i16* %a, align 2                     ; <i16> [#uses=1]
  store i16 %10, i16* %c, align 2
  %11 = load i16* %b, align 2                     ; <i16> [#uses=1]
  store i16 %11, i16* %d, align 2
  %12 = load i16* %a, align 2                     ; <i16> [#uses=1]
  %13 = load i16* %b, align 2                     ; <i16> [#uses=1]
  %14 = add i16 %12, %13                          ; <i16> [#uses=1]
  %15 = sext i16 %14 to i32                       ; <i32> [#uses=1]
  %16 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str3, i32 0, i32 0), i32 %15) nounwind ; <i32> [#uses=0]
  %17 = load i16* %a, align 2                     ; <i16> [#uses=1]
  %18 = sext i16 %17 to i32                       ; <i32> [#uses=1]
  %19 = mul i32 %18, 2                            ; <i32> [#uses=1]
  %20 = trunc i32 %19 to i16                      ; <i16> [#uses=1]
  %21 = load i16* %b, align 2                     ; <i16> [#uses=1]
  %22 = sub i16 %20, %21                          ; <i16> [#uses=1]
  %23 = sext i16 %22 to i32                       ; <i32> [#uses=1]
  %24 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str4, i32 0, i32 0), i32 %23) nounwind ; <i32> [#uses=0]
  %25 = load i16* %a, align 2                     ; <i16> [#uses=1]
  %26 = sext i16 %25 to i32                       ; <i32> [#uses=1]
  %27 = mul i32 %26, 3                            ; <i32> [#uses=1]
  %28 = trunc i32 %27 to i16                      ; <i16> [#uses=1]
  %29 = load i16* %a, align 2                     ; <i16> [#uses=1]
  %30 = sext i16 %29 to i32                       ; <i32> [#uses=1]
  %31 = load i16* %b, align 2                     ; <i16> [#uses=1]
  %32 = sext i16 %31 to i32                       ; <i32> [#uses=1]
  %33 = sdiv i32 %30, %32                         ; <i32> [#uses=1]
  %34 = trunc i32 %33 to i16                      ; <i16> [#uses=1]
  %35 = add i16 %28, %34                          ; <i16> [#uses=1]
  %36 = sext i16 %35 to i32                       ; <i32> [#uses=1]
  %37 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str5, i32 0, i32 0), i32 %36) nounwind ; <i32> [#uses=0]
  %38 = load i16* %a, align 2                     ; <i16> [#uses=1]
  %39 = sext i16 %38 to i32                       ; <i32> [#uses=1]
  %40 = load i16* %a, align 2                     ; <i16> [#uses=1]
  %41 = sext i16 %40 to i32                       ; <i32> [#uses=1]
  %42 = mul i32 %39, %41                          ; <i32> [#uses=1]
  %43 = mul i32 %42, 4                            ; <i32> [#uses=1]
  %44 = trunc i32 %43 to i16                      ; <i16> [#uses=1]
  %45 = load i16* %b, align 2                     ; <i16> [#uses=1]
  %46 = sub i16 %44, %45                          ; <i16> [#uses=1]
  %47 = sext i16 %46 to i32                       ; <i32> [#uses=1]
  %48 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str6, i32 0, i32 0), i32 %47) nounwind ; <i32> [#uses=0]
  %49 = call i32 @putchar(i32 10) nounwind        ; <i32> [#uses=0]
  %50 = load i16* %a, align 2                     ; <i16> [#uses=1]
  %51 = sext i16 %50 to i32                       ; <i32> [#uses=1]
  %52 = load i16* %b, align 2                     ; <i16> [#uses=1]
  %53 = sext i16 %52 to i32                       ; <i32> [#uses=1]
  %54 = sdiv i32 %51, %53                         ; <i32> [#uses=1]
  %55 = trunc i32 %54 to i16                      ; <i16> [#uses=1]
  %56 = sext i16 %55 to i32                       ; <i32> [#uses=1]
  %57 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([22 x i8]* @.str7, i32 0, i32 0), i32 %56) nounwind ; <i32> [#uses=0]
  %58 = load i16* %a, align 2                     ; <i16> [#uses=1]
  %59 = sext i16 %58 to i32                       ; <i32> [#uses=1]
  %60 = load i16* %b, align 2                     ; <i16> [#uses=1]
  %61 = sext i16 %60 to i32                       ; <i32> [#uses=1]
  %62 = srem i32 %59, %61                         ; <i32> [#uses=1]
  %63 = trunc i32 %62 to i16                      ; <i16> [#uses=1]
  %64 = sext i16 %63 to i32                       ; <i32> [#uses=1]
  %65 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([23 x i8]* @.str8, i32 0, i32 0), i32 %64) nounwind ; <i32> [#uses=0]
  %66 = load i16* %c, align 2                     ; <i16> [#uses=1]
  %67 = load i16* %d, align 2                     ; <i16> [#uses=1]
  %68 = udiv i16 %66, %67                         ; <i16> [#uses=1]
  %69 = zext i16 %68 to i32                       ; <i32> [#uses=1]
  %70 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([22 x i8]* @.str9, i32 0, i32 0), i32 %69) nounwind ; <i32> [#uses=0]
  %71 = load i16* %c, align 2                     ; <i16> [#uses=1]
  %72 = load i16* %d, align 2                     ; <i16> [#uses=1]
  %73 = urem i16 %71, %72                         ; <i16> [#uses=1]
  %74 = zext i16 %73 to i32                       ; <i32> [#uses=1]
  %75 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([23 x i8]* @.str10, i32 0, i32 0), i32 %74) nounwind ; <i32> [#uses=0]
  store i32 0, i32* %0, align 4
  %76 = load i32* %0, align 4                     ; <i32> [#uses=1]
  store i32 %76, i32* %retval, align 4
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval1
}

declare i32 @puts(i8*)

declare i32 @"\01__isoc99_scanf"(i8* noalias, ...) nounwind

declare i32 @putchar(i32)

declare i32 @printf(i8* noalias, ...) nounwind
