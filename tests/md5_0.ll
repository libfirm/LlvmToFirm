; ModuleID = 'md5.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

%struct.FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct.FILE*, i32, i32, i32, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i32, i32, [40 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct.FILE*, i32 }
%struct.md5_ctx = type { i32, i32, i32, i32, [2 x i32], i32, [32 x i32] }

@fillbuf = internal constant [64 x i8] c"\80\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", align 32 ; <[64 x i8]*> [#uses=1]
@.str = private constant [7 x i8] c"%1000s\00", align 1 ; <[7 x i8]*> [#uses=1]
@.str1 = private constant [5 x i8] c"%02x\00", align 1 ; <[5 x i8]*> [#uses=1]

define void @md5_init_ctx(%struct.md5_ctx* %ctx) nounwind {
entry:
  %ctx_addr = alloca %struct.md5_ctx*             ; <%struct.md5_ctx**> [#uses=9]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store %struct.md5_ctx* %ctx, %struct.md5_ctx** %ctx_addr
  %0 = load %struct.md5_ctx** %ctx_addr, align 4  ; <%struct.md5_ctx*> [#uses=1]
  %1 = getelementptr inbounds %struct.md5_ctx* %0, i32 0, i32 0 ; <i32*> [#uses=1]
  store i32 1732584193, i32* %1, align 4
  %2 = load %struct.md5_ctx** %ctx_addr, align 4  ; <%struct.md5_ctx*> [#uses=1]
  %3 = getelementptr inbounds %struct.md5_ctx* %2, i32 0, i32 1 ; <i32*> [#uses=1]
  store i32 -271733879, i32* %3, align 4
  %4 = load %struct.md5_ctx** %ctx_addr, align 4  ; <%struct.md5_ctx*> [#uses=1]
  %5 = getelementptr inbounds %struct.md5_ctx* %4, i32 0, i32 2 ; <i32*> [#uses=1]
  store i32 -1732584194, i32* %5, align 4
  %6 = load %struct.md5_ctx** %ctx_addr, align 4  ; <%struct.md5_ctx*> [#uses=1]
  %7 = getelementptr inbounds %struct.md5_ctx* %6, i32 0, i32 3 ; <i32*> [#uses=1]
  store i32 271733878, i32* %7, align 4
  %8 = load %struct.md5_ctx** %ctx_addr, align 4  ; <%struct.md5_ctx*> [#uses=1]
  %9 = getelementptr inbounds %struct.md5_ctx* %8, i32 0, i32 4 ; <[2 x i32]*> [#uses=1]
  %10 = getelementptr inbounds [2 x i32]* %9, i32 0, i32 1 ; <i32*> [#uses=1]
  store i32 0, i32* %10, align 4
  %11 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %12 = getelementptr inbounds %struct.md5_ctx* %11, i32 0, i32 4 ; <[2 x i32]*> [#uses=1]
  %13 = getelementptr inbounds [2 x i32]* %12, i32 0, i32 1 ; <i32*> [#uses=1]
  %14 = load i32* %13, align 4                    ; <i32> [#uses=1]
  %15 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %16 = getelementptr inbounds %struct.md5_ctx* %15, i32 0, i32 4 ; <[2 x i32]*> [#uses=1]
  %17 = getelementptr inbounds [2 x i32]* %16, i32 0, i32 0 ; <i32*> [#uses=1]
  store i32 %14, i32* %17, align 4
  %18 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %19 = getelementptr inbounds %struct.md5_ctx* %18, i32 0, i32 5 ; <i32*> [#uses=1]
  store i32 0, i32* %19, align 4
  br label %return

return:                                           ; preds = %entry
  ret void
}

define i8* @md5_read_ctx(%struct.md5_ctx* %ctx, i8* %resbuf) nounwind {
entry:
  %ctx_addr = alloca %struct.md5_ctx*             ; <%struct.md5_ctx**> [#uses=5]
  %resbuf_addr = alloca i8*                       ; <i8**> [#uses=3]
  %retval = alloca i8*                            ; <i8**> [#uses=2]
  %r = alloca i8*                                 ; <i8**> [#uses=5]
  %0 = alloca i8*                                 ; <i8**> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store %struct.md5_ctx* %ctx, %struct.md5_ctx** %ctx_addr
  store i8* %resbuf, i8** %resbuf_addr
  %1 = load i8** %resbuf_addr, align 4            ; <i8*> [#uses=1]
  store i8* %1, i8** %r, align 4
  %2 = load %struct.md5_ctx** %ctx_addr, align 4  ; <%struct.md5_ctx*> [#uses=1]
  %3 = getelementptr inbounds %struct.md5_ctx* %2, i32 0, i32 0 ; <i32*> [#uses=1]
  %4 = load i32* %3, align 4                      ; <i32> [#uses=1]
  %5 = load i8** %r, align 4                      ; <i8*> [#uses=1]
  %6 = getelementptr inbounds i8* %5, i32 0       ; <i8*> [#uses=1]
  call void @set_uint32(i8* %6, i32 %4) nounwind
  %7 = load %struct.md5_ctx** %ctx_addr, align 4  ; <%struct.md5_ctx*> [#uses=1]
  %8 = getelementptr inbounds %struct.md5_ctx* %7, i32 0, i32 1 ; <i32*> [#uses=1]
  %9 = load i32* %8, align 4                      ; <i32> [#uses=1]
  %10 = load i8** %r, align 4                     ; <i8*> [#uses=1]
  %11 = getelementptr inbounds i8* %10, i32 4     ; <i8*> [#uses=1]
  call void @set_uint32(i8* %11, i32 %9) nounwind
  %12 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %13 = getelementptr inbounds %struct.md5_ctx* %12, i32 0, i32 2 ; <i32*> [#uses=1]
  %14 = load i32* %13, align 4                    ; <i32> [#uses=1]
  %15 = load i8** %r, align 4                     ; <i8*> [#uses=1]
  %16 = getelementptr inbounds i8* %15, i32 8     ; <i8*> [#uses=1]
  call void @set_uint32(i8* %16, i32 %14) nounwind
  %17 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %18 = getelementptr inbounds %struct.md5_ctx* %17, i32 0, i32 3 ; <i32*> [#uses=1]
  %19 = load i32* %18, align 4                    ; <i32> [#uses=1]
  %20 = load i8** %r, align 4                     ; <i8*> [#uses=1]
  %21 = getelementptr inbounds i8* %20, i32 12    ; <i8*> [#uses=1]
  call void @set_uint32(i8* %21, i32 %19) nounwind
  %22 = load i8** %resbuf_addr, align 4           ; <i8*> [#uses=1]
  store i8* %22, i8** %0, align 4
  %23 = load i8** %0, align 4                     ; <i8*> [#uses=1]
  store i8* %23, i8** %retval, align 4
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i8** %retval                    ; <i8*> [#uses=1]
  ret i8* %retval1
}

define internal void @set_uint32(i8* %cp, i32 %v) nounwind {
entry:
  %cp_addr = alloca i8*                           ; <i8**> [#uses=2]
  %v_addr = alloca i32                            ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i8* %cp, i8** %cp_addr
  store i32 %v, i32* %v_addr
  %0 = load i8** %cp_addr, align 4                ; <i8*> [#uses=1]
  %v_addr1 = bitcast i32* %v_addr to i8*          ; <i8*> [#uses=1]
  call void @llvm.memcpy.i32(i8* %0, i8* %v_addr1, i32 4, i32 1)
  br label %return

return:                                           ; preds = %entry
  ret void
}

declare void @llvm.memcpy.i32(i8* nocapture, i8* nocapture, i32, i32) nounwind

define i8* @md5_finish_ctx(%struct.md5_ctx* %ctx, i8* %resbuf) nounwind {
entry:
  %ctx_addr = alloca %struct.md5_ctx*             ; <%struct.md5_ctx**> [#uses=16]
  %resbuf_addr = alloca i8*                       ; <i8**> [#uses=2]
  %retval = alloca i8*                            ; <i8**> [#uses=2]
  %size = alloca i32                              ; <i32*> [#uses=5]
  %bytes = alloca i32                             ; <i32*> [#uses=6]
  %0 = alloca i8*                                 ; <i8**> [#uses=2]
  %iftmp.0 = alloca i32                           ; <i32*> [#uses=3]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store %struct.md5_ctx* %ctx, %struct.md5_ctx** %ctx_addr
  store i8* %resbuf, i8** %resbuf_addr
  %1 = load %struct.md5_ctx** %ctx_addr, align 4  ; <%struct.md5_ctx*> [#uses=1]
  %2 = getelementptr inbounds %struct.md5_ctx* %1, i32 0, i32 5 ; <i32*> [#uses=1]
  %3 = load i32* %2, align 4                      ; <i32> [#uses=1]
  store i32 %3, i32* %bytes, align 4
  %4 = load i32* %bytes, align 4                  ; <i32> [#uses=1]
  %5 = icmp ule i32 %4, 55                        ; <i1> [#uses=1]
  br i1 %5, label %bb, label %bb1

bb:                                               ; preds = %entry
  store i32 16, i32* %iftmp.0, align 4
  br label %bb2

bb1:                                              ; preds = %entry
  store i32 32, i32* %iftmp.0, align 4
  br label %bb2

bb2:                                              ; preds = %bb1, %bb
  %6 = load i32* %iftmp.0, align 4                ; <i32> [#uses=1]
  store i32 %6, i32* %size, align 4
  %7 = load %struct.md5_ctx** %ctx_addr, align 4  ; <%struct.md5_ctx*> [#uses=1]
  %8 = getelementptr inbounds %struct.md5_ctx* %7, i32 0, i32 4 ; <[2 x i32]*> [#uses=1]
  %9 = getelementptr inbounds [2 x i32]* %8, i32 0, i32 0 ; <i32*> [#uses=1]
  %10 = load i32* %9, align 4                     ; <i32> [#uses=1]
  %11 = load i32* %bytes, align 4                 ; <i32> [#uses=1]
  %12 = add i32 %10, %11                          ; <i32> [#uses=1]
  %13 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %14 = getelementptr inbounds %struct.md5_ctx* %13, i32 0, i32 4 ; <[2 x i32]*> [#uses=1]
  %15 = getelementptr inbounds [2 x i32]* %14, i32 0, i32 0 ; <i32*> [#uses=1]
  store i32 %12, i32* %15, align 4
  %16 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %17 = getelementptr inbounds %struct.md5_ctx* %16, i32 0, i32 4 ; <[2 x i32]*> [#uses=1]
  %18 = getelementptr inbounds [2 x i32]* %17, i32 0, i32 0 ; <i32*> [#uses=1]
  %19 = load i32* %18, align 4                    ; <i32> [#uses=1]
  %20 = load i32* %bytes, align 4                 ; <i32> [#uses=1]
  %21 = icmp ult i32 %19, %20                     ; <i1> [#uses=1]
  br i1 %21, label %bb3, label %bb4

bb3:                                              ; preds = %bb2
  %22 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %23 = getelementptr inbounds %struct.md5_ctx* %22, i32 0, i32 4 ; <[2 x i32]*> [#uses=1]
  %24 = getelementptr inbounds [2 x i32]* %23, i32 0, i32 1 ; <i32*> [#uses=1]
  %25 = load i32* %24, align 4                    ; <i32> [#uses=1]
  %26 = add i32 %25, 1                            ; <i32> [#uses=1]
  %27 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %28 = getelementptr inbounds %struct.md5_ctx* %27, i32 0, i32 4 ; <[2 x i32]*> [#uses=1]
  %29 = getelementptr inbounds [2 x i32]* %28, i32 0, i32 1 ; <i32*> [#uses=1]
  store i32 %26, i32* %29, align 4
  br label %bb4

bb4:                                              ; preds = %bb3, %bb2
  %30 = load i32* %size, align 4                  ; <i32> [#uses=1]
  %31 = sub i32 %30, 2                            ; <i32> [#uses=1]
  %32 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %33 = getelementptr inbounds %struct.md5_ctx* %32, i32 0, i32 4 ; <[2 x i32]*> [#uses=1]
  %34 = getelementptr inbounds [2 x i32]* %33, i32 0, i32 0 ; <i32*> [#uses=1]
  %35 = load i32* %34, align 4                    ; <i32> [#uses=1]
  %36 = shl i32 %35, 3                            ; <i32> [#uses=1]
  %37 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %38 = getelementptr inbounds %struct.md5_ctx* %37, i32 0, i32 6 ; <[32 x i32]*> [#uses=1]
  %39 = getelementptr inbounds [32 x i32]* %38, i32 0, i32 %31 ; <i32*> [#uses=1]
  store i32 %36, i32* %39, align 4
  %40 = load i32* %size, align 4                  ; <i32> [#uses=1]
  %41 = sub i32 %40, 1                            ; <i32> [#uses=1]
  %42 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %43 = getelementptr inbounds %struct.md5_ctx* %42, i32 0, i32 4 ; <[2 x i32]*> [#uses=1]
  %44 = getelementptr inbounds [2 x i32]* %43, i32 0, i32 1 ; <i32*> [#uses=1]
  %45 = load i32* %44, align 4                    ; <i32> [#uses=1]
  %46 = shl i32 %45, 3                            ; <i32> [#uses=1]
  %47 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %48 = getelementptr inbounds %struct.md5_ctx* %47, i32 0, i32 4 ; <[2 x i32]*> [#uses=1]
  %49 = getelementptr inbounds [2 x i32]* %48, i32 0, i32 0 ; <i32*> [#uses=1]
  %50 = load i32* %49, align 4                    ; <i32> [#uses=1]
  %51 = lshr i32 %50, 29                          ; <i32> [#uses=1]
  %52 = or i32 %46, %51                           ; <i32> [#uses=1]
  %53 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %54 = getelementptr inbounds %struct.md5_ctx* %53, i32 0, i32 6 ; <[32 x i32]*> [#uses=1]
  %55 = getelementptr inbounds [32 x i32]* %54, i32 0, i32 %41 ; <i32*> [#uses=1]
  store i32 %52, i32* %55, align 4
  %56 = load i32* %size, align 4                  ; <i32> [#uses=1]
  %57 = mul i32 %56, 4                            ; <i32> [#uses=1]
  %58 = load i32* %bytes, align 4                 ; <i32> [#uses=1]
  %59 = sub i32 %57, %58                          ; <i32> [#uses=1]
  %60 = add i32 %59, -8                           ; <i32> [#uses=1]
  %61 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %62 = getelementptr inbounds %struct.md5_ctx* %61, i32 0, i32 6 ; <[32 x i32]*> [#uses=1]
  %63 = bitcast [32 x i32]* %62 to i8*            ; <i8*> [#uses=1]
  %64 = load i32* %bytes, align 4                 ; <i32> [#uses=1]
  %65 = getelementptr inbounds i8* %63, i32 %64   ; <i8*> [#uses=1]
  call void @llvm.memcpy.i32(i8* %65, i8* getelementptr inbounds ([64 x i8]* @fillbuf, i32 0, i32 0), i32 %60, i32 1)
  %66 = load i32* %size, align 4                  ; <i32> [#uses=1]
  %67 = mul i32 %66, 4                            ; <i32> [#uses=1]
  %68 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %69 = getelementptr inbounds %struct.md5_ctx* %68, i32 0, i32 6 ; <[32 x i32]*> [#uses=1]
  %70 = getelementptr inbounds [32 x i32]* %69, i32 0, i32 0 ; <i32*> [#uses=1]
  %71 = bitcast i32* %70 to i8*                   ; <i8*> [#uses=1]
  %72 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  call void @md5_process_block(i8* %71, i32 %67, %struct.md5_ctx* %72) nounwind
  %73 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %74 = load i8** %resbuf_addr, align 4           ; <i8*> [#uses=1]
  %75 = call i8* @md5_read_ctx(%struct.md5_ctx* %73, i8* %74) nounwind ; <i8*> [#uses=1]
  store i8* %75, i8** %0, align 4
  %76 = load i8** %0, align 4                     ; <i8*> [#uses=1]
  store i8* %76, i8** %retval, align 4
  br label %return

return:                                           ; preds = %bb4
  %retval5 = load i8** %retval                    ; <i8*> [#uses=1]
  ret i8* %retval5
}

define i32 @md5_stream(%struct.FILE* %stream, i8* %resblock) nounwind {
entry:
  %stream_addr = alloca %struct.FILE*             ; <%struct.FILE**> [#uses=4]
  %resblock_addr = alloca i8*                     ; <i8**> [#uses=2]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %n = alloca i32                                 ; <i32*> [#uses=3]
  %buffer = alloca i8*                            ; <i8**> [#uses=7]
  %sum = alloca i32                               ; <i32*> [#uses=8]
  %ctx = alloca %struct.md5_ctx                   ; <%struct.md5_ctx*> [#uses=4]
  %0 = alloca i32                                 ; <i32*> [#uses=4]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store %struct.FILE* %stream, %struct.FILE** %stream_addr
  store i8* %resblock, i8** %resblock_addr
  %1 = call noalias i8* @malloc(i32 32840) nounwind ; <i8*> [#uses=1]
  store i8* %1, i8** %buffer, align 4
  %2 = load i8** %buffer, align 4                 ; <i8*> [#uses=1]
  %3 = icmp eq i8* %2, null                       ; <i1> [#uses=1]
  br i1 %3, label %bb, label %bb1

bb:                                               ; preds = %entry
  store i32 1, i32* %0, align 4
  br label %bb13

bb1:                                              ; preds = %entry
  call void @md5_init_ctx(%struct.md5_ctx* %ctx) nounwind
  br label %bb2

bb2:                                              ; preds = %bb10, %bb1
  store i32 0, i32* %sum, align 4
  br label %bb3

bb3:                                              ; preds = %bb9, %bb2
  %4 = load i32* %sum, align 4                    ; <i32> [#uses=1]
  %5 = sub i32 32768, %4                          ; <i32> [#uses=1]
  %6 = load i8** %buffer, align 4                 ; <i8*> [#uses=1]
  %7 = load i32* %sum, align 4                    ; <i32> [#uses=1]
  %8 = getelementptr inbounds i8* %6, i32 %7      ; <i8*> [#uses=1]
  %9 = load %struct.FILE** %stream_addr, align 4  ; <%struct.FILE*> [#uses=1]
  %10 = call i32 @fread(i8* noalias %8, i32 1, i32 %5, %struct.FILE* noalias %9) nounwind ; <i32> [#uses=1]
  store i32 %10, i32* %n, align 4
  %11 = load i32* %sum, align 4                   ; <i32> [#uses=1]
  %12 = load i32* %n, align 4                     ; <i32> [#uses=1]
  %13 = add i32 %11, %12                          ; <i32> [#uses=1]
  store i32 %13, i32* %sum, align 4
  %14 = load i32* %sum, align 4                   ; <i32> [#uses=1]
  %15 = icmp eq i32 %14, 32768                    ; <i1> [#uses=1]
  br i1 %15, label %bb10, label %bb4

bb4:                                              ; preds = %bb3
  %16 = load i32* %n, align 4                     ; <i32> [#uses=1]
  %17 = icmp eq i32 %16, 0                        ; <i1> [#uses=1]
  br i1 %17, label %bb5, label %bb8

bb5:                                              ; preds = %bb4
  %18 = load %struct.FILE** %stream_addr, align 4 ; <%struct.FILE*> [#uses=1]
  %19 = call i32 @ferror(%struct.FILE* %18) nounwind ; <i32> [#uses=1]
  %20 = icmp ne i32 %19, 0                        ; <i1> [#uses=1]
  br i1 %20, label %bb6, label %bb7

bb6:                                              ; preds = %bb5
  %21 = load i8** %buffer, align 4                ; <i8*> [#uses=1]
  call void @free(i8* %21) nounwind
  store i32 1, i32* %0, align 4
  br label %bb13

bb7:                                              ; preds = %bb5
  br label %process_partial_block

bb8:                                              ; preds = %bb4
  %22 = load %struct.FILE** %stream_addr, align 4 ; <%struct.FILE*> [#uses=1]
  %23 = call i32 @feof(%struct.FILE* %22) nounwind ; <i32> [#uses=1]
  %24 = icmp ne i32 %23, 0                        ; <i1> [#uses=1]
  br i1 %24, label %process_partial_block, label %bb9

bb9:                                              ; preds = %bb8
  br label %bb3

bb10:                                             ; preds = %bb3
  %25 = load i8** %buffer, align 4                ; <i8*> [#uses=1]
  call void @md5_process_block(i8* %25, i32 32768, %struct.md5_ctx* %ctx) nounwind
  br label %bb2

process_partial_block:                            ; preds = %bb8, %bb7
  %26 = load i32* %sum, align 4                   ; <i32> [#uses=1]
  %27 = icmp ne i32 %26, 0                        ; <i1> [#uses=1]
  br i1 %27, label %bb11, label %bb12

bb11:                                             ; preds = %process_partial_block
  %28 = load i8** %buffer, align 4                ; <i8*> [#uses=1]
  %29 = load i32* %sum, align 4                   ; <i32> [#uses=1]
  call void @md5_process_bytes(i8* %28, i32 %29, %struct.md5_ctx* %ctx) nounwind
  br label %bb12

bb12:                                             ; preds = %bb11, %process_partial_block
  %30 = load i8** %resblock_addr, align 4         ; <i8*> [#uses=1]
  %31 = call i8* @md5_finish_ctx(%struct.md5_ctx* %ctx, i8* %30) nounwind ; <i8*> [#uses=0]
  %32 = load i8** %buffer, align 4                ; <i8*> [#uses=1]
  call void @free(i8* %32) nounwind
  store i32 0, i32* %0, align 4
  br label %bb13

bb13:                                             ; preds = %bb12, %bb6, %bb
  %33 = load i32* %0, align 4                     ; <i32> [#uses=1]
  store i32 %33, i32* %retval, align 4
  br label %return

return:                                           ; preds = %bb13
  %retval14 = load i32* %retval                   ; <i32> [#uses=1]
  ret i32 %retval14
}

declare noalias i8* @malloc(i32) nounwind

declare i32 @fread(i8* noalias, i32, i32, %struct.FILE* noalias)

declare i32 @ferror(%struct.FILE*) nounwind

declare void @free(i8*) nounwind

declare i32 @feof(%struct.FILE*) nounwind

define i8* @md5_buffer(i8* %buffer, i32 %len, i8* %resblock) nounwind {
entry:
  %buffer_addr = alloca i8*                       ; <i8**> [#uses=2]
  %len_addr = alloca i32                          ; <i32*> [#uses=2]
  %resblock_addr = alloca i8*                     ; <i8**> [#uses=2]
  %retval = alloca i8*                            ; <i8**> [#uses=2]
  %ctx = alloca %struct.md5_ctx                   ; <%struct.md5_ctx*> [#uses=3]
  %0 = alloca i8*                                 ; <i8**> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i8* %buffer, i8** %buffer_addr
  store i32 %len, i32* %len_addr
  store i8* %resblock, i8** %resblock_addr
  call void @md5_init_ctx(%struct.md5_ctx* %ctx) nounwind
  %1 = load i8** %buffer_addr, align 4            ; <i8*> [#uses=1]
  %2 = load i32* %len_addr, align 4               ; <i32> [#uses=1]
  call void @md5_process_bytes(i8* %1, i32 %2, %struct.md5_ctx* %ctx) nounwind
  %3 = load i8** %resblock_addr, align 4          ; <i8*> [#uses=1]
  %4 = call i8* @md5_finish_ctx(%struct.md5_ctx* %ctx, i8* %3) nounwind ; <i8*> [#uses=1]
  store i8* %4, i8** %0, align 4
  %5 = load i8** %0, align 4                      ; <i8*> [#uses=1]
  store i8* %5, i8** %retval, align 4
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i8** %retval                    ; <i8*> [#uses=1]
  ret i8* %retval1
}

define void @md5_process_bytes(i8* %buffer, i32 %len, %struct.md5_ctx* %ctx) nounwind {
entry:
  %buffer_addr = alloca i8*                       ; <i8**> [#uses=12]
  %len_addr = alloca i32                          ; <i32*> [#uses=15]
  %ctx_addr = alloca %struct.md5_ctx*             ; <%struct.md5_ctx**> [#uses=25]
  %left_over = alloca i32                         ; <i32*> [#uses=9]
  %add = alloca i32                               ; <i32*> [#uses=6]
  %left_over1 = alloca i32                        ; <i32*> [#uses=4]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i8* %buffer, i8** %buffer_addr
  store i32 %len, i32* %len_addr
  store %struct.md5_ctx* %ctx, %struct.md5_ctx** %ctx_addr
  %0 = load %struct.md5_ctx** %ctx_addr, align 4  ; <%struct.md5_ctx*> [#uses=1]
  %1 = getelementptr inbounds %struct.md5_ctx* %0, i32 0, i32 5 ; <i32*> [#uses=1]
  %2 = load i32* %1, align 4                      ; <i32> [#uses=1]
  %3 = icmp ne i32 %2, 0                          ; <i1> [#uses=1]
  br i1 %3, label %bb, label %bb4

bb:                                               ; preds = %entry
  %4 = load %struct.md5_ctx** %ctx_addr, align 4  ; <%struct.md5_ctx*> [#uses=1]
  %5 = getelementptr inbounds %struct.md5_ctx* %4, i32 0, i32 5 ; <i32*> [#uses=1]
  %6 = load i32* %5, align 4                      ; <i32> [#uses=1]
  store i32 %6, i32* %left_over1, align 4
  %7 = load i32* %left_over1, align 4             ; <i32> [#uses=1]
  %8 = sub i32 128, %7                            ; <i32> [#uses=2]
  %9 = load i32* %len_addr, align 4               ; <i32> [#uses=2]
  %10 = icmp ule i32 %8, %9                       ; <i1> [#uses=1]
  %min = select i1 %10, i32 %8, i32 %9            ; <i32> [#uses=1]
  store i32 %min, i32* %add, align 4
  %11 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %12 = getelementptr inbounds %struct.md5_ctx* %11, i32 0, i32 6 ; <[32 x i32]*> [#uses=1]
  %13 = bitcast [32 x i32]* %12 to i8*            ; <i8*> [#uses=1]
  %14 = load i32* %left_over1, align 4            ; <i32> [#uses=1]
  %15 = getelementptr inbounds i8* %13, i32 %14   ; <i8*> [#uses=1]
  %16 = load i8** %buffer_addr, align 4           ; <i8*> [#uses=1]
  %17 = load i32* %add, align 4                   ; <i32> [#uses=1]
  call void @llvm.memcpy.i32(i8* %15, i8* %16, i32 %17, i32 1)
  %18 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %19 = getelementptr inbounds %struct.md5_ctx* %18, i32 0, i32 5 ; <i32*> [#uses=1]
  %20 = load i32* %19, align 4                    ; <i32> [#uses=1]
  %21 = load i32* %add, align 4                   ; <i32> [#uses=1]
  %22 = add i32 %20, %21                          ; <i32> [#uses=1]
  %23 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %24 = getelementptr inbounds %struct.md5_ctx* %23, i32 0, i32 5 ; <i32*> [#uses=1]
  store i32 %22, i32* %24, align 4
  %25 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %26 = getelementptr inbounds %struct.md5_ctx* %25, i32 0, i32 5 ; <i32*> [#uses=1]
  %27 = load i32* %26, align 4                    ; <i32> [#uses=1]
  %28 = icmp ugt i32 %27, 64                      ; <i1> [#uses=1]
  br i1 %28, label %bb2, label %bb3

bb2:                                              ; preds = %bb
  %29 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %30 = getelementptr inbounds %struct.md5_ctx* %29, i32 0, i32 5 ; <i32*> [#uses=1]
  %31 = load i32* %30, align 4                    ; <i32> [#uses=1]
  %32 = and i32 %31, -64                          ; <i32> [#uses=1]
  %33 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %34 = getelementptr inbounds %struct.md5_ctx* %33, i32 0, i32 6 ; <[32 x i32]*> [#uses=1]
  %35 = getelementptr inbounds [32 x i32]* %34, i32 0, i32 0 ; <i32*> [#uses=1]
  %36 = bitcast i32* %35 to i8*                   ; <i8*> [#uses=1]
  %37 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  call void @md5_process_block(i8* %36, i32 %32, %struct.md5_ctx* %37) nounwind
  %38 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %39 = getelementptr inbounds %struct.md5_ctx* %38, i32 0, i32 5 ; <i32*> [#uses=1]
  %40 = load i32* %39, align 4                    ; <i32> [#uses=1]
  %41 = and i32 %40, 63                           ; <i32> [#uses=1]
  %42 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %43 = getelementptr inbounds %struct.md5_ctx* %42, i32 0, i32 5 ; <i32*> [#uses=1]
  store i32 %41, i32* %43, align 4
  %44 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %45 = getelementptr inbounds %struct.md5_ctx* %44, i32 0, i32 5 ; <i32*> [#uses=1]
  %46 = load i32* %45, align 4                    ; <i32> [#uses=1]
  %47 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %48 = getelementptr inbounds %struct.md5_ctx* %47, i32 0, i32 6 ; <[32 x i32]*> [#uses=1]
  %49 = bitcast [32 x i32]* %48 to i8*            ; <i8*> [#uses=1]
  %50 = load i32* %left_over1, align 4            ; <i32> [#uses=1]
  %51 = load i32* %add, align 4                   ; <i32> [#uses=1]
  %52 = add i32 %50, %51                          ; <i32> [#uses=1]
  %53 = and i32 %52, -64                          ; <i32> [#uses=1]
  %54 = getelementptr inbounds i8* %49, i32 %53   ; <i8*> [#uses=1]
  %55 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %56 = getelementptr inbounds %struct.md5_ctx* %55, i32 0, i32 6 ; <[32 x i32]*> [#uses=1]
  %57 = getelementptr inbounds [32 x i32]* %56, i32 0, i32 0 ; <i32*> [#uses=1]
  %58 = bitcast i32* %57 to i8*                   ; <i8*> [#uses=1]
  call void @llvm.memcpy.i32(i8* %58, i8* %54, i32 %46, i32 1)
  br label %bb3

bb3:                                              ; preds = %bb2, %bb
  %59 = load i8** %buffer_addr, align 4           ; <i8*> [#uses=1]
  %60 = load i32* %add, align 4                   ; <i32> [#uses=1]
  %61 = getelementptr inbounds i8* %59, i32 %60   ; <i8*> [#uses=1]
  store i8* %61, i8** %buffer_addr, align 4
  %62 = load i32* %len_addr, align 4              ; <i32> [#uses=1]
  %63 = load i32* %add, align 4                   ; <i32> [#uses=1]
  %64 = sub i32 %62, %63                          ; <i32> [#uses=1]
  store i32 %64, i32* %len_addr, align 4
  br label %bb4

bb4:                                              ; preds = %bb3, %entry
  %65 = load i32* %len_addr, align 4              ; <i32> [#uses=1]
  %66 = icmp ugt i32 %65, 63                      ; <i1> [#uses=1]
  br i1 %66, label %bb5, label %bb11

bb5:                                              ; preds = %bb4
  %67 = load i8** %buffer_addr, align 4           ; <i8*> [#uses=1]
  %68 = ptrtoint i8* %67 to i32                   ; <i32> [#uses=1]
  %69 = and i32 %68, 3                            ; <i32> [#uses=1]
  %70 = icmp ne i32 %69, 0                        ; <i1> [#uses=1]
  br i1 %70, label %bb6, label %bb10

bb6:                                              ; preds = %bb5
  br label %bb8

bb7:                                              ; preds = %bb8
  %71 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %72 = getelementptr inbounds %struct.md5_ctx* %71, i32 0, i32 6 ; <[32 x i32]*> [#uses=1]
  %73 = getelementptr inbounds [32 x i32]* %72, i32 0, i32 0 ; <i32*> [#uses=1]
  %74 = load i8** %buffer_addr, align 4           ; <i8*> [#uses=1]
  %75 = bitcast i32* %73 to i8*                   ; <i8*> [#uses=2]
  call void @llvm.memcpy.i32(i8* %75, i8* %74, i32 64, i32 1)
  %76 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  call void @md5_process_block(i8* %75, i32 64, %struct.md5_ctx* %76) nounwind
  %77 = load i8** %buffer_addr, align 4           ; <i8*> [#uses=1]
  %78 = getelementptr inbounds i8* %77, i32 64    ; <i8*> [#uses=1]
  store i8* %78, i8** %buffer_addr, align 4
  %79 = load i32* %len_addr, align 4              ; <i32> [#uses=1]
  %80 = sub i32 %79, 64                           ; <i32> [#uses=1]
  store i32 %80, i32* %len_addr, align 4
  br label %bb8

bb8:                                              ; preds = %bb7, %bb6
  %81 = load i32* %len_addr, align 4              ; <i32> [#uses=1]
  %82 = icmp ugt i32 %81, 64                      ; <i1> [#uses=1]
  br i1 %82, label %bb7, label %bb9

bb9:                                              ; preds = %bb8
  br label %bb11

bb10:                                             ; preds = %bb5
  %83 = load i32* %len_addr, align 4              ; <i32> [#uses=1]
  %84 = and i32 %83, -64                          ; <i32> [#uses=1]
  %85 = load i8** %buffer_addr, align 4           ; <i8*> [#uses=1]
  %86 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  call void @md5_process_block(i8* %85, i32 %84, %struct.md5_ctx* %86) nounwind
  %87 = load i8** %buffer_addr, align 4           ; <i8*> [#uses=1]
  %88 = load i32* %len_addr, align 4              ; <i32> [#uses=1]
  %89 = and i32 %88, -64                          ; <i32> [#uses=1]
  %90 = getelementptr inbounds i8* %87, i32 %89   ; <i8*> [#uses=1]
  store i8* %90, i8** %buffer_addr, align 4
  %91 = load i32* %len_addr, align 4              ; <i32> [#uses=1]
  %92 = and i32 %91, 63                           ; <i32> [#uses=1]
  store i32 %92, i32* %len_addr, align 4
  br label %bb11

bb11:                                             ; preds = %bb10, %bb9, %bb4
  %93 = load i32* %len_addr, align 4              ; <i32> [#uses=1]
  %94 = icmp ne i32 %93, 0                        ; <i1> [#uses=1]
  br i1 %94, label %bb12, label %bb15

bb12:                                             ; preds = %bb11
  %95 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %96 = getelementptr inbounds %struct.md5_ctx* %95, i32 0, i32 5 ; <i32*> [#uses=1]
  %97 = load i32* %96, align 4                    ; <i32> [#uses=1]
  store i32 %97, i32* %left_over, align 4
  %98 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %99 = getelementptr inbounds %struct.md5_ctx* %98, i32 0, i32 6 ; <[32 x i32]*> [#uses=1]
  %100 = bitcast [32 x i32]* %99 to i8*           ; <i8*> [#uses=1]
  %101 = load i32* %left_over, align 4            ; <i32> [#uses=1]
  %102 = getelementptr inbounds i8* %100, i32 %101 ; <i8*> [#uses=1]
  %103 = load i8** %buffer_addr, align 4          ; <i8*> [#uses=1]
  %104 = load i32* %len_addr, align 4             ; <i32> [#uses=1]
  call void @llvm.memcpy.i32(i8* %102, i8* %103, i32 %104, i32 1)
  %105 = load i32* %left_over, align 4            ; <i32> [#uses=1]
  %106 = load i32* %len_addr, align 4             ; <i32> [#uses=1]
  %107 = add i32 %105, %106                       ; <i32> [#uses=1]
  store i32 %107, i32* %left_over, align 4
  %108 = load i32* %left_over, align 4            ; <i32> [#uses=1]
  %109 = icmp ugt i32 %108, 63                    ; <i1> [#uses=1]
  br i1 %109, label %bb13, label %bb14

bb13:                                             ; preds = %bb12
  %110 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %111 = getelementptr inbounds %struct.md5_ctx* %110, i32 0, i32 6 ; <[32 x i32]*> [#uses=1]
  %112 = getelementptr inbounds [32 x i32]* %111, i32 0, i32 0 ; <i32*> [#uses=1]
  %113 = bitcast i32* %112 to i8*                 ; <i8*> [#uses=1]
  %114 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  call void @md5_process_block(i8* %113, i32 64, %struct.md5_ctx* %114) nounwind
  %115 = load i32* %left_over, align 4            ; <i32> [#uses=1]
  %116 = sub i32 %115, 64                         ; <i32> [#uses=1]
  store i32 %116, i32* %left_over, align 4
  %117 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %118 = getelementptr inbounds %struct.md5_ctx* %117, i32 0, i32 6 ; <[32 x i32]*> [#uses=1]
  %119 = getelementptr inbounds [32 x i32]* %118, i32 0, i32 16 ; <i32*> [#uses=1]
  %120 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %121 = getelementptr inbounds %struct.md5_ctx* %120, i32 0, i32 6 ; <[32 x i32]*> [#uses=1]
  %122 = getelementptr inbounds [32 x i32]* %121, i32 0, i32 0 ; <i32*> [#uses=1]
  %123 = load i32* %left_over, align 4            ; <i32> [#uses=1]
  %124 = bitcast i32* %122 to i8*                 ; <i8*> [#uses=1]
  %125 = bitcast i32* %119 to i8*                 ; <i8*> [#uses=1]
  call void @llvm.memcpy.i32(i8* %124, i8* %125, i32 %123, i32 1)
  br label %bb14

bb14:                                             ; preds = %bb13, %bb12
  %126 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %127 = getelementptr inbounds %struct.md5_ctx* %126, i32 0, i32 5 ; <i32*> [#uses=1]
  %128 = load i32* %left_over, align 4            ; <i32> [#uses=1]
  store i32 %128, i32* %127, align 4
  br label %bb15

bb15:                                             ; preds = %bb14, %bb11
  br label %return

return:                                           ; preds = %bb15
  ret void
}

define void @md5_process_block(i8* %buffer, i32 %len, %struct.md5_ctx* %ctx) nounwind {
entry:
  %buffer_addr = alloca i8*                       ; <i8**> [#uses=2]
  %len_addr = alloca i32                          ; <i32*> [#uses=4]
  %ctx_addr = alloca %struct.md5_ctx*             ; <%struct.md5_ctx**> [#uses=14]
  %D_save = alloca i32                            ; <i32*> [#uses=2]
  %C_save = alloca i32                            ; <i32*> [#uses=2]
  %B_save = alloca i32                            ; <i32*> [#uses=2]
  %A_save = alloca i32                            ; <i32*> [#uses=2]
  %cwp = alloca i32*                              ; <i32**> [#uses=65]
  %D = alloca i32                                 ; <i32*> [#uses=173]
  %C = alloca i32                                 ; <i32*> [#uses=173]
  %B = alloca i32                                 ; <i32*> [#uses=173]
  %A = alloca i32                                 ; <i32*> [#uses=173]
  %endp = alloca i32*                             ; <i32**> [#uses=2]
  %nwords = alloca i32                            ; <i32*> [#uses=2]
  %words = alloca i32*                            ; <i32**> [#uses=51]
  %correct_words = alloca [16 x i32]              ; <[16 x i32]*> [#uses=49]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i8* %buffer, i8** %buffer_addr
  store i32 %len, i32* %len_addr
  store %struct.md5_ctx* %ctx, %struct.md5_ctx** %ctx_addr
  %0 = load i8** %buffer_addr, align 4            ; <i8*> [#uses=1]
  %1 = bitcast i8* %0 to i32*                     ; <i32*> [#uses=1]
  store i32* %1, i32** %words, align 4
  %2 = load i32* %len_addr, align 4               ; <i32> [#uses=1]
  %3 = udiv i32 %2, 4                             ; <i32> [#uses=1]
  store i32 %3, i32* %nwords, align 4
  %4 = load i32** %words, align 4                 ; <i32*> [#uses=1]
  %5 = load i32* %nwords, align 4                 ; <i32> [#uses=1]
  %6 = getelementptr inbounds i32* %4, i32 %5     ; <i32*> [#uses=1]
  store i32* %6, i32** %endp, align 4
  %7 = load %struct.md5_ctx** %ctx_addr, align 4  ; <%struct.md5_ctx*> [#uses=1]
  %8 = getelementptr inbounds %struct.md5_ctx* %7, i32 0, i32 0 ; <i32*> [#uses=1]
  %9 = load i32* %8, align 4                      ; <i32> [#uses=1]
  store i32 %9, i32* %A, align 4
  %10 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %11 = getelementptr inbounds %struct.md5_ctx* %10, i32 0, i32 1 ; <i32*> [#uses=1]
  %12 = load i32* %11, align 4                    ; <i32> [#uses=1]
  store i32 %12, i32* %B, align 4
  %13 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %14 = getelementptr inbounds %struct.md5_ctx* %13, i32 0, i32 2 ; <i32*> [#uses=1]
  %15 = load i32* %14, align 4                    ; <i32> [#uses=1]
  store i32 %15, i32* %C, align 4
  %16 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %17 = getelementptr inbounds %struct.md5_ctx* %16, i32 0, i32 3 ; <i32*> [#uses=1]
  %18 = load i32* %17, align 4                    ; <i32> [#uses=1]
  store i32 %18, i32* %D, align 4
  %19 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %20 = getelementptr inbounds %struct.md5_ctx* %19, i32 0, i32 4 ; <[2 x i32]*> [#uses=1]
  %21 = getelementptr inbounds [2 x i32]* %20, i32 0, i32 0 ; <i32*> [#uses=1]
  %22 = load i32* %21, align 4                    ; <i32> [#uses=1]
  %23 = load i32* %len_addr, align 4              ; <i32> [#uses=1]
  %24 = add i32 %22, %23                          ; <i32> [#uses=1]
  %25 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %26 = getelementptr inbounds %struct.md5_ctx* %25, i32 0, i32 4 ; <[2 x i32]*> [#uses=1]
  %27 = getelementptr inbounds [2 x i32]* %26, i32 0, i32 0 ; <i32*> [#uses=1]
  store i32 %24, i32* %27, align 4
  %28 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %29 = getelementptr inbounds %struct.md5_ctx* %28, i32 0, i32 4 ; <[2 x i32]*> [#uses=1]
  %30 = getelementptr inbounds [2 x i32]* %29, i32 0, i32 0 ; <i32*> [#uses=1]
  %31 = load i32* %30, align 4                    ; <i32> [#uses=1]
  %32 = load i32* %len_addr, align 4              ; <i32> [#uses=1]
  %33 = icmp ult i32 %31, %32                     ; <i1> [#uses=1]
  br i1 %33, label %bb, label %bb1

bb:                                               ; preds = %entry
  %34 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %35 = getelementptr inbounds %struct.md5_ctx* %34, i32 0, i32 4 ; <[2 x i32]*> [#uses=1]
  %36 = getelementptr inbounds [2 x i32]* %35, i32 0, i32 1 ; <i32*> [#uses=1]
  %37 = load i32* %36, align 4                    ; <i32> [#uses=1]
  %38 = add i32 %37, 1                            ; <i32> [#uses=1]
  %39 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %40 = getelementptr inbounds %struct.md5_ctx* %39, i32 0, i32 4 ; <[2 x i32]*> [#uses=1]
  %41 = getelementptr inbounds [2 x i32]* %40, i32 0, i32 1 ; <i32*> [#uses=1]
  store i32 %38, i32* %41, align 4
  br label %bb1

bb1:                                              ; preds = %bb, %entry
  br label %bb35

bb2:                                              ; preds = %bb35
  %correct_words3 = bitcast [16 x i32]* %correct_words to i32* ; <i32*> [#uses=1]
  store i32* %correct_words3, i32** %cwp, align 4
  %42 = load i32* %A, align 4                     ; <i32> [#uses=1]
  store i32 %42, i32* %A_save, align 4
  %43 = load i32* %B, align 4                     ; <i32> [#uses=1]
  store i32 %43, i32* %B_save, align 4
  %44 = load i32* %C, align 4                     ; <i32> [#uses=1]
  store i32 %44, i32* %C_save, align 4
  %45 = load i32* %D, align 4                     ; <i32> [#uses=1]
  store i32 %45, i32* %D_save, align 4
  %46 = load i32* %C, align 4                     ; <i32> [#uses=1]
  %47 = load i32* %D, align 4                     ; <i32> [#uses=1]
  %48 = xor i32 %46, %47                          ; <i32> [#uses=1]
  %49 = load i32* %B, align 4                     ; <i32> [#uses=1]
  %50 = and i32 %48, %49                          ; <i32> [#uses=1]
  %51 = load i32* %D, align 4                     ; <i32> [#uses=1]
  %52 = xor i32 %50, %51                          ; <i32> [#uses=1]
  %53 = load i32** %words, align 4                ; <i32*> [#uses=1]
  %54 = load i32* %53, align 4                    ; <i32> [#uses=1]
  %55 = load i32** %cwp, align 4                  ; <i32*> [#uses=1]
  store i32 %54, i32* %55, align 4
  %56 = load i32** %cwp, align 4                  ; <i32*> [#uses=1]
  %57 = load i32* %56, align 4                    ; <i32> [#uses=1]
  %58 = add i32 %52, %57                          ; <i32> [#uses=1]
  %59 = load i32* %A, align 4                     ; <i32> [#uses=1]
  %60 = add i32 %58, %59                          ; <i32> [#uses=1]
  %61 = add i32 %60, -680876936                   ; <i32> [#uses=1]
  store i32 %61, i32* %A, align 4
  %62 = load i32** %cwp, align 4                  ; <i32*> [#uses=1]
  %63 = getelementptr inbounds i32* %62, i64 1    ; <i32*> [#uses=1]
  store i32* %63, i32** %cwp, align 4
  %64 = load i32** %words, align 4                ; <i32*> [#uses=1]
  %65 = getelementptr inbounds i32* %64, i64 1    ; <i32*> [#uses=1]
  store i32* %65, i32** %words, align 4
  %66 = load i32* %A, align 4                     ; <i32> [#uses=2]
  %67 = lshr i32 %66, 25                          ; <i32> [#uses=1]
  %68 = shl i32 %66, 7                            ; <i32> [#uses=1]
  %69 = or i32 %67, %68                           ; <i32> [#uses=1]
  store i32 %69, i32* %A, align 4
  %70 = load i32* %A, align 4                     ; <i32> [#uses=1]
  %71 = load i32* %B, align 4                     ; <i32> [#uses=1]
  %72 = add i32 %70, %71                          ; <i32> [#uses=1]
  store i32 %72, i32* %A, align 4
  %73 = load i32* %B, align 4                     ; <i32> [#uses=1]
  %74 = load i32* %C, align 4                     ; <i32> [#uses=1]
  %75 = xor i32 %73, %74                          ; <i32> [#uses=1]
  %76 = load i32* %A, align 4                     ; <i32> [#uses=1]
  %77 = and i32 %75, %76                          ; <i32> [#uses=1]
  %78 = load i32* %C, align 4                     ; <i32> [#uses=1]
  %79 = xor i32 %77, %78                          ; <i32> [#uses=1]
  %80 = load i32** %words, align 4                ; <i32*> [#uses=1]
  %81 = load i32* %80, align 4                    ; <i32> [#uses=1]
  %82 = load i32** %cwp, align 4                  ; <i32*> [#uses=1]
  store i32 %81, i32* %82, align 4
  %83 = load i32** %cwp, align 4                  ; <i32*> [#uses=1]
  %84 = load i32* %83, align 4                    ; <i32> [#uses=1]
  %85 = add i32 %79, %84                          ; <i32> [#uses=1]
  %86 = load i32* %D, align 4                     ; <i32> [#uses=1]
  %87 = add i32 %85, %86                          ; <i32> [#uses=1]
  %88 = add i32 %87, -389564586                   ; <i32> [#uses=1]
  store i32 %88, i32* %D, align 4
  %89 = load i32** %cwp, align 4                  ; <i32*> [#uses=1]
  %90 = getelementptr inbounds i32* %89, i64 1    ; <i32*> [#uses=1]
  store i32* %90, i32** %cwp, align 4
  %91 = load i32** %words, align 4                ; <i32*> [#uses=1]
  %92 = getelementptr inbounds i32* %91, i64 1    ; <i32*> [#uses=1]
  store i32* %92, i32** %words, align 4
  %93 = load i32* %D, align 4                     ; <i32> [#uses=2]
  %94 = lshr i32 %93, 20                          ; <i32> [#uses=1]
  %95 = shl i32 %93, 12                           ; <i32> [#uses=1]
  %96 = or i32 %94, %95                           ; <i32> [#uses=1]
  store i32 %96, i32* %D, align 4
  %97 = load i32* %D, align 4                     ; <i32> [#uses=1]
  %98 = load i32* %A, align 4                     ; <i32> [#uses=1]
  %99 = add i32 %97, %98                          ; <i32> [#uses=1]
  store i32 %99, i32* %D, align 4
  %100 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %101 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %102 = xor i32 %100, %101                       ; <i32> [#uses=1]
  %103 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %104 = and i32 %102, %103                       ; <i32> [#uses=1]
  %105 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %106 = xor i32 %104, %105                       ; <i32> [#uses=1]
  %107 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %108 = load i32* %107, align 4                  ; <i32> [#uses=1]
  %109 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  store i32 %108, i32* %109, align 4
  %110 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %111 = load i32* %110, align 4                  ; <i32> [#uses=1]
  %112 = add i32 %106, %111                       ; <i32> [#uses=1]
  %113 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %114 = add i32 %112, %113                       ; <i32> [#uses=1]
  %115 = add i32 %114, 606105819                  ; <i32> [#uses=1]
  store i32 %115, i32* %C, align 4
  %116 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %117 = getelementptr inbounds i32* %116, i64 1  ; <i32*> [#uses=1]
  store i32* %117, i32** %cwp, align 4
  %118 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %119 = getelementptr inbounds i32* %118, i64 1  ; <i32*> [#uses=1]
  store i32* %119, i32** %words, align 4
  %120 = load i32* %C, align 4                    ; <i32> [#uses=2]
  %121 = lshr i32 %120, 15                        ; <i32> [#uses=1]
  %122 = shl i32 %120, 17                         ; <i32> [#uses=1]
  %123 = or i32 %121, %122                        ; <i32> [#uses=1]
  store i32 %123, i32* %C, align 4
  %124 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %125 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %126 = add i32 %124, %125                       ; <i32> [#uses=1]
  store i32 %126, i32* %C, align 4
  %127 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %128 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %129 = xor i32 %127, %128                       ; <i32> [#uses=1]
  %130 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %131 = and i32 %129, %130                       ; <i32> [#uses=1]
  %132 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %133 = xor i32 %131, %132                       ; <i32> [#uses=1]
  %134 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %135 = load i32* %134, align 4                  ; <i32> [#uses=1]
  %136 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  store i32 %135, i32* %136, align 4
  %137 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %138 = load i32* %137, align 4                  ; <i32> [#uses=1]
  %139 = add i32 %133, %138                       ; <i32> [#uses=1]
  %140 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %141 = add i32 %139, %140                       ; <i32> [#uses=1]
  %142 = add i32 %141, -1044525330                ; <i32> [#uses=1]
  store i32 %142, i32* %B, align 4
  %143 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %144 = getelementptr inbounds i32* %143, i64 1  ; <i32*> [#uses=1]
  store i32* %144, i32** %cwp, align 4
  %145 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %146 = getelementptr inbounds i32* %145, i64 1  ; <i32*> [#uses=1]
  store i32* %146, i32** %words, align 4
  %147 = load i32* %B, align 4                    ; <i32> [#uses=2]
  %148 = lshr i32 %147, 10                        ; <i32> [#uses=1]
  %149 = shl i32 %147, 22                         ; <i32> [#uses=1]
  %150 = or i32 %148, %149                        ; <i32> [#uses=1]
  store i32 %150, i32* %B, align 4
  %151 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %152 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %153 = add i32 %151, %152                       ; <i32> [#uses=1]
  store i32 %153, i32* %B, align 4
  %154 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %155 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %156 = xor i32 %154, %155                       ; <i32> [#uses=1]
  %157 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %158 = and i32 %156, %157                       ; <i32> [#uses=1]
  %159 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %160 = xor i32 %158, %159                       ; <i32> [#uses=1]
  %161 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %162 = load i32* %161, align 4                  ; <i32> [#uses=1]
  %163 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  store i32 %162, i32* %163, align 4
  %164 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %165 = load i32* %164, align 4                  ; <i32> [#uses=1]
  %166 = add i32 %160, %165                       ; <i32> [#uses=1]
  %167 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %168 = add i32 %166, %167                       ; <i32> [#uses=1]
  %169 = add i32 %168, -176418897                 ; <i32> [#uses=1]
  store i32 %169, i32* %A, align 4
  %170 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %171 = getelementptr inbounds i32* %170, i64 1  ; <i32*> [#uses=1]
  store i32* %171, i32** %cwp, align 4
  %172 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %173 = getelementptr inbounds i32* %172, i64 1  ; <i32*> [#uses=1]
  store i32* %173, i32** %words, align 4
  %174 = load i32* %A, align 4                    ; <i32> [#uses=2]
  %175 = lshr i32 %174, 25                        ; <i32> [#uses=1]
  %176 = shl i32 %174, 7                          ; <i32> [#uses=1]
  %177 = or i32 %175, %176                        ; <i32> [#uses=1]
  store i32 %177, i32* %A, align 4
  %178 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %179 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %180 = add i32 %178, %179                       ; <i32> [#uses=1]
  store i32 %180, i32* %A, align 4
  %181 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %182 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %183 = xor i32 %181, %182                       ; <i32> [#uses=1]
  %184 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %185 = and i32 %183, %184                       ; <i32> [#uses=1]
  %186 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %187 = xor i32 %185, %186                       ; <i32> [#uses=1]
  %188 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %189 = load i32* %188, align 4                  ; <i32> [#uses=1]
  %190 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  store i32 %189, i32* %190, align 4
  %191 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %192 = load i32* %191, align 4                  ; <i32> [#uses=1]
  %193 = add i32 %187, %192                       ; <i32> [#uses=1]
  %194 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %195 = add i32 %193, %194                       ; <i32> [#uses=1]
  %196 = add i32 %195, 1200080426                 ; <i32> [#uses=1]
  store i32 %196, i32* %D, align 4
  %197 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %198 = getelementptr inbounds i32* %197, i64 1  ; <i32*> [#uses=1]
  store i32* %198, i32** %cwp, align 4
  %199 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %200 = getelementptr inbounds i32* %199, i64 1  ; <i32*> [#uses=1]
  store i32* %200, i32** %words, align 4
  %201 = load i32* %D, align 4                    ; <i32> [#uses=2]
  %202 = lshr i32 %201, 20                        ; <i32> [#uses=1]
  %203 = shl i32 %201, 12                         ; <i32> [#uses=1]
  %204 = or i32 %202, %203                        ; <i32> [#uses=1]
  store i32 %204, i32* %D, align 4
  %205 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %206 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %207 = add i32 %205, %206                       ; <i32> [#uses=1]
  store i32 %207, i32* %D, align 4
  %208 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %209 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %210 = xor i32 %208, %209                       ; <i32> [#uses=1]
  %211 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %212 = and i32 %210, %211                       ; <i32> [#uses=1]
  %213 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %214 = xor i32 %212, %213                       ; <i32> [#uses=1]
  %215 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %216 = load i32* %215, align 4                  ; <i32> [#uses=1]
  %217 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  store i32 %216, i32* %217, align 4
  %218 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %219 = load i32* %218, align 4                  ; <i32> [#uses=1]
  %220 = add i32 %214, %219                       ; <i32> [#uses=1]
  %221 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %222 = add i32 %220, %221                       ; <i32> [#uses=1]
  %223 = add i32 %222, -1473231341                ; <i32> [#uses=1]
  store i32 %223, i32* %C, align 4
  %224 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %225 = getelementptr inbounds i32* %224, i64 1  ; <i32*> [#uses=1]
  store i32* %225, i32** %cwp, align 4
  %226 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %227 = getelementptr inbounds i32* %226, i64 1  ; <i32*> [#uses=1]
  store i32* %227, i32** %words, align 4
  %228 = load i32* %C, align 4                    ; <i32> [#uses=2]
  %229 = lshr i32 %228, 15                        ; <i32> [#uses=1]
  %230 = shl i32 %228, 17                         ; <i32> [#uses=1]
  %231 = or i32 %229, %230                        ; <i32> [#uses=1]
  store i32 %231, i32* %C, align 4
  %232 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %233 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %234 = add i32 %232, %233                       ; <i32> [#uses=1]
  store i32 %234, i32* %C, align 4
  %235 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %236 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %237 = xor i32 %235, %236                       ; <i32> [#uses=1]
  %238 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %239 = and i32 %237, %238                       ; <i32> [#uses=1]
  %240 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %241 = xor i32 %239, %240                       ; <i32> [#uses=1]
  %242 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %243 = load i32* %242, align 4                  ; <i32> [#uses=1]
  %244 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  store i32 %243, i32* %244, align 4
  %245 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %246 = load i32* %245, align 4                  ; <i32> [#uses=1]
  %247 = add i32 %241, %246                       ; <i32> [#uses=1]
  %248 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %249 = add i32 %247, %248                       ; <i32> [#uses=1]
  %250 = add i32 %249, -45705983                  ; <i32> [#uses=1]
  store i32 %250, i32* %B, align 4
  %251 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %252 = getelementptr inbounds i32* %251, i64 1  ; <i32*> [#uses=1]
  store i32* %252, i32** %cwp, align 4
  %253 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %254 = getelementptr inbounds i32* %253, i64 1  ; <i32*> [#uses=1]
  store i32* %254, i32** %words, align 4
  %255 = load i32* %B, align 4                    ; <i32> [#uses=2]
  %256 = lshr i32 %255, 10                        ; <i32> [#uses=1]
  %257 = shl i32 %255, 22                         ; <i32> [#uses=1]
  %258 = or i32 %256, %257                        ; <i32> [#uses=1]
  store i32 %258, i32* %B, align 4
  %259 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %260 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %261 = add i32 %259, %260                       ; <i32> [#uses=1]
  store i32 %261, i32* %B, align 4
  %262 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %263 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %264 = xor i32 %262, %263                       ; <i32> [#uses=1]
  %265 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %266 = and i32 %264, %265                       ; <i32> [#uses=1]
  %267 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %268 = xor i32 %266, %267                       ; <i32> [#uses=1]
  %269 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %270 = load i32* %269, align 4                  ; <i32> [#uses=1]
  %271 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  store i32 %270, i32* %271, align 4
  %272 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %273 = load i32* %272, align 4                  ; <i32> [#uses=1]
  %274 = add i32 %268, %273                       ; <i32> [#uses=1]
  %275 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %276 = add i32 %274, %275                       ; <i32> [#uses=1]
  %277 = add i32 %276, 1770035416                 ; <i32> [#uses=1]
  store i32 %277, i32* %A, align 4
  %278 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %279 = getelementptr inbounds i32* %278, i64 1  ; <i32*> [#uses=1]
  store i32* %279, i32** %cwp, align 4
  %280 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %281 = getelementptr inbounds i32* %280, i64 1  ; <i32*> [#uses=1]
  store i32* %281, i32** %words, align 4
  %282 = load i32* %A, align 4                    ; <i32> [#uses=2]
  %283 = lshr i32 %282, 25                        ; <i32> [#uses=1]
  %284 = shl i32 %282, 7                          ; <i32> [#uses=1]
  %285 = or i32 %283, %284                        ; <i32> [#uses=1]
  store i32 %285, i32* %A, align 4
  %286 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %287 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %288 = add i32 %286, %287                       ; <i32> [#uses=1]
  store i32 %288, i32* %A, align 4
  %289 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %290 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %291 = xor i32 %289, %290                       ; <i32> [#uses=1]
  %292 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %293 = and i32 %291, %292                       ; <i32> [#uses=1]
  %294 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %295 = xor i32 %293, %294                       ; <i32> [#uses=1]
  %296 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %297 = load i32* %296, align 4                  ; <i32> [#uses=1]
  %298 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  store i32 %297, i32* %298, align 4
  %299 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %300 = load i32* %299, align 4                  ; <i32> [#uses=1]
  %301 = add i32 %295, %300                       ; <i32> [#uses=1]
  %302 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %303 = add i32 %301, %302                       ; <i32> [#uses=1]
  %304 = add i32 %303, -1958414417                ; <i32> [#uses=1]
  store i32 %304, i32* %D, align 4
  %305 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %306 = getelementptr inbounds i32* %305, i64 1  ; <i32*> [#uses=1]
  store i32* %306, i32** %cwp, align 4
  %307 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %308 = getelementptr inbounds i32* %307, i64 1  ; <i32*> [#uses=1]
  store i32* %308, i32** %words, align 4
  %309 = load i32* %D, align 4                    ; <i32> [#uses=2]
  %310 = lshr i32 %309, 20                        ; <i32> [#uses=1]
  %311 = shl i32 %309, 12                         ; <i32> [#uses=1]
  %312 = or i32 %310, %311                        ; <i32> [#uses=1]
  store i32 %312, i32* %D, align 4
  %313 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %314 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %315 = add i32 %313, %314                       ; <i32> [#uses=1]
  store i32 %315, i32* %D, align 4
  %316 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %317 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %318 = xor i32 %316, %317                       ; <i32> [#uses=1]
  %319 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %320 = and i32 %318, %319                       ; <i32> [#uses=1]
  %321 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %322 = xor i32 %320, %321                       ; <i32> [#uses=1]
  %323 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %324 = load i32* %323, align 4                  ; <i32> [#uses=1]
  %325 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  store i32 %324, i32* %325, align 4
  %326 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %327 = load i32* %326, align 4                  ; <i32> [#uses=1]
  %328 = add i32 %322, %327                       ; <i32> [#uses=1]
  %329 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %330 = add i32 %328, %329                       ; <i32> [#uses=1]
  %331 = add i32 %330, -42063                     ; <i32> [#uses=1]
  store i32 %331, i32* %C, align 4
  %332 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %333 = getelementptr inbounds i32* %332, i64 1  ; <i32*> [#uses=1]
  store i32* %333, i32** %cwp, align 4
  %334 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %335 = getelementptr inbounds i32* %334, i64 1  ; <i32*> [#uses=1]
  store i32* %335, i32** %words, align 4
  %336 = load i32* %C, align 4                    ; <i32> [#uses=2]
  %337 = lshr i32 %336, 15                        ; <i32> [#uses=1]
  %338 = shl i32 %336, 17                         ; <i32> [#uses=1]
  %339 = or i32 %337, %338                        ; <i32> [#uses=1]
  store i32 %339, i32* %C, align 4
  %340 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %341 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %342 = add i32 %340, %341                       ; <i32> [#uses=1]
  store i32 %342, i32* %C, align 4
  %343 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %344 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %345 = xor i32 %343, %344                       ; <i32> [#uses=1]
  %346 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %347 = and i32 %345, %346                       ; <i32> [#uses=1]
  %348 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %349 = xor i32 %347, %348                       ; <i32> [#uses=1]
  %350 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %351 = load i32* %350, align 4                  ; <i32> [#uses=1]
  %352 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  store i32 %351, i32* %352, align 4
  %353 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %354 = load i32* %353, align 4                  ; <i32> [#uses=1]
  %355 = add i32 %349, %354                       ; <i32> [#uses=1]
  %356 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %357 = add i32 %355, %356                       ; <i32> [#uses=1]
  %358 = add i32 %357, -1990404162                ; <i32> [#uses=1]
  store i32 %358, i32* %B, align 4
  %359 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %360 = getelementptr inbounds i32* %359, i64 1  ; <i32*> [#uses=1]
  store i32* %360, i32** %cwp, align 4
  %361 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %362 = getelementptr inbounds i32* %361, i64 1  ; <i32*> [#uses=1]
  store i32* %362, i32** %words, align 4
  %363 = load i32* %B, align 4                    ; <i32> [#uses=2]
  %364 = lshr i32 %363, 10                        ; <i32> [#uses=1]
  %365 = shl i32 %363, 22                         ; <i32> [#uses=1]
  %366 = or i32 %364, %365                        ; <i32> [#uses=1]
  store i32 %366, i32* %B, align 4
  %367 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %368 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %369 = add i32 %367, %368                       ; <i32> [#uses=1]
  store i32 %369, i32* %B, align 4
  %370 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %371 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %372 = xor i32 %370, %371                       ; <i32> [#uses=1]
  %373 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %374 = and i32 %372, %373                       ; <i32> [#uses=1]
  %375 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %376 = xor i32 %374, %375                       ; <i32> [#uses=1]
  %377 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %378 = load i32* %377, align 4                  ; <i32> [#uses=1]
  %379 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  store i32 %378, i32* %379, align 4
  %380 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %381 = load i32* %380, align 4                  ; <i32> [#uses=1]
  %382 = add i32 %376, %381                       ; <i32> [#uses=1]
  %383 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %384 = add i32 %382, %383                       ; <i32> [#uses=1]
  %385 = add i32 %384, 1804603682                 ; <i32> [#uses=1]
  store i32 %385, i32* %A, align 4
  %386 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %387 = getelementptr inbounds i32* %386, i64 1  ; <i32*> [#uses=1]
  store i32* %387, i32** %cwp, align 4
  %388 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %389 = getelementptr inbounds i32* %388, i64 1  ; <i32*> [#uses=1]
  store i32* %389, i32** %words, align 4
  %390 = load i32* %A, align 4                    ; <i32> [#uses=2]
  %391 = lshr i32 %390, 25                        ; <i32> [#uses=1]
  %392 = shl i32 %390, 7                          ; <i32> [#uses=1]
  %393 = or i32 %391, %392                        ; <i32> [#uses=1]
  store i32 %393, i32* %A, align 4
  %394 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %395 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %396 = add i32 %394, %395                       ; <i32> [#uses=1]
  store i32 %396, i32* %A, align 4
  %397 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %398 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %399 = xor i32 %397, %398                       ; <i32> [#uses=1]
  %400 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %401 = and i32 %399, %400                       ; <i32> [#uses=1]
  %402 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %403 = xor i32 %401, %402                       ; <i32> [#uses=1]
  %404 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %405 = load i32* %404, align 4                  ; <i32> [#uses=1]
  %406 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  store i32 %405, i32* %406, align 4
  %407 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %408 = load i32* %407, align 4                  ; <i32> [#uses=1]
  %409 = add i32 %403, %408                       ; <i32> [#uses=1]
  %410 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %411 = add i32 %409, %410                       ; <i32> [#uses=1]
  %412 = add i32 %411, -40341101                  ; <i32> [#uses=1]
  store i32 %412, i32* %D, align 4
  %413 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %414 = getelementptr inbounds i32* %413, i64 1  ; <i32*> [#uses=1]
  store i32* %414, i32** %cwp, align 4
  %415 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %416 = getelementptr inbounds i32* %415, i64 1  ; <i32*> [#uses=1]
  store i32* %416, i32** %words, align 4
  %417 = load i32* %D, align 4                    ; <i32> [#uses=2]
  %418 = lshr i32 %417, 20                        ; <i32> [#uses=1]
  %419 = shl i32 %417, 12                         ; <i32> [#uses=1]
  %420 = or i32 %418, %419                        ; <i32> [#uses=1]
  store i32 %420, i32* %D, align 4
  %421 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %422 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %423 = add i32 %421, %422                       ; <i32> [#uses=1]
  store i32 %423, i32* %D, align 4
  %424 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %425 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %426 = xor i32 %424, %425                       ; <i32> [#uses=1]
  %427 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %428 = and i32 %426, %427                       ; <i32> [#uses=1]
  %429 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %430 = xor i32 %428, %429                       ; <i32> [#uses=1]
  %431 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %432 = load i32* %431, align 4                  ; <i32> [#uses=1]
  %433 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  store i32 %432, i32* %433, align 4
  %434 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %435 = load i32* %434, align 4                  ; <i32> [#uses=1]
  %436 = add i32 %430, %435                       ; <i32> [#uses=1]
  %437 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %438 = add i32 %436, %437                       ; <i32> [#uses=1]
  %439 = add i32 %438, -1502002290                ; <i32> [#uses=1]
  store i32 %439, i32* %C, align 4
  %440 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %441 = getelementptr inbounds i32* %440, i64 1  ; <i32*> [#uses=1]
  store i32* %441, i32** %cwp, align 4
  %442 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %443 = getelementptr inbounds i32* %442, i64 1  ; <i32*> [#uses=1]
  store i32* %443, i32** %words, align 4
  %444 = load i32* %C, align 4                    ; <i32> [#uses=2]
  %445 = lshr i32 %444, 15                        ; <i32> [#uses=1]
  %446 = shl i32 %444, 17                         ; <i32> [#uses=1]
  %447 = or i32 %445, %446                        ; <i32> [#uses=1]
  store i32 %447, i32* %C, align 4
  %448 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %449 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %450 = add i32 %448, %449                       ; <i32> [#uses=1]
  store i32 %450, i32* %C, align 4
  %451 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %452 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %453 = xor i32 %451, %452                       ; <i32> [#uses=1]
  %454 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %455 = and i32 %453, %454                       ; <i32> [#uses=1]
  %456 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %457 = xor i32 %455, %456                       ; <i32> [#uses=1]
  %458 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %459 = load i32* %458, align 4                  ; <i32> [#uses=1]
  %460 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  store i32 %459, i32* %460, align 4
  %461 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %462 = load i32* %461, align 4                  ; <i32> [#uses=1]
  %463 = add i32 %457, %462                       ; <i32> [#uses=1]
  %464 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %465 = add i32 %463, %464                       ; <i32> [#uses=1]
  %466 = add i32 %465, 1236535329                 ; <i32> [#uses=1]
  store i32 %466, i32* %B, align 4
  %467 = load i32** %cwp, align 4                 ; <i32*> [#uses=1]
  %468 = getelementptr inbounds i32* %467, i64 1  ; <i32*> [#uses=1]
  store i32* %468, i32** %cwp, align 4
  %469 = load i32** %words, align 4               ; <i32*> [#uses=1]
  %470 = getelementptr inbounds i32* %469, i64 1  ; <i32*> [#uses=1]
  store i32* %470, i32** %words, align 4
  %471 = load i32* %B, align 4                    ; <i32> [#uses=2]
  %472 = lshr i32 %471, 10                        ; <i32> [#uses=1]
  %473 = shl i32 %471, 22                         ; <i32> [#uses=1]
  %474 = or i32 %472, %473                        ; <i32> [#uses=1]
  store i32 %474, i32* %B, align 4
  %475 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %476 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %477 = add i32 %475, %476                       ; <i32> [#uses=1]
  store i32 %477, i32* %B, align 4
  %478 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %479 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %480 = xor i32 %478, %479                       ; <i32> [#uses=1]
  %481 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %482 = and i32 %480, %481                       ; <i32> [#uses=1]
  %483 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %484 = xor i32 %482, %483                       ; <i32> [#uses=1]
  %485 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 1 ; <i32*> [#uses=1]
  %486 = load i32* %485, align 4                  ; <i32> [#uses=1]
  %487 = add i32 %484, %486                       ; <i32> [#uses=1]
  %488 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %489 = add i32 %487, %488                       ; <i32> [#uses=1]
  %490 = add i32 %489, -165796510                 ; <i32> [#uses=1]
  store i32 %490, i32* %A, align 4
  %491 = load i32* %A, align 4                    ; <i32> [#uses=2]
  %492 = lshr i32 %491, 27                        ; <i32> [#uses=1]
  %493 = shl i32 %491, 5                          ; <i32> [#uses=1]
  %494 = or i32 %492, %493                        ; <i32> [#uses=1]
  store i32 %494, i32* %A, align 4
  %495 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %496 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %497 = add i32 %495, %496                       ; <i32> [#uses=1]
  store i32 %497, i32* %A, align 4
  %498 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %499 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %500 = xor i32 %498, %499                       ; <i32> [#uses=1]
  %501 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %502 = and i32 %500, %501                       ; <i32> [#uses=1]
  %503 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %504 = xor i32 %502, %503                       ; <i32> [#uses=1]
  %505 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 6 ; <i32*> [#uses=1]
  %506 = load i32* %505, align 4                  ; <i32> [#uses=1]
  %507 = add i32 %504, %506                       ; <i32> [#uses=1]
  %508 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %509 = add i32 %507, %508                       ; <i32> [#uses=1]
  %510 = add i32 %509, -1069501632                ; <i32> [#uses=1]
  store i32 %510, i32* %D, align 4
  %511 = load i32* %D, align 4                    ; <i32> [#uses=2]
  %512 = lshr i32 %511, 23                        ; <i32> [#uses=1]
  %513 = shl i32 %511, 9                          ; <i32> [#uses=1]
  %514 = or i32 %512, %513                        ; <i32> [#uses=1]
  store i32 %514, i32* %D, align 4
  %515 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %516 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %517 = add i32 %515, %516                       ; <i32> [#uses=1]
  store i32 %517, i32* %D, align 4
  %518 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %519 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %520 = xor i32 %518, %519                       ; <i32> [#uses=1]
  %521 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %522 = and i32 %520, %521                       ; <i32> [#uses=1]
  %523 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %524 = xor i32 %522, %523                       ; <i32> [#uses=1]
  %525 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 11 ; <i32*> [#uses=1]
  %526 = load i32* %525, align 4                  ; <i32> [#uses=1]
  %527 = add i32 %524, %526                       ; <i32> [#uses=1]
  %528 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %529 = add i32 %527, %528                       ; <i32> [#uses=1]
  %530 = add i32 %529, 643717713                  ; <i32> [#uses=1]
  store i32 %530, i32* %C, align 4
  %531 = load i32* %C, align 4                    ; <i32> [#uses=2]
  %532 = lshr i32 %531, 18                        ; <i32> [#uses=1]
  %533 = shl i32 %531, 14                         ; <i32> [#uses=1]
  %534 = or i32 %532, %533                        ; <i32> [#uses=1]
  store i32 %534, i32* %C, align 4
  %535 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %536 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %537 = add i32 %535, %536                       ; <i32> [#uses=1]
  store i32 %537, i32* %C, align 4
  %538 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %539 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %540 = xor i32 %538, %539                       ; <i32> [#uses=1]
  %541 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %542 = and i32 %540, %541                       ; <i32> [#uses=1]
  %543 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %544 = xor i32 %542, %543                       ; <i32> [#uses=1]
  %545 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 0 ; <i32*> [#uses=1]
  %546 = load i32* %545, align 4                  ; <i32> [#uses=1]
  %547 = add i32 %544, %546                       ; <i32> [#uses=1]
  %548 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %549 = add i32 %547, %548                       ; <i32> [#uses=1]
  %550 = add i32 %549, -373897302                 ; <i32> [#uses=1]
  store i32 %550, i32* %B, align 4
  %551 = load i32* %B, align 4                    ; <i32> [#uses=2]
  %552 = lshr i32 %551, 12                        ; <i32> [#uses=1]
  %553 = shl i32 %551, 20                         ; <i32> [#uses=1]
  %554 = or i32 %552, %553                        ; <i32> [#uses=1]
  store i32 %554, i32* %B, align 4
  %555 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %556 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %557 = add i32 %555, %556                       ; <i32> [#uses=1]
  store i32 %557, i32* %B, align 4
  %558 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %559 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %560 = xor i32 %558, %559                       ; <i32> [#uses=1]
  %561 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %562 = and i32 %560, %561                       ; <i32> [#uses=1]
  %563 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %564 = xor i32 %562, %563                       ; <i32> [#uses=1]
  %565 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 5 ; <i32*> [#uses=1]
  %566 = load i32* %565, align 4                  ; <i32> [#uses=1]
  %567 = add i32 %564, %566                       ; <i32> [#uses=1]
  %568 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %569 = add i32 %567, %568                       ; <i32> [#uses=1]
  %570 = add i32 %569, -701558691                 ; <i32> [#uses=1]
  store i32 %570, i32* %A, align 4
  %571 = load i32* %A, align 4                    ; <i32> [#uses=2]
  %572 = lshr i32 %571, 27                        ; <i32> [#uses=1]
  %573 = shl i32 %571, 5                          ; <i32> [#uses=1]
  %574 = or i32 %572, %573                        ; <i32> [#uses=1]
  store i32 %574, i32* %A, align 4
  %575 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %576 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %577 = add i32 %575, %576                       ; <i32> [#uses=1]
  store i32 %577, i32* %A, align 4
  %578 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %579 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %580 = xor i32 %578, %579                       ; <i32> [#uses=1]
  %581 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %582 = and i32 %580, %581                       ; <i32> [#uses=1]
  %583 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %584 = xor i32 %582, %583                       ; <i32> [#uses=1]
  %585 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 10 ; <i32*> [#uses=1]
  %586 = load i32* %585, align 4                  ; <i32> [#uses=1]
  %587 = add i32 %584, %586                       ; <i32> [#uses=1]
  %588 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %589 = add i32 %587, %588                       ; <i32> [#uses=1]
  %590 = add i32 %589, 38016083                   ; <i32> [#uses=1]
  store i32 %590, i32* %D, align 4
  %591 = load i32* %D, align 4                    ; <i32> [#uses=2]
  %592 = lshr i32 %591, 23                        ; <i32> [#uses=1]
  %593 = shl i32 %591, 9                          ; <i32> [#uses=1]
  %594 = or i32 %592, %593                        ; <i32> [#uses=1]
  store i32 %594, i32* %D, align 4
  %595 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %596 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %597 = add i32 %595, %596                       ; <i32> [#uses=1]
  store i32 %597, i32* %D, align 4
  %598 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %599 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %600 = xor i32 %598, %599                       ; <i32> [#uses=1]
  %601 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %602 = and i32 %600, %601                       ; <i32> [#uses=1]
  %603 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %604 = xor i32 %602, %603                       ; <i32> [#uses=1]
  %605 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 15 ; <i32*> [#uses=1]
  %606 = load i32* %605, align 4                  ; <i32> [#uses=1]
  %607 = add i32 %604, %606                       ; <i32> [#uses=1]
  %608 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %609 = add i32 %607, %608                       ; <i32> [#uses=1]
  %610 = add i32 %609, -660478335                 ; <i32> [#uses=1]
  store i32 %610, i32* %C, align 4
  %611 = load i32* %C, align 4                    ; <i32> [#uses=2]
  %612 = lshr i32 %611, 18                        ; <i32> [#uses=1]
  %613 = shl i32 %611, 14                         ; <i32> [#uses=1]
  %614 = or i32 %612, %613                        ; <i32> [#uses=1]
  store i32 %614, i32* %C, align 4
  %615 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %616 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %617 = add i32 %615, %616                       ; <i32> [#uses=1]
  store i32 %617, i32* %C, align 4
  %618 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %619 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %620 = xor i32 %618, %619                       ; <i32> [#uses=1]
  %621 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %622 = and i32 %620, %621                       ; <i32> [#uses=1]
  %623 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %624 = xor i32 %622, %623                       ; <i32> [#uses=1]
  %625 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 4 ; <i32*> [#uses=1]
  %626 = load i32* %625, align 4                  ; <i32> [#uses=1]
  %627 = add i32 %624, %626                       ; <i32> [#uses=1]
  %628 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %629 = add i32 %627, %628                       ; <i32> [#uses=1]
  %630 = add i32 %629, -405537848                 ; <i32> [#uses=1]
  store i32 %630, i32* %B, align 4
  %631 = load i32* %B, align 4                    ; <i32> [#uses=2]
  %632 = lshr i32 %631, 12                        ; <i32> [#uses=1]
  %633 = shl i32 %631, 20                         ; <i32> [#uses=1]
  %634 = or i32 %632, %633                        ; <i32> [#uses=1]
  store i32 %634, i32* %B, align 4
  %635 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %636 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %637 = add i32 %635, %636                       ; <i32> [#uses=1]
  store i32 %637, i32* %B, align 4
  %638 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %639 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %640 = xor i32 %638, %639                       ; <i32> [#uses=1]
  %641 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %642 = and i32 %640, %641                       ; <i32> [#uses=1]
  %643 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %644 = xor i32 %642, %643                       ; <i32> [#uses=1]
  %645 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 9 ; <i32*> [#uses=1]
  %646 = load i32* %645, align 4                  ; <i32> [#uses=1]
  %647 = add i32 %644, %646                       ; <i32> [#uses=1]
  %648 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %649 = add i32 %647, %648                       ; <i32> [#uses=1]
  %650 = add i32 %649, 568446438                  ; <i32> [#uses=1]
  store i32 %650, i32* %A, align 4
  %651 = load i32* %A, align 4                    ; <i32> [#uses=2]
  %652 = lshr i32 %651, 27                        ; <i32> [#uses=1]
  %653 = shl i32 %651, 5                          ; <i32> [#uses=1]
  %654 = or i32 %652, %653                        ; <i32> [#uses=1]
  store i32 %654, i32* %A, align 4
  %655 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %656 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %657 = add i32 %655, %656                       ; <i32> [#uses=1]
  store i32 %657, i32* %A, align 4
  %658 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %659 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %660 = xor i32 %658, %659                       ; <i32> [#uses=1]
  %661 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %662 = and i32 %660, %661                       ; <i32> [#uses=1]
  %663 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %664 = xor i32 %662, %663                       ; <i32> [#uses=1]
  %665 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 14 ; <i32*> [#uses=1]
  %666 = load i32* %665, align 4                  ; <i32> [#uses=1]
  %667 = add i32 %664, %666                       ; <i32> [#uses=1]
  %668 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %669 = add i32 %667, %668                       ; <i32> [#uses=1]
  %670 = add i32 %669, -1019803690                ; <i32> [#uses=1]
  store i32 %670, i32* %D, align 4
  %671 = load i32* %D, align 4                    ; <i32> [#uses=2]
  %672 = lshr i32 %671, 23                        ; <i32> [#uses=1]
  %673 = shl i32 %671, 9                          ; <i32> [#uses=1]
  %674 = or i32 %672, %673                        ; <i32> [#uses=1]
  store i32 %674, i32* %D, align 4
  %675 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %676 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %677 = add i32 %675, %676                       ; <i32> [#uses=1]
  store i32 %677, i32* %D, align 4
  %678 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %679 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %680 = xor i32 %678, %679                       ; <i32> [#uses=1]
  %681 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %682 = and i32 %680, %681                       ; <i32> [#uses=1]
  %683 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %684 = xor i32 %682, %683                       ; <i32> [#uses=1]
  %685 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 3 ; <i32*> [#uses=1]
  %686 = load i32* %685, align 4                  ; <i32> [#uses=1]
  %687 = add i32 %684, %686                       ; <i32> [#uses=1]
  %688 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %689 = add i32 %687, %688                       ; <i32> [#uses=1]
  %690 = add i32 %689, -187363961                 ; <i32> [#uses=1]
  store i32 %690, i32* %C, align 4
  %691 = load i32* %C, align 4                    ; <i32> [#uses=2]
  %692 = lshr i32 %691, 18                        ; <i32> [#uses=1]
  %693 = shl i32 %691, 14                         ; <i32> [#uses=1]
  %694 = or i32 %692, %693                        ; <i32> [#uses=1]
  store i32 %694, i32* %C, align 4
  %695 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %696 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %697 = add i32 %695, %696                       ; <i32> [#uses=1]
  store i32 %697, i32* %C, align 4
  %698 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %699 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %700 = xor i32 %698, %699                       ; <i32> [#uses=1]
  %701 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %702 = and i32 %700, %701                       ; <i32> [#uses=1]
  %703 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %704 = xor i32 %702, %703                       ; <i32> [#uses=1]
  %705 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 8 ; <i32*> [#uses=1]
  %706 = load i32* %705, align 4                  ; <i32> [#uses=1]
  %707 = add i32 %704, %706                       ; <i32> [#uses=1]
  %708 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %709 = add i32 %707, %708                       ; <i32> [#uses=1]
  %710 = add i32 %709, 1163531501                 ; <i32> [#uses=1]
  store i32 %710, i32* %B, align 4
  %711 = load i32* %B, align 4                    ; <i32> [#uses=2]
  %712 = lshr i32 %711, 12                        ; <i32> [#uses=1]
  %713 = shl i32 %711, 20                         ; <i32> [#uses=1]
  %714 = or i32 %712, %713                        ; <i32> [#uses=1]
  store i32 %714, i32* %B, align 4
  %715 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %716 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %717 = add i32 %715, %716                       ; <i32> [#uses=1]
  store i32 %717, i32* %B, align 4
  %718 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %719 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %720 = xor i32 %718, %719                       ; <i32> [#uses=1]
  %721 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %722 = and i32 %720, %721                       ; <i32> [#uses=1]
  %723 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %724 = xor i32 %722, %723                       ; <i32> [#uses=1]
  %725 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 13 ; <i32*> [#uses=1]
  %726 = load i32* %725, align 4                  ; <i32> [#uses=1]
  %727 = add i32 %724, %726                       ; <i32> [#uses=1]
  %728 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %729 = add i32 %727, %728                       ; <i32> [#uses=1]
  %730 = add i32 %729, -1444681467                ; <i32> [#uses=1]
  store i32 %730, i32* %A, align 4
  %731 = load i32* %A, align 4                    ; <i32> [#uses=2]
  %732 = lshr i32 %731, 27                        ; <i32> [#uses=1]
  %733 = shl i32 %731, 5                          ; <i32> [#uses=1]
  %734 = or i32 %732, %733                        ; <i32> [#uses=1]
  store i32 %734, i32* %A, align 4
  %735 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %736 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %737 = add i32 %735, %736                       ; <i32> [#uses=1]
  store i32 %737, i32* %A, align 4
  %738 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %739 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %740 = xor i32 %738, %739                       ; <i32> [#uses=1]
  %741 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %742 = and i32 %740, %741                       ; <i32> [#uses=1]
  %743 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %744 = xor i32 %742, %743                       ; <i32> [#uses=1]
  %745 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 2 ; <i32*> [#uses=1]
  %746 = load i32* %745, align 4                  ; <i32> [#uses=1]
  %747 = add i32 %744, %746                       ; <i32> [#uses=1]
  %748 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %749 = add i32 %747, %748                       ; <i32> [#uses=1]
  %750 = add i32 %749, -51403784                  ; <i32> [#uses=1]
  store i32 %750, i32* %D, align 4
  %751 = load i32* %D, align 4                    ; <i32> [#uses=2]
  %752 = lshr i32 %751, 23                        ; <i32> [#uses=1]
  %753 = shl i32 %751, 9                          ; <i32> [#uses=1]
  %754 = or i32 %752, %753                        ; <i32> [#uses=1]
  store i32 %754, i32* %D, align 4
  %755 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %756 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %757 = add i32 %755, %756                       ; <i32> [#uses=1]
  store i32 %757, i32* %D, align 4
  %758 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %759 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %760 = xor i32 %758, %759                       ; <i32> [#uses=1]
  %761 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %762 = and i32 %760, %761                       ; <i32> [#uses=1]
  %763 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %764 = xor i32 %762, %763                       ; <i32> [#uses=1]
  %765 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 7 ; <i32*> [#uses=1]
  %766 = load i32* %765, align 4                  ; <i32> [#uses=1]
  %767 = add i32 %764, %766                       ; <i32> [#uses=1]
  %768 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %769 = add i32 %767, %768                       ; <i32> [#uses=1]
  %770 = add i32 %769, 1735328473                 ; <i32> [#uses=1]
  store i32 %770, i32* %C, align 4
  %771 = load i32* %C, align 4                    ; <i32> [#uses=2]
  %772 = lshr i32 %771, 18                        ; <i32> [#uses=1]
  %773 = shl i32 %771, 14                         ; <i32> [#uses=1]
  %774 = or i32 %772, %773                        ; <i32> [#uses=1]
  store i32 %774, i32* %C, align 4
  %775 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %776 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %777 = add i32 %775, %776                       ; <i32> [#uses=1]
  store i32 %777, i32* %C, align 4
  %778 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %779 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %780 = xor i32 %778, %779                       ; <i32> [#uses=1]
  %781 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %782 = and i32 %780, %781                       ; <i32> [#uses=1]
  %783 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %784 = xor i32 %782, %783                       ; <i32> [#uses=1]
  %785 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 12 ; <i32*> [#uses=1]
  %786 = load i32* %785, align 4                  ; <i32> [#uses=1]
  %787 = add i32 %784, %786                       ; <i32> [#uses=1]
  %788 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %789 = add i32 %787, %788                       ; <i32> [#uses=1]
  %790 = add i32 %789, -1926607734                ; <i32> [#uses=1]
  store i32 %790, i32* %B, align 4
  %791 = load i32* %B, align 4                    ; <i32> [#uses=2]
  %792 = lshr i32 %791, 12                        ; <i32> [#uses=1]
  %793 = shl i32 %791, 20                         ; <i32> [#uses=1]
  %794 = or i32 %792, %793                        ; <i32> [#uses=1]
  store i32 %794, i32* %B, align 4
  %795 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %796 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %797 = add i32 %795, %796                       ; <i32> [#uses=1]
  store i32 %797, i32* %B, align 4
  %798 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %799 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %800 = xor i32 %798, %799                       ; <i32> [#uses=1]
  %801 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %802 = xor i32 %800, %801                       ; <i32> [#uses=1]
  %803 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 5 ; <i32*> [#uses=1]
  %804 = load i32* %803, align 4                  ; <i32> [#uses=1]
  %805 = add i32 %802, %804                       ; <i32> [#uses=1]
  %806 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %807 = add i32 %805, %806                       ; <i32> [#uses=1]
  %808 = add i32 %807, -378558                    ; <i32> [#uses=1]
  store i32 %808, i32* %A, align 4
  %809 = load i32* %A, align 4                    ; <i32> [#uses=2]
  %810 = lshr i32 %809, 28                        ; <i32> [#uses=1]
  %811 = shl i32 %809, 4                          ; <i32> [#uses=1]
  %812 = or i32 %810, %811                        ; <i32> [#uses=1]
  store i32 %812, i32* %A, align 4
  %813 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %814 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %815 = add i32 %813, %814                       ; <i32> [#uses=1]
  store i32 %815, i32* %A, align 4
  %816 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %817 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %818 = xor i32 %816, %817                       ; <i32> [#uses=1]
  %819 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %820 = xor i32 %818, %819                       ; <i32> [#uses=1]
  %821 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 8 ; <i32*> [#uses=1]
  %822 = load i32* %821, align 4                  ; <i32> [#uses=1]
  %823 = add i32 %820, %822                       ; <i32> [#uses=1]
  %824 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %825 = add i32 %823, %824                       ; <i32> [#uses=1]
  %826 = add i32 %825, -2022574463                ; <i32> [#uses=1]
  store i32 %826, i32* %D, align 4
  %827 = load i32* %D, align 4                    ; <i32> [#uses=2]
  %828 = lshr i32 %827, 21                        ; <i32> [#uses=1]
  %829 = shl i32 %827, 11                         ; <i32> [#uses=1]
  %830 = or i32 %828, %829                        ; <i32> [#uses=1]
  store i32 %830, i32* %D, align 4
  %831 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %832 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %833 = add i32 %831, %832                       ; <i32> [#uses=1]
  store i32 %833, i32* %D, align 4
  %834 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %835 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %836 = xor i32 %834, %835                       ; <i32> [#uses=1]
  %837 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %838 = xor i32 %836, %837                       ; <i32> [#uses=1]
  %839 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 11 ; <i32*> [#uses=1]
  %840 = load i32* %839, align 4                  ; <i32> [#uses=1]
  %841 = add i32 %838, %840                       ; <i32> [#uses=1]
  %842 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %843 = add i32 %841, %842                       ; <i32> [#uses=1]
  %844 = add i32 %843, 1839030562                 ; <i32> [#uses=1]
  store i32 %844, i32* %C, align 4
  %845 = load i32* %C, align 4                    ; <i32> [#uses=2]
  %846 = lshr i32 %845, 16                        ; <i32> [#uses=1]
  %847 = shl i32 %845, 16                         ; <i32> [#uses=1]
  %848 = or i32 %846, %847                        ; <i32> [#uses=1]
  store i32 %848, i32* %C, align 4
  %849 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %850 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %851 = add i32 %849, %850                       ; <i32> [#uses=1]
  store i32 %851, i32* %C, align 4
  %852 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %853 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %854 = xor i32 %852, %853                       ; <i32> [#uses=1]
  %855 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %856 = xor i32 %854, %855                       ; <i32> [#uses=1]
  %857 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 14 ; <i32*> [#uses=1]
  %858 = load i32* %857, align 4                  ; <i32> [#uses=1]
  %859 = add i32 %856, %858                       ; <i32> [#uses=1]
  %860 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %861 = add i32 %859, %860                       ; <i32> [#uses=1]
  %862 = add i32 %861, -35309556                  ; <i32> [#uses=1]
  store i32 %862, i32* %B, align 4
  %863 = load i32* %B, align 4                    ; <i32> [#uses=2]
  %864 = lshr i32 %863, 9                         ; <i32> [#uses=1]
  %865 = shl i32 %863, 23                         ; <i32> [#uses=1]
  %866 = or i32 %864, %865                        ; <i32> [#uses=1]
  store i32 %866, i32* %B, align 4
  %867 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %868 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %869 = add i32 %867, %868                       ; <i32> [#uses=1]
  store i32 %869, i32* %B, align 4
  %870 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %871 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %872 = xor i32 %870, %871                       ; <i32> [#uses=1]
  %873 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %874 = xor i32 %872, %873                       ; <i32> [#uses=1]
  %875 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 1 ; <i32*> [#uses=1]
  %876 = load i32* %875, align 4                  ; <i32> [#uses=1]
  %877 = add i32 %874, %876                       ; <i32> [#uses=1]
  %878 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %879 = add i32 %877, %878                       ; <i32> [#uses=1]
  %880 = add i32 %879, -1530992060                ; <i32> [#uses=1]
  store i32 %880, i32* %A, align 4
  %881 = load i32* %A, align 4                    ; <i32> [#uses=2]
  %882 = lshr i32 %881, 28                        ; <i32> [#uses=1]
  %883 = shl i32 %881, 4                          ; <i32> [#uses=1]
  %884 = or i32 %882, %883                        ; <i32> [#uses=1]
  store i32 %884, i32* %A, align 4
  %885 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %886 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %887 = add i32 %885, %886                       ; <i32> [#uses=1]
  store i32 %887, i32* %A, align 4
  %888 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %889 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %890 = xor i32 %888, %889                       ; <i32> [#uses=1]
  %891 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %892 = xor i32 %890, %891                       ; <i32> [#uses=1]
  %893 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 4 ; <i32*> [#uses=1]
  %894 = load i32* %893, align 4                  ; <i32> [#uses=1]
  %895 = add i32 %892, %894                       ; <i32> [#uses=1]
  %896 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %897 = add i32 %895, %896                       ; <i32> [#uses=1]
  %898 = add i32 %897, 1272893353                 ; <i32> [#uses=1]
  store i32 %898, i32* %D, align 4
  %899 = load i32* %D, align 4                    ; <i32> [#uses=2]
  %900 = lshr i32 %899, 21                        ; <i32> [#uses=1]
  %901 = shl i32 %899, 11                         ; <i32> [#uses=1]
  %902 = or i32 %900, %901                        ; <i32> [#uses=1]
  store i32 %902, i32* %D, align 4
  %903 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %904 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %905 = add i32 %903, %904                       ; <i32> [#uses=1]
  store i32 %905, i32* %D, align 4
  %906 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %907 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %908 = xor i32 %906, %907                       ; <i32> [#uses=1]
  %909 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %910 = xor i32 %908, %909                       ; <i32> [#uses=1]
  %911 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 7 ; <i32*> [#uses=1]
  %912 = load i32* %911, align 4                  ; <i32> [#uses=1]
  %913 = add i32 %910, %912                       ; <i32> [#uses=1]
  %914 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %915 = add i32 %913, %914                       ; <i32> [#uses=1]
  %916 = add i32 %915, -155497632                 ; <i32> [#uses=1]
  store i32 %916, i32* %C, align 4
  %917 = load i32* %C, align 4                    ; <i32> [#uses=2]
  %918 = lshr i32 %917, 16                        ; <i32> [#uses=1]
  %919 = shl i32 %917, 16                         ; <i32> [#uses=1]
  %920 = or i32 %918, %919                        ; <i32> [#uses=1]
  store i32 %920, i32* %C, align 4
  %921 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %922 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %923 = add i32 %921, %922                       ; <i32> [#uses=1]
  store i32 %923, i32* %C, align 4
  %924 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %925 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %926 = xor i32 %924, %925                       ; <i32> [#uses=1]
  %927 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %928 = xor i32 %926, %927                       ; <i32> [#uses=1]
  %929 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 10 ; <i32*> [#uses=1]
  %930 = load i32* %929, align 4                  ; <i32> [#uses=1]
  %931 = add i32 %928, %930                       ; <i32> [#uses=1]
  %932 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %933 = add i32 %931, %932                       ; <i32> [#uses=1]
  %934 = add i32 %933, -1094730640                ; <i32> [#uses=1]
  store i32 %934, i32* %B, align 4
  %935 = load i32* %B, align 4                    ; <i32> [#uses=2]
  %936 = lshr i32 %935, 9                         ; <i32> [#uses=1]
  %937 = shl i32 %935, 23                         ; <i32> [#uses=1]
  %938 = or i32 %936, %937                        ; <i32> [#uses=1]
  store i32 %938, i32* %B, align 4
  %939 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %940 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %941 = add i32 %939, %940                       ; <i32> [#uses=1]
  store i32 %941, i32* %B, align 4
  %942 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %943 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %944 = xor i32 %942, %943                       ; <i32> [#uses=1]
  %945 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %946 = xor i32 %944, %945                       ; <i32> [#uses=1]
  %947 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 13 ; <i32*> [#uses=1]
  %948 = load i32* %947, align 4                  ; <i32> [#uses=1]
  %949 = add i32 %946, %948                       ; <i32> [#uses=1]
  %950 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %951 = add i32 %949, %950                       ; <i32> [#uses=1]
  %952 = add i32 %951, 681279174                  ; <i32> [#uses=1]
  store i32 %952, i32* %A, align 4
  %953 = load i32* %A, align 4                    ; <i32> [#uses=2]
  %954 = lshr i32 %953, 28                        ; <i32> [#uses=1]
  %955 = shl i32 %953, 4                          ; <i32> [#uses=1]
  %956 = or i32 %954, %955                        ; <i32> [#uses=1]
  store i32 %956, i32* %A, align 4
  %957 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %958 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %959 = add i32 %957, %958                       ; <i32> [#uses=1]
  store i32 %959, i32* %A, align 4
  %960 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %961 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %962 = xor i32 %960, %961                       ; <i32> [#uses=1]
  %963 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %964 = xor i32 %962, %963                       ; <i32> [#uses=1]
  %965 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 0 ; <i32*> [#uses=1]
  %966 = load i32* %965, align 4                  ; <i32> [#uses=1]
  %967 = add i32 %964, %966                       ; <i32> [#uses=1]
  %968 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %969 = add i32 %967, %968                       ; <i32> [#uses=1]
  %970 = add i32 %969, -358537222                 ; <i32> [#uses=1]
  store i32 %970, i32* %D, align 4
  %971 = load i32* %D, align 4                    ; <i32> [#uses=2]
  %972 = lshr i32 %971, 21                        ; <i32> [#uses=1]
  %973 = shl i32 %971, 11                         ; <i32> [#uses=1]
  %974 = or i32 %972, %973                        ; <i32> [#uses=1]
  store i32 %974, i32* %D, align 4
  %975 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %976 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %977 = add i32 %975, %976                       ; <i32> [#uses=1]
  store i32 %977, i32* %D, align 4
  %978 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %979 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %980 = xor i32 %978, %979                       ; <i32> [#uses=1]
  %981 = load i32* %B, align 4                    ; <i32> [#uses=1]
  %982 = xor i32 %980, %981                       ; <i32> [#uses=1]
  %983 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 3 ; <i32*> [#uses=1]
  %984 = load i32* %983, align 4                  ; <i32> [#uses=1]
  %985 = add i32 %982, %984                       ; <i32> [#uses=1]
  %986 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %987 = add i32 %985, %986                       ; <i32> [#uses=1]
  %988 = add i32 %987, -722521979                 ; <i32> [#uses=1]
  store i32 %988, i32* %C, align 4
  %989 = load i32* %C, align 4                    ; <i32> [#uses=2]
  %990 = lshr i32 %989, 16                        ; <i32> [#uses=1]
  %991 = shl i32 %989, 16                         ; <i32> [#uses=1]
  %992 = or i32 %990, %991                        ; <i32> [#uses=1]
  store i32 %992, i32* %C, align 4
  %993 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %994 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %995 = add i32 %993, %994                       ; <i32> [#uses=1]
  store i32 %995, i32* %C, align 4
  %996 = load i32* %C, align 4                    ; <i32> [#uses=1]
  %997 = load i32* %D, align 4                    ; <i32> [#uses=1]
  %998 = xor i32 %996, %997                       ; <i32> [#uses=1]
  %999 = load i32* %A, align 4                    ; <i32> [#uses=1]
  %1000 = xor i32 %998, %999                      ; <i32> [#uses=1]
  %1001 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 6 ; <i32*> [#uses=1]
  %1002 = load i32* %1001, align 4                ; <i32> [#uses=1]
  %1003 = add i32 %1000, %1002                    ; <i32> [#uses=1]
  %1004 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1005 = add i32 %1003, %1004                    ; <i32> [#uses=1]
  %1006 = add i32 %1005, 76029189                 ; <i32> [#uses=1]
  store i32 %1006, i32* %B, align 4
  %1007 = load i32* %B, align 4                   ; <i32> [#uses=2]
  %1008 = lshr i32 %1007, 9                       ; <i32> [#uses=1]
  %1009 = shl i32 %1007, 23                       ; <i32> [#uses=1]
  %1010 = or i32 %1008, %1009                     ; <i32> [#uses=1]
  store i32 %1010, i32* %B, align 4
  %1011 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1012 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1013 = add i32 %1011, %1012                    ; <i32> [#uses=1]
  store i32 %1013, i32* %B, align 4
  %1014 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1015 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1016 = xor i32 %1014, %1015                    ; <i32> [#uses=1]
  %1017 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1018 = xor i32 %1016, %1017                    ; <i32> [#uses=1]
  %1019 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 9 ; <i32*> [#uses=1]
  %1020 = load i32* %1019, align 4                ; <i32> [#uses=1]
  %1021 = add i32 %1018, %1020                    ; <i32> [#uses=1]
  %1022 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1023 = add i32 %1021, %1022                    ; <i32> [#uses=1]
  %1024 = add i32 %1023, -640364487               ; <i32> [#uses=1]
  store i32 %1024, i32* %A, align 4
  %1025 = load i32* %A, align 4                   ; <i32> [#uses=2]
  %1026 = lshr i32 %1025, 28                      ; <i32> [#uses=1]
  %1027 = shl i32 %1025, 4                        ; <i32> [#uses=1]
  %1028 = or i32 %1026, %1027                     ; <i32> [#uses=1]
  store i32 %1028, i32* %A, align 4
  %1029 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1030 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1031 = add i32 %1029, %1030                    ; <i32> [#uses=1]
  store i32 %1031, i32* %A, align 4
  %1032 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1033 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1034 = xor i32 %1032, %1033                    ; <i32> [#uses=1]
  %1035 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1036 = xor i32 %1034, %1035                    ; <i32> [#uses=1]
  %1037 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 12 ; <i32*> [#uses=1]
  %1038 = load i32* %1037, align 4                ; <i32> [#uses=1]
  %1039 = add i32 %1036, %1038                    ; <i32> [#uses=1]
  %1040 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1041 = add i32 %1039, %1040                    ; <i32> [#uses=1]
  %1042 = add i32 %1041, -421815835               ; <i32> [#uses=1]
  store i32 %1042, i32* %D, align 4
  %1043 = load i32* %D, align 4                   ; <i32> [#uses=2]
  %1044 = lshr i32 %1043, 21                      ; <i32> [#uses=1]
  %1045 = shl i32 %1043, 11                       ; <i32> [#uses=1]
  %1046 = or i32 %1044, %1045                     ; <i32> [#uses=1]
  store i32 %1046, i32* %D, align 4
  %1047 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1048 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1049 = add i32 %1047, %1048                    ; <i32> [#uses=1]
  store i32 %1049, i32* %D, align 4
  %1050 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1051 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1052 = xor i32 %1050, %1051                    ; <i32> [#uses=1]
  %1053 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1054 = xor i32 %1052, %1053                    ; <i32> [#uses=1]
  %1055 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 15 ; <i32*> [#uses=1]
  %1056 = load i32* %1055, align 4                ; <i32> [#uses=1]
  %1057 = add i32 %1054, %1056                    ; <i32> [#uses=1]
  %1058 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1059 = add i32 %1057, %1058                    ; <i32> [#uses=1]
  %1060 = add i32 %1059, 530742520                ; <i32> [#uses=1]
  store i32 %1060, i32* %C, align 4
  %1061 = load i32* %C, align 4                   ; <i32> [#uses=2]
  %1062 = lshr i32 %1061, 16                      ; <i32> [#uses=1]
  %1063 = shl i32 %1061, 16                       ; <i32> [#uses=1]
  %1064 = or i32 %1062, %1063                     ; <i32> [#uses=1]
  store i32 %1064, i32* %C, align 4
  %1065 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1066 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1067 = add i32 %1065, %1066                    ; <i32> [#uses=1]
  store i32 %1067, i32* %C, align 4
  %1068 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1069 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1070 = xor i32 %1068, %1069                    ; <i32> [#uses=1]
  %1071 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1072 = xor i32 %1070, %1071                    ; <i32> [#uses=1]
  %1073 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 2 ; <i32*> [#uses=1]
  %1074 = load i32* %1073, align 4                ; <i32> [#uses=1]
  %1075 = add i32 %1072, %1074                    ; <i32> [#uses=1]
  %1076 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1077 = add i32 %1075, %1076                    ; <i32> [#uses=1]
  %1078 = add i32 %1077, -995338651               ; <i32> [#uses=1]
  store i32 %1078, i32* %B, align 4
  %1079 = load i32* %B, align 4                   ; <i32> [#uses=2]
  %1080 = lshr i32 %1079, 9                       ; <i32> [#uses=1]
  %1081 = shl i32 %1079, 23                       ; <i32> [#uses=1]
  %1082 = or i32 %1080, %1081                     ; <i32> [#uses=1]
  store i32 %1082, i32* %B, align 4
  %1083 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1084 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1085 = add i32 %1083, %1084                    ; <i32> [#uses=1]
  store i32 %1085, i32* %B, align 4
  %1086 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %not = xor i32 %1086, -1                        ; <i32> [#uses=1]
  %1087 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1088 = or i32 %not, %1087                      ; <i32> [#uses=1]
  %1089 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1090 = xor i32 %1088, %1089                    ; <i32> [#uses=1]
  %1091 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 0 ; <i32*> [#uses=1]
  %1092 = load i32* %1091, align 4                ; <i32> [#uses=1]
  %1093 = add i32 %1090, %1092                    ; <i32> [#uses=1]
  %1094 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1095 = add i32 %1093, %1094                    ; <i32> [#uses=1]
  %1096 = add i32 %1095, -198630844               ; <i32> [#uses=1]
  store i32 %1096, i32* %A, align 4
  %1097 = load i32* %A, align 4                   ; <i32> [#uses=2]
  %1098 = lshr i32 %1097, 26                      ; <i32> [#uses=1]
  %1099 = shl i32 %1097, 6                        ; <i32> [#uses=1]
  %1100 = or i32 %1098, %1099                     ; <i32> [#uses=1]
  store i32 %1100, i32* %A, align 4
  %1101 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1102 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1103 = add i32 %1101, %1102                    ; <i32> [#uses=1]
  store i32 %1103, i32* %A, align 4
  %1104 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %not5 = xor i32 %1104, -1                       ; <i32> [#uses=1]
  %1105 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1106 = or i32 %not5, %1105                     ; <i32> [#uses=1]
  %1107 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1108 = xor i32 %1106, %1107                    ; <i32> [#uses=1]
  %1109 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 7 ; <i32*> [#uses=1]
  %1110 = load i32* %1109, align 4                ; <i32> [#uses=1]
  %1111 = add i32 %1108, %1110                    ; <i32> [#uses=1]
  %1112 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1113 = add i32 %1111, %1112                    ; <i32> [#uses=1]
  %1114 = add i32 %1113, 1126891415               ; <i32> [#uses=1]
  store i32 %1114, i32* %D, align 4
  %1115 = load i32* %D, align 4                   ; <i32> [#uses=2]
  %1116 = lshr i32 %1115, 22                      ; <i32> [#uses=1]
  %1117 = shl i32 %1115, 10                       ; <i32> [#uses=1]
  %1118 = or i32 %1116, %1117                     ; <i32> [#uses=1]
  store i32 %1118, i32* %D, align 4
  %1119 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1120 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1121 = add i32 %1119, %1120                    ; <i32> [#uses=1]
  store i32 %1121, i32* %D, align 4
  %1122 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %not7 = xor i32 %1122, -1                       ; <i32> [#uses=1]
  %1123 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1124 = or i32 %not7, %1123                     ; <i32> [#uses=1]
  %1125 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1126 = xor i32 %1124, %1125                    ; <i32> [#uses=1]
  %1127 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 14 ; <i32*> [#uses=1]
  %1128 = load i32* %1127, align 4                ; <i32> [#uses=1]
  %1129 = add i32 %1126, %1128                    ; <i32> [#uses=1]
  %1130 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1131 = add i32 %1129, %1130                    ; <i32> [#uses=1]
  %1132 = add i32 %1131, -1416354905              ; <i32> [#uses=1]
  store i32 %1132, i32* %C, align 4
  %1133 = load i32* %C, align 4                   ; <i32> [#uses=2]
  %1134 = lshr i32 %1133, 17                      ; <i32> [#uses=1]
  %1135 = shl i32 %1133, 15                       ; <i32> [#uses=1]
  %1136 = or i32 %1134, %1135                     ; <i32> [#uses=1]
  store i32 %1136, i32* %C, align 4
  %1137 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1138 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1139 = add i32 %1137, %1138                    ; <i32> [#uses=1]
  store i32 %1139, i32* %C, align 4
  %1140 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %not9 = xor i32 %1140, -1                       ; <i32> [#uses=1]
  %1141 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1142 = or i32 %not9, %1141                     ; <i32> [#uses=1]
  %1143 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1144 = xor i32 %1142, %1143                    ; <i32> [#uses=1]
  %1145 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 5 ; <i32*> [#uses=1]
  %1146 = load i32* %1145, align 4                ; <i32> [#uses=1]
  %1147 = add i32 %1144, %1146                    ; <i32> [#uses=1]
  %1148 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1149 = add i32 %1147, %1148                    ; <i32> [#uses=1]
  %1150 = add i32 %1149, -57434055                ; <i32> [#uses=1]
  store i32 %1150, i32* %B, align 4
  %1151 = load i32* %B, align 4                   ; <i32> [#uses=2]
  %1152 = lshr i32 %1151, 11                      ; <i32> [#uses=1]
  %1153 = shl i32 %1151, 21                       ; <i32> [#uses=1]
  %1154 = or i32 %1152, %1153                     ; <i32> [#uses=1]
  store i32 %1154, i32* %B, align 4
  %1155 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1156 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1157 = add i32 %1155, %1156                    ; <i32> [#uses=1]
  store i32 %1157, i32* %B, align 4
  %1158 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %not11 = xor i32 %1158, -1                      ; <i32> [#uses=1]
  %1159 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1160 = or i32 %not11, %1159                    ; <i32> [#uses=1]
  %1161 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1162 = xor i32 %1160, %1161                    ; <i32> [#uses=1]
  %1163 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 12 ; <i32*> [#uses=1]
  %1164 = load i32* %1163, align 4                ; <i32> [#uses=1]
  %1165 = add i32 %1162, %1164                    ; <i32> [#uses=1]
  %1166 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1167 = add i32 %1165, %1166                    ; <i32> [#uses=1]
  %1168 = add i32 %1167, 1700485571               ; <i32> [#uses=1]
  store i32 %1168, i32* %A, align 4
  %1169 = load i32* %A, align 4                   ; <i32> [#uses=2]
  %1170 = lshr i32 %1169, 26                      ; <i32> [#uses=1]
  %1171 = shl i32 %1169, 6                        ; <i32> [#uses=1]
  %1172 = or i32 %1170, %1171                     ; <i32> [#uses=1]
  store i32 %1172, i32* %A, align 4
  %1173 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1174 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1175 = add i32 %1173, %1174                    ; <i32> [#uses=1]
  store i32 %1175, i32* %A, align 4
  %1176 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %not13 = xor i32 %1176, -1                      ; <i32> [#uses=1]
  %1177 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1178 = or i32 %not13, %1177                    ; <i32> [#uses=1]
  %1179 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1180 = xor i32 %1178, %1179                    ; <i32> [#uses=1]
  %1181 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 3 ; <i32*> [#uses=1]
  %1182 = load i32* %1181, align 4                ; <i32> [#uses=1]
  %1183 = add i32 %1180, %1182                    ; <i32> [#uses=1]
  %1184 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1185 = add i32 %1183, %1184                    ; <i32> [#uses=1]
  %1186 = add i32 %1185, -1894986606              ; <i32> [#uses=1]
  store i32 %1186, i32* %D, align 4
  %1187 = load i32* %D, align 4                   ; <i32> [#uses=2]
  %1188 = lshr i32 %1187, 22                      ; <i32> [#uses=1]
  %1189 = shl i32 %1187, 10                       ; <i32> [#uses=1]
  %1190 = or i32 %1188, %1189                     ; <i32> [#uses=1]
  store i32 %1190, i32* %D, align 4
  %1191 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1192 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1193 = add i32 %1191, %1192                    ; <i32> [#uses=1]
  store i32 %1193, i32* %D, align 4
  %1194 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %not15 = xor i32 %1194, -1                      ; <i32> [#uses=1]
  %1195 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1196 = or i32 %not15, %1195                    ; <i32> [#uses=1]
  %1197 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1198 = xor i32 %1196, %1197                    ; <i32> [#uses=1]
  %1199 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 10 ; <i32*> [#uses=1]
  %1200 = load i32* %1199, align 4                ; <i32> [#uses=1]
  %1201 = add i32 %1198, %1200                    ; <i32> [#uses=1]
  %1202 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1203 = add i32 %1201, %1202                    ; <i32> [#uses=1]
  %1204 = add i32 %1203, -1051523                 ; <i32> [#uses=1]
  store i32 %1204, i32* %C, align 4
  %1205 = load i32* %C, align 4                   ; <i32> [#uses=2]
  %1206 = lshr i32 %1205, 17                      ; <i32> [#uses=1]
  %1207 = shl i32 %1205, 15                       ; <i32> [#uses=1]
  %1208 = or i32 %1206, %1207                     ; <i32> [#uses=1]
  store i32 %1208, i32* %C, align 4
  %1209 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1210 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1211 = add i32 %1209, %1210                    ; <i32> [#uses=1]
  store i32 %1211, i32* %C, align 4
  %1212 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %not17 = xor i32 %1212, -1                      ; <i32> [#uses=1]
  %1213 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1214 = or i32 %not17, %1213                    ; <i32> [#uses=1]
  %1215 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1216 = xor i32 %1214, %1215                    ; <i32> [#uses=1]
  %1217 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 1 ; <i32*> [#uses=1]
  %1218 = load i32* %1217, align 4                ; <i32> [#uses=1]
  %1219 = add i32 %1216, %1218                    ; <i32> [#uses=1]
  %1220 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1221 = add i32 %1219, %1220                    ; <i32> [#uses=1]
  %1222 = add i32 %1221, -2054922799              ; <i32> [#uses=1]
  store i32 %1222, i32* %B, align 4
  %1223 = load i32* %B, align 4                   ; <i32> [#uses=2]
  %1224 = lshr i32 %1223, 11                      ; <i32> [#uses=1]
  %1225 = shl i32 %1223, 21                       ; <i32> [#uses=1]
  %1226 = or i32 %1224, %1225                     ; <i32> [#uses=1]
  store i32 %1226, i32* %B, align 4
  %1227 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1228 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1229 = add i32 %1227, %1228                    ; <i32> [#uses=1]
  store i32 %1229, i32* %B, align 4
  %1230 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %not19 = xor i32 %1230, -1                      ; <i32> [#uses=1]
  %1231 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1232 = or i32 %not19, %1231                    ; <i32> [#uses=1]
  %1233 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1234 = xor i32 %1232, %1233                    ; <i32> [#uses=1]
  %1235 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 8 ; <i32*> [#uses=1]
  %1236 = load i32* %1235, align 4                ; <i32> [#uses=1]
  %1237 = add i32 %1234, %1236                    ; <i32> [#uses=1]
  %1238 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1239 = add i32 %1237, %1238                    ; <i32> [#uses=1]
  %1240 = add i32 %1239, 1873313359               ; <i32> [#uses=1]
  store i32 %1240, i32* %A, align 4
  %1241 = load i32* %A, align 4                   ; <i32> [#uses=2]
  %1242 = lshr i32 %1241, 26                      ; <i32> [#uses=1]
  %1243 = shl i32 %1241, 6                        ; <i32> [#uses=1]
  %1244 = or i32 %1242, %1243                     ; <i32> [#uses=1]
  store i32 %1244, i32* %A, align 4
  %1245 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1246 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1247 = add i32 %1245, %1246                    ; <i32> [#uses=1]
  store i32 %1247, i32* %A, align 4
  %1248 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %not21 = xor i32 %1248, -1                      ; <i32> [#uses=1]
  %1249 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1250 = or i32 %not21, %1249                    ; <i32> [#uses=1]
  %1251 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1252 = xor i32 %1250, %1251                    ; <i32> [#uses=1]
  %1253 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 15 ; <i32*> [#uses=1]
  %1254 = load i32* %1253, align 4                ; <i32> [#uses=1]
  %1255 = add i32 %1252, %1254                    ; <i32> [#uses=1]
  %1256 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1257 = add i32 %1255, %1256                    ; <i32> [#uses=1]
  %1258 = add i32 %1257, -30611744                ; <i32> [#uses=1]
  store i32 %1258, i32* %D, align 4
  %1259 = load i32* %D, align 4                   ; <i32> [#uses=2]
  %1260 = lshr i32 %1259, 22                      ; <i32> [#uses=1]
  %1261 = shl i32 %1259, 10                       ; <i32> [#uses=1]
  %1262 = or i32 %1260, %1261                     ; <i32> [#uses=1]
  store i32 %1262, i32* %D, align 4
  %1263 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1264 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1265 = add i32 %1263, %1264                    ; <i32> [#uses=1]
  store i32 %1265, i32* %D, align 4
  %1266 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %not23 = xor i32 %1266, -1                      ; <i32> [#uses=1]
  %1267 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1268 = or i32 %not23, %1267                    ; <i32> [#uses=1]
  %1269 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1270 = xor i32 %1268, %1269                    ; <i32> [#uses=1]
  %1271 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 6 ; <i32*> [#uses=1]
  %1272 = load i32* %1271, align 4                ; <i32> [#uses=1]
  %1273 = add i32 %1270, %1272                    ; <i32> [#uses=1]
  %1274 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1275 = add i32 %1273, %1274                    ; <i32> [#uses=1]
  %1276 = add i32 %1275, -1560198380              ; <i32> [#uses=1]
  store i32 %1276, i32* %C, align 4
  %1277 = load i32* %C, align 4                   ; <i32> [#uses=2]
  %1278 = lshr i32 %1277, 17                      ; <i32> [#uses=1]
  %1279 = shl i32 %1277, 15                       ; <i32> [#uses=1]
  %1280 = or i32 %1278, %1279                     ; <i32> [#uses=1]
  store i32 %1280, i32* %C, align 4
  %1281 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1282 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1283 = add i32 %1281, %1282                    ; <i32> [#uses=1]
  store i32 %1283, i32* %C, align 4
  %1284 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %not25 = xor i32 %1284, -1                      ; <i32> [#uses=1]
  %1285 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1286 = or i32 %not25, %1285                    ; <i32> [#uses=1]
  %1287 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1288 = xor i32 %1286, %1287                    ; <i32> [#uses=1]
  %1289 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 13 ; <i32*> [#uses=1]
  %1290 = load i32* %1289, align 4                ; <i32> [#uses=1]
  %1291 = add i32 %1288, %1290                    ; <i32> [#uses=1]
  %1292 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1293 = add i32 %1291, %1292                    ; <i32> [#uses=1]
  %1294 = add i32 %1293, 1309151649               ; <i32> [#uses=1]
  store i32 %1294, i32* %B, align 4
  %1295 = load i32* %B, align 4                   ; <i32> [#uses=2]
  %1296 = lshr i32 %1295, 11                      ; <i32> [#uses=1]
  %1297 = shl i32 %1295, 21                       ; <i32> [#uses=1]
  %1298 = or i32 %1296, %1297                     ; <i32> [#uses=1]
  store i32 %1298, i32* %B, align 4
  %1299 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1300 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1301 = add i32 %1299, %1300                    ; <i32> [#uses=1]
  store i32 %1301, i32* %B, align 4
  %1302 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %not27 = xor i32 %1302, -1                      ; <i32> [#uses=1]
  %1303 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1304 = or i32 %not27, %1303                    ; <i32> [#uses=1]
  %1305 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1306 = xor i32 %1304, %1305                    ; <i32> [#uses=1]
  %1307 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 4 ; <i32*> [#uses=1]
  %1308 = load i32* %1307, align 4                ; <i32> [#uses=1]
  %1309 = add i32 %1306, %1308                    ; <i32> [#uses=1]
  %1310 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1311 = add i32 %1309, %1310                    ; <i32> [#uses=1]
  %1312 = add i32 %1311, -145523070               ; <i32> [#uses=1]
  store i32 %1312, i32* %A, align 4
  %1313 = load i32* %A, align 4                   ; <i32> [#uses=2]
  %1314 = lshr i32 %1313, 26                      ; <i32> [#uses=1]
  %1315 = shl i32 %1313, 6                        ; <i32> [#uses=1]
  %1316 = or i32 %1314, %1315                     ; <i32> [#uses=1]
  store i32 %1316, i32* %A, align 4
  %1317 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1318 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1319 = add i32 %1317, %1318                    ; <i32> [#uses=1]
  store i32 %1319, i32* %A, align 4
  %1320 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %not29 = xor i32 %1320, -1                      ; <i32> [#uses=1]
  %1321 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1322 = or i32 %not29, %1321                    ; <i32> [#uses=1]
  %1323 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1324 = xor i32 %1322, %1323                    ; <i32> [#uses=1]
  %1325 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 11 ; <i32*> [#uses=1]
  %1326 = load i32* %1325, align 4                ; <i32> [#uses=1]
  %1327 = add i32 %1324, %1326                    ; <i32> [#uses=1]
  %1328 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1329 = add i32 %1327, %1328                    ; <i32> [#uses=1]
  %1330 = add i32 %1329, -1120210379              ; <i32> [#uses=1]
  store i32 %1330, i32* %D, align 4
  %1331 = load i32* %D, align 4                   ; <i32> [#uses=2]
  %1332 = lshr i32 %1331, 22                      ; <i32> [#uses=1]
  %1333 = shl i32 %1331, 10                       ; <i32> [#uses=1]
  %1334 = or i32 %1332, %1333                     ; <i32> [#uses=1]
  store i32 %1334, i32* %D, align 4
  %1335 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1336 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1337 = add i32 %1335, %1336                    ; <i32> [#uses=1]
  store i32 %1337, i32* %D, align 4
  %1338 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %not31 = xor i32 %1338, -1                      ; <i32> [#uses=1]
  %1339 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1340 = or i32 %not31, %1339                    ; <i32> [#uses=1]
  %1341 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1342 = xor i32 %1340, %1341                    ; <i32> [#uses=1]
  %1343 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 2 ; <i32*> [#uses=1]
  %1344 = load i32* %1343, align 4                ; <i32> [#uses=1]
  %1345 = add i32 %1342, %1344                    ; <i32> [#uses=1]
  %1346 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1347 = add i32 %1345, %1346                    ; <i32> [#uses=1]
  %1348 = add i32 %1347, 718787259                ; <i32> [#uses=1]
  store i32 %1348, i32* %C, align 4
  %1349 = load i32* %C, align 4                   ; <i32> [#uses=2]
  %1350 = lshr i32 %1349, 17                      ; <i32> [#uses=1]
  %1351 = shl i32 %1349, 15                       ; <i32> [#uses=1]
  %1352 = or i32 %1350, %1351                     ; <i32> [#uses=1]
  store i32 %1352, i32* %C, align 4
  %1353 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1354 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1355 = add i32 %1353, %1354                    ; <i32> [#uses=1]
  store i32 %1355, i32* %C, align 4
  %1356 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %not33 = xor i32 %1356, -1                      ; <i32> [#uses=1]
  %1357 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1358 = or i32 %not33, %1357                    ; <i32> [#uses=1]
  %1359 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1360 = xor i32 %1358, %1359                    ; <i32> [#uses=1]
  %1361 = getelementptr inbounds [16 x i32]* %correct_words, i32 0, i32 9 ; <i32*> [#uses=1]
  %1362 = load i32* %1361, align 4                ; <i32> [#uses=1]
  %1363 = add i32 %1360, %1362                    ; <i32> [#uses=1]
  %1364 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1365 = add i32 %1363, %1364                    ; <i32> [#uses=1]
  %1366 = add i32 %1365, -343485551               ; <i32> [#uses=1]
  store i32 %1366, i32* %B, align 4
  %1367 = load i32* %B, align 4                   ; <i32> [#uses=2]
  %1368 = lshr i32 %1367, 11                      ; <i32> [#uses=1]
  %1369 = shl i32 %1367, 21                       ; <i32> [#uses=1]
  %1370 = or i32 %1368, %1369                     ; <i32> [#uses=1]
  store i32 %1370, i32* %B, align 4
  %1371 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1372 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1373 = add i32 %1371, %1372                    ; <i32> [#uses=1]
  store i32 %1373, i32* %B, align 4
  %1374 = load i32* %A, align 4                   ; <i32> [#uses=1]
  %1375 = load i32* %A_save, align 4              ; <i32> [#uses=1]
  %1376 = add i32 %1374, %1375                    ; <i32> [#uses=1]
  store i32 %1376, i32* %A, align 4
  %1377 = load i32* %B, align 4                   ; <i32> [#uses=1]
  %1378 = load i32* %B_save, align 4              ; <i32> [#uses=1]
  %1379 = add i32 %1377, %1378                    ; <i32> [#uses=1]
  store i32 %1379, i32* %B, align 4
  %1380 = load i32* %C, align 4                   ; <i32> [#uses=1]
  %1381 = load i32* %C_save, align 4              ; <i32> [#uses=1]
  %1382 = add i32 %1380, %1381                    ; <i32> [#uses=1]
  store i32 %1382, i32* %C, align 4
  %1383 = load i32* %D, align 4                   ; <i32> [#uses=1]
  %1384 = load i32* %D_save, align 4              ; <i32> [#uses=1]
  %1385 = add i32 %1383, %1384                    ; <i32> [#uses=1]
  store i32 %1385, i32* %D, align 4
  br label %bb35

bb35:                                             ; preds = %bb2, %bb1
  %1386 = load i32** %words, align 4              ; <i32*> [#uses=1]
  %1387 = load i32** %endp, align 4               ; <i32*> [#uses=1]
  %1388 = icmp ult i32* %1386, %1387              ; <i1> [#uses=1]
  br i1 %1388, label %bb2, label %bb36

bb36:                                             ; preds = %bb35
  %1389 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %1390 = getelementptr inbounds %struct.md5_ctx* %1389, i32 0, i32 0 ; <i32*> [#uses=1]
  %1391 = load i32* %A, align 4                   ; <i32> [#uses=1]
  store i32 %1391, i32* %1390, align 4
  %1392 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %1393 = getelementptr inbounds %struct.md5_ctx* %1392, i32 0, i32 1 ; <i32*> [#uses=1]
  %1394 = load i32* %B, align 4                   ; <i32> [#uses=1]
  store i32 %1394, i32* %1393, align 4
  %1395 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %1396 = getelementptr inbounds %struct.md5_ctx* %1395, i32 0, i32 2 ; <i32*> [#uses=1]
  %1397 = load i32* %C, align 4                   ; <i32> [#uses=1]
  store i32 %1397, i32* %1396, align 4
  %1398 = load %struct.md5_ctx** %ctx_addr, align 4 ; <%struct.md5_ctx*> [#uses=1]
  %1399 = getelementptr inbounds %struct.md5_ctx* %1398, i32 0, i32 3 ; <i32*> [#uses=1]
  %1400 = load i32* %D, align 4                   ; <i32> [#uses=1]
  store i32 %1400, i32* %1399, align 4
  br label %return

return:                                           ; preds = %bb36
  ret void
}

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %argc_addr = alloca i32                         ; <i32*> [#uses=1]
  %argv_addr = alloca i8**                        ; <i8***> [#uses=1]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %i = alloca i32                                 ; <i32*> [#uses=5]
  %result = alloca [16 x i8]                      ; <[16 x i8]*> [#uses=2]
  %ctx = alloca %struct.md5_ctx                   ; <%struct.md5_ctx*> [#uses=3]
  %buffer = alloca [1000 x i8]                    ; <[1000 x i8]*> [#uses=3]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 %argc, i32* %argc_addr
  store i8** %argv, i8*** %argv_addr
  %buffer1 = bitcast [1000 x i8]* %buffer to i8*  ; <i8*> [#uses=1]
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([7 x i8]* @.str, i32 0, i32 0), i8* %buffer1) nounwind ; <i32> [#uses=0]
  call void @md5_init_ctx(%struct.md5_ctx* %ctx) nounwind
  %buffer2 = bitcast [1000 x i8]* %buffer to i8*  ; <i8*> [#uses=1]
  %2 = call i32 @strlen(i8* %buffer2) nounwind readonly ; <i32> [#uses=1]
  %buffer3 = bitcast [1000 x i8]* %buffer to i8*  ; <i8*> [#uses=1]
  call void @md5_process_bytes(i8* %buffer3, i32 %2, %struct.md5_ctx* %ctx) nounwind
  %result4 = bitcast [16 x i8]* %result to i8*    ; <i8*> [#uses=1]
  %3 = call i8* @md5_finish_ctx(%struct.md5_ctx* %ctx, i8* %result4) nounwind ; <i8*> [#uses=0]
  store i32 0, i32* %i, align 4
  br label %bb5

bb:                                               ; preds = %bb5
  %4 = load i32* %i, align 4                      ; <i32> [#uses=1]
  %5 = getelementptr inbounds [16 x i8]* %result, i32 0, i32 %4 ; <i8*> [#uses=1]
  %6 = load i8* %5, align 1                       ; <i8> [#uses=1]
  %7 = sext i8 %6 to i32                          ; <i32> [#uses=1]
  %8 = and i32 %7, 255                            ; <i32> [#uses=1]
  %9 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([5 x i8]* @.str1, i32 0, i32 0), i32 %8) nounwind ; <i32> [#uses=0]
  %10 = load i32* %i, align 4                     ; <i32> [#uses=1]
  %11 = add nsw i32 %10, 1                        ; <i32> [#uses=1]
  store i32 %11, i32* %i, align 4
  br label %bb5

bb5:                                              ; preds = %bb, %entry
  %12 = load i32* %i, align 4                     ; <i32> [#uses=1]
  %13 = icmp sle i32 %12, 15                      ; <i1> [#uses=1]
  br i1 %13, label %bb, label %bb6

bb6:                                              ; preds = %bb5
  %14 = call i32 @putchar(i32 10) nounwind        ; <i32> [#uses=0]
  store i32 0, i32* %0, align 4
  %15 = load i32* %0, align 4                     ; <i32> [#uses=1]
  store i32 %15, i32* %retval, align 4
  br label %return

return:                                           ; preds = %bb6
  %retval7 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval7
}

declare i32 @"\01__isoc99_scanf"(i8* noalias, ...) nounwind

declare i32 @strlen(i8*) nounwind readonly

declare i32 @printf(i8* noalias, ...) nounwind

declare i32 @putchar(i32)
