; ModuleID = 'test.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str  = private constant [4 x i8]  c"%i\0A\00", align 1
@.str1 = private constant [16 x i8] c"a = %i, b = %i\0A\00", align 1

define i32 @main() nounwind {
entry:
  br label %loop1

  ; Two nested loops, with i6 counters from 0 to 31, so that each i5 operand is tested.

loop1:
  ; Get the loop counter.
  %i = phi i6 [ 0, %entry ], [ %ni, %loop1_2 ]
  br label %loop2

loop2:
  ; Get the loop counter.
  %j = phi i6 [ 0, %loop1 ], [ %nj, %loop2_3 ]

  ; Turn the counters into i5.
  %0 = trunc i6 %i to i5
  %1 = trunc i6 %j to i5

  ; Perform tests.
  %2  = add  i5 %0, %1
  %3  = sub  i5 %0, %1
  %4  = mul  i5 %0, %1
  %5  = and  i5 %0, %1
  %6  = or   i5 %0, %1
  %7  = xor  i5 %0, %1
  %8  = shl  i5 %0, %1
  %9  = lshr i5 %0, %1
  %10 = ashr i5 %0, %1

  ; Expand to i32 for output.
  %11 = zext i5 %2  to i32
  %12 = zext i5 %3  to i32
  %13 = zext i5 %4  to i32
  %14 = zext i5 %5  to i32
  %15 = zext i5 %6  to i32
  %16 = zext i5 %7  to i32
  %17 = zext i5 %8  to i32
  %18 = zext i5 %9  to i32
  %19 = zext i5 %10 to i32
  %20 = sext i5 %2  to i32
  %21 = sext i5 %3  to i32
  %22 = sext i5 %4  to i32
  %23 = sext i5 %5  to i32
  %24 = sext i5 %6  to i32
  %25 = sext i5 %7  to i32
  %26 = sext i5 %8  to i32
  %27 = sext i5 %9  to i32
  %28 = sext i5 %10 to i32

  ; Output the results.
  %29 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %11) nounwind
  %30 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %12) nounwind
  %31 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %13) nounwind
  %32 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %14) nounwind
  %33 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %15) nounwind
  %34 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %16) nounwind
  %35 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %17) nounwind
  %36 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %18) nounwind
  %37 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %19) nounwind
  %38 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %20) nounwind
  %39 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %21) nounwind
  %40 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %22) nounwind
  %41 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %23) nounwind
  %42 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %24) nounwind
  %43 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %25) nounwind
  %44 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %26) nounwind
  %45 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %27) nounwind
  %46 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %28) nounwind

  ; Skip the next part when j is zero.
  %jz = icmp eq i6 %j, 0
  br i1 %jz, label %loop2_3, label %loop2_2

loop2_2:
  ; Do division tests.
  %47 = sdiv i5 %0, %1
  %48 = udiv i5 %0, %1
  %49 = srem i5 %0, %1
  %50 = urem i5 %0, %1

  ; Expand to i32 for output.
  %51 = zext i5 %47 to i32
  %52 = zext i5 %48 to i32
  %53 = zext i5 %49 to i32
  %54 = zext i5 %50 to i32
  %55 = sext i5 %47 to i32
  %56 = sext i5 %48 to i32
  %57 = sext i5 %49 to i32
  %58 = sext i5 %50 to i32

  ; Output the results.
  %59 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %51) nounwind
  %60 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %52) nounwind
  %61 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %53) nounwind
  %62 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %54) nounwind
  %63 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %55) nounwind
  %64 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %56) nounwind
  %65 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %57) nounwind
  %66 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %58) nounwind

  br label %loop2_3

loop2_3:
  ; Test comparisons.
  %67 = icmp eq  i5 %0, %1
  %68 = icmp ne  i5 %0, %1
  %69 = icmp ugt i5 %0, %1
  %70 = icmp uge i5 %0, %1
  %71 = icmp ult i5 %0, %1
  %72 = icmp ule i5 %0, %1
  %73 = icmp sgt i5 %0, %1
  %74 = icmp sge i5 %0, %1
  %75 = icmp slt i5 %0, %1
  %76 = icmp sle i5 %0, %1

  ; Convert to integers.
  %77 = zext i1 %67 to i32
  %78 = zext i1 %68 to i32
  %79 = zext i1 %69 to i32
  %80 = zext i1 %70 to i32
  %81 = zext i1 %71 to i32
  %82 = zext i1 %72 to i32
  %83 = zext i1 %73 to i32
  %84 = zext i1 %74 to i32
  %85 = zext i1 %75 to i32
  %86 = zext i1 %76 to i32

  ; Output the results.
  %87 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %77) nounwind
  %88 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %78) nounwind
  %89 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %79) nounwind
  %90 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %80) nounwind
  %91 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %81) nounwind
  %92 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %82) nounwind
  %93 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %83) nounwind
  %94 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %84) nounwind
  %95 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %85) nounwind
  %96 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %86) nounwind

  ; Output the counter variables.
  %97  = zext i5 %0 to i32
  %98  = zext i5 %1 to i32
  %99  = sext i5 %0 to i32
  %100 = sext i5 %1 to i32
  %101 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([16 x i8]* @.str1, i32 0, i32 0), i32 %97, i32 %98)  nounwind
  %102 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([16 x i8]* @.str1, i32 0, i32 0), i32 %99, i32 %100) nounwind

  ; Increate the loop counter, leave on 32.
  %nj = add i6 %j, 1
  %jc = icmp uge i6 %nj, 32
  br i1 %jc, label %loop1_2, label %loop2

loop1_2:
  ; Increase the loop counter, leave on 32.
  %ni = add i6 %i, 1
  %ic = icmp uge i6 %ni, 32
  br i1 %ic, label %leave, label %loop1

leave:
  ret i32 0
}

declare i32 @printf(i8* nocapture, ...) nounwind
