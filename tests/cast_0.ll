; ModuleID = 'cast.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str1 = private constant [4 x i8] c"%i\0A\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str2 = private constant [4 x i8] c"%p\0A\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str3 = private constant [3 x i8] c"%f\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str4 = private constant [4 x i8] c"%E\0A\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str5 = private constant [4 x i8] c"%f\0A\00", align 1 ; <[4 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %argc_addr = alloca i32                         ; <i32*> [#uses=1]
  %argv_addr = alloca i8**                        ; <i8***> [#uses=1]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %sitofp = alloca float                          ; <float*> [#uses=2]
  %uitofp = alloca float                          ; <float*> [#uses=2]
  %fptosi = alloca i32                            ; <i32*> [#uses=3]
  %fptoui = alloca i32                            ; <i32*> [#uses=3]
  %negfpnum = alloca float                        ; <float*> [#uses=2]
  %fptrunc = alloca float                         ; <float*> [#uses=2]
  %fpext = alloca double, align 8                 ; <double*> [#uses=5]
  %fpnum = alloca float                           ; <float*> [#uses=4]
  %inttoptr = alloca i8*                          ; <i8**> [#uses=2]
  %zext = alloca i32                              ; <i32*> [#uses=2]
  %sext = alloca i32                              ; <i32*> [#uses=2]
  %trunc = alloca i8                              ; <i8*> [#uses=6]
  %num = alloca i32                               ; <i32*> [#uses=3]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 %argc, i32* %argc_addr
  store i8** %argv, i8*** %argv_addr
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %num) nounwind ; <i32> [#uses=0]
  %2 = load i32* %num, align 4                    ; <i32> [#uses=1]
  %3 = trunc i32 %2 to i8                         ; <i8> [#uses=1]
  store i8 %3, i8* %trunc, align 1
  %4 = load i8* %trunc, align 1                   ; <i8> [#uses=1]
  %5 = add nsw i8 %4, 1                           ; <i8> [#uses=1]
  store i8 %5, i8* %trunc, align 1
  %6 = load i8* %trunc, align 1                   ; <i8> [#uses=1]
  %7 = sext i8 %6 to i32                          ; <i32> [#uses=1]
  store i32 %7, i32* %sext, align 4
  %8 = load i8* %trunc, align 1                   ; <i8> [#uses=1]
  %9 = zext i8 %8 to i32                          ; <i32> [#uses=1]
  store i32 %9, i32* %zext, align 4
  %10 = load i8* %trunc, align 1                  ; <i8> [#uses=1]
  %11 = sext i8 %10 to i32                        ; <i32> [#uses=1]
  %12 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %11) nounwind ; <i32> [#uses=0]
  %13 = load i32* %sext, align 4                  ; <i32> [#uses=1]
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %13) nounwind ; <i32> [#uses=0]
  %15 = load i32* %zext, align 4                  ; <i32> [#uses=1]
  %16 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %15) nounwind ; <i32> [#uses=0]
  %17 = load i32* %num, align 4                   ; <i32> [#uses=1]
  %18 = inttoptr i32 %17 to i8*                   ; <i8*> [#uses=1]
  store i8* %18, i8** %inttoptr, align 4
  %19 = load i8** %inttoptr, align 4              ; <i8*> [#uses=1]
  %20 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0), i8* %19) nounwind ; <i32> [#uses=0]
  %21 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str3, i32 0, i32 0), float* %fpnum) nounwind ; <i32> [#uses=0]
  %22 = load float* %fpnum, align 4               ; <float> [#uses=1]
  %23 = fpext float %22 to double                 ; <double> [#uses=1]
  store double %23, double* %fpext, align 8
  %24 = load double* %fpext, align 8              ; <double> [#uses=1]
  %25 = fadd double %24, 1.000000e+100            ; <double> [#uses=1]
  store double %25, double* %fpext, align 8
  %26 = load double* %fpext, align 8              ; <double> [#uses=1]
  %27 = fptrunc double %26 to float               ; <float> [#uses=1]
  store float %27, float* %fptrunc, align 4
  %28 = load double* %fpext, align 8              ; <double> [#uses=1]
  %29 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str4, i32 0, i32 0), double %28) nounwind ; <i32> [#uses=0]
  %30 = load float* %fptrunc, align 4             ; <float> [#uses=1]
  %31 = fpext float %30 to double                 ; <double> [#uses=1]
  %32 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str4, i32 0, i32 0), double %31) nounwind ; <i32> [#uses=0]
  %33 = load float* %fpnum, align 4               ; <float> [#uses=1]
  %34 = fsub float -0.000000e+00, %33             ; <float> [#uses=1]
  store float %34, float* %negfpnum, align 4
  %35 = load float* %fpnum, align 4               ; <float> [#uses=1]
  %36 = fptoui float %35 to i32                   ; <i32> [#uses=1]
  store i32 %36, i32* %fptoui, align 4
  %37 = load float* %negfpnum, align 4            ; <float> [#uses=1]
  %38 = fptosi float %37 to i32                   ; <i32> [#uses=1]
  store i32 %38, i32* %fptosi, align 4
  %39 = load i32* %fptoui, align 4                ; <i32> [#uses=1]
  %40 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %39) nounwind ; <i32> [#uses=0]
  %41 = load i32* %fptosi, align 4                ; <i32> [#uses=1]
  %42 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %41) nounwind ; <i32> [#uses=0]
  %43 = load i32* %fptoui, align 4                ; <i32> [#uses=1]
  %44 = uitofp i32 %43 to float                   ; <float> [#uses=1]
  store float %44, float* %uitofp, align 4
  %45 = load i32* %fptosi, align 4                ; <i32> [#uses=1]
  %46 = sitofp i32 %45 to float                   ; <float> [#uses=1]
  store float %46, float* %sitofp, align 4
  %47 = load float* %uitofp, align 4              ; <float> [#uses=1]
  %48 = fpext float %47 to double                 ; <double> [#uses=1]
  %49 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str5, i32 0, i32 0), double %48) nounwind ; <i32> [#uses=0]
  %50 = load float* %sitofp, align 4              ; <float> [#uses=1]
  %51 = fpext float %50 to double                 ; <double> [#uses=1]
  %52 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str5, i32 0, i32 0), double %51) nounwind ; <i32> [#uses=0]
  store i32 0, i32* %0, align 4
  %53 = load i32* %0, align 4                     ; <i32> [#uses=1]
  store i32 %53, i32* %retval, align 4
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval1
}

declare i32 @"\01__isoc99_scanf"(i8* noalias, ...) nounwind

declare i32 @printf(i8* noalias, ...) nounwind
