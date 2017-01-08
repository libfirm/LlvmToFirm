; ModuleID = '/home/olaf/Projekte/testing/structret/test.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

%struct.testStruct = type { i32, [2 x i32], i32 }

@.str = private constant [24 x i8] c"{ %i, [ %i, %i ], %i }\0A\00", align 1
@mem  = private global %struct.testStruct zeroinitializer

define void @bar(%struct.testStruct %ts) nounwind {
entry:
  %0 = extractvalue %struct.testStruct %ts, 0
  %1 = extractvalue %struct.testStruct %ts, 1, 0
  %2 = extractvalue %struct.testStruct %ts, 1, 1
  %3 = extractvalue %struct.testStruct %ts, 2
  %4 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @.str, i32 0, i32 0), i32 %0, i32 %1, i32 %2, i32 %3)
  ret void
}

define %struct.testStruct @foo() nounwind {
entry:
  %0 = insertvalue %struct.testStruct undef, [ 2 x i32 ] [ i32 18, i32 8 ], 1
  %1 = insertvalue %struct.testStruct %0, i32 9, 0
  %2 = insertvalue %struct.testStruct %1, i32 7, 2
  ret %struct.testStruct %2
}

define i32 @main() nounwind {
entry:
  %0 = call %struct.testStruct ()* @foo()
  store %struct.testStruct %0, %struct.testStruct* @mem
  %1 = load %struct.testStruct* @mem
  call void (%struct.testStruct)* @bar(%struct.testStruct %1)
  ret i32 0
}

declare i32 @printf(i8* nocapture, ...) nounwind
