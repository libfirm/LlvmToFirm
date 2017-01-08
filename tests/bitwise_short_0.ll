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

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %argc_addr = alloca i32                         ; <i32*> [#uses=1]
  %argv_addr = alloca i8**                        ; <i8***> [#uses=1]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %d = alloca i16                                 ; <i16*> [#uses=1]
  %c = alloca i16                                 ; <i16*> [#uses=3]
  %b = alloca i16                                 ; <i16*> [#uses=7]
  %a = alloca i16                                 ; <i16*> [#uses=11]
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
  %14 = xor i16 %12, %13                          ; <i16> [#uses=1]
  %15 = sext i16 %14 to i32                       ; <i32> [#uses=1]
  %16 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str3, i32 0, i32 0), i32 %15) nounwind ; <i32> [#uses=0]
  %17 = load i16* %a, align 2                     ; <i16> [#uses=1]
  %18 = load i16* %b, align 2                     ; <i16> [#uses=1]
  %19 = or i16 %17, %18                           ; <i16> [#uses=1]
  %20 = sext i16 %19 to i32                       ; <i32> [#uses=1]
  %21 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str4, i32 0, i32 0), i32 %20) nounwind ; <i32> [#uses=0]
  %22 = load i16* %a, align 2                     ; <i16> [#uses=1]
  %23 = load i16* %b, align 2                     ; <i16> [#uses=1]
  %24 = and i16 %22, %23                          ; <i16> [#uses=1]
  %25 = sext i16 %24 to i32                       ; <i32> [#uses=1]
  %26 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str5, i32 0, i32 0), i32 %25) nounwind ; <i32> [#uses=0]
  %27 = load i16* %a, align 2                     ; <i16> [#uses=1]
  %28 = sext i16 %27 to i32                       ; <i32> [#uses=1]
  %29 = shl i32 %28, 7                            ; <i32> [#uses=1]
  %30 = trunc i32 %29 to i16                      ; <i16> [#uses=1]
  %31 = sext i16 %30 to i32                       ; <i32> [#uses=1]
  %32 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str6, i32 0, i32 0), i32 %31) nounwind ; <i32> [#uses=0]
  %33 = load i16* %a, align 2                     ; <i16> [#uses=1]
  %34 = sext i16 %33 to i32                       ; <i32> [#uses=1]
  %35 = shl i32 %34, 12                           ; <i32> [#uses=1]
  %36 = trunc i32 %35 to i16                      ; <i16> [#uses=1]
  %37 = sext i16 %36 to i32                       ; <i32> [#uses=1]
  %38 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str7, i32 0, i32 0), i32 %37) nounwind ; <i32> [#uses=0]
  %39 = load i16* %a, align 2                     ; <i16> [#uses=1]
  %40 = ashr i16 %39, 7                           ; <i16> [#uses=1]
  %41 = sext i16 %40 to i32                       ; <i32> [#uses=1]
  %42 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str8, i32 0, i32 0), i32 %41) nounwind ; <i32> [#uses=0]
  %43 = load i16* %a, align 2                     ; <i16> [#uses=1]
  %44 = ashr i16 %43, 12                          ; <i16> [#uses=1]
  %45 = sext i16 %44 to i32                       ; <i32> [#uses=1]
  %46 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str9, i32 0, i32 0), i32 %45) nounwind ; <i32> [#uses=0]
  %47 = load i16* %c, align 2                     ; <i16> [#uses=1]
  %48 = lshr i16 %47, 7                           ; <i16> [#uses=1]
  %49 = zext i16 %48 to i32                       ; <i32> [#uses=1]
  %50 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str10, i32 0, i32 0), i32 %49) nounwind ; <i32> [#uses=0]
  %51 = load i16* %c, align 2                     ; <i16> [#uses=1]
  %52 = lshr i16 %51, 12                          ; <i16> [#uses=1]
  %53 = zext i16 %52 to i32                       ; <i32> [#uses=1]
  %54 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str11, i32 0, i32 0), i32 %53) nounwind ; <i32> [#uses=0]
  %55 = load i16* %a, align 2                     ; <i16> [#uses=1]
  %56 = load i16* %b, align 2                     ; <i16> [#uses=1]
  %57 = and i16 %55, %56                          ; <i16> [#uses=1]
  %58 = load i16* %a, align 2                     ; <i16> [#uses=1]
  %59 = load i16* %b, align 2                     ; <i16> [#uses=1]
  %60 = or i16 %58, %59                           ; <i16> [#uses=1]
  %61 = xor i16 %57, %60                          ; <i16> [#uses=1]
  %62 = sext i16 %61 to i32                       ; <i32> [#uses=1]
  %63 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str12, i32 0, i32 0), i32 %62) nounwind ; <i32> [#uses=0]
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
