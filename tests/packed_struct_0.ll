; ModuleID = 'packed_struct.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

%struct.TestStruct = type <{ i8, i16, i32 }>

@.str = private constant [4 x i8] c"%i\0A\00", align 1 ; <[4 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %argc_addr = alloca i32                         ; <i32*> [#uses=1]
  %argv_addr = alloca i8**                        ; <i8***> [#uses=1]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %ts = alloca %struct.TestStruct                 ; <%struct.TestStruct*> [#uses=4]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 %argc, i32* %argc_addr
  store i8** %argv, i8*** %argv_addr
  %1 = getelementptr inbounds %struct.TestStruct* %ts, i32 0, i32 0 ; <i8*> [#uses=1]
  store i8 123, i8* %1, align 1
  %2 = getelementptr inbounds %struct.TestStruct* %ts, i32 0, i32 1 ; <i16*> [#uses=1]
  store i16 8937, i16* %2, align 1
  %3 = getelementptr inbounds %struct.TestStruct* %ts, i32 0, i32 2 ; <i32*> [#uses=1]
  store i32 98733, i32* %3, align 1
  %ts1 = bitcast %struct.TestStruct* %ts to i32*  ; <i32*> [#uses=1]
  %4 = load i32* %ts1, align 4                    ; <i32> [#uses=1]
  %5 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %4) nounwind ; <i32> [#uses=0]
  store i32 0, i32* %0, align 4
  %6 = load i32* %0, align 4                      ; <i32> [#uses=1]
  store i32 %6, i32* %retval, align 4
  br label %return

return:                                           ; preds = %entry
  %retval3 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval3
}

declare i32 @printf(i8* noalias, ...) nounwind
