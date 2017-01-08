; ModuleID = 'test.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [4 x i8] c"%i\0A\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str1 = private constant [4 x i8] c"%f\0A\00", align 1 ; <[4 x i8]*> [#uses=1]

define void @foo(i32 %a, ...) nounwind {
entry:
  %y = alloca i8*, align 4                        ; <i8**> [#uses=8]
  %x = alloca i8*, align 4                        ; <i8**> [#uses=7]
  %memtmp = alloca i8*, align 4                   ; <i8**> [#uses=2]
  %y1 = bitcast i8** %y to i8*                    ; <i8*> [#uses=2]
  call void @llvm.va_start(i8* %y1)
  %x2 = bitcast i8** %x to i8*                    ; <i8*> [#uses=3]
  call void @llvm.va_start(i8* %x2)
  %0 = load i8** %x, align 4                      ; <i8*> [#uses=2]
  %1 = getelementptr inbounds i8* %0, i32 4       ; <i8*> [#uses=1]
  store i8* %1, i8** %x, align 4
  %2 = bitcast i8* %0 to i32*                     ; <i32*> [#uses=1]
  %3 = load i32* %2, align 4                      ; <i32> [#uses=1]
  %4 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %3) nounwind ; <i32> [#uses=0]
  %5 = load i8** %x, align 4                      ; <i8*> [#uses=2]
  %6 = getelementptr inbounds i8* %5, i32 8       ; <i8*> [#uses=1]
  store i8* %6, i8** %x, align 4
  %7 = bitcast i8* %5 to double*                  ; <double*> [#uses=1]
  %8 = load double* %7, align 4                   ; <double> [#uses=1]
  %9 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), double %8) nounwind ; <i32> [#uses=0]
  %10 = load i8** %y, align 4                     ; <i8*> [#uses=1]
  store i8* %10, i8** %memtmp
  %memtmp4 = bitcast i8** %memtmp to i8*          ; <i8*> [#uses=1]
  call void @llvm.va_copy(i8* %x2, i8* %memtmp4)
  %11 = load i8** %x, align 4                     ; <i8*> [#uses=2]
  %12 = getelementptr inbounds i8* %11, i32 4     ; <i8*> [#uses=1]
  store i8* %12, i8** %x, align 4
  %13 = bitcast i8* %11 to i32*                   ; <i32*> [#uses=1]
  %14 = load i32* %13, align 4                    ; <i32> [#uses=1]
  %15 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %14) nounwind ; <i32> [#uses=0]
  call void @llvm.va_end(i8* %x2)
  %16 = load i8** %y, align 4                     ; <i8*> [#uses=2]
  %17 = getelementptr inbounds i8* %16, i32 4     ; <i8*> [#uses=1]
  store i8* %17, i8** %y, align 4
  %18 = bitcast i8* %16 to i32*                   ; <i32*> [#uses=1]
  %19 = load i32* %18, align 4                    ; <i32> [#uses=1]
  %20 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %19) nounwind ; <i32> [#uses=0]
  %21 = load i8** %y, align 4                     ; <i8*> [#uses=2]
  %22 = getelementptr inbounds i8* %21, i32 8     ; <i8*> [#uses=1]
  store i8* %22, i8** %y, align 4
  %23 = bitcast i8* %21 to double*                ; <double*> [#uses=1]
  %24 = load double* %23, align 4                 ; <double> [#uses=1]
  %25 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), double %24) nounwind ; <i32> [#uses=0]
  %26 = load i8** %y, align 4                     ; <i8*> [#uses=2]
  %27 = getelementptr inbounds i8* %26, i32 4     ; <i8*> [#uses=1]
  store i8* %27, i8** %y, align 4
  %28 = bitcast i8* %26 to i32*                   ; <i32*> [#uses=1]
  %29 = load i32* %28, align 4                    ; <i32> [#uses=1]
  %30 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %29) nounwind ; <i32> [#uses=0]
  call void @llvm.va_end(i8* %y1)
  ret void
}

declare void @llvm.va_start(i8*) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind

declare void @llvm.va_copy(i8*, i8*) nounwind

declare void @llvm.va_end(i8*) nounwind

define i32 @main() nounwind {
entry:
  tail call void (i32, ...)* @foo(i32 0, i32 1, double 2.900000e+00, i32 3) nounwind
  ret i32 0
}
