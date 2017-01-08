; ModuleID = 'bitfields.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

%struct.TestStruct = type <{ i32 }>

@.str = private constant [4 x i8] c"%i\0A\00", align 1 ; <[4 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %argc_addr = alloca i32                         ; <i32*> [#uses=1]
  %argv_addr = alloca i8**                        ; <i8***> [#uses=1]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %ts = alloca %struct.TestStruct, align 4        ; <%struct.TestStruct*> [#uses=6]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 %argc, i32* %argc_addr
  store i8** %argv, i8*** %argv_addr
  %1 = getelementptr inbounds %struct.TestStruct* %ts, i32 0, i32 0 ; <i32*> [#uses=2]
  %2 = load i32* %1, align 1                      ; <i32> [#uses=1]
  %3 = and i32 %2, -2                             ; <i32> [#uses=1]
  %4 = or i32 %3, 1                               ; <i32> [#uses=1]
  store i32 %4, i32* %1, align 1
  %5 = getelementptr inbounds %struct.TestStruct* %ts, i32 0, i32 0 ; <i32*> [#uses=2]
  %6 = load i32* %5, align 1                      ; <i32> [#uses=1]
  %7 = and i32 %6, -31                            ; <i32> [#uses=1]
  %8 = or i32 %7, 24                              ; <i32> [#uses=1]
  store i32 %8, i32* %5, align 1
  %9 = getelementptr inbounds %struct.TestStruct* %ts, i32 0, i32 0 ; <i32*> [#uses=2]
  %10 = load i32* %9, align 1                     ; <i32> [#uses=1]
  %11 = and i32 %10, -32737                       ; <i32> [#uses=1]
  %12 = or i32 %11, 3936                          ; <i32> [#uses=1]
  store i32 %12, i32* %9, align 1
  %13 = getelementptr inbounds %struct.TestStruct* %ts, i32 0, i32 0 ; <i32*> [#uses=2]
  %14 = load i32* %13, align 1                    ; <i32> [#uses=1]
  %15 = and i32 %14, -536838145                   ; <i32> [#uses=1]
  %16 = or i32 %15, 40435712                      ; <i32> [#uses=1]
  store i32 %16, i32* %13, align 1
  %17 = getelementptr inbounds %struct.TestStruct* %ts, i32 0, i32 0 ; <i32*> [#uses=2]
  %18 = load i32* %17, align 1                    ; <i32> [#uses=1]
  %19 = and i32 %18, 536870911                    ; <i32> [#uses=1]
  %20 = or i32 %19, 536870912                     ; <i32> [#uses=1]
  store i32 %20, i32* %17, align 1
  %ts1 = bitcast %struct.TestStruct* %ts to i32*  ; <i32*> [#uses=1]
  %21 = load i32* %ts1, align 4                   ; <i32> [#uses=1]
  %22 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %21) nounwind ; <i32> [#uses=0]
  store i32 0, i32* %0, align 4
  %23 = load i32* %0, align 4                     ; <i32> [#uses=1]
  store i32 %23, i32* %retval, align 4
  br label %return

return:                                           ; preds = %entry
  %retval3 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval3
}

declare i32 @printf(i8* noalias, ...) nounwind
