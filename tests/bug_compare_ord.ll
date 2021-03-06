; ModuleID = 'test.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str1 = private constant [4 x i8] c"%i\0A\00", align 1 ; <[4 x i8]*> [#uses=1]

define i32 @func(double %a, double %b) nounwind readnone {
entry:
  %0 = fcmp ord double %a, %b                     ; <i1> [#uses=1]
  %1 = zext i1 %0 to i32                          ; <i32> [#uses=1]
  ret i32 %1
}

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind {
entry:
  %b = alloca i32, align 4                        ; <i32*> [#uses=2]
  %a = alloca i32, align 4                        ; <i32*> [#uses=2]
  %0 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %a) nounwind ; <i32> [#uses=0]
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %b) nounwind ; <i32> [#uses=0]
  %2 = load i32* %b, align 4                      ; <i32> [#uses=1]
  %3 = sitofp i32 %2 to double                    ; <double> [#uses=1]
  %4 = load i32* %a, align 4                      ; <i32> [#uses=1]
  %5 = sitofp i32 %4 to double                    ; <double> [#uses=1]
  %6 = call i32 @func(double %5, double %3) nounwind ; <i32> [#uses=1]
  %7 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %6) nounwind ; <i32> [#uses=0]
  ret i32 0
}

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind
