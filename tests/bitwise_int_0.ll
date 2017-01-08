; ModuleID = 'bitwise_int.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [4 x i8] c"a =\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str1 = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str2 = private constant [4 x i8] c"b =\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str3 = private constant [24 x i8] c"a ^ b             = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str4 = private constant [24 x i8] c"a | b             = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str5 = private constant [24 x i8] c"a & b             = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str6 = private constant [24 x i8] c"a << 5            = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str7 = private constant [24 x i8] c"a << 20           = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str8 = private constant [24 x i8] c"Signed: a >> 5    = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str9 = private constant [24 x i8] c"Signed: a >> 20   = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str10 = private constant [24 x i8] c"Unsigned: a >> 5  = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str11 = private constant [24 x i8] c"Unsigned: a >> 20 = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]
@.str12 = private constant [24 x i8] c"(a & b) ^ (a | b) = %i\0A\00", align 1 ; <[24 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %argc_addr = alloca i32                         ; <i32*> [#uses=1]
  %argv_addr = alloca i8**                        ; <i8***> [#uses=1]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %d = alloca i32                                 ; <i32*> [#uses=1]
  %c = alloca i32                                 ; <i32*> [#uses=3]
  %b = alloca i32                                 ; <i32*> [#uses=7]
  %a = alloca i32                                 ; <i32*> [#uses=11]
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
  %10 = xor i32 %8, %9                            ; <i32> [#uses=1]
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str3, i32 0, i32 0), i32 %10) nounwind ; <i32> [#uses=0]
  %12 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %13 = load i32* %b, align 4                     ; <i32> [#uses=1]
  %14 = or i32 %12, %13                           ; <i32> [#uses=1]
  %15 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str4, i32 0, i32 0), i32 %14) nounwind ; <i32> [#uses=0]
  %16 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %17 = load i32* %b, align 4                     ; <i32> [#uses=1]
  %18 = and i32 %16, %17                          ; <i32> [#uses=1]
  %19 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str5, i32 0, i32 0), i32 %18) nounwind ; <i32> [#uses=0]
  %20 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %21 = shl i32 %20, 5                            ; <i32> [#uses=1]
  %22 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str6, i32 0, i32 0), i32 %21) nounwind ; <i32> [#uses=0]
  %23 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %24 = shl i32 %23, 20                           ; <i32> [#uses=1]
  %25 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str7, i32 0, i32 0), i32 %24) nounwind ; <i32> [#uses=0]
  %26 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %27 = ashr i32 %26, 5                           ; <i32> [#uses=1]
  %28 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str8, i32 0, i32 0), i32 %27) nounwind ; <i32> [#uses=0]
  %29 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %30 = ashr i32 %29, 20                          ; <i32> [#uses=1]
  %31 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str9, i32 0, i32 0), i32 %30) nounwind ; <i32> [#uses=0]
  %32 = load i32* %c, align 4                     ; <i32> [#uses=1]
  %33 = lshr i32 %32, 5                           ; <i32> [#uses=1]
  %34 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str10, i32 0, i32 0), i32 %33) nounwind ; <i32> [#uses=0]
  %35 = load i32* %c, align 4                     ; <i32> [#uses=1]
  %36 = lshr i32 %35, 20                          ; <i32> [#uses=1]
  %37 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str11, i32 0, i32 0), i32 %36) nounwind ; <i32> [#uses=0]
  %38 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %39 = load i32* %b, align 4                     ; <i32> [#uses=1]
  %40 = and i32 %38, %39                          ; <i32> [#uses=1]
  %41 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %42 = load i32* %b, align 4                     ; <i32> [#uses=1]
  %43 = or i32 %41, %42                           ; <i32> [#uses=1]
  %44 = xor i32 %40, %43                          ; <i32> [#uses=1]
  %45 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str12, i32 0, i32 0), i32 %44) nounwind ; <i32> [#uses=0]
  store i32 0, i32* %0, align 4
  %46 = load i32* %0, align 4                     ; <i32> [#uses=1]
  store i32 %46, i32* %retval, align 4
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval1
}

declare i32 @puts(i8*)

declare i32 @"\01__isoc99_scanf"(i8* noalias, ...) nounwind

declare i32 @putchar(i32)

declare i32 @printf(i8* noalias, ...) nounwind
