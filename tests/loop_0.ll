; ModuleID = 'loop.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str1 = private constant [12 x i8] c"loop 1: %i\0A\00", align 1 ; <[12 x i8]*> [#uses=1]
@.str2 = private constant [16 x i8] c"loop 2: %i, %i\0A\00", align 1 ; <[16 x i8]*> [#uses=1]
@.str3 = private constant [12 x i8] c"loop 3: %i\0A\00", align 1 ; <[12 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %argc_addr = alloca i32                         ; <i32*> [#uses=1]
  %argv_addr = alloca i8**                        ; <i8***> [#uses=1]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %j = alloca i32                                 ; <i32*> [#uses=5]
  %i = alloca i32                                 ; <i32*> [#uses=6]
  %z = alloca i32                                 ; <i32*> [#uses=5]
  %b = alloca i32                                 ; <i32*> [#uses=2]
  %a = alloca i32                                 ; <i32*> [#uses=6]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 %argc, i32* %argc_addr
  store i8** %argv, i8*** %argv_addr
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %a) nounwind ; <i32> [#uses=0]
  %2 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %b) nounwind ; <i32> [#uses=0]
  store i32 1, i32* %z, align 4
  store i32 0, i32* %i, align 4
  br label %bb4

bb:                                               ; preds = %bb4
  %3 = load i32* %i, align 4                      ; <i32> [#uses=1]
  %4 = load i32* %z, align 4                      ; <i32> [#uses=1]
  %5 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([12 x i8]* @.str1, i32 0, i32 0), i32 %3, i32 %4) nounwind ; <i32> [#uses=0]
  store i32 0, i32* %j, align 4
  br label %bb2

bb1:                                              ; preds = %bb2
  %6 = load i32* %j, align 4                      ; <i32> [#uses=1]
  %7 = load i32* %z, align 4                      ; <i32> [#uses=1]
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([16 x i8]* @.str2, i32 0, i32 0), i32 %6, i32 %7) nounwind ; <i32> [#uses=0]
  %9 = load i32* %b, align 4                      ; <i32> [#uses=1]
  %10 = load i32* %z, align 4                     ; <i32> [#uses=1]
  %11 = mul i32 %10, %9                           ; <i32> [#uses=1]
  store i32 %11, i32* %z, align 4
  %12 = load i32* %j, align 4                     ; <i32> [#uses=1]
  %13 = add nsw i32 %12, 1                        ; <i32> [#uses=1]
  store i32 %13, i32* %j, align 4
  br label %bb2

bb2:                                              ; preds = %bb1, %bb
  %14 = load i32* %j, align 4                     ; <i32> [#uses=1]
  %15 = load i32* %i, align 4                     ; <i32> [#uses=1]
  %16 = icmp slt i32 %14, %15                     ; <i1> [#uses=1]
  br i1 %16, label %bb1, label %bb3

bb3:                                              ; preds = %bb2
  %17 = load i32* %i, align 4                     ; <i32> [#uses=1]
  %18 = add nsw i32 %17, 1                        ; <i32> [#uses=1]
  store i32 %18, i32* %i, align 4
  br label %bb4

bb4:                                              ; preds = %bb3, %entry
  %19 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %20 = load i32* %i, align 4                     ; <i32> [#uses=1]
  %21 = icmp slt i32 %20, %19                     ; <i1> [#uses=1]
  br i1 %21, label %bb, label %bb5

bb5:                                              ; preds = %bb5, %bb4
  %22 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([12 x i8]* @.str3, i32 0, i32 0), i32 %22) nounwind ; <i32> [#uses=0]
  %24 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %25 = sub i32 %24, 1                            ; <i32> [#uses=1]
  store i32 %25, i32* %a, align 4
  %26 = load i32* %a, align 4                     ; <i32> [#uses=1]
  %27 = icmp sgt i32 %26, 0                       ; <i1> [#uses=1]
  br i1 %27, label %bb5, label %bb6

bb6:                                              ; preds = %bb5
  store i32 0, i32* %0, align 4
  %28 = load i32* %0, align 4                     ; <i32> [#uses=1]
  store i32 %28, i32* %retval, align 4
  br label %return

return:                                           ; preds = %bb6
  %retval7 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval7
}

declare i32 @"\01__isoc99_scanf"(i8* noalias, ...) nounwind

declare i32 @printf(i8* noalias, ...) nounwind
