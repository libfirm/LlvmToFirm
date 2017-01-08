; ModuleID = 'fibonacci.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str1 = private constant [4 x i8] c"%i\0A\00", align 1 ; <[4 x i8]*> [#uses=1]

define i32 @fibonacci(i32 %num) nounwind {
entry:
  %num_addr = alloca i32                          ; <i32*> [#uses=5]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %0 = alloca i32                                 ; <i32*> [#uses=4]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 %num, i32* %num_addr
  %1 = load i32* %num_addr, align 4               ; <i32> [#uses=1]
  %2 = icmp eq i32 %1, 0                          ; <i1> [#uses=1]
  br i1 %2, label %bb, label %bb1

bb:                                               ; preds = %entry
  store i32 0, i32* %0, align 4
  br label %bb4

bb1:                                              ; preds = %entry
  %3 = load i32* %num_addr, align 4               ; <i32> [#uses=1]
  %4 = icmp eq i32 %3, 1                          ; <i1> [#uses=1]
  br i1 %4, label %bb2, label %bb3

bb2:                                              ; preds = %bb1
  store i32 1, i32* %0, align 4
  br label %bb4

bb3:                                              ; preds = %bb1
  %5 = load i32* %num_addr, align 4               ; <i32> [#uses=1]
  %6 = sub i32 %5, 1                              ; <i32> [#uses=1]
  %7 = call i32 @fibonacci(i32 %6) nounwind       ; <i32> [#uses=1]
  %8 = load i32* %num_addr, align 4               ; <i32> [#uses=1]
  %9 = sub i32 %8, 2                              ; <i32> [#uses=1]
  %10 = call i32 @fibonacci(i32 %9) nounwind      ; <i32> [#uses=1]
  %11 = add nsw i32 %7, %10                       ; <i32> [#uses=1]
  store i32 %11, i32* %0, align 4
  br label %bb4

bb4:                                              ; preds = %bb3, %bb2, %bb
  %12 = load i32* %0, align 4                     ; <i32> [#uses=1]
  store i32 %12, i32* %retval, align 4
  br label %return

return:                                           ; preds = %bb4
  %retval5 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval5
}

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %argc_addr = alloca i32                         ; <i32*> [#uses=1]
  %argv_addr = alloca i8**                        ; <i8***> [#uses=1]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %i = alloca i32                                 ; <i32*> [#uses=5]
  %num = alloca i32                               ; <i32*> [#uses=2]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 %argc, i32* %argc_addr
  store i8** %argv, i8*** %argv_addr
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %num) nounwind ; <i32> [#uses=0]
  store i32 0, i32* %i, align 4
  br label %bb1

bb:                                               ; preds = %bb1
  %2 = load i32* %i, align 4                      ; <i32> [#uses=1]
  %3 = call i32 @fibonacci(i32 %2) nounwind       ; <i32> [#uses=1]
  %4 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %3) nounwind ; <i32> [#uses=0]
  %5 = load i32* %i, align 4                      ; <i32> [#uses=1]
  %6 = add nsw i32 %5, 1                          ; <i32> [#uses=1]
  store i32 %6, i32* %i, align 4
  br label %bb1

bb1:                                              ; preds = %bb, %entry
  %7 = load i32* %num, align 4                    ; <i32> [#uses=1]
  %8 = load i32* %i, align 4                      ; <i32> [#uses=1]
  %9 = icmp slt i32 %8, %7                        ; <i1> [#uses=1]
  br i1 %9, label %bb, label %bb2

bb2:                                              ; preds = %bb1
  store i32 0, i32* %0, align 4
  %10 = load i32* %0, align 4                     ; <i32> [#uses=1]
  store i32 %10, i32* %retval, align 4
  br label %return

return:                                           ; preds = %bb2
  %retval3 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval3
}

declare i32 @"\01__isoc99_scanf"(i8* noalias, ...) nounwind

declare i32 @printf(i8* noalias, ...) nounwind
