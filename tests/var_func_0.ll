; ModuleID = 'var_func.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str1 = private constant [4 x i8] c"%i\0A\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str2 = private constant [7 x i8] c"%i %x\0A\00", align 1 ; <[7 x i8]*> [#uses=1]
@.str3 = private constant [10 x i8] c"%i %x %o\0A\00", align 1 ; <[10 x i8]*> [#uses=1]
@.str4 = private constant [13 x i8] c"%i %x %o %X\0A\00", align 1 ; <[13 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %argc_addr = alloca i32                         ; <i32*> [#uses=1]
  %argv_addr = alloca i8**                        ; <i8***> [#uses=1]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %num = alloca i32                               ; <i32*> [#uses=11]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 %argc, i32* %argc_addr
  store i8** %argv, i8*** %argv_addr
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %num) nounwind ; <i32> [#uses=0]
  %2 = load i32* %num, align 4                    ; <i32> [#uses=1]
  %3 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %2) nounwind ; <i32> [#uses=0]
  %4 = load i32* %num, align 4                    ; <i32> [#uses=1]
  %5 = load i32* %num, align 4                    ; <i32> [#uses=1]
  %6 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([7 x i8]* @.str2, i32 0, i32 0), i32 %5, i32 %4) nounwind ; <i32> [#uses=0]
  %7 = load i32* %num, align 4                    ; <i32> [#uses=1]
  %8 = load i32* %num, align 4                    ; <i32> [#uses=1]
  %9 = load i32* %num, align 4                    ; <i32> [#uses=1]
  %10 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([10 x i8]* @.str3, i32 0, i32 0), i32 %9, i32 %8, i32 %7) nounwind ; <i32> [#uses=0]
  %11 = load i32* %num, align 4                   ; <i32> [#uses=1]
  %12 = load i32* %num, align 4                   ; <i32> [#uses=1]
  %13 = load i32* %num, align 4                   ; <i32> [#uses=1]
  %14 = load i32* %num, align 4                   ; <i32> [#uses=1]
  %15 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([13 x i8]* @.str4, i32 0, i32 0), i32 %14, i32 %13, i32 %12, i32 %11) nounwind ; <i32> [#uses=0]
  store i32 0, i32* %0, align 4
  %16 = load i32* %0, align 4                     ; <i32> [#uses=1]
  store i32 %16, i32* %retval, align 4
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval1
}

declare i32 @"\01__isoc99_scanf"(i8* noalias, ...) nounwind

declare i32 @printf(i8* noalias, ...) nounwind
