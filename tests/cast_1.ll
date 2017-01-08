; ModuleID = 'cast.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str1 = private constant [4 x i8] c"%i\0A\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str2 = private constant [4 x i8] c"%p\0A\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str3 = private constant [3 x i8] c"%f\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str4 = private constant [4 x i8] c"%E\0A\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str5 = private constant [4 x i8] c"%f\0A\00", align 1 ; <[4 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind {
entry:
  %fpnum = alloca float, align 4                  ; <float*> [#uses=3]
  %num = alloca i32, align 4                      ; <i32*> [#uses=3]
  %0 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %num) nounwind ; <i32> [#uses=0]
  %1 = load i32* %num, align 4                    ; <i32> [#uses=1]
  %2 = trunc i32 %1 to i8                         ; <i8> [#uses=1]
  %3 = add nsw i8 %2, 1                           ; <i8> [#uses=2]
  %4 = sext i8 %3 to i32                          ; <i32> [#uses=2]
  %5 = zext i8 %3 to i32                          ; <i32> [#uses=1]
  %6 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %4) nounwind ; <i32> [#uses=0]
  %7 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %4) nounwind ; <i32> [#uses=0]
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %5) nounwind ; <i32> [#uses=0]
  %9 = load i32* %num, align 4                    ; <i32> [#uses=1]
  %10 = inttoptr i32 %9 to i8*                    ; <i8*> [#uses=1]
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0), i8* %10) nounwind ; <i32> [#uses=0]
  %12 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str3, i32 0, i32 0), float* %fpnum) nounwind ; <i32> [#uses=0]
  %13 = load float* %fpnum, align 4               ; <float> [#uses=1]
  %14 = fpext float %13 to double                 ; <double> [#uses=1]
  %15 = fadd double %14, 1.000000e+100            ; <double> [#uses=2]
  %16 = fptrunc double %15 to float               ; <float> [#uses=1]
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str4, i32 0, i32 0), double %15) nounwind ; <i32> [#uses=0]
  %18 = fpext float %16 to double                 ; <double> [#uses=1]
  %19 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str4, i32 0, i32 0), double %18) nounwind ; <i32> [#uses=0]
  %20 = load float* %fpnum, align 4               ; <float> [#uses=2]
  %21 = fsub float -0.000000e+00, %20             ; <float> [#uses=1]
  %22 = fptoui float %20 to i32                   ; <i32> [#uses=2]
  %23 = fptosi float %21 to i32                   ; <i32> [#uses=2]
  %24 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %22) nounwind ; <i32> [#uses=0]
  %25 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %23) nounwind ; <i32> [#uses=0]
  %26 = uitofp i32 %22 to float                   ; <float> [#uses=1]
  %27 = sitofp i32 %23 to float                   ; <float> [#uses=1]
  %28 = fpext float %26 to double                 ; <double> [#uses=1]
  %29 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str5, i32 0, i32 0), double %28) nounwind ; <i32> [#uses=0]
  %30 = fpext float %27 to double                 ; <double> [#uses=1]
  %31 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str5, i32 0, i32 0), double %30) nounwind ; <i32> [#uses=0]
  ret i32 0
}

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind
