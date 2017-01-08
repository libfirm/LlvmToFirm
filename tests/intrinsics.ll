; ModuleID = '/home/olaf/Projekte/testing/intrinsics.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [7 x i8] c"%1024s\00", align 1 ; <[7 x i8]*> [#uses=1]
@.str1 = private constant [4 x i8] c"%lf\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str2 = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str3 = private constant [4 x i8] c"%f\0A\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str4 = private constant [4 x i8] c"%i\0A\00", align 1 ; <[4 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind {
entry:
  %c = alloca i32, align 4                        ; <i32*> [#uses=2]
  %b = alloca double, align 8                     ; <double*> [#uses=2]
  %a = alloca double, align 8                     ; <double*> [#uses=6]

  ; memcpy, memset, memmove. More or less llvm-gcc output.
  %buffer2 = alloca [1024 x i8], align 1          ; <[1024 x i8]*> [#uses=1]
  %buffer = alloca [1024 x i8], align 1           ; <[1024 x i8]*> [#uses=4]
  %0 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([7 x i8]* @.str, i32 0, i32 0), [1024 x i8]* %buffer) nounwind ; <i32> [#uses=0]
  %buffer22 = getelementptr inbounds [1024 x i8]* %buffer2, i32 0, i32 0 ; <i8*> [#uses=2]
  %buffer3 = getelementptr inbounds [1024 x i8]* %buffer, i32 0, i32 0 ; <i8*> [#uses=5]
  call void @llvm.memcpy.i32(i8* %buffer22, i8* %buffer3, i32 1024, i32 1)
  %1 = call i32 @puts(i8* %buffer22) nounwind     ; <i32> [#uses=0]
  call void @llvm.memset.i32(i8* %buffer3, i8 65, i32 10, i32 1)
  %2 = getelementptr inbounds [1024 x i8]* %buffer, i32 0, i32 9 ; <i8*> [#uses=1]
  store i8 0, i8* %2, align 1
  %3 = call i32 @puts(i8* %buffer3) nounwind      ; <i32> [#uses=0]
  %4 = getelementptr inbounds [1024 x i8]* %buffer, i32 0, i32 5 ; <i8*> [#uses=1]
  call void @llvm.memmove.i32(i8* %4, i8* %buffer3, i32 10, i32 1)
  %5 = call i32 @puts(i8* %buffer3) nounwind      ; <i32> [#uses=0]

  ; Read in two floats and an int to work with.
  %6 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), double* %a) nounwind
  %7 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), double* %b) nounwind
  %8 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str2, i32 0, i32 0), i32* %c) nounwind
  %9 = load double* %a, align 8
  %10 = load double* %b, align 8
  %11 = load i32* %c, align 8

  ; Call all those intrinsics.
  %12 = call double @llvm.sqrt.f64(double %9) nounwind readonly
  %13 = call double @llvm.pow.f64(double %9, double %10) nounwind readonly
  %14 = call double @llvm.log.f64(double %9) nounwind readonly
  %15 = call double @llvm.log2.f64(double %9) nounwind readonly
  %16 = call double @llvm.log10.f64(double %9) nounwind readonly
  %17 = call double @llvm.exp.f64(double %9) nounwind readonly
  %18 = call double @llvm.exp2.f64(double %9) nounwind readonly
  %19 = call i32 @llvm.bswap.i32(i32 %11) nounwind readonly
  %20 = call i32 @llvm.ctpop.i32(i32 %11) nounwind readonly
  %21 = call i32 @llvm.ctlz.i32(i32 %11) nounwind readonly
  %22 = call i32 @llvm.cttz.i32(i32 %11) nounwind readonly

  ; And write out all results.
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str3, i32 0, i32 0), double %12) nounwind ; <i32> [#uses=0]
  %24 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str3, i32 0, i32 0), double %13) nounwind ; <i32> [#uses=0]
  %25 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str3, i32 0, i32 0), double %14) nounwind ; <i32> [#uses=0]
  %26 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str3, i32 0, i32 0), double %15) nounwind ; <i32> [#uses=0]
  %27 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str3, i32 0, i32 0), double %16) nounwind ; <i32> [#uses=0]
  %28 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str3, i32 0, i32 0), double %17) nounwind ; <i32> [#uses=0]
  %29 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str3, i32 0, i32 0), double %18) nounwind ; <i32> [#uses=0]
  %30 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str4, i32 0, i32 0), i32 %19) nounwind ; <i32> [#uses=0]
  %31 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str4, i32 0, i32 0), i32 %20) nounwind ; <i32> [#uses=0]
  %32 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str4, i32 0, i32 0), i32 %21) nounwind ; <i32> [#uses=0]
  %33 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str4, i32 0, i32 0), i32 %22) nounwind ; <i32> [#uses=0]
  ret i32 0
}

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind
declare void @llvm.memcpy.i32(i8* nocapture, i8* nocapture, i32, i32) nounwind
declare i32 @puts(i8* nocapture) nounwind
declare void @llvm.memset.i32(i8* nocapture, i8, i32, i32) nounwind
declare void @llvm.memmove.i32(i8* nocapture, i8* nocapture, i32, i32) nounwind
declare i32 @printf(i8* nocapture, ...) nounwind
declare double @llvm.sqrt.f64(double) nounwind readonly
declare double @llvm.pow.f64(double, double) nounwind readonly
declare double @llvm.log.f64(double) nounwind readonly
declare double @llvm.log2.f64(double) nounwind readonly
declare double @llvm.log10.f64(double) nounwind readonly
declare double @llvm.exp.f64(double) nounwind readonly
declare double @llvm.exp2.f64(double) nounwind readonly
declare i32 @llvm.bswap.i32(i32) nounwind readonly
declare i32 @llvm.ctpop.i32(i32) nounwind readonly
declare i32 @llvm.ctlz.i32(i32) nounwind readonly
declare i32 @llvm.cttz.i32(i32) nounwind readonly
