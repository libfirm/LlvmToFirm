target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [3 x i8] c"%i\00", align 1
@.str1 = private constant [4 x i8] c"%lf\00", align 1
@.str2 = private constant [4 x i8] c"%i\0A\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str3 = private constant [4 x i8] c"%f\0A\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str4 = private constant [4 x i8] c"%p\0A\00", align 1 ; <[4 x i8]*> [#uses=1]

define i32 @main() nounwind {
entry:

  ; Read in some values.
  %a  = alloca i32, align 4    ; =  0    used to construct i1 0 and 1 ; zext, sext, uitofp, sitofp
  %b  = alloca i32, align 4    ; =  1    used to construct i1 0 and 1
  %c  = alloca i32, align 4    ; =  6    low order bit 0 should be 0 on trunc
  %d  = alloca i32, align 4    ; =  3    low order bit 1 should be 1 on trunc
  %e  = alloca double, align 8 ; =  0.99 should be rounded to 0 for fptoui
  %f  = alloca double, align 8 ; =  1.0  should be 1 for fptoui
  %g  = alloca double, align 8 ; = -0.99 should be rounded to 0 for fptosi
  %h  = alloca double, align 8 ; = -1.0  should be 1 for fptosi
  %0  = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %a) nounwind
  %1  = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %b) nounwind
  %2  = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %c) nounwind
  %3  = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %d) nounwind
  %4  = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), double* %e) nounwind
  %5  = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), double* %f) nounwind
  %6  = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), double* %g) nounwind
  %7  = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), double* %h) nounwind
  %8  = load i32* %a, align 4
  %9  = load i32* %b, align 4
  %10 = load i32* %c, align 4
  %11 = load i32* %d, align 4
  %12 = load double* %e, align 8
  %13 = load double* %f, align 8
  %14 = load double* %g, align 8
  %15 = load double* %h, align 8

  ; Create both i1 values without conversions.
  %16 = icmp eq i32 %8, %9 ; = 0
  %17 = icmp ne i32 %8, %9 ; = 1

  ; zext tests
  %18 = zext i1 %16 to i32 ; = 0
  %19 = zext i1 %17 to i32 ; = 1
  %20 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0), i32 %18) nounwind
  %21 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0), i32 %19) nounwind

  ; sext tests
  %22 = sext i1 %16 to i32 ; =  0
  %23 = sext i1 %17 to i32 ; = -1
  %24 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0), i32 %22) nounwind
  %25 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0), i32 %23) nounwind

  ; trunc tests
  %26 = trunc i32 %10 to i1 ; = 0
  %27 = trunc i32 %11 to i1 ; = 1
  %28 = select i1 %26, i32 1, i32 0
  %29 = select i1 %27, i32 1, i32 0
  %30 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0), i32 %28) nounwind
  %31 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0), i32 %29) nounwind

  ; uitofp tests
  %32 = uitofp i1 %16 to double ; = 0.0
  %33 = uitofp i1 %17 to double ; = 1.0
  %34 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str3, i32 0, i32 0), double %32) nounwind
  %35 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str3, i32 0, i32 0), double %33) nounwind
  
  ; sitofp tests
  %36 = sitofp i1 %16 to double ; =  0.0
  %37 = sitofp i1 %17 to double ; = -1.0
  %38 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str3, i32 0, i32 0), double %36) nounwind
  %39 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str3, i32 0, i32 0), double %37) nounwind

  ; inttoptr
  %40 = inttoptr i1 %16 to i1* ; = 0x0
  %41 = inttoptr i1 %17 to i1* ; = 0x1
  %42 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str4, i32 0, i32 0), i1* %40) nounwind
  %43 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str4, i32 0, i32 0), i1* %41) nounwind

  ; fptoui tests
  %44 = fptoui double %12 to i1 ; = 0
  %45 = fptoui double %13 to i1 ; = 1
  %46 = select i1 %44, i32 1, i32 0
  %47 = select i1 %45, i32 1, i32 0
  %48 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0), i32 %46) nounwind
  %49 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0), i32 %47) nounwind

  ; fptosi tests
  %50 = fptosi double %14 to i1 ; =  0
  %51 = fptosi double %15 to i1 ; = -1
  %52 = select i1 %50, i32 -1, i32 0
  %53 = select i1 %51, i32 -1, i32 0
  %54 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0), i32 %52) nounwind
  %55 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str2, i32 0, i32 0), i32 %53) nounwind

  ret i32 0
}

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind
