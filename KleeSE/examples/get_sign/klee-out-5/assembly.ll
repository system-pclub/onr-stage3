; ModuleID = 'get_sign.bc'
source_filename = "get_sign.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [2 x i8] c"a\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"klee_choose\00", align 1
@.str.1.2 = private unnamed_addr constant [67 x i8] c"/home/tzt77/Develop/KleeSE/runtime/Intrinsic/klee_div_zero_check.c\00", align 1
@.str.1.2.3 = private unnamed_addr constant [15 x i8] c"divide by zero\00", align 1
@.str.2 = private unnamed_addr constant [8 x i8] c"div.err\00", align 1
@.str.3 = private unnamed_addr constant [8 x i8] c"IGNORED\00", align 1
@.str.1.4 = private unnamed_addr constant [16 x i8] c"overshift error\00", align 1
@.str.2.5 = private unnamed_addr constant [14 x i8] c"overshift.err\00", align 1
@.str.6 = private unnamed_addr constant [58 x i8] c"/home/tzt77/Develop/KleeSE/runtime/Intrinsic/klee_range.c\00", align 1
@.str.1.7 = private unnamed_addr constant [14 x i8] c"invalid range\00", align 1
@.str.2.8 = private unnamed_addr constant [5 x i8] c"user\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @get_sign(i32 %x) #0 !dbg !27 {
entry:
  %retval = alloca i32, align 4
  %x.addr = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  %0 = load i32, i32* %x.addr, align 4, !dbg !31
  %cmp = icmp eq i32 %0, 0, !dbg !33
  br i1 %cmp, label %if.then, label %if.end, !dbg !34

if.then:                                          ; preds = %entry
  store i32 0, i32* %retval, align 4, !dbg !35
  br label %return, !dbg !35

if.end:                                           ; preds = %entry
  %1 = load i32, i32* %x.addr, align 4, !dbg !36
  %cmp1 = icmp slt i32 %1, 0, !dbg !38
  br i1 %cmp1, label %if.then2, label %if.else, !dbg !39

if.then2:                                         ; preds = %if.end
  store i32 -1, i32* %retval, align 4, !dbg !40
  br label %return, !dbg !40

if.else:                                          ; preds = %if.end
  store i32 1, i32* %retval, align 4, !dbg !41
  br label %return, !dbg !41

return:                                           ; preds = %if.else, %if.then2, %if.then
  %2 = load i32, i32* %retval, align 4, !dbg !42
  ret i32 %2, !dbg !42
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !43 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %0 = bitcast i32* %a to i8*, !dbg !46
  call void @klee_make_symbolic(i8* %0, i64 4, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i32 0, i32 0)), !dbg !47
  %1 = load i32, i32* %a, align 4, !dbg !48
  %call = call i32 @get_sign(i32 %1), !dbg !49
  ret i32 %call, !dbg !50
}

declare void @klee_make_symbolic(i8*, i64, i8*) #2

; Function Attrs: nounwind uwtable
define i64 @klee_choose(i64 %n) local_unnamed_addr #3 !dbg !51 {
entry:
  %x = alloca i64, align 8
  %0 = bitcast i64* %x to i8*, !dbg !60
  call void @klee_make_symbolic(i8* nonnull %0, i64 8, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i64 0, i64 0)) #7, !dbg !61
  %1 = load i64, i64* %x, align 8, !dbg !62, !tbaa !64
  %cmp = icmp ult i64 %1, %n, !dbg !68
  br i1 %cmp, label %if.end, label %if.then, !dbg !69

if.then:                                          ; preds = %entry
  call void @klee_silent_exit(i32 0) #8, !dbg !70
  unreachable, !dbg !70

if.end:                                           ; preds = %entry
  ret i64 %1, !dbg !71
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #4

; Function Attrs: noreturn
declare void @klee_silent_exit(i32) local_unnamed_addr #5

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #4

; Function Attrs: nounwind uwtable
define void @klee_div_zero_check(i64 %z) local_unnamed_addr #3 !dbg !72 {
entry:
  %cmp = icmp eq i64 %z, 0, !dbg !78
  br i1 %cmp, label %if.then, label %if.end, !dbg !80

if.then:                                          ; preds = %entry
  tail call void @klee_report_error(i8* getelementptr inbounds ([67 x i8], [67 x i8]* @.str.1.2, i64 0, i64 0), i32 14, i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.1.2.3, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2,
  unreachable, !dbg !81

if.end:                                           ; preds = %entry
  ret void, !dbg !82
}

; Function Attrs: noreturn
declare void @klee_report_error(i8*, i32, i8*, i8*) local_unnamed_addr #5

; Function Attrs: nounwind uwtable
define i32 @klee_int(i8* %name) local_unnamed_addr #3 !dbg !83 {
entry:
  %x = alloca i32, align 4
  %0 = bitcast i32* %x to i8*, !dbg !92
  call void @klee_make_symbolic(i8* nonnull %0, i64 4, i8* %name) #7, !dbg !93
  %1 = load i32, i32* %x, align 4, !dbg !94, !tbaa !95
  ret i32 %1, !dbg !97
}

; Function Attrs: nounwind uwtable
define void @klee_overshift_check(i64 %bitWidth, i64 %shift) local_unnamed_addr #3 !dbg !98 {
entry:
  %cmp = icmp ult i64 %shift, %bitWidth, !dbg !105
  br i1 %cmp, label %if.end, label %if.then, !dbg !107

if.then:                                          ; preds = %entry
  tail call void @klee_report_error(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.3, i64 0, i64 0), i32 0, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1.4, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.2.5, i6
  unreachable, !dbg !108

if.end:                                           ; preds = %entry
  ret void, !dbg !110
}

; Function Attrs: nounwind uwtable
define i32 @klee_range(i32 %start, i32 %end, i8* %name) local_unnamed_addr #3 !dbg !111 {
entry:
  %x = alloca i32, align 4
  %0 = bitcast i32* %x to i8*, !dbg !119
  %cmp = icmp slt i32 %start, %end, !dbg !120
  br i1 %cmp, label %if.end, label %if.then, !dbg !122

if.then:                                          ; preds = %entry
  tail call void @klee_report_error(i8* getelementptr inbounds ([58 x i8], [58 x i8]* @.str.6, i64 0, i64 0), i32 17, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1.7, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2.8, i
  unreachable, !dbg !123

if.end:                                           ; preds = %entry
  %add = add nsw i32 %start, 1, !dbg !124
  %cmp1 = icmp eq i32 %add, %end, !dbg !126
  br i1 %cmp1, label %cleanup, label %if.else, !dbg !127

if.else:                                          ; preds = %if.end
  call void @klee_make_symbolic(i8* nonnull %0, i64 4, i8* %name) #7, !dbg !128
  %cmp3 = icmp eq i32 %start, 0, !dbg !130
  %1 = load i32, i32* %x, align 4, !tbaa !95
  br i1 %cmp3, label %if.then4, label %if.else7, !dbg !132

if.then4:                                         ; preds = %if.else
  %cmp5 = icmp ult i32 %1, %end, !dbg !133
  %conv6 = zext i1 %cmp5 to i64, !dbg !135
  call void @klee_assume(i64 %conv6) #7, !dbg !136
  br label %if.end14, !dbg !137

if.else7:                                         ; preds = %if.else
  %cmp8 = icmp sge i32 %1, %start, !dbg !138
  %conv10 = zext i1 %cmp8 to i64, !dbg !140
  call void @klee_assume(i64 %conv10) #7, !dbg !141
  %2 = load i32, i32* %x, align 4, !dbg !142, !tbaa !95
  %cmp11 = icmp slt i32 %2, %end, !dbg !143
  %conv13 = zext i1 %cmp11 to i64, !dbg !142
  call void @klee_assume(i64 %conv13) #7, !dbg !144
  br label %if.end14

if.end14:                                         ; preds = %if.else7, %if.then4
  %3 = load i32, i32* %x, align 4, !dbg !145, !tbaa !95
  br label %cleanup, !dbg !146

cleanup:                                          ; preds = %if.end, %if.end14
  %retval.0 = phi i32 [ %3, %if.end14 ], [ %start, %if.end ]
  ret i32 %retval.0, !dbg !147
}

declare void @klee_assume(i64) local_unnamed_addr #6

; Function Attrs: nounwind uwtable
define weak i8* @memcpy(i8* %destaddr, i8* %srcaddr, i64 %len) local_unnamed_addr #3 !dbg !148 {
entry:
  %cmp5 = icmp eq i64 %len, 0, !dbg !163
  br i1 %cmp5, label %while.end, label %while.body.lr.ph, !dbg !164

while.body.lr.ph:                                 ; preds = %entry
  %min.iters.check = icmp ult i64 %len, 32, !dbg !164
  br i1 %min.iters.check, label %while.body.preheader, label %vector.memcheck, !dbg !164

vector.memcheck:                                  ; preds = %while.body.lr.ph
  %scevgep = getelementptr i8, i8* %destaddr, i64 %len, !dbg !164
  %scevgep9 = getelementptr i8, i8* %srcaddr, i64 %len, !dbg !164
  %bound0 = icmp ugt i8* %scevgep9, %destaddr, !dbg !164
  %bound1 = icmp ugt i8* %scevgep, %srcaddr, !dbg !164
  %memcheck.conflict = and i1 %bound0, %bound1, !dbg !164
  br i1 %memcheck.conflict, label %while.body.preheader, label %vector.ph, !dbg !164

vector.ph:                                        ; preds = %vector.memcheck
  %n.vec = and i64 %len, -32, !dbg !164
  %ind.end = getelementptr i8, i8* %srcaddr, i64 %n.vec, !dbg !164
  %ind.end11 = getelementptr i8, i8* %destaddr, i64 %n.vec, !dbg !164
  %ind.end13 = sub i64 %len, %n.vec, !dbg !164
  %0 = add i64 %n.vec, -32, !dbg !164
  %1 = lshr exact i64 %0, 5, !dbg !164
  %2 = add nuw nsw i64 %1, 1, !dbg !164
  %xtraiter19 = and i64 %2, 3, !dbg !164
  %3 = icmp ult i64 %0, 96, !dbg !164
  br i1 %3, label %middle.block.unr-lcssa, label %vector.ph.new, !dbg !164

vector.ph.new:                                    ; preds = %vector.ph
  %unroll_iter = sub nsw i64 %2, %xtraiter19, !dbg !164
  br label %vector.body, !dbg !164

vector.body:                                      ; preds = %vector.body, %vector.ph.new
  %index = phi i64 [ 0, %vector.ph.new ], [ %index.next.3, %vector.body ]
  %niter = phi i64 [ %unroll_iter, %vector.ph.new ], [ %niter.nsub.3, %vector.body ]
  %next.gep = getelementptr i8, i8* %srcaddr, i64 %index
  %next.gep15 = getelementptr i8, i8* %destaddr, i64 %index
  %4 = bitcast i8* %next.gep to <16 x i8>*, !dbg !165
  %wide.load = load <16 x i8>, <16 x i8>* %4, align 1, !dbg !165, !tbaa !166, !alias.scope !167
  %5 = getelementptr i8, i8* %next.gep, i64 16, !dbg !165
  %6 = bitcast i8* %5 to <16 x i8>*, !dbg !165
  %wide.load18 = load <16 x i8>, <16 x i8>* %6, align 1, !dbg !165, !tbaa !166, !alias.scope !167
  %7 = bitcast i8* %next.gep15 to <16 x i8>*, !dbg !170
  store <16 x i8> %wide.load, <16 x i8>* %7, align 1, !dbg !170, !tbaa !166, !alias.scope !171, !noalias !167
  %8 = getelementptr i8, i8* %next.gep15, i64 16, !dbg !170
  %9 = bitcast i8* %8 to <16 x i8>*, !dbg !170
  store <16 x i8> %wide.load18, <16 x i8>* %9, align 1, !dbg !170, !tbaa !166, !alias.scope !171, !noalias !167
  %index.next = or i64 %index, 32
  %next.gep.1 = getelementptr i8, i8* %srcaddr, i64 %index.next
  %next.gep15.1 = getelementptr i8, i8* %destaddr, i64 %index.next
  %10 = bitcast i8* %next.gep.1 to <16 x i8>*, !dbg !165
  %wide.load.1 = load <16 x i8>, <16 x i8>* %10, align 1, !dbg !165, !tbaa !166, !alias.scope !167
  %11 = getelementptr i8, i8* %next.gep.1, i64 16, !dbg !165
  %12 = bitcast i8* %11 to <16 x i8>*, !dbg !165
  %wide.load18.1 = load <16 x i8>, <16 x i8>* %12, align 1, !dbg !165, !tbaa !166, !alias.scope !167
  %13 = bitcast i8* %next.gep15.1 to <16 x i8>*, !dbg !170
  store <16 x i8> %wide.load.1, <16 x i8>* %13, align 1, !dbg !170, !tbaa !166, !alias.scope !171, !noalias !167
  %14 = getelementptr i8, i8* %next.gep15.1, i64 16, !dbg !170
  %15 = bitcast i8* %14 to <16 x i8>*, !dbg !170
  store <16 x i8> %wide.load18.1, <16 x i8>* %15, align 1, !dbg !170, !tbaa !166, !alias.scope !171, !noalias !167
  %index.next.1 = or i64 %index, 64
  %next.gep.2 = getelementptr i8, i8* %srcaddr, i64 %index.next.1
  %next.gep15.2 = getelementptr i8, i8* %destaddr, i64 %index.next.1
  %16 = bitcast i8* %next.gep.2 to <16 x i8>*, !dbg !165
  %wide.load.2 = load <16 x i8>, <16 x i8>* %16, align 1, !dbg !165, !tbaa !166, !alias.scope !167
  %17 = getelementptr i8, i8* %next.gep.2, i64 16, !dbg !165
  %18 = bitcast i8* %17 to <16 x i8>*, !dbg !165
  %wide.load18.2 = load <16 x i8>, <16 x i8>* %18, align 1, !dbg !165, !tbaa !166, !alias.scope !167
  %19 = bitcast i8* %next.gep15.2 to <16 x i8>*, !dbg !170
  store <16 x i8> %wide.load.2, <16 x i8>* %19, align 1, !dbg !170, !tbaa !166, !alias.scope !171, !noalias !167
  %20 = getelementptr i8, i8* %next.gep15.2, i64 16, !dbg !170
  %21 = bitcast i8* %20 to <16 x i8>*, !dbg !170
  store <16 x i8> %wide.load18.2, <16 x i8>* %21, align 1, !dbg !170, !tbaa !166, !alias.scope !171, !noalias !167
  %index.next.2 = or i64 %index, 96
  %next.gep.3 = getelementptr i8, i8* %srcaddr, i64 %index.next.2
  %next.gep15.3 = getelementptr i8, i8* %destaddr, i64 %index.next.2
  %22 = bitcast i8* %next.gep.3 to <16 x i8>*, !dbg !165
  %wide.load.3 = load <16 x i8>, <16 x i8>* %22, align 1, !dbg !165, !tbaa !166, !alias.scope !167
  %23 = getelementptr i8, i8* %next.gep.3, i64 16, !dbg !165
  %24 = bitcast i8* %23 to <16 x i8>*, !dbg !165
  %wide.load18.3 = load <16 x i8>, <16 x i8>* %24, align 1, !dbg !165, !tbaa !166, !alias.scope !167
  %25 = bitcast i8* %next.gep15.3 to <16 x i8>*, !dbg !170
  store <16 x i8> %wide.load.3, <16 x i8>* %25, align 1, !dbg !170, !tbaa !166, !alias.scope !171, !noalias !167
  %26 = getelementptr i8, i8* %next.gep15.3, i64 16, !dbg !170
  %27 = bitcast i8* %26 to <16 x i8>*, !dbg !170
  store <16 x i8> %wide.load18.3, <16 x i8>* %27, align 1, !dbg !170, !tbaa !166, !alias.scope !171, !noalias !167
  %index.next.3 = add i64 %index, 128
  %niter.nsub.3 = add i64 %niter, -4
  %niter.ncmp.3 = icmp eq i64 %niter.nsub.3, 0
  br i1 %niter.ncmp.3, label %middle.block.unr-lcssa, label %vector.body, !llvm.loop !173

middle.block.unr-lcssa:                           ; preds = %vector.body, %vector.ph
  %index.unr = phi i64 [ 0, %vector.ph ], [ %index.next.3, %vector.body ]
  %lcmp.mod20 = icmp eq i64 %xtraiter19, 0
  br i1 %lcmp.mod20, label %middle.block, label %vector.body.epil.preheader

vector.body.epil.preheader:                       ; preds = %middle.block.unr-lcssa
  br label %vector.body.epil

vector.body.epil:                                 ; preds = %vector.body.epil, %vector.body.epil.preheader
  %index.epil = phi i64 [ %index.unr, %vector.body.epil.preheader ], [ %index.next.epil, %vector.body.epil ]
  %epil.iter = phi i64 [ %xtraiter19, %vector.body.epil.preheader ], [ %epil.iter.sub, %vector.body.epil ]
  %next.gep.epil = getelementptr i8, i8* %srcaddr, i64 %index.epil
  %next.gep15.epil = getelementptr i8, i8* %destaddr, i64 %index.epil
  %28 = bitcast i8* %next.gep.epil to <16 x i8>*, !dbg !165
  %wide.load.epil = load <16 x i8>, <16 x i8>* %28, align 1, !dbg !165, !tbaa !166, !alias.scope !167
  %29 = getelementptr i8, i8* %next.gep.epil, i64 16, !dbg !165
  %30 = bitcast i8* %29 to <16 x i8>*, !dbg !165
  %wide.load18.epil = load <16 x i8>, <16 x i8>* %30, align 1, !dbg !165, !tbaa !166, !alias.scope !167
  %31 = bitcast i8* %next.gep15.epil to <16 x i8>*, !dbg !170
  store <16 x i8> %wide.load.epil, <16 x i8>* %31, align 1, !dbg !170, !tbaa !166, !alias.scope !171, !noalias !167
  %32 = getelementptr i8, i8* %next.gep15.epil, i64 16, !dbg !170
  %33 = bitcast i8* %32 to <16 x i8>*, !dbg !170
  store <16 x i8> %wide.load18.epil, <16 x i8>* %33, align 1, !dbg !170, !tbaa !166, !alias.scope !171, !noalias !167
  %index.next.epil = add i64 %index.epil, 32
  %epil.iter.sub = add i64 %epil.iter, -1
  %epil.iter.cmp = icmp eq i64 %epil.iter.sub, 0
  br i1 %epil.iter.cmp, label %middle.block, label %vector.body.epil, !llvm.loop !177

middle.block:                                     ; preds = %vector.body.epil, %middle.block.unr-lcssa
  %cmp.n = icmp eq i64 %n.vec, %len
  br i1 %cmp.n, label %while.end, label %while.body.preheader, !dbg !164

while.body.preheader:                             ; preds = %middle.block, %vector.memcheck, %while.body.lr.ph
  %src.08.ph = phi i8* [ %srcaddr, %vector.memcheck ], [ %srcaddr, %while.body.lr.ph ], [ %ind.end, %middle.block ]
  %dest.07.ph = phi i8* [ %destaddr, %vector.memcheck ], [ %destaddr, %while.body.lr.ph ], [ %ind.end11, %middle.block ]
  %len.addr.06.ph = phi i64 [ %len, %vector.memcheck ], [ %len, %while.body.lr.ph ], [ %ind.end13, %middle.block ]
  %34 = add i64 %len.addr.06.ph, -1, !dbg !179
  %xtraiter = and i64 %len.addr.06.ph, 7, !dbg !179
  %lcmp.mod = icmp eq i64 %xtraiter, 0, !dbg !179
  br i1 %lcmp.mod, label %while.body.prol.loopexit, label %while.body.prol.preheader, !dbg !179

while.body.prol.preheader:                        ; preds = %while.body.preheader
  br label %while.body.prol, !dbg !179

while.body.prol:                                  ; preds = %while.body.prol, %while.body.prol.preheader
  %src.08.prol = phi i8* [ %incdec.ptr.prol, %while.body.prol ], [ %src.08.ph, %while.body.prol.preheader ]
  %dest.07.prol = phi i8* [ %incdec.ptr1.prol, %while.body.prol ], [ %dest.07.ph, %while.body.prol.preheader ]
  %len.addr.06.prol = phi i64 [ %dec.prol, %while.body.prol ], [ %len.addr.06.ph, %while.body.prol.preheader ]
  %prol.iter = phi i64 [ %prol.iter.sub, %while.body.prol ], [ %xtraiter, %while.body.prol.preheader ]
  %dec.prol = add i64 %len.addr.06.prol, -1, !dbg !179
  %incdec.ptr.prol = getelementptr inbounds i8, i8* %src.08.prol, i64 1, !dbg !174
  %35 = load i8, i8* %src.08.prol, align 1, !dbg !165, !tbaa !166
  %incdec.ptr1.prol = getelementptr inbounds i8, i8* %dest.07.prol, i64 1, !dbg !180
  store i8 %35, i8* %dest.07.prol, align 1, !dbg !170, !tbaa !166
  %prol.iter.sub = add i64 %prol.iter, -1, !dbg !164
  %prol.iter.cmp = icmp eq i64 %prol.iter.sub, 0, !dbg !164
  br i1 %prol.iter.cmp, label %while.body.prol.loopexit, label %while.body.prol, !dbg !164, !llvm.loop !181

while.body.prol.loopexit:                         ; preds = %while.body.prol, %while.body.preheader
  %src.08.unr = phi i8* [ %src.08.ph, %while.body.preheader ], [ %incdec.ptr.prol, %while.body.prol ]
  %dest.07.unr = phi i8* [ %dest.07.ph, %while.body.preheader ], [ %incdec.ptr1.prol, %while.body.prol ]
  %len.addr.06.unr = phi i64 [ %len.addr.06.ph, %while.body.preheader ], [ %dec.prol, %while.body.prol ]
  %36 = icmp ult i64 %34, 7, !dbg !179
  br i1 %36, label %while.end, label %while.body.preheader.new, !dbg !179

while.body.preheader.new:                         ; preds = %while.body.prol.loopexit
  br label %while.body, !dbg !179

while.body:                                       ; preds = %while.body, %while.body.preheader.new
  %src.08 = phi i8* [ %src.08.unr, %while.body.preheader.new ], [ %incdec.ptr.7, %while.body ]
  %dest.07 = phi i8* [ %dest.07.unr, %while.body.preheader.new ], [ %incdec.ptr1.7, %while.body ]
  %len.addr.06 = phi i64 [ %len.addr.06.unr, %while.body.preheader.new ], [ %dec.7, %while.body ]
  %incdec.ptr = getelementptr inbounds i8, i8* %src.08, i64 1, !dbg !174
  %37 = load i8, i8* %src.08, align 1, !dbg !165, !tbaa !166
  %incdec.ptr1 = getelementptr inbounds i8, i8* %dest.07, i64 1, !dbg !180
  store i8 %37, i8* %dest.07, align 1, !dbg !170, !tbaa !166
  %incdec.ptr.1 = getelementptr inbounds i8, i8* %src.08, i64 2, !dbg !174
  %38 = load i8, i8* %incdec.ptr, align 1, !dbg !165, !tbaa !166
  %incdec.ptr1.1 = getelementptr inbounds i8, i8* %dest.07, i64 2, !dbg !180
  store i8 %38, i8* %incdec.ptr1, align 1, !dbg !170, !tbaa !166
  %incdec.ptr.2 = getelementptr inbounds i8, i8* %src.08, i64 3, !dbg !174
  %39 = load i8, i8* %incdec.ptr.1, align 1, !dbg !165, !tbaa !166
  %incdec.ptr1.2 = getelementptr inbounds i8, i8* %dest.07, i64 3, !dbg !180
  store i8 %39, i8* %incdec.ptr1.1, align 1, !dbg !170, !tbaa !166
  %incdec.ptr.3 = getelementptr inbounds i8, i8* %src.08, i64 4, !dbg !174
  %40 = load i8, i8* %incdec.ptr.2, align 1, !dbg !165, !tbaa !166
  %incdec.ptr1.3 = getelementptr inbounds i8, i8* %dest.07, i64 4, !dbg !180
  store i8 %40, i8* %incdec.ptr1.2, align 1, !dbg !170, !tbaa !166
  %incdec.ptr.4 = getelementptr inbounds i8, i8* %src.08, i64 5, !dbg !174
  %41 = load i8, i8* %incdec.ptr.3, align 1, !dbg !165, !tbaa !166
  %incdec.ptr1.4 = getelementptr inbounds i8, i8* %dest.07, i64 5, !dbg !180
  store i8 %41, i8* %incdec.ptr1.3, align 1, !dbg !170, !tbaa !166
  %incdec.ptr.5 = getelementptr inbounds i8, i8* %src.08, i64 6, !dbg !174
  %42 = load i8, i8* %incdec.ptr.4, align 1, !dbg !165, !tbaa !166
  %incdec.ptr1.5 = getelementptr inbounds i8, i8* %dest.07, i64 6, !dbg !180
  store i8 %42, i8* %incdec.ptr1.4, align 1, !dbg !170, !tbaa !166
  %incdec.ptr.6 = getelementptr inbounds i8, i8* %src.08, i64 7, !dbg !174
  %43 = load i8, i8* %incdec.ptr.5, align 1, !dbg !165, !tbaa !166
  %incdec.ptr1.6 = getelementptr inbounds i8, i8* %dest.07, i64 7, !dbg !180
  store i8 %43, i8* %incdec.ptr1.5, align 1, !dbg !170, !tbaa !166
  %dec.7 = add i64 %len.addr.06, -8, !dbg !179
  %incdec.ptr.7 = getelementptr inbounds i8, i8* %src.08, i64 8, !dbg !174
  %44 = load i8, i8* %incdec.ptr.6, align 1, !dbg !165, !tbaa !166
  %incdec.ptr1.7 = getelementptr inbounds i8, i8* %dest.07, i64 8, !dbg !180
  store i8 %44, i8* %incdec.ptr1.6, align 1, !dbg !170, !tbaa !166
  %cmp.7 = icmp eq i64 %dec.7, 0, !dbg !163
  br i1 %cmp.7, label %while.end, label %while.body, !dbg !164, !llvm.loop !182

while.end:                                        ; preds = %while.body.prol.loopexit, %while.body, %middle.block, %entry
  ret i8* %destaddr, !dbg !183
}

; Function Attrs: nounwind uwtable
define weak i8* @memmove(i8* %dst, i8* %src, i64 %count) local_unnamed_addr #3 !dbg !184 {
entry:
  %cmp = icmp eq i8* %src, %dst, !dbg !191
  br i1 %cmp, label %cleanup, label %if.end, !dbg !193

if.end:                                           ; preds = %entry
  %cmp1 = icmp ugt i8* %src, %dst, !dbg !194
  br i1 %cmp1, label %if.then2, label %if.else, !dbg !196

if.then2:                                         ; preds = %if.end
  %tobool31 = icmp eq i64 %count, 0, !dbg !197
  br i1 %tobool31, label %cleanup, label %while.body.lr.ph, !dbg !197

while.body.lr.ph:                                 ; preds = %if.then2
  %min.iters.check58 = icmp ult i64 %count, 32, !dbg !197
  br i1 %min.iters.check58, label %while.body.preheader, label %vector.memcheck66, !dbg !197

vector.memcheck66:                                ; preds = %while.body.lr.ph
  %scevgep60 = getelementptr i8, i8* %dst, i64 %count, !dbg !197
  %scevgep61 = getelementptr i8, i8* %src, i64 %count, !dbg !197
  %bound062 = icmp ugt i8* %scevgep61, %dst, !dbg !197
  %bound163 = icmp ugt i8* %scevgep60, %src, !dbg !197
  %memcheck.conflict65 = and i1 %bound062, %bound163, !dbg !197
  br i1 %memcheck.conflict65, label %while.body.preheader, label %vector.ph67, !dbg !197

vector.ph67:                                      ; preds = %vector.memcheck66
  %n.vec69 = and i64 %count, -32, !dbg !197
  %ind.end73 = getelementptr i8, i8* %src, i64 %n.vec69, !dbg !197
  %ind.end75 = getelementptr i8, i8* %dst, i64 %n.vec69, !dbg !197
  %ind.end77 = sub i64 %count, %n.vec69, !dbg !197
  %0 = add i64 %n.vec69, -32, !dbg !197
  %1 = lshr exact i64 %0, 5, !dbg !197
  %2 = add nuw nsw i64 %1, 1, !dbg !197
  %xtraiter93 = and i64 %2, 3, !dbg !197
  %3 = icmp ult i64 %0, 96, !dbg !197
  br i1 %3, label %middle.block56.unr-lcssa, label %vector.ph67.new, !dbg !197

vector.ph67.new:                                  ; preds = %vector.ph67
  %unroll_iter = sub nsw i64 %2, %xtraiter93, !dbg !197
  br label %vector.body55, !dbg !197

vector.body55:                                    ; preds = %vector.body55, %vector.ph67.new
  %index70 = phi i64 [ 0, %vector.ph67.new ], [ %index.next71.3, %vector.body55 ]
  %niter = phi i64 [ %unroll_iter, %vector.ph67.new ], [ %niter.nsub.3, %vector.body55 ]
  %next.gep79 = getelementptr i8, i8* %src, i64 %index70
  %next.gep81 = getelementptr i8, i8* %dst, i64 %index70
  %4 = bitcast i8* %next.gep79 to <16 x i8>*, !dbg !199
  %wide.load88 = load <16 x i8>, <16 x i8>* %4, align 1, !dbg !199, !tbaa !166, !alias.scope !200
  %5 = getelementptr i8, i8* %next.gep79, i64 16, !dbg !199
  %6 = bitcast i8* %5 to <16 x i8>*, !dbg !199
  %wide.load89 = load <16 x i8>, <16 x i8>* %6, align 1, !dbg !199, !tbaa !166, !alias.scope !200
  %7 = bitcast i8* %next.gep81 to <16 x i8>*, !dbg !203
  store <16 x i8> %wide.load88, <16 x i8>* %7, align 1, !dbg !203, !tbaa !166, !alias.scope !204, !noalias !200
  %8 = getelementptr i8, i8* %next.gep81, i64 16, !dbg !203
  %9 = bitcast i8* %8 to <16 x i8>*, !dbg !203
  store <16 x i8> %wide.load89, <16 x i8>* %9, align 1, !dbg !203, !tbaa !166, !alias.scope !204, !noalias !200
  %index.next71 = or i64 %index70, 32
  %next.gep79.1 = getelementptr i8, i8* %src, i64 %index.next71
  %next.gep81.1 = getelementptr i8, i8* %dst, i64 %index.next71
  %10 = bitcast i8* %next.gep79.1 to <16 x i8>*, !dbg !199
  %wide.load88.1 = load <16 x i8>, <16 x i8>* %10, align 1, !dbg !199, !tbaa !166, !alias.scope !200
  %11 = getelementptr i8, i8* %next.gep79.1, i64 16, !dbg !199
  %12 = bitcast i8* %11 to <16 x i8>*, !dbg !199
  %wide.load89.1 = load <16 x i8>, <16 x i8>* %12, align 1, !dbg !199, !tbaa !166, !alias.scope !200
  %13 = bitcast i8* %next.gep81.1 to <16 x i8>*, !dbg !203
  store <16 x i8> %wide.load88.1, <16 x i8>* %13, align 1, !dbg !203, !tbaa !166, !alias.scope !204, !noalias !200
  %14 = getelementptr i8, i8* %next.gep81.1, i64 16, !dbg !203
  %15 = bitcast i8* %14 to <16 x i8>*, !dbg !203
  store <16 x i8> %wide.load89.1, <16 x i8>* %15, align 1, !dbg !203, !tbaa !166, !alias.scope !204, !noalias !200
  %index.next71.1 = or i64 %index70, 64
  %next.gep79.2 = getelementptr i8, i8* %src, i64 %index.next71.1
  %next.gep81.2 = getelementptr i8, i8* %dst, i64 %index.next71.1
  %16 = bitcast i8* %next.gep79.2 to <16 x i8>*, !dbg !199
  %wide.load88.2 = load <16 x i8>, <16 x i8>* %16, align 1, !dbg !199, !tbaa !166, !alias.scope !200
  %17 = getelementptr i8, i8* %next.gep79.2, i64 16, !dbg !199
  %18 = bitcast i8* %17 to <16 x i8>*, !dbg !199
  %wide.load89.2 = load <16 x i8>, <16 x i8>* %18, align 1, !dbg !199, !tbaa !166, !alias.scope !200
  %19 = bitcast i8* %next.gep81.2 to <16 x i8>*, !dbg !203
  store <16 x i8> %wide.load88.2, <16 x i8>* %19, align 1, !dbg !203, !tbaa !166, !alias.scope !204, !noalias !200
  %20 = getelementptr i8, i8* %next.gep81.2, i64 16, !dbg !203
  %21 = bitcast i8* %20 to <16 x i8>*, !dbg !203
  store <16 x i8> %wide.load89.2, <16 x i8>* %21, align 1, !dbg !203, !tbaa !166, !alias.scope !204, !noalias !200
  %index.next71.2 = or i64 %index70, 96
  %next.gep79.3 = getelementptr i8, i8* %src, i64 %index.next71.2
  %next.gep81.3 = getelementptr i8, i8* %dst, i64 %index.next71.2
  %22 = bitcast i8* %next.gep79.3 to <16 x i8>*, !dbg !199
  %wide.load88.3 = load <16 x i8>, <16 x i8>* %22, align 1, !dbg !199, !tbaa !166, !alias.scope !200
  %23 = getelementptr i8, i8* %next.gep79.3, i64 16, !dbg !199
  %24 = bitcast i8* %23 to <16 x i8>*, !dbg !199
  %wide.load89.3 = load <16 x i8>, <16 x i8>* %24, align 1, !dbg !199, !tbaa !166, !alias.scope !200
  %25 = bitcast i8* %next.gep81.3 to <16 x i8>*, !dbg !203
  store <16 x i8> %wide.load88.3, <16 x i8>* %25, align 1, !dbg !203, !tbaa !166, !alias.scope !204, !noalias !200
  %26 = getelementptr i8, i8* %next.gep81.3, i64 16, !dbg !203
  %27 = bitcast i8* %26 to <16 x i8>*, !dbg !203
  store <16 x i8> %wide.load89.3, <16 x i8>* %27, align 1, !dbg !203, !tbaa !166, !alias.scope !204, !noalias !200
  %index.next71.3 = add i64 %index70, 128
  %niter.nsub.3 = add i64 %niter, -4
  %niter.ncmp.3 = icmp eq i64 %niter.nsub.3, 0
  br i1 %niter.ncmp.3, label %middle.block56.unr-lcssa, label %vector.body55, !llvm.loop !206

middle.block56.unr-lcssa:                         ; preds = %vector.body55, %vector.ph67
  %index70.unr = phi i64 [ 0, %vector.ph67 ], [ %index.next71.3, %vector.body55 ]
  %lcmp.mod94 = icmp eq i64 %xtraiter93, 0
  br i1 %lcmp.mod94, label %middle.block56, label %vector.body55.epil.preheader

vector.body55.epil.preheader:                     ; preds = %middle.block56.unr-lcssa
  br label %vector.body55.epil

vector.body55.epil:                               ; preds = %vector.body55.epil, %vector.body55.epil.preheader
  %index70.epil = phi i64 [ %index70.unr, %vector.body55.epil.preheader ], [ %index.next71.epil, %vector.body55.epil ]
  %epil.iter = phi i64 [ %xtraiter93, %vector.body55.epil.preheader ], [ %epil.iter.sub, %vector.body55.epil ]
  %next.gep79.epil = getelementptr i8, i8* %src, i64 %index70.epil
  %next.gep81.epil = getelementptr i8, i8* %dst, i64 %index70.epil
  %28 = bitcast i8* %next.gep79.epil to <16 x i8>*, !dbg !199
  %wide.load88.epil = load <16 x i8>, <16 x i8>* %28, align 1, !dbg !199, !tbaa !166, !alias.scope !200
  %29 = getelementptr i8, i8* %next.gep79.epil, i64 16, !dbg !199
  %30 = bitcast i8* %29 to <16 x i8>*, !dbg !199
  %wide.load89.epil = load <16 x i8>, <16 x i8>* %30, align 1, !dbg !199, !tbaa !166, !alias.scope !200
  %31 = bitcast i8* %next.gep81.epil to <16 x i8>*, !dbg !203
  store <16 x i8> %wide.load88.epil, <16 x i8>* %31, align 1, !dbg !203, !tbaa !166, !alias.scope !204, !noalias !200
  %32 = getelementptr i8, i8* %next.gep81.epil, i64 16, !dbg !203
  %33 = bitcast i8* %32 to <16 x i8>*, !dbg !203
  store <16 x i8> %wide.load89.epil, <16 x i8>* %33, align 1, !dbg !203, !tbaa !166, !alias.scope !204, !noalias !200
  %index.next71.epil = add i64 %index70.epil, 32
  %epil.iter.sub = add i64 %epil.iter, -1
  %epil.iter.cmp = icmp eq i64 %epil.iter.sub, 0
  br i1 %epil.iter.cmp, label %middle.block56, label %vector.body55.epil, !llvm.loop !208

middle.block56:                                   ; preds = %vector.body55.epil, %middle.block56.unr-lcssa
  %cmp.n78 = icmp eq i64 %n.vec69, %count
  br i1 %cmp.n78, label %cleanup, label %while.body.preheader, !dbg !197

while.body.preheader:                             ; preds = %middle.block56, %vector.memcheck66, %while.body.lr.ph
  %b.034.ph = phi i8* [ %src, %vector.memcheck66 ], [ %src, %while.body.lr.ph ], [ %ind.end73, %middle.block56 ]
  %a.033.ph = phi i8* [ %dst, %vector.memcheck66 ], [ %dst, %while.body.lr.ph ], [ %ind.end75, %middle.block56 ]
  %count.addr.032.ph = phi i64 [ %count, %vector.memcheck66 ], [ %count, %while.body.lr.ph ], [ %ind.end77, %middle.block56 ]
  %34 = add i64 %count.addr.032.ph, -1, !dbg !209
  %xtraiter = and i64 %count.addr.032.ph, 7, !dbg !209
  %lcmp.mod = icmp eq i64 %xtraiter, 0, !dbg !209
  br i1 %lcmp.mod, label %while.body.prol.loopexit, label %while.body.prol.preheader, !dbg !209

while.body.prol.preheader:                        ; preds = %while.body.preheader
  br label %while.body.prol, !dbg !209

while.body.prol:                                  ; preds = %while.body.prol, %while.body.prol.preheader
  %b.034.prol = phi i8* [ %incdec.ptr.prol, %while.body.prol ], [ %b.034.ph, %while.body.prol.preheader ]
  %a.033.prol = phi i8* [ %incdec.ptr3.prol, %while.body.prol ], [ %a.033.ph, %while.body.prol.preheader ]
  %count.addr.032.prol = phi i64 [ %dec.prol, %while.body.prol ], [ %count.addr.032.ph, %while.body.prol.preheader ]
  %prol.iter = phi i64 [ %prol.iter.sub, %while.body.prol ], [ %xtraiter, %while.body.prol.preheader ]
  %dec.prol = add i64 %count.addr.032.prol, -1, !dbg !209
  %incdec.ptr.prol = getelementptr inbounds i8, i8* %b.034.prol, i64 1, !dbg !207
  %35 = load i8, i8* %b.034.prol, align 1, !dbg !199, !tbaa !166
  %incdec.ptr3.prol = getelementptr inbounds i8, i8* %a.033.prol, i64 1, !dbg !210
  store i8 %35, i8* %a.033.prol, align 1, !dbg !203, !tbaa !166
  %prol.iter.sub = add i64 %prol.iter, -1, !dbg !197
  %prol.iter.cmp = icmp eq i64 %prol.iter.sub, 0, !dbg !197
  br i1 %prol.iter.cmp, label %while.body.prol.loopexit, label %while.body.prol, !dbg !197, !llvm.loop !211

while.body.prol.loopexit:                         ; preds = %while.body.prol, %while.body.preheader
  %b.034.unr = phi i8* [ %b.034.ph, %while.body.preheader ], [ %incdec.ptr.prol, %while.body.prol ]
  %a.033.unr = phi i8* [ %a.033.ph, %while.body.preheader ], [ %incdec.ptr3.prol, %while.body.prol ]
  %count.addr.032.unr = phi i64 [ %count.addr.032.ph, %while.body.preheader ], [ %dec.prol, %while.body.prol ]
  %36 = icmp ult i64 %34, 7, !dbg !209
  br i1 %36, label %cleanup, label %while.body.preheader.new, !dbg !209

while.body.preheader.new:                         ; preds = %while.body.prol.loopexit
  br label %while.body, !dbg !209

while.body:                                       ; preds = %while.body, %while.body.preheader.new
  %b.034 = phi i8* [ %b.034.unr, %while.body.preheader.new ], [ %incdec.ptr.7, %while.body ]
  %a.033 = phi i8* [ %a.033.unr, %while.body.preheader.new ], [ %incdec.ptr3.7, %while.body ]
  %count.addr.032 = phi i64 [ %count.addr.032.unr, %while.body.preheader.new ], [ %dec.7, %while.body ]
  %incdec.ptr = getelementptr inbounds i8, i8* %b.034, i64 1, !dbg !207
  %37 = load i8, i8* %b.034, align 1, !dbg !199, !tbaa !166
  %incdec.ptr3 = getelementptr inbounds i8, i8* %a.033, i64 1, !dbg !210
  store i8 %37, i8* %a.033, align 1, !dbg !203, !tbaa !166
  %incdec.ptr.1 = getelementptr inbounds i8, i8* %b.034, i64 2, !dbg !207
  %38 = load i8, i8* %incdec.ptr, align 1, !dbg !199, !tbaa !166
  %incdec.ptr3.1 = getelementptr inbounds i8, i8* %a.033, i64 2, !dbg !210
  store i8 %38, i8* %incdec.ptr3, align 1, !dbg !203, !tbaa !166
  %incdec.ptr.2 = getelementptr inbounds i8, i8* %b.034, i64 3, !dbg !207
  %39 = load i8, i8* %incdec.ptr.1, align 1, !dbg !199, !tbaa !166
  %incdec.ptr3.2 = getelementptr inbounds i8, i8* %a.033, i64 3, !dbg !210
  store i8 %39, i8* %incdec.ptr3.1, align 1, !dbg !203, !tbaa !166
  %incdec.ptr.3 = getelementptr inbounds i8, i8* %b.034, i64 4, !dbg !207
  %40 = load i8, i8* %incdec.ptr.2, align 1, !dbg !199, !tbaa !166
  %incdec.ptr3.3 = getelementptr inbounds i8, i8* %a.033, i64 4, !dbg !210
  store i8 %40, i8* %incdec.ptr3.2, align 1, !dbg !203, !tbaa !166
  %incdec.ptr.4 = getelementptr inbounds i8, i8* %b.034, i64 5, !dbg !207
  %41 = load i8, i8* %incdec.ptr.3, align 1, !dbg !199, !tbaa !166
  %incdec.ptr3.4 = getelementptr inbounds i8, i8* %a.033, i64 5, !dbg !210
  store i8 %41, i8* %incdec.ptr3.3, align 1, !dbg !203, !tbaa !166
  %incdec.ptr.5 = getelementptr inbounds i8, i8* %b.034, i64 6, !dbg !207
  %42 = load i8, i8* %incdec.ptr.4, align 1, !dbg !199, !tbaa !166
  %incdec.ptr3.5 = getelementptr inbounds i8, i8* %a.033, i64 6, !dbg !210
  store i8 %42, i8* %incdec.ptr3.4, align 1, !dbg !203, !tbaa !166
  %incdec.ptr.6 = getelementptr inbounds i8, i8* %b.034, i64 7, !dbg !207
  %43 = load i8, i8* %incdec.ptr.5, align 1, !dbg !199, !tbaa !166
  %incdec.ptr3.6 = getelementptr inbounds i8, i8* %a.033, i64 7, !dbg !210
  store i8 %43, i8* %incdec.ptr3.5, align 1, !dbg !203, !tbaa !166
  %dec.7 = add i64 %count.addr.032, -8, !dbg !209
  %incdec.ptr.7 = getelementptr inbounds i8, i8* %b.034, i64 8, !dbg !207
  %44 = load i8, i8* %incdec.ptr.6, align 1, !dbg !199, !tbaa !166
  %incdec.ptr3.7 = getelementptr inbounds i8, i8* %a.033, i64 8, !dbg !210
  store i8 %44, i8* %incdec.ptr3.6, align 1, !dbg !203, !tbaa !166
  %tobool.7 = icmp eq i64 %dec.7, 0, !dbg !197
  br i1 %tobool.7, label %cleanup, label %while.body, !dbg !197, !llvm.loop !212

if.else:                                          ; preds = %if.end
  %sub = add i64 %count, -1, !dbg !213
  %tobool835 = icmp eq i64 %count, 0, !dbg !215
  br i1 %tobool835, label %cleanup, label %while.body9.lr.ph, !dbg !215

while.body9.lr.ph:                                ; preds = %if.else
  %add.ptr5 = getelementptr inbounds i8, i8* %src, i64 %sub, !dbg !216
  %add.ptr = getelementptr inbounds i8, i8* %dst, i64 %sub, !dbg !217
  %min.iters.check = icmp ult i64 %count, 16, !dbg !215
  br i1 %min.iters.check, label %while.body9.preheader, label %vector.memcheck, !dbg !215

vector.memcheck:                                  ; preds = %while.body9.lr.ph
  %scevgep = getelementptr i8, i8* %dst, i64 %count, !dbg !215
  %scevgep42 = getelementptr i8, i8* %src, i64 %count, !dbg !215
  %bound0 = icmp ugt i8* %scevgep42, %dst, !dbg !215
  %bound1 = icmp ugt i8* %scevgep, %src, !dbg !215
  %memcheck.conflict = and i1 %bound0, %bound1, !dbg !215
  br i1 %memcheck.conflict, label %while.body9.preheader, label %vector.ph, !dbg !215

vector.ph:                                        ; preds = %vector.memcheck
  %n.mod.vf = and i64 %count, 15, !dbg !215
  %n.vec = sub i64 %count, %n.mod.vf, !dbg !215
  %45 = sub i64 %n.mod.vf, %count, !dbg !215
  %ind.end = getelementptr i8, i8* %add.ptr5, i64 %45, !dbg !215
  %ind.end44 = getelementptr i8, i8* %add.ptr, i64 %45, !dbg !215
  br label %vector.body, !dbg !215

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %46 = sub i64 0, %index
  %next.gep = getelementptr i8, i8* %add.ptr5, i64 %46
  %47 = sub i64 0, %index
  %next.gep48 = getelementptr i8, i8* %add.ptr, i64 %47
  %48 = getelementptr i8, i8* %next.gep, i64 -8, !dbg !218
  %49 = getelementptr i8, i8* %48, i64 -7, !dbg !218
  %50 = bitcast i8* %49 to <2 x i64>*, !dbg !218
  %51 = load <2 x i64>, <2 x i64>* %50, align 1, !dbg !218, !tbaa !166, !alias.scope !219
  %52 = getelementptr i8, i8* %next.gep48, i64 -8, !dbg !222
  %53 = getelementptr i8, i8* %52, i64 -7, !dbg !222
  %54 = bitcast i8* %53 to <2 x i64>*, !dbg !222
  store <2 x i64> %51, <2 x i64>* %54, align 1, !dbg !222, !tbaa !166, !alias.scope !223, !noalias !219
  %index.next = add i64 %index, 16
  %55 = icmp eq i64 %index.next, %n.vec
  br i1 %55, label %middle.block, label %vector.body, !llvm.loop !225

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %n.mod.vf, 0
  br i1 %cmp.n, label %cleanup, label %while.body9.preheader, !dbg !215

while.body9.preheader:                            ; preds = %middle.block, %vector.memcheck, %while.body9.lr.ph
  %b.138.ph = phi i8* [ %add.ptr5, %vector.memcheck ], [ %add.ptr5, %while.body9.lr.ph ], [ %ind.end, %middle.block ]
  %a.137.ph = phi i8* [ %add.ptr, %vector.memcheck ], [ %add.ptr, %while.body9.lr.ph ], [ %ind.end44, %middle.block ]
  %count.addr.136.ph = phi i64 [ %count, %vector.memcheck ], [ %count, %while.body9.lr.ph ], [ %n.mod.vf, %middle.block ]
  %56 = add i64 %count.addr.136.ph, -1, !dbg !227
  %xtraiter95 = and i64 %count.addr.136.ph, 7, !dbg !227
  %lcmp.mod96 = icmp eq i64 %xtraiter95, 0, !dbg !227
  br i1 %lcmp.mod96, label %while.body9.prol.loopexit, label %while.body9.prol.preheader, !dbg !227

while.body9.prol.preheader:                       ; preds = %while.body9.preheader
  br label %while.body9.prol, !dbg !227

while.body9.prol:                                 ; preds = %while.body9.prol, %while.body9.prol.preheader
  %b.138.prol = phi i8* [ %incdec.ptr10.prol, %while.body9.prol ], [ %b.138.ph, %while.body9.prol.preheader ]
  %a.137.prol = phi i8* [ %incdec.ptr11.prol, %while.body9.prol ], [ %a.137.ph, %while.body9.prol.preheader ]
  %count.addr.136.prol = phi i64 [ %dec7.prol, %while.body9.prol ], [ %count.addr.136.ph, %while.body9.prol.preheader ]
  %prol.iter97 = phi i64 [ %prol.iter97.sub, %while.body9.prol ], [ %xtraiter95, %while.body9.prol.preheader ]
  %dec7.prol = add i64 %count.addr.136.prol, -1, !dbg !227
  %incdec.ptr10.prol = getelementptr inbounds i8, i8* %b.138.prol, i64 -1, !dbg !226
  %57 = load i8, i8* %b.138.prol, align 1, !dbg !218, !tbaa !166
  %incdec.ptr11.prol = getelementptr inbounds i8, i8* %a.137.prol, i64 -1, !dbg !228
  store i8 %57, i8* %a.137.prol, align 1, !dbg !222, !tbaa !166
  %prol.iter97.sub = add i64 %prol.iter97, -1, !dbg !215
  %prol.iter97.cmp = icmp eq i64 %prol.iter97.sub, 0, !dbg !215
  br i1 %prol.iter97.cmp, label %while.body9.prol.loopexit, label %while.body9.prol, !dbg !215, !llvm.loop !229

while.body9.prol.loopexit:                        ; preds = %while.body9.prol, %while.body9.preheader
  %b.138.unr = phi i8* [ %b.138.ph, %while.body9.preheader ], [ %incdec.ptr10.prol, %while.body9.prol ]
  %a.137.unr = phi i8* [ %a.137.ph, %while.body9.preheader ], [ %incdec.ptr11.prol, %while.body9.prol ]
  %count.addr.136.unr = phi i64 [ %count.addr.136.ph, %while.body9.preheader ], [ %dec7.prol, %while.body9.prol ]
  %58 = icmp ult i64 %56, 7, !dbg !227
  br i1 %58, label %cleanup, label %while.body9.preheader.new, !dbg !227

while.body9.preheader.new:                        ; preds = %while.body9.prol.loopexit
  br label %while.body9, !dbg !227

while.body9:                                      ; preds = %while.body9, %while.body9.preheader.new
  %b.138 = phi i8* [ %b.138.unr, %while.body9.preheader.new ], [ %incdec.ptr10.7, %while.body9 ]
  %a.137 = phi i8* [ %a.137.unr, %while.body9.preheader.new ], [ %incdec.ptr11.7, %while.body9 ]
  %count.addr.136 = phi i64 [ %count.addr.136.unr, %while.body9.preheader.new ], [ %dec7.7, %while.body9 ]
  %incdec.ptr10 = getelementptr inbounds i8, i8* %b.138, i64 -1, !dbg !226
  %59 = load i8, i8* %b.138, align 1, !dbg !218, !tbaa !166
  %incdec.ptr11 = getelementptr inbounds i8, i8* %a.137, i64 -1, !dbg !228
  store i8 %59, i8* %a.137, align 1, !dbg !222, !tbaa !166
  %incdec.ptr10.1 = getelementptr inbounds i8, i8* %b.138, i64 -2, !dbg !226
  %60 = load i8, i8* %incdec.ptr10, align 1, !dbg !218, !tbaa !166
  %incdec.ptr11.1 = getelementptr inbounds i8, i8* %a.137, i64 -2, !dbg !228
  store i8 %60, i8* %incdec.ptr11, align 1, !dbg !222, !tbaa !166
  %incdec.ptr10.2 = getelementptr inbounds i8, i8* %b.138, i64 -3, !dbg !226
  %61 = load i8, i8* %incdec.ptr10.1, align 1, !dbg !218, !tbaa !166
  %incdec.ptr11.2 = getelementptr inbounds i8, i8* %a.137, i64 -3, !dbg !228
  store i8 %61, i8* %incdec.ptr11.1, align 1, !dbg !222, !tbaa !166
  %incdec.ptr10.3 = getelementptr inbounds i8, i8* %b.138, i64 -4, !dbg !226
  %62 = load i8, i8* %incdec.ptr10.2, align 1, !dbg !218, !tbaa !166
  %incdec.ptr11.3 = getelementptr inbounds i8, i8* %a.137, i64 -4, !dbg !228
  store i8 %62, i8* %incdec.ptr11.2, align 1, !dbg !222, !tbaa !166
  %incdec.ptr10.4 = getelementptr inbounds i8, i8* %b.138, i64 -5, !dbg !226
  %63 = load i8, i8* %incdec.ptr10.3, align 1, !dbg !218, !tbaa !166
  %incdec.ptr11.4 = getelementptr inbounds i8, i8* %a.137, i64 -5, !dbg !228
  store i8 %63, i8* %incdec.ptr11.3, align 1, !dbg !222, !tbaa !166
  %incdec.ptr10.5 = getelementptr inbounds i8, i8* %b.138, i64 -6, !dbg !226
  %64 = load i8, i8* %incdec.ptr10.4, align 1, !dbg !218, !tbaa !166
  %incdec.ptr11.5 = getelementptr inbounds i8, i8* %a.137, i64 -6, !dbg !228
  store i8 %64, i8* %incdec.ptr11.4, align 1, !dbg !222, !tbaa !166
  %incdec.ptr10.6 = getelementptr inbounds i8, i8* %b.138, i64 -7, !dbg !226
  %65 = load i8, i8* %incdec.ptr10.5, align 1, !dbg !218, !tbaa !166
  %incdec.ptr11.6 = getelementptr inbounds i8, i8* %a.137, i64 -7, !dbg !228
  store i8 %65, i8* %incdec.ptr11.5, align 1, !dbg !222, !tbaa !166
  %dec7.7 = add i64 %count.addr.136, -8, !dbg !227
  %incdec.ptr10.7 = getelementptr inbounds i8, i8* %b.138, i64 -8, !dbg !226
  %66 = load i8, i8* %incdec.ptr10.6, align 1, !dbg !218, !tbaa !166
  %incdec.ptr11.7 = getelementptr inbounds i8, i8* %a.137, i64 -8, !dbg !228
  store i8 %66, i8* %incdec.ptr11.6, align 1, !dbg !222, !tbaa !166
  %tobool8.7 = icmp eq i64 %dec7.7, 0, !dbg !215
  br i1 %tobool8.7, label %cleanup, label %while.body9, !dbg !215, !llvm.loop !230

cleanup:                                          ; preds = %while.body9.prol.loopexit, %while.body9, %while.body.prol.loopexit, %while.body, %middle.block, %middle.block56, %if.else, %if.then2, %entry
  ret i8* %dst, !dbg !231
}

; Function Attrs: nounwind uwtable
define weak i8* @mempcpy(i8* %destaddr, i8* %srcaddr, i64 %len) local_unnamed_addr #3 !dbg !232 {
entry:
  %cmp5 = icmp eq i64 %len, 0, !dbg !239
  br i1 %cmp5, label %while.end, label %while.body.lr.ph, !dbg !240

while.body.lr.ph:                                 ; preds = %entry
  %min.iters.check = icmp ult i64 %len, 32, !dbg !240
  br i1 %min.iters.check, label %while.body.preheader, label %vector.memcheck, !dbg !240

vector.memcheck:                                  ; preds = %while.body.lr.ph
  %scevgep9 = getelementptr i8, i8* %destaddr, i64 %len, !dbg !240
  %scevgep10 = getelementptr i8, i8* %srcaddr, i64 %len, !dbg !240
  %bound0 = icmp ugt i8* %scevgep10, %destaddr, !dbg !240
  %bound1 = icmp ugt i8* %scevgep9, %srcaddr, !dbg !240
  %memcheck.conflict = and i1 %bound0, %bound1, !dbg !240
  br i1 %memcheck.conflict, label %while.body.preheader, label %vector.ph, !dbg !240

vector.ph:                                        ; preds = %vector.memcheck
  %n.vec = and i64 %len, -32, !dbg !240
  %ind.end = getelementptr i8, i8* %srcaddr, i64 %n.vec, !dbg !240
  %ind.end12 = getelementptr i8, i8* %destaddr, i64 %n.vec, !dbg !240
  %ind.end14 = sub i64 %len, %n.vec, !dbg !240
  %0 = add i64 %n.vec, -32, !dbg !240
  %1 = lshr exact i64 %0, 5, !dbg !240
  %2 = add nuw nsw i64 %1, 1, !dbg !240
  %xtraiter20 = and i64 %2, 3, !dbg !240
  %3 = icmp ult i64 %0, 96, !dbg !240
  br i1 %3, label %middle.block.unr-lcssa, label %vector.ph.new, !dbg !240

vector.ph.new:                                    ; preds = %vector.ph
  %unroll_iter = sub nsw i64 %2, %xtraiter20, !dbg !240
  br label %vector.body, !dbg !240

vector.body:                                      ; preds = %vector.body, %vector.ph.new
  %index = phi i64 [ 0, %vector.ph.new ], [ %index.next.3, %vector.body ]
  %niter = phi i64 [ %unroll_iter, %vector.ph.new ], [ %niter.nsub.3, %vector.body ]
  %next.gep = getelementptr i8, i8* %srcaddr, i64 %index
  %next.gep16 = getelementptr i8, i8* %destaddr, i64 %index
  %4 = bitcast i8* %next.gep to <16 x i8>*, !dbg !241
  %wide.load = load <16 x i8>, <16 x i8>* %4, align 1, !dbg !241, !tbaa !166, !alias.scope !242
  %5 = getelementptr i8, i8* %next.gep, i64 16, !dbg !241
  %6 = bitcast i8* %5 to <16 x i8>*, !dbg !241
  %wide.load19 = load <16 x i8>, <16 x i8>* %6, align 1, !dbg !241, !tbaa !166, !alias.scope !242
  %7 = bitcast i8* %next.gep16 to <16 x i8>*, !dbg !245
  store <16 x i8> %wide.load, <16 x i8>* %7, align 1, !dbg !245, !tbaa !166, !alias.scope !246, !noalias !242
  %8 = getelementptr i8, i8* %next.gep16, i64 16, !dbg !245
  %9 = bitcast i8* %8 to <16 x i8>*, !dbg !245
  store <16 x i8> %wide.load19, <16 x i8>* %9, align 1, !dbg !245, !tbaa !166, !alias.scope !246, !noalias !242
  %index.next = or i64 %index, 32
  %next.gep.1 = getelementptr i8, i8* %srcaddr, i64 %index.next
  %next.gep16.1 = getelementptr i8, i8* %destaddr, i64 %index.next
  %10 = bitcast i8* %next.gep.1 to <16 x i8>*, !dbg !241
  %wide.load.1 = load <16 x i8>, <16 x i8>* %10, align 1, !dbg !241, !tbaa !166, !alias.scope !242
  %11 = getelementptr i8, i8* %next.gep.1, i64 16, !dbg !241
  %12 = bitcast i8* %11 to <16 x i8>*, !dbg !241
  %wide.load19.1 = load <16 x i8>, <16 x i8>* %12, align 1, !dbg !241, !tbaa !166, !alias.scope !242
  %13 = bitcast i8* %next.gep16.1 to <16 x i8>*, !dbg !245
  store <16 x i8> %wide.load.1, <16 x i8>* %13, align 1, !dbg !245, !tbaa !166, !alias.scope !246, !noalias !242
  %14 = getelementptr i8, i8* %next.gep16.1, i64 16, !dbg !245
  %15 = bitcast i8* %14 to <16 x i8>*, !dbg !245
  store <16 x i8> %wide.load19.1, <16 x i8>* %15, align 1, !dbg !245, !tbaa !166, !alias.scope !246, !noalias !242
  %index.next.1 = or i64 %index, 64
  %next.gep.2 = getelementptr i8, i8* %srcaddr, i64 %index.next.1
  %next.gep16.2 = getelementptr i8, i8* %destaddr, i64 %index.next.1
  %16 = bitcast i8* %next.gep.2 to <16 x i8>*, !dbg !241
  %wide.load.2 = load <16 x i8>, <16 x i8>* %16, align 1, !dbg !241, !tbaa !166, !alias.scope !242
  %17 = getelementptr i8, i8* %next.gep.2, i64 16, !dbg !241
  %18 = bitcast i8* %17 to <16 x i8>*, !dbg !241
  %wide.load19.2 = load <16 x i8>, <16 x i8>* %18, align 1, !dbg !241, !tbaa !166, !alias.scope !242
  %19 = bitcast i8* %next.gep16.2 to <16 x i8>*, !dbg !245
  store <16 x i8> %wide.load.2, <16 x i8>* %19, align 1, !dbg !245, !tbaa !166, !alias.scope !246, !noalias !242
  %20 = getelementptr i8, i8* %next.gep16.2, i64 16, !dbg !245
  %21 = bitcast i8* %20 to <16 x i8>*, !dbg !245
  store <16 x i8> %wide.load19.2, <16 x i8>* %21, align 1, !dbg !245, !tbaa !166, !alias.scope !246, !noalias !242
  %index.next.2 = or i64 %index, 96
  %next.gep.3 = getelementptr i8, i8* %srcaddr, i64 %index.next.2
  %next.gep16.3 = getelementptr i8, i8* %destaddr, i64 %index.next.2
  %22 = bitcast i8* %next.gep.3 to <16 x i8>*, !dbg !241
  %wide.load.3 = load <16 x i8>, <16 x i8>* %22, align 1, !dbg !241, !tbaa !166, !alias.scope !242
  %23 = getelementptr i8, i8* %next.gep.3, i64 16, !dbg !241
  %24 = bitcast i8* %23 to <16 x i8>*, !dbg !241
  %wide.load19.3 = load <16 x i8>, <16 x i8>* %24, align 1, !dbg !241, !tbaa !166, !alias.scope !242
  %25 = bitcast i8* %next.gep16.3 to <16 x i8>*, !dbg !245
  store <16 x i8> %wide.load.3, <16 x i8>* %25, align 1, !dbg !245, !tbaa !166, !alias.scope !246, !noalias !242
  %26 = getelementptr i8, i8* %next.gep16.3, i64 16, !dbg !245
  %27 = bitcast i8* %26 to <16 x i8>*, !dbg !245
  store <16 x i8> %wide.load19.3, <16 x i8>* %27, align 1, !dbg !245, !tbaa !166, !alias.scope !246, !noalias !242
  %index.next.3 = add i64 %index, 128
  %niter.nsub.3 = add i64 %niter, -4
  %niter.ncmp.3 = icmp eq i64 %niter.nsub.3, 0
  br i1 %niter.ncmp.3, label %middle.block.unr-lcssa, label %vector.body, !llvm.loop !248

middle.block.unr-lcssa:                           ; preds = %vector.body, %vector.ph
  %index.unr = phi i64 [ 0, %vector.ph ], [ %index.next.3, %vector.body ]
  %lcmp.mod21 = icmp eq i64 %xtraiter20, 0
  br i1 %lcmp.mod21, label %middle.block, label %vector.body.epil.preheader

vector.body.epil.preheader:                       ; preds = %middle.block.unr-lcssa
  br label %vector.body.epil

vector.body.epil:                                 ; preds = %vector.body.epil, %vector.body.epil.preheader
  %index.epil = phi i64 [ %index.unr, %vector.body.epil.preheader ], [ %index.next.epil, %vector.body.epil ]
  %epil.iter = phi i64 [ %xtraiter20, %vector.body.epil.preheader ], [ %epil.iter.sub, %vector.body.epil ]
  %next.gep.epil = getelementptr i8, i8* %srcaddr, i64 %index.epil
  %next.gep16.epil = getelementptr i8, i8* %destaddr, i64 %index.epil
  %28 = bitcast i8* %next.gep.epil to <16 x i8>*, !dbg !241
  %wide.load.epil = load <16 x i8>, <16 x i8>* %28, align 1, !dbg !241, !tbaa !166, !alias.scope !242
  %29 = getelementptr i8, i8* %next.gep.epil, i64 16, !dbg !241
  %30 = bitcast i8* %29 to <16 x i8>*, !dbg !241
  %wide.load19.epil = load <16 x i8>, <16 x i8>* %30, align 1, !dbg !241, !tbaa !166, !alias.scope !242
  %31 = bitcast i8* %next.gep16.epil to <16 x i8>*, !dbg !245
  store <16 x i8> %wide.load.epil, <16 x i8>* %31, align 1, !dbg !245, !tbaa !166, !alias.scope !246, !noalias !242
  %32 = getelementptr i8, i8* %next.gep16.epil, i64 16, !dbg !245
  %33 = bitcast i8* %32 to <16 x i8>*, !dbg !245
  store <16 x i8> %wide.load19.epil, <16 x i8>* %33, align 1, !dbg !245, !tbaa !166, !alias.scope !246, !noalias !242
  %index.next.epil = add i64 %index.epil, 32
  %epil.iter.sub = add i64 %epil.iter, -1
  %epil.iter.cmp = icmp eq i64 %epil.iter.sub, 0
  br i1 %epil.iter.cmp, label %middle.block, label %vector.body.epil, !llvm.loop !250

middle.block:                                     ; preds = %vector.body.epil, %middle.block.unr-lcssa
  %cmp.n = icmp eq i64 %n.vec, %len
  br i1 %cmp.n, label %while.end.loopexit, label %while.body.preheader, !dbg !240

while.body.preheader:                             ; preds = %middle.block, %vector.memcheck, %while.body.lr.ph
  %src.08.ph = phi i8* [ %srcaddr, %vector.memcheck ], [ %srcaddr, %while.body.lr.ph ], [ %ind.end, %middle.block ]
  %dest.07.ph = phi i8* [ %destaddr, %vector.memcheck ], [ %destaddr, %while.body.lr.ph ], [ %ind.end12, %middle.block ]
  %len.addr.06.ph = phi i64 [ %len, %vector.memcheck ], [ %len, %while.body.lr.ph ], [ %ind.end14, %middle.block ]
  %34 = add i64 %len.addr.06.ph, -1, !dbg !251
  %xtraiter = and i64 %len.addr.06.ph, 7, !dbg !251
  %lcmp.mod = icmp eq i64 %xtraiter, 0, !dbg !251
  br i1 %lcmp.mod, label %while.body.prol.loopexit, label %while.body.prol.preheader, !dbg !251

while.body.prol.preheader:                        ; preds = %while.body.preheader
  br label %while.body.prol, !dbg !251

while.body.prol:                                  ; preds = %while.body.prol, %while.body.prol.preheader
  %src.08.prol = phi i8* [ %incdec.ptr.prol, %while.body.prol ], [ %src.08.ph, %while.body.prol.preheader ]
  %dest.07.prol = phi i8* [ %incdec.ptr1.prol, %while.body.prol ], [ %dest.07.ph, %while.body.prol.preheader ]
  %len.addr.06.prol = phi i64 [ %dec.prol, %while.body.prol ], [ %len.addr.06.ph, %while.body.prol.preheader ]
  %prol.iter = phi i64 [ %prol.iter.sub, %while.body.prol ], [ %xtraiter, %while.body.prol.preheader ]
  %dec.prol = add i64 %len.addr.06.prol, -1, !dbg !251
  %incdec.ptr.prol = getelementptr inbounds i8, i8* %src.08.prol, i64 1, !dbg !249
  %35 = load i8, i8* %src.08.prol, align 1, !dbg !241, !tbaa !166
  %incdec.ptr1.prol = getelementptr inbounds i8, i8* %dest.07.prol, i64 1, !dbg !252
  store i8 %35, i8* %dest.07.prol, align 1, !dbg !245, !tbaa !166
  %prol.iter.sub = add i64 %prol.iter, -1, !dbg !240
  %prol.iter.cmp = icmp eq i64 %prol.iter.sub, 0, !dbg !240
  br i1 %prol.iter.cmp, label %while.body.prol.loopexit, label %while.body.prol, !dbg !240, !llvm.loop !253

while.body.prol.loopexit:                         ; preds = %while.body.prol, %while.body.preheader
  %src.08.unr = phi i8* [ %src.08.ph, %while.body.preheader ], [ %incdec.ptr.prol, %while.body.prol ]
  %dest.07.unr = phi i8* [ %dest.07.ph, %while.body.preheader ], [ %incdec.ptr1.prol, %while.body.prol ]
  %len.addr.06.unr = phi i64 [ %len.addr.06.ph, %while.body.preheader ], [ %dec.prol, %while.body.prol ]
  %36 = icmp ult i64 %34, 7, !dbg !251
  br i1 %36, label %while.end.loopexit, label %while.body.preheader.new, !dbg !251

while.body.preheader.new:                         ; preds = %while.body.prol.loopexit
  br label %while.body, !dbg !251

while.body:                                       ; preds = %while.body, %while.body.preheader.new
  %src.08 = phi i8* [ %src.08.unr, %while.body.preheader.new ], [ %incdec.ptr.7, %while.body ]
  %dest.07 = phi i8* [ %dest.07.unr, %while.body.preheader.new ], [ %incdec.ptr1.7, %while.body ]
  %len.addr.06 = phi i64 [ %len.addr.06.unr, %while.body.preheader.new ], [ %dec.7, %while.body ]
  %incdec.ptr = getelementptr inbounds i8, i8* %src.08, i64 1, !dbg !249
  %37 = load i8, i8* %src.08, align 1, !dbg !241, !tbaa !166
  %incdec.ptr1 = getelementptr inbounds i8, i8* %dest.07, i64 1, !dbg !252
  store i8 %37, i8* %dest.07, align 1, !dbg !245, !tbaa !166
  %incdec.ptr.1 = getelementptr inbounds i8, i8* %src.08, i64 2, !dbg !249
  %38 = load i8, i8* %incdec.ptr, align 1, !dbg !241, !tbaa !166
  %incdec.ptr1.1 = getelementptr inbounds i8, i8* %dest.07, i64 2, !dbg !252
  store i8 %38, i8* %incdec.ptr1, align 1, !dbg !245, !tbaa !166
  %incdec.ptr.2 = getelementptr inbounds i8, i8* %src.08, i64 3, !dbg !249
  %39 = load i8, i8* %incdec.ptr.1, align 1, !dbg !241, !tbaa !166
  %incdec.ptr1.2 = getelementptr inbounds i8, i8* %dest.07, i64 3, !dbg !252
  store i8 %39, i8* %incdec.ptr1.1, align 1, !dbg !245, !tbaa !166
  %incdec.ptr.3 = getelementptr inbounds i8, i8* %src.08, i64 4, !dbg !249
  %40 = load i8, i8* %incdec.ptr.2, align 1, !dbg !241, !tbaa !166
  %incdec.ptr1.3 = getelementptr inbounds i8, i8* %dest.07, i64 4, !dbg !252
  store i8 %40, i8* %incdec.ptr1.2, align 1, !dbg !245, !tbaa !166
  %incdec.ptr.4 = getelementptr inbounds i8, i8* %src.08, i64 5, !dbg !249
  %41 = load i8, i8* %incdec.ptr.3, align 1, !dbg !241, !tbaa !166
  %incdec.ptr1.4 = getelementptr inbounds i8, i8* %dest.07, i64 5, !dbg !252
  store i8 %41, i8* %incdec.ptr1.3, align 1, !dbg !245, !tbaa !166
  %incdec.ptr.5 = getelementptr inbounds i8, i8* %src.08, i64 6, !dbg !249
  %42 = load i8, i8* %incdec.ptr.4, align 1, !dbg !241, !tbaa !166
  %incdec.ptr1.5 = getelementptr inbounds i8, i8* %dest.07, i64 6, !dbg !252
  store i8 %42, i8* %incdec.ptr1.4, align 1, !dbg !245, !tbaa !166
  %incdec.ptr.6 = getelementptr inbounds i8, i8* %src.08, i64 7, !dbg !249
  %43 = load i8, i8* %incdec.ptr.5, align 1, !dbg !241, !tbaa !166
  %incdec.ptr1.6 = getelementptr inbounds i8, i8* %dest.07, i64 7, !dbg !252
  store i8 %43, i8* %incdec.ptr1.5, align 1, !dbg !245, !tbaa !166
  %dec.7 = add i64 %len.addr.06, -8, !dbg !251
  %incdec.ptr.7 = getelementptr inbounds i8, i8* %src.08, i64 8, !dbg !249
  %44 = load i8, i8* %incdec.ptr.6, align 1, !dbg !241, !tbaa !166
  %incdec.ptr1.7 = getelementptr inbounds i8, i8* %dest.07, i64 8, !dbg !252
  store i8 %44, i8* %incdec.ptr1.6, align 1, !dbg !245, !tbaa !166
  %cmp.7 = icmp eq i64 %dec.7, 0, !dbg !239
  br i1 %cmp.7, label %while.end.loopexit, label %while.body, !dbg !240, !llvm.loop !254

while.end.loopexit:                               ; preds = %while.body.prol.loopexit, %while.body, %middle.block
  %scevgep = getelementptr i8, i8* %destaddr, i64 %len, !dbg !240
  br label %while.end, !dbg !255

while.end:                                        ; preds = %while.end.loopexit, %entry
  %dest.0.lcssa = phi i8* [ %destaddr, %entry ], [ %scevgep, %while.end.loopexit ]
  ret i8* %dest.0.lcssa, !dbg !255
}

; Function Attrs: nounwind uwtable
define weak i8* @memset(i8* %dst, i32 %s, i64 %count) local_unnamed_addr #3 !dbg !256 {
entry:
  %cmp3 = icmp eq i64 %count, 0, !dbg !266
  br i1 %cmp3, label %while.end, label %while.body.lr.ph, !dbg !267

while.body.lr.ph:                                 ; preds = %entry
  %conv = trunc i32 %s to i8
  %0 = add i64 %count, -1, !dbg !267
  %xtraiter = and i64 %count, 7, !dbg !267
  %lcmp.mod = icmp eq i64 %xtraiter, 0, !dbg !267
  br i1 %lcmp.mod, label %while.body.prol.loopexit, label %while.body.prol.preheader, !dbg !267

while.body.prol.preheader:                        ; preds = %while.body.lr.ph
  br label %while.body.prol, !dbg !267

while.body.prol:                                  ; preds = %while.body.prol, %while.body.prol.preheader
  %a.05.prol = phi i8* [ %dst, %while.body.prol.preheader ], [ %incdec.ptr.prol, %while.body.prol ]
  %count.addr.04.prol = phi i64 [ %count, %while.body.prol.preheader ], [ %dec.prol, %while.body.prol ]
  %prol.iter = phi i64 [ %xtraiter, %while.body.prol.preheader ], [ %prol.iter.sub, %while.body.prol ]
  %dec.prol = add i64 %count.addr.04.prol, -1, !dbg !268
  %incdec.ptr.prol = getelementptr inbounds i8, i8* %a.05.prol, i64 1, !dbg !269
  store volatile i8 %conv, i8* %a.05.prol, align 1, !dbg !270, !tbaa !166
  %prol.iter.sub = add i64 %prol.iter, -1, !dbg !267
  %prol.iter.cmp = icmp eq i64 %prol.iter.sub, 0, !dbg !267
  br i1 %prol.iter.cmp, label %while.body.prol.loopexit, label %while.body.prol, !dbg !267, !llvm.loop !271

while.body.prol.loopexit:                         ; preds = %while.body.prol, %while.body.lr.ph
  %a.05.unr = phi i8* [ %dst, %while.body.lr.ph ], [ %incdec.ptr.prol, %while.body.prol ]
  %count.addr.04.unr = phi i64 [ %count, %while.body.lr.ph ], [ %dec.prol, %while.body.prol ]
  %1 = icmp ult i64 %0, 7, !dbg !267
  br i1 %1, label %while.end, label %while.body.lr.ph.new, !dbg !267

while.body.lr.ph.new:                             ; preds = %while.body.prol.loopexit
  br label %while.body, !dbg !267

while.body:                                       ; preds = %while.body, %while.body.lr.ph.new
  %a.05 = phi i8* [ %a.05.unr, %while.body.lr.ph.new ], [ %incdec.ptr.7, %while.body ]
  %count.addr.04 = phi i64 [ %count.addr.04.unr, %while.body.lr.ph.new ], [ %dec.7, %while.body ]
  %incdec.ptr = getelementptr inbounds i8, i8* %a.05, i64 1, !dbg !269
  store volatile i8 %conv, i8* %a.05, align 1, !dbg !270, !tbaa !166
  %incdec.ptr.1 = getelementptr inbounds i8, i8* %a.05, i64 2, !dbg !269
  store volatile i8 %conv, i8* %incdec.ptr, align 1, !dbg !270, !tbaa !166
  %incdec.ptr.2 = getelementptr inbounds i8, i8* %a.05, i64 3, !dbg !269
  store volatile i8 %conv, i8* %incdec.ptr.1, align 1, !dbg !270, !tbaa !166
  %incdec.ptr.3 = getelementptr inbounds i8, i8* %a.05, i64 4, !dbg !269
  store volatile i8 %conv, i8* %incdec.ptr.2, align 1, !dbg !270, !tbaa !166
  %incdec.ptr.4 = getelementptr inbounds i8, i8* %a.05, i64 5, !dbg !269
  store volatile i8 %conv, i8* %incdec.ptr.3, align 1, !dbg !270, !tbaa !166
  %incdec.ptr.5 = getelementptr inbounds i8, i8* %a.05, i64 6, !dbg !269
  store volatile i8 %conv, i8* %incdec.ptr.4, align 1, !dbg !270, !tbaa !166
  %incdec.ptr.6 = getelementptr inbounds i8, i8* %a.05, i64 7, !dbg !269
  store volatile i8 %conv, i8* %incdec.ptr.5, align 1, !dbg !270, !tbaa !166
  %dec.7 = add i64 %count.addr.04, -8, !dbg !268
  %incdec.ptr.7 = getelementptr inbounds i8, i8* %a.05, i64 8, !dbg !269
  store volatile i8 %conv, i8* %incdec.ptr.6, align 1, !dbg !270, !tbaa !166
  %cmp.7 = icmp eq i64 %dec.7, 0, !dbg !266
  br i1 %cmp.7, label %while.end, label %while.body, !dbg !267, !llvm.loop !272

while.end:                                        ; preds = %while.body.prol.loopexit, %while.body, %entry
  ret i8* %dst, !dbg !274
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-ju
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zer
attributes #3 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-
attributes #4 = { argmemonly nounwind }
attributes #5 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no
attributes #6 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping
attributes #7 = { nobuiltin nounwind }
attributes #8 = { nobuiltin noreturn nounwind }

!llvm.dbg.cu = !{!0, !3, !5, !7, !9, !11, !15, !17, !19, !21}
!llvm.module.flags = !{!23, !24, !25}
!llvm.ident = !{!26, !26, !26, !26, !26, !26, !26, !26, !26, !26}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "get_sign.c", directory: "/home/tzt77/Develop/KleeSE/examples/get_sign")
!2 = !{}
!3 = distinct !DICompileUnit(language: DW_LANG_C89, file: !4, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!4 = !DIFile(filename: "/home/tzt77/Develop/KleeSE/runtime/Intrinsic/klee_choose.c", directory: "/home/tzt77/Develop/KleeSE/cmake-build-debug/runtime/Intrinsic")
!5 = distinct !DICompileUnit(language: DW_LANG_C89, file: !6, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!6 = !DIFile(filename: "/home/tzt77/Develop/KleeSE/runtime/Intrinsic/klee_div_zero_check.c", directory: "/home/tzt77/Develop/KleeSE/cmake-build-debug/runtime/Intrinsic")
!7 = distinct !DICompileUnit(language: DW_LANG_C89, file: !8, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!8 = !DIFile(filename: "/home/tzt77/Develop/KleeSE/runtime/Intrinsic/klee_int.c", directory: "/home/tzt77/Develop/KleeSE/cmake-build-debug/runtime/Intrinsic")
!9 = distinct !DICompileUnit(language: DW_LANG_C89, file: !10, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!10 = !DIFile(filename: "/home/tzt77/Develop/KleeSE/runtime/Intrinsic/klee_overshift_check.c", directory: "/home/tzt77/Develop/KleeSE/cmake-build-debug/runtime/Intrinsic")
!11 = distinct !DICompileUnit(language: DW_LANG_C89, file: !12, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !13)
!12 = !DIFile(filename: "/home/tzt77/Develop/KleeSE/runtime/Intrinsic/klee_range.c", directory: "/home/tzt77/Develop/KleeSE/cmake-build-debug/runtime/Intrinsic")
!13 = !{!14}
!14 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!15 = distinct !DICompileUnit(language: DW_LANG_C89, file: !16, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!16 = !DIFile(filename: "/home/tzt77/Develop/KleeSE/runtime/Intrinsic/memcpy.c", directory: "/home/tzt77/Develop/KleeSE/cmake-build-debug/runtime/Intrinsic")
!17 = distinct !DICompileUnit(language: DW_LANG_C89, file: !18, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!18 = !DIFile(filename: "/home/tzt77/Develop/KleeSE/runtime/Intrinsic/memmove.c", directory: "/home/tzt77/Develop/KleeSE/cmake-build-debug/runtime/Intrinsic")
!19 = distinct !DICompileUnit(language: DW_LANG_C89, file: !20, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!20 = !DIFile(filename: "/home/tzt77/Develop/KleeSE/runtime/Intrinsic/mempcpy.c", directory: "/home/tzt77/Develop/KleeSE/cmake-build-debug/runtime/Intrinsic")
!21 = distinct !DICompileUnit(language: DW_LANG_C89, file: !22, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!22 = !DIFile(filename: "/home/tzt77/Develop/KleeSE/runtime/Intrinsic/memset.c", directory: "/home/tzt77/Develop/KleeSE/cmake-build-debug/runtime/Intrinsic")
!23 = !{i32 2, !"Dwarf Version", i32 4}
!24 = !{i32 2, !"Debug Info Version", i32 3}
!25 = !{i32 1, !"wchar_size", i32 4}
!26 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
!27 = distinct !DISubprogram(name: "get_sign", scope: !1, file: !1, line: 7, type: !28, isLocal: false, isDefinition: true, scopeLine: 7, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!28 = !DISubroutineType(types: !29)
!29 = !{!30, !30}
!30 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!31 = !DILocation(line: 8, column: 7, scope: !32)
!32 = distinct !DILexicalBlock(scope: !27, file: !1, line: 8, column: 7)
!33 = !DILocation(line: 8, column: 9, scope: !32)
!34 = !DILocation(line: 8, column: 7, scope: !27)
!35 = !DILocation(line: 9, column: 6, scope: !32)
!36 = !DILocation(line: 11, column: 7, scope: !37)
!37 = distinct !DILexicalBlock(scope: !27, file: !1, line: 11, column: 7)
!38 = !DILocation(line: 11, column: 9, scope: !37)
!39 = !DILocation(line: 11, column: 7, scope: !27)
!40 = !DILocation(line: 12, column: 6, scope: !37)
!41 = !DILocation(line: 14, column: 6, scope: !37)
!42 = !DILocation(line: 15, column: 1, scope: !27)
!43 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 17, type: !44, isLocal: false, isDefinition: true, scopeLine: 17, isOptimized: false, unit: !0, variables: !2)
!44 = !DISubroutineType(types: !45)
!45 = !{!30}
!46 = !DILocation(line: 19, column: 22, scope: !43)
!47 = !DILocation(line: 19, column: 3, scope: !43)
!48 = !DILocation(line: 20, column: 19, scope: !43)
!49 = !DILocation(line: 20, column: 10, scope: !43)
!50 = !DILocation(line: 20, column: 3, scope: !43)
!51 = distinct !DISubprogram(name: "klee_choose", scope: !4, file: !4, line: 12, type: !52, isLocal: false, isDefinition: true, scopeLine: 12, flags: DIFlagPrototyped, isOptimized: true, unit: !3, variables: !57)
!52 = !DISubroutineType(types: !53)
!53 = !{!54, !54}
!54 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintptr_t", file: !55, line: 122, baseType: !56)
!55 = !DIFile(filename: "/usr/include/stdint.h", directory: "/home/tzt77/Develop/KleeSE/cmake-build-debug/runtime/Intrinsic")
!56 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!57 = !{!58, !59}
!58 = !DILocalVariable(name: "n", arg: 1, scope: !51, file: !4, line: 12, type: !54)
!59 = !DILocalVariable(name: "x", scope: !51, file: !4, line: 13, type: !54)
!60 = !DILocation(line: 13, column: 3, scope: !51)
!61 = !DILocation(line: 14, column: 3, scope: !51)
!62 = !DILocation(line: 17, column: 6, scope: !63)
!63 = distinct !DILexicalBlock(scope: !51, file: !4, line: 17, column: 6)
!64 = !{!65, !65, i64 0}
!65 = !{!"long", !66, i64 0}
!66 = !{!"omnipotent char", !67, i64 0}
!67 = !{!"Simple C/C++ TBAA"}
!68 = !DILocation(line: 17, column: 8, scope: !63)
!69 = !DILocation(line: 17, column: 6, scope: !51)
!70 = !DILocation(line: 18, column: 5, scope: !63)
!71 = !DILocation(line: 19, column: 3, scope: !51)
!72 = distinct !DISubprogram(name: "klee_div_zero_check", scope: !6, file: !6, line: 12, type: !73, isLocal: false, isDefinition: true, scopeLine: 12, flags: DIFlagPrototyped, isOptimized: true, unit: !5, variables: !76)
!73 = !DISubroutineType(types: !74)
!74 = !{null, !75}
!75 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!76 = !{!77}
!77 = !DILocalVariable(name: "z", arg: 1, scope: !72, file: !6, line: 12, type: !75)
!78 = !DILocation(line: 13, column: 9, scope: !79)
!79 = distinct !DILexicalBlock(scope: !72, file: !6, line: 13, column: 7)
!80 = !DILocation(line: 13, column: 7, scope: !72)
!81 = !DILocation(line: 14, column: 5, scope: !79)
!82 = !DILocation(line: 15, column: 1, scope: !72)
!83 = distinct !DISubprogram(name: "klee_int", scope: !8, file: !8, line: 13, type: !84, isLocal: false, isDefinition: true, scopeLine: 13, flags: DIFlagPrototyped, isOptimized: true, unit: !7, variables: !89)
!84 = !DISubroutineType(types: !85)
!85 = !{!30, !86}
!86 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !87, size: 64)
!87 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !88)
!88 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!89 = !{!90, !91}
!90 = !DILocalVariable(name: "name", arg: 1, scope: !83, file: !8, line: 13, type: !86)
!91 = !DILocalVariable(name: "x", scope: !83, file: !8, line: 14, type: !30)
!92 = !DILocation(line: 14, column: 3, scope: !83)
!93 = !DILocation(line: 15, column: 3, scope: !83)
!94 = !DILocation(line: 16, column: 10, scope: !83)
!95 = !{!96, !96, i64 0}
!96 = !{!"int", !66, i64 0}
!97 = !DILocation(line: 16, column: 3, scope: !83)
!98 = distinct !DISubprogram(name: "klee_overshift_check", scope: !10, file: !10, line: 20, type: !99, isLocal: false, isDefinition: true, scopeLine: 20, flags: DIFlagPrototyped, isOptimized: true, unit: !9, variables: !102)
!99 = !DISubroutineType(types: !100)
!100 = !{null, !101, !101}
!101 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!102 = !{!103, !104}
!103 = !DILocalVariable(name: "bitWidth", arg: 1, scope: !98, file: !10, line: 20, type: !101)
!104 = !DILocalVariable(name: "shift", arg: 2, scope: !98, file: !10, line: 20, type: !101)
!105 = !DILocation(line: 21, column: 13, scope: !106)
!106 = distinct !DILexicalBlock(scope: !98, file: !10, line: 21, column: 7)
!107 = !DILocation(line: 21, column: 7, scope: !98)
!108 = !DILocation(line: 27, column: 5, scope: !109)
!109 = distinct !DILexicalBlock(scope: !106, file: !10, line: 21, column: 26)
!110 = !DILocation(line: 29, column: 1, scope: !98)
!111 = distinct !DISubprogram(name: "klee_range", scope: !12, file: !12, line: 13, type: !112, isLocal: false, isDefinition: true, scopeLine: 13, flags: DIFlagPrototyped, isOptimized: true, unit: !11, variables: !114)
!112 = !DISubroutineType(types: !113)
!113 = !{!30, !30, !30, !86}
!114 = !{!115, !116, !117, !118}
!115 = !DILocalVariable(name: "start", arg: 1, scope: !111, file: !12, line: 13, type: !30)
!116 = !DILocalVariable(name: "end", arg: 2, scope: !111, file: !12, line: 13, type: !30)
!117 = !DILocalVariable(name: "name", arg: 3, scope: !111, file: !12, line: 13, type: !86)
!118 = !DILocalVariable(name: "x", scope: !111, file: !12, line: 14, type: !30)
!119 = !DILocation(line: 14, column: 3, scope: !111)
!120 = !DILocation(line: 16, column: 13, scope: !121)
!121 = distinct !DILexicalBlock(scope: !111, file: !12, line: 16, column: 7)
!122 = !DILocation(line: 16, column: 7, scope: !111)
!123 = !DILocation(line: 17, column: 5, scope: !121)
!124 = !DILocation(line: 19, column: 12, scope: !125)
!125 = distinct !DILexicalBlock(scope: !111, file: !12, line: 19, column: 7)
!126 = !DILocation(line: 19, column: 14, scope: !125)
!127 = !DILocation(line: 19, column: 7, scope: !111)
!128 = !DILocation(line: 22, column: 5, scope: !129)
!129 = distinct !DILexicalBlock(scope: !125, file: !12, line: 21, column: 10)
!130 = !DILocation(line: 25, column: 14, scope: !131)
!131 = distinct !DILexicalBlock(scope: !129, file: !12, line: 25, column: 9)
!132 = !DILocation(line: 25, column: 9, scope: !129)
!133 = !DILocation(line: 26, column: 32, scope: !134)
!134 = distinct !DILexicalBlock(scope: !131, file: !12, line: 25, column: 19)
!135 = !DILocation(line: 26, column: 19, scope: !134)
!136 = !DILocation(line: 26, column: 7, scope: !134)
!137 = !DILocation(line: 27, column: 5, scope: !134)
!138 = !DILocation(line: 28, column: 25, scope: !139)
!139 = distinct !DILexicalBlock(scope: !131, file: !12, line: 27, column: 12)
!140 = !DILocation(line: 28, column: 19, scope: !139)
!141 = !DILocation(line: 28, column: 7, scope: !139)
!142 = !DILocation(line: 29, column: 19, scope: !139)
!143 = !DILocation(line: 29, column: 21, scope: !139)
!144 = !DILocation(line: 29, column: 7, scope: !139)
!145 = !DILocation(line: 32, column: 12, scope: !129)
!146 = !DILocation(line: 32, column: 5, scope: !129)
!147 = !DILocation(line: 34, column: 1, scope: !111)
!148 = distinct !DISubprogram(name: "memcpy", scope: !16, file: !16, line: 12, type: !149, isLocal: false, isDefinition: true, scopeLine: 12, flags: DIFlagPrototyped, isOptimized: true, unit: !15, variables: !156)
!149 = !DISubroutineType(types: !150)
!150 = !{!151, !151, !152, !154}
!151 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!152 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !153, size: 64)
!153 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!154 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !155, line: 62, baseType: !56)
!155 = !DIFile(filename: "/HDD/llvm5.0/install/lib/clang/5.0.0/include/stddef.h", directory: "/home/tzt77/Develop/KleeSE/cmake-build-debug/runtime/Intrinsic")
!156 = !{!157, !158, !159, !160, !162}
!157 = !DILocalVariable(name: "destaddr", arg: 1, scope: !148, file: !16, line: 12, type: !151)
!158 = !DILocalVariable(name: "srcaddr", arg: 2, scope: !148, file: !16, line: 12, type: !152)
!159 = !DILocalVariable(name: "len", arg: 3, scope: !148, file: !16, line: 12, type: !154)
!160 = !DILocalVariable(name: "dest", scope: !148, file: !16, line: 13, type: !161)
!161 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !88, size: 64)
!162 = !DILocalVariable(name: "src", scope: !148, file: !16, line: 14, type: !86)
!163 = !DILocation(line: 16, column: 16, scope: !148)
!164 = !DILocation(line: 16, column: 3, scope: !148)
!165 = !DILocation(line: 17, column: 15, scope: !148)
!166 = !{!66, !66, i64 0}
!167 = !{!168}
!168 = distinct !{!168, !169}
!169 = distinct !{!169, !"LVerDomain"}
!170 = !DILocation(line: 17, column: 13, scope: !148)
!171 = !{!172}
!172 = distinct !{!172, !169}
!173 = distinct !{!173, !164, !174, !175, !176}
!174 = !DILocation(line: 17, column: 19, scope: !148)
!175 = !{!"llvm.loop.vectorize.width", i32 1}
!176 = !{!"llvm.loop.interleave.count", i32 1}
!177 = distinct !{!177, !178}
!178 = !{!"llvm.loop.unroll.disable"}
!179 = !DILocation(line: 16, column: 13, scope: !148)
!180 = !DILocation(line: 17, column: 10, scope: !148)
!181 = distinct !{!181, !178}
!182 = distinct !{!182, !164, !174, !175, !176}
!183 = !DILocation(line: 18, column: 3, scope: !148)
!184 = distinct !DISubprogram(name: "memmove", scope: !18, file: !18, line: 12, type: !149, isLocal: false, isDefinition: true, scopeLine: 12, flags: DIFlagPrototyped, isOptimized: true, unit: !17, variables: !185)
!185 = !{!186, !187, !188, !189, !190}
!186 = !DILocalVariable(name: "dst", arg: 1, scope: !184, file: !18, line: 12, type: !151)
!187 = !DILocalVariable(name: "src", arg: 2, scope: !184, file: !18, line: 12, type: !152)
!188 = !DILocalVariable(name: "count", arg: 3, scope: !184, file: !18, line: 12, type: !154)
!189 = !DILocalVariable(name: "a", scope: !184, file: !18, line: 13, type: !161)
!190 = !DILocalVariable(name: "b", scope: !184, file: !18, line: 14, type: !86)
!191 = !DILocation(line: 16, column: 11, scope: !192)
!192 = distinct !DILexicalBlock(scope: !184, file: !18, line: 16, column: 7)
!193 = !DILocation(line: 16, column: 7, scope: !184)
!194 = !DILocation(line: 19, column: 10, scope: !195)
!195 = distinct !DILexicalBlock(scope: !184, file: !18, line: 19, column: 7)
!196 = !DILocation(line: 19, column: 7, scope: !184)
!197 = !DILocation(line: 20, column: 5, scope: !198)
!198 = distinct !DILexicalBlock(scope: !195, file: !18, line: 19, column: 16)
!199 = !DILocation(line: 20, column: 28, scope: !198)
!200 = !{!201}
!201 = distinct !{!201, !202}
!202 = distinct !{!202, !"LVerDomain"}
!203 = !DILocation(line: 20, column: 26, scope: !198)
!204 = !{!205}
!205 = distinct !{!205, !202}
!206 = distinct !{!206, !197, !207, !175, !176}
!207 = !DILocation(line: 20, column: 30, scope: !198)
!208 = distinct !{!208, !178}
!209 = !DILocation(line: 20, column: 17, scope: !198)
!210 = !DILocation(line: 20, column: 23, scope: !198)
!211 = distinct !{!211, !178}
!212 = distinct !{!212, !197, !207, !175, !176}
!213 = !DILocation(line: 22, column: 13, scope: !214)
!214 = distinct !DILexicalBlock(scope: !195, file: !18, line: 21, column: 10)
!215 = !DILocation(line: 24, column: 5, scope: !214)
!216 = !DILocation(line: 23, column: 6, scope: !214)
!217 = !DILocation(line: 22, column: 6, scope: !214)
!218 = !DILocation(line: 24, column: 28, scope: !214)
!219 = !{!220}
!220 = distinct !{!220, !221}
!221 = distinct !{!221, !"LVerDomain"}
!222 = !DILocation(line: 24, column: 26, scope: !214)
!223 = !{!224}
!224 = distinct !{!224, !221}
!225 = distinct !{!225, !215, !226, !175, !176}
!226 = !DILocation(line: 24, column: 30, scope: !214)
!227 = !DILocation(line: 24, column: 17, scope: !214)
!228 = !DILocation(line: 24, column: 23, scope: !214)
!229 = distinct !{!229, !178}
!230 = distinct !{!230, !215, !226, !175, !176}
!231 = !DILocation(line: 28, column: 1, scope: !184)
!232 = distinct !DISubprogram(name: "mempcpy", scope: !20, file: !20, line: 11, type: !149, isLocal: false, isDefinition: true, scopeLine: 11, flags: DIFlagPrototyped, isOptimized: true, unit: !19, variables: !233)
!233 = !{!234, !235, !236, !237, !238}
!234 = !DILocalVariable(name: "destaddr", arg: 1, scope: !232, file: !20, line: 11, type: !151)
!235 = !DILocalVariable(name: "srcaddr", arg: 2, scope: !232, file: !20, line: 11, type: !152)
!236 = !DILocalVariable(name: "len", arg: 3, scope: !232, file: !20, line: 11, type: !154)
!237 = !DILocalVariable(name: "dest", scope: !232, file: !20, line: 12, type: !161)
!238 = !DILocalVariable(name: "src", scope: !232, file: !20, line: 13, type: !86)
!239 = !DILocation(line: 15, column: 16, scope: !232)
!240 = !DILocation(line: 15, column: 3, scope: !232)
!241 = !DILocation(line: 16, column: 15, scope: !232)
!242 = !{!243}
!243 = distinct !{!243, !244}
!244 = distinct !{!244, !"LVerDomain"}
!245 = !DILocation(line: 16, column: 13, scope: !232)
!246 = !{!247}
!247 = distinct !{!247, !244}
!248 = distinct !{!248, !240, !249, !175, !176}
!249 = !DILocation(line: 16, column: 19, scope: !232)
!250 = distinct !{!250, !178}
!251 = !DILocation(line: 15, column: 13, scope: !232)
!252 = !DILocation(line: 16, column: 10, scope: !232)
!253 = distinct !{!253, !178}
!254 = distinct !{!254, !240, !249, !175, !176}
!255 = !DILocation(line: 17, column: 3, scope: !232)
!256 = distinct !DISubprogram(name: "memset", scope: !22, file: !22, line: 11, type: !257, isLocal: false, isDefinition: true, scopeLine: 11, flags: DIFlagPrototyped, isOptimized: true, unit: !21, variables: !259)
!257 = !DISubroutineType(types: !258)
!258 = !{!151, !151, !30, !154}
!259 = !{!260, !261, !262, !263}
!260 = !DILocalVariable(name: "dst", arg: 1, scope: !256, file: !22, line: 11, type: !151)
!261 = !DILocalVariable(name: "s", arg: 2, scope: !256, file: !22, line: 11, type: !30)
!262 = !DILocalVariable(name: "count", arg: 3, scope: !256, file: !22, line: 11, type: !154)
!263 = !DILocalVariable(name: "a", scope: !256, file: !22, line: 12, type: !264)
!264 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !265, size: 64)
!265 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !88)
!266 = !DILocation(line: 13, column: 20, scope: !256)
!267 = !DILocation(line: 13, column: 5, scope: !256)
!268 = !DILocation(line: 13, column: 17, scope: !256)
!269 = !DILocation(line: 14, column: 9, scope: !256)
!270 = !DILocation(line: 14, column: 12, scope: !256)
!271 = distinct !{!271, !178}
!272 = distinct !{!272, !267, !273}
!273 = !DILocation(line: 14, column: 14, scope: !256)
!274 = !DILocation(line: 15, column: 5, scope: !256)
