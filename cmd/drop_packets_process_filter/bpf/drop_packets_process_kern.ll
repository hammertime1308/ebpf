; ModuleID = './cmd/drop_packets_process_filter/bpf/drop_packets_process_kern.c'
source_filename = "./cmd/drop_packets_process_filter/bpf/drop_packets_process_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [1 x i32]*, i16*, [64 x i8]*, [1024 x i32]* }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }

@port_process_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@xdp_packet_filter_process_wise.____fmt = internal constant [30 x i8] c"found request for process %s\0A\00", align 1, !dbg !47
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !133
@llvm.used = appending global [3 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon* @port_process_map to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_packet_filter_process_wise to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_packet_filter_process_wise(%struct.xdp_md* nocapture readonly %0) #0 section "xdp" !dbg !49 {
  %2 = alloca i16, align 2
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !65, metadata !DIExpression()), !dbg !175
  %3 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !176
  %4 = load i32, i32* %3, align 4, !dbg !176, !tbaa !177
  %5 = zext i32 %4 to i64, !dbg !182
  %6 = inttoptr i64 %5 to i8*, !dbg !183
  call void @llvm.dbg.value(metadata i8* %6, metadata !66, metadata !DIExpression()), !dbg !175
  %7 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !184
  %8 = load i32, i32* %7, align 4, !dbg !184, !tbaa !185
  %9 = zext i32 %8 to i64, !dbg !186
  %10 = inttoptr i64 %9 to i8*, !dbg !187
  call void @llvm.dbg.value(metadata i8* %10, metadata !67, metadata !DIExpression()), !dbg !175
  call void @llvm.dbg.value(metadata i8* %6, metadata !68, metadata !DIExpression()), !dbg !175
  %11 = getelementptr i8, i8* %6, i64 14, !dbg !188
  %12 = icmp ugt i8* %11, %10, !dbg !190
  br i1 %12, label %39, label %13, !dbg !191

13:                                               ; preds = %1
  %14 = inttoptr i64 %5 to %struct.ethhdr*, !dbg !192
  call void @llvm.dbg.value(metadata %struct.ethhdr* %14, metadata !68, metadata !DIExpression()), !dbg !175
  %15 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %14, i64 0, i32 2, !dbg !193
  %16 = load i16, i16* %15, align 1, !dbg !193, !tbaa !195
  %17 = icmp eq i16 %16, 8, !dbg !198
  br i1 %17, label %18, label %39, !dbg !199

18:                                               ; preds = %13
  call void @llvm.dbg.value(metadata i8* %11, metadata !84, metadata !DIExpression()), !dbg !175
  %19 = getelementptr i8, i8* %6, i64 34, !dbg !200
  %20 = icmp ugt i8* %19, %10, !dbg !202
  br i1 %20, label %39, label %21, !dbg !203

21:                                               ; preds = %18
  call void @llvm.dbg.value(metadata i8* %11, metadata !84, metadata !DIExpression()), !dbg !175
  %22 = getelementptr i8, i8* %6, i64 23, !dbg !204
  %23 = load i8, i8* %22, align 1, !dbg !204, !tbaa !206
  %24 = icmp eq i8 %23, 6, !dbg !208
  br i1 %24, label %25, label %39, !dbg !209

25:                                               ; preds = %21
  call void @llvm.dbg.value(metadata i8* %19, metadata !103, metadata !DIExpression()), !dbg !175
  %26 = getelementptr i8, i8* %6, i64 54, !dbg !210
  %27 = icmp ugt i8* %26, %10, !dbg !212
  br i1 %27, label %39, label %28, !dbg !213

28:                                               ; preds = %25
  call void @llvm.dbg.value(metadata i8* %19, metadata !103, metadata !DIExpression()), !dbg !175
  %29 = bitcast i16* %2 to i8*, !dbg !214
  call void @llvm.lifetime.start.p0i8(i64 2, i8* nonnull %29) #3, !dbg !214
  %30 = getelementptr i8, i8* %6, i64 36, !dbg !215
  %31 = bitcast i8* %30 to i16*, !dbg !215
  %32 = load i16, i16* %31, align 2, !dbg !215, !tbaa !216
  %33 = tail call i16 @llvm.bswap.i16(i16 %32), !dbg !218
  call void @llvm.dbg.value(metadata i16 %33, metadata !125, metadata !DIExpression()), !dbg !175
  store i16 %33, i16* %2, align 2, !dbg !219, !tbaa !220
  call void @llvm.dbg.value(metadata i16* %2, metadata !125, metadata !DIExpression(DW_OP_deref)), !dbg !175
  %34 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @port_process_map to i8*), i8* nonnull %29) #3, !dbg !221
  call void @llvm.dbg.value(metadata i8* %34, metadata !126, metadata !DIExpression()), !dbg !175
  %35 = icmp eq i8* %34, null, !dbg !222
  br i1 %35, label %38, label %36, !dbg !224

36:                                               ; preds = %28
  %37 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @xdp_packet_filter_process_wise.____fmt, i64 0, i64 0), i32 30, i8* nonnull %34) #3, !dbg !225
  br label %38, !dbg !228

38:                                               ; preds = %28, %36
  call void @llvm.lifetime.end.p0i8(i64 2, i8* nonnull %29) #3, !dbg !229
  br label %39

39:                                               ; preds = %18, %21, %25, %38, %13, %1
  %40 = phi i32 [ 0, %1 ], [ 2, %13 ], [ 0, %18 ], [ 2, %21 ], [ 2, %38 ], [ 0, %25 ], !dbg !175
  ret i32 %40, !dbg !229
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare i16 @llvm.bswap.i16(i16) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!171, !172, !173}
!llvm.ident = !{!174}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "port_process_map", scope: !2, file: !50, line: 20, type: !152, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !43, globals: !46, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "cmd/drop_packets_process_filter/bpf/drop_packets_process_kern.c", directory: "/home/mandark/go/src/github.com/hammertime1308/ebpf")
!4 = !{!5, !14}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 3151, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0, isUnsigned: true)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1, isUnsigned: true)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2, isUnsigned: true)
!12 = !DIEnumerator(name: "XDP_TX", value: 3, isUnsigned: true)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4, isUnsigned: true)
!14 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !15, line: 40, baseType: !7, size: 32, elements: !16)
!15 = !DIFile(filename: "/usr/include/netinet/in.h", directory: "")
!16 = !{!17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42}
!17 = !DIEnumerator(name: "IPPROTO_IP", value: 0, isUnsigned: true)
!18 = !DIEnumerator(name: "IPPROTO_ICMP", value: 1, isUnsigned: true)
!19 = !DIEnumerator(name: "IPPROTO_IGMP", value: 2, isUnsigned: true)
!20 = !DIEnumerator(name: "IPPROTO_IPIP", value: 4, isUnsigned: true)
!21 = !DIEnumerator(name: "IPPROTO_TCP", value: 6, isUnsigned: true)
!22 = !DIEnumerator(name: "IPPROTO_EGP", value: 8, isUnsigned: true)
!23 = !DIEnumerator(name: "IPPROTO_PUP", value: 12, isUnsigned: true)
!24 = !DIEnumerator(name: "IPPROTO_UDP", value: 17, isUnsigned: true)
!25 = !DIEnumerator(name: "IPPROTO_IDP", value: 22, isUnsigned: true)
!26 = !DIEnumerator(name: "IPPROTO_TP", value: 29, isUnsigned: true)
!27 = !DIEnumerator(name: "IPPROTO_DCCP", value: 33, isUnsigned: true)
!28 = !DIEnumerator(name: "IPPROTO_IPV6", value: 41, isUnsigned: true)
!29 = !DIEnumerator(name: "IPPROTO_RSVP", value: 46, isUnsigned: true)
!30 = !DIEnumerator(name: "IPPROTO_GRE", value: 47, isUnsigned: true)
!31 = !DIEnumerator(name: "IPPROTO_ESP", value: 50, isUnsigned: true)
!32 = !DIEnumerator(name: "IPPROTO_AH", value: 51, isUnsigned: true)
!33 = !DIEnumerator(name: "IPPROTO_MTP", value: 92, isUnsigned: true)
!34 = !DIEnumerator(name: "IPPROTO_BEETPH", value: 94, isUnsigned: true)
!35 = !DIEnumerator(name: "IPPROTO_ENCAP", value: 98, isUnsigned: true)
!36 = !DIEnumerator(name: "IPPROTO_PIM", value: 103, isUnsigned: true)
!37 = !DIEnumerator(name: "IPPROTO_COMP", value: 108, isUnsigned: true)
!38 = !DIEnumerator(name: "IPPROTO_SCTP", value: 132, isUnsigned: true)
!39 = !DIEnumerator(name: "IPPROTO_UDPLITE", value: 136, isUnsigned: true)
!40 = !DIEnumerator(name: "IPPROTO_MPLS", value: 137, isUnsigned: true)
!41 = !DIEnumerator(name: "IPPROTO_RAW", value: 255, isUnsigned: true)
!42 = !DIEnumerator(name: "IPPROTO_MAX", value: 256, isUnsigned: true)
!43 = !{!44, !45}
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!45 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!46 = !{!47, !133, !0, !138, !146}
!47 = !DIGlobalVariableExpression(var: !48, expr: !DIExpression())
!48 = distinct !DIGlobalVariable(name: "____fmt", scope: !49, file: !50, line: 55, type: !129, isLocal: true, isDefinition: true)
!49 = distinct !DISubprogram(name: "xdp_packet_filter_process_wise", scope: !50, file: !50, line: 23, type: !51, scopeLine: 24, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !64)
!50 = !DIFile(filename: "./cmd/drop_packets_process_filter/bpf/drop_packets_process_kern.c", directory: "/home/mandark/go/src/github.com/hammertime1308/ebpf")
!51 = !DISubroutineType(types: !52)
!52 = !{!53, !54}
!53 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!54 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !55, size: 64)
!55 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3162, size: 160, elements: !56)
!56 = !{!57, !60, !61, !62, !63}
!57 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !55, file: !6, line: 3163, baseType: !58, size: 32)
!58 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !59, line: 27, baseType: !7)
!59 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!60 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !55, file: !6, line: 3164, baseType: !58, size: 32, offset: 32)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !55, file: !6, line: 3165, baseType: !58, size: 32, offset: 64)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !55, file: !6, line: 3167, baseType: !58, size: 32, offset: 96)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !55, file: !6, line: 3168, baseType: !58, size: 32, offset: 128)
!64 = !{!65, !66, !67, !68, !84, !103, !125, !126}
!65 = !DILocalVariable(name: "ctx", arg: 1, scope: !49, file: !50, line: 23, type: !54)
!66 = !DILocalVariable(name: "data", scope: !49, file: !50, line: 25, type: !44)
!67 = !DILocalVariable(name: "data_end", scope: !49, file: !50, line: 26, type: !44)
!68 = !DILocalVariable(name: "eth", scope: !49, file: !50, line: 28, type: !69)
!69 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !70, size: 64)
!70 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !71, line: 163, size: 112, elements: !72)
!71 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!72 = !{!73, !78, !79}
!73 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !70, file: !71, line: 164, baseType: !74, size: 48)
!74 = !DICompositeType(tag: DW_TAG_array_type, baseType: !75, size: 48, elements: !76)
!75 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!76 = !{!77}
!77 = !DISubrange(count: 6)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !70, file: !71, line: 165, baseType: !74, size: 48, offset: 48)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !70, file: !71, line: 166, baseType: !80, size: 16, offset: 96)
!80 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !81, line: 25, baseType: !82)
!81 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!82 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !59, line: 24, baseType: !83)
!83 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!84 = !DILocalVariable(name: "iph", scope: !49, file: !50, line: 38, type: !85)
!85 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !86, size: 64)
!86 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !87, line: 86, size: 160, elements: !88)
!87 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "")
!88 = !{!89, !91, !92, !93, !94, !95, !96, !97, !98, !100, !102}
!89 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !86, file: !87, line: 88, baseType: !90, size: 4, flags: DIFlagBitField, extraData: i64 0)
!90 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !59, line: 21, baseType: !75)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !86, file: !87, line: 89, baseType: !90, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!92 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !86, file: !87, line: 96, baseType: !90, size: 8, offset: 8)
!93 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !86, file: !87, line: 97, baseType: !80, size: 16, offset: 16)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !86, file: !87, line: 98, baseType: !80, size: 16, offset: 32)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !86, file: !87, line: 99, baseType: !80, size: 16, offset: 48)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !86, file: !87, line: 100, baseType: !90, size: 8, offset: 64)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !86, file: !87, line: 101, baseType: !90, size: 8, offset: 72)
!98 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !86, file: !87, line: 102, baseType: !99, size: 16, offset: 80)
!99 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !81, line: 31, baseType: !82)
!100 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !86, file: !87, line: 103, baseType: !101, size: 32, offset: 96)
!101 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !81, line: 27, baseType: !58)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !86, file: !87, line: 104, baseType: !101, size: 32, offset: 128)
!103 = !DILocalVariable(name: "tcph", scope: !49, file: !50, line: 46, type: !104)
!104 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !105, size: 64)
!105 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tcphdr", file: !106, line: 25, size: 160, elements: !107)
!106 = !DIFile(filename: "/usr/include/linux/tcp.h", directory: "")
!107 = !{!108, !109, !110, !111, !112, !113, !114, !115, !116, !117, !118, !119, !120, !121, !122, !123, !124}
!108 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !105, file: !106, line: 26, baseType: !80, size: 16)
!109 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !105, file: !106, line: 27, baseType: !80, size: 16, offset: 16)
!110 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !105, file: !106, line: 28, baseType: !101, size: 32, offset: 32)
!111 = !DIDerivedType(tag: DW_TAG_member, name: "ack_seq", scope: !105, file: !106, line: 29, baseType: !101, size: 32, offset: 64)
!112 = !DIDerivedType(tag: DW_TAG_member, name: "res1", scope: !105, file: !106, line: 31, baseType: !82, size: 4, offset: 96, flags: DIFlagBitField, extraData: i64 96)
!113 = !DIDerivedType(tag: DW_TAG_member, name: "doff", scope: !105, file: !106, line: 32, baseType: !82, size: 4, offset: 100, flags: DIFlagBitField, extraData: i64 96)
!114 = !DIDerivedType(tag: DW_TAG_member, name: "fin", scope: !105, file: !106, line: 33, baseType: !82, size: 1, offset: 104, flags: DIFlagBitField, extraData: i64 96)
!115 = !DIDerivedType(tag: DW_TAG_member, name: "syn", scope: !105, file: !106, line: 34, baseType: !82, size: 1, offset: 105, flags: DIFlagBitField, extraData: i64 96)
!116 = !DIDerivedType(tag: DW_TAG_member, name: "rst", scope: !105, file: !106, line: 35, baseType: !82, size: 1, offset: 106, flags: DIFlagBitField, extraData: i64 96)
!117 = !DIDerivedType(tag: DW_TAG_member, name: "psh", scope: !105, file: !106, line: 36, baseType: !82, size: 1, offset: 107, flags: DIFlagBitField, extraData: i64 96)
!118 = !DIDerivedType(tag: DW_TAG_member, name: "ack", scope: !105, file: !106, line: 37, baseType: !82, size: 1, offset: 108, flags: DIFlagBitField, extraData: i64 96)
!119 = !DIDerivedType(tag: DW_TAG_member, name: "urg", scope: !105, file: !106, line: 38, baseType: !82, size: 1, offset: 109, flags: DIFlagBitField, extraData: i64 96)
!120 = !DIDerivedType(tag: DW_TAG_member, name: "ece", scope: !105, file: !106, line: 39, baseType: !82, size: 1, offset: 110, flags: DIFlagBitField, extraData: i64 96)
!121 = !DIDerivedType(tag: DW_TAG_member, name: "cwr", scope: !105, file: !106, line: 40, baseType: !82, size: 1, offset: 111, flags: DIFlagBitField, extraData: i64 96)
!122 = !DIDerivedType(tag: DW_TAG_member, name: "window", scope: !105, file: !106, line: 55, baseType: !80, size: 16, offset: 112)
!123 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !105, file: !106, line: 56, baseType: !99, size: 16, offset: 128)
!124 = !DIDerivedType(tag: DW_TAG_member, name: "urg_ptr", scope: !105, file: !106, line: 57, baseType: !80, size: 16, offset: 144)
!125 = !DILocalVariable(name: "dst_port", scope: !49, file: !50, line: 50, type: !82)
!126 = !DILocalVariable(name: "process_name", scope: !49, file: !50, line: 52, type: !127)
!127 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !128, size: 64)
!128 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!129 = !DICompositeType(tag: DW_TAG_array_type, baseType: !130, size: 240, elements: !131)
!130 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !128)
!131 = !{!132}
!132 = !DISubrange(count: 30)
!133 = !DIGlobalVariableExpression(var: !134, expr: !DIExpression())
!134 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !50, line: 61, type: !135, isLocal: false, isDefinition: true)
!135 = !DICompositeType(tag: DW_TAG_array_type, baseType: !128, size: 32, elements: !136)
!136 = !{!137}
!137 = !DISubrange(count: 4)
!138 = !DIGlobalVariableExpression(var: !139, expr: !DIExpression())
!139 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !140, line: 56, type: !141, isLocal: true, isDefinition: true)
!140 = !DIFile(filename: "./libbpf/src/bpf_helper_defs.h", directory: "/home/mandark/go/src/github.com/hammertime1308/ebpf")
!141 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !142, size: 64)
!142 = !DISubroutineType(types: !143)
!143 = !{!44, !44, !144}
!144 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !145, size: 64)
!145 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!146 = !DIGlobalVariableExpression(var: !147, expr: !DIExpression())
!147 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !140, line: 177, type: !148, isLocal: true, isDefinition: true)
!148 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !149, size: 64)
!149 = !DISubroutineType(types: !150)
!150 = !{!45, !151, !58, null}
!151 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !130, size: 64)
!152 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !50, line: 14, size: 256, elements: !153)
!153 = !{!154, !159, !161, !166}
!154 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !152, file: !50, line: 16, baseType: !155, size: 64)
!155 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !156, size: 64)
!156 = !DICompositeType(tag: DW_TAG_array_type, baseType: !53, size: 32, elements: !157)
!157 = !{!158}
!158 = !DISubrange(count: 1)
!159 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !152, file: !50, line: 17, baseType: !160, size: 64, offset: 64)
!160 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !82, size: 64)
!161 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !152, file: !50, line: 18, baseType: !162, size: 64, offset: 128)
!162 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !163, size: 64)
!163 = !DICompositeType(tag: DW_TAG_array_type, baseType: !128, size: 512, elements: !164)
!164 = !{!165}
!165 = !DISubrange(count: 64)
!166 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !152, file: !50, line: 19, baseType: !167, size: 64, offset: 192)
!167 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !168, size: 64)
!168 = !DICompositeType(tag: DW_TAG_array_type, baseType: !53, size: 32768, elements: !169)
!169 = !{!170}
!170 = !DISubrange(count: 1024)
!171 = !{i32 7, !"Dwarf Version", i32 4}
!172 = !{i32 2, !"Debug Info Version", i32 3}
!173 = !{i32 1, !"wchar_size", i32 4}
!174 = !{!"clang version 10.0.0-4ubuntu1 "}
!175 = !DILocation(line: 0, scope: !49)
!176 = !DILocation(line: 25, column: 34, scope: !49)
!177 = !{!178, !179, i64 0}
!178 = !{!"xdp_md", !179, i64 0, !179, i64 4, !179, i64 8, !179, i64 12, !179, i64 16}
!179 = !{!"int", !180, i64 0}
!180 = !{!"omnipotent char", !181, i64 0}
!181 = !{!"Simple C/C++ TBAA"}
!182 = !DILocation(line: 25, column: 23, scope: !49)
!183 = !DILocation(line: 25, column: 15, scope: !49)
!184 = !DILocation(line: 26, column: 38, scope: !49)
!185 = !{!178, !179, i64 4}
!186 = !DILocation(line: 26, column: 27, scope: !49)
!187 = !DILocation(line: 26, column: 19, scope: !49)
!188 = !DILocation(line: 30, column: 11, scope: !189)
!189 = distinct !DILexicalBlock(scope: !49, file: !50, line: 30, column: 6)
!190 = !DILocation(line: 30, column: 35, scope: !189)
!191 = !DILocation(line: 30, column: 6, scope: !49)
!192 = !DILocation(line: 28, column: 23, scope: !49)
!193 = !DILocation(line: 34, column: 29, scope: !194)
!194 = distinct !DILexicalBlock(scope: !49, file: !50, line: 34, column: 6)
!195 = !{!196, !197, i64 12}
!196 = !{!"ethhdr", !180, i64 0, !180, i64 6, !197, i64 12}
!197 = !{!"short", !180, i64 0}
!198 = !DILocation(line: 34, column: 38, scope: !194)
!199 = !DILocation(line: 34, column: 6, scope: !49)
!200 = !DILocation(line: 39, column: 35, scope: !201)
!201 = distinct !DILexicalBlock(scope: !49, file: !50, line: 39, column: 6)
!202 = !DILocation(line: 39, column: 58, scope: !201)
!203 = !DILocation(line: 39, column: 6, scope: !49)
!204 = !DILocation(line: 43, column: 11, scope: !205)
!205 = distinct !DILexicalBlock(scope: !49, file: !50, line: 43, column: 6)
!206 = !{!207, !180, i64 9}
!207 = !{!"iphdr", !180, i64 0, !180, i64 0, !180, i64 1, !197, i64 2, !197, i64 4, !197, i64 6, !180, i64 8, !180, i64 9, !197, i64 10, !179, i64 12, !179, i64 16}
!208 = !DILocation(line: 43, column: 20, scope: !205)
!209 = !DILocation(line: 43, column: 6, scope: !49)
!210 = !DILocation(line: 47, column: 58, scope: !211)
!211 = distinct !DILexicalBlock(scope: !49, file: !50, line: 47, column: 6)
!212 = !DILocation(line: 47, column: 82, scope: !211)
!213 = !DILocation(line: 47, column: 6, scope: !49)
!214 = !DILocation(line: 50, column: 2, scope: !49)
!215 = !DILocation(line: 50, column: 43, scope: !49)
!216 = !{!217, !197, i64 2}
!217 = !{!"tcphdr", !197, i64 0, !197, i64 2, !179, i64 4, !179, i64 8, !197, i64 12, !197, i64 12, !197, i64 13, !197, i64 13, !197, i64 13, !197, i64 13, !197, i64 13, !197, i64 13, !197, i64 13, !197, i64 13, !197, i64 14, !197, i64 16, !197, i64 18}
!218 = !DILocation(line: 50, column: 19, scope: !49)
!219 = !DILocation(line: 50, column: 8, scope: !49)
!220 = !{!197, !197, i64 0}
!221 = !DILocation(line: 52, column: 23, scope: !49)
!222 = !DILocation(line: 53, column: 6, scope: !223)
!223 = distinct !DILexicalBlock(scope: !49, file: !50, line: 53, column: 6)
!224 = !DILocation(line: 53, column: 6, scope: !49)
!225 = !DILocation(line: 55, column: 3, scope: !226)
!226 = distinct !DILexicalBlock(scope: !227, file: !50, line: 55, column: 3)
!227 = distinct !DILexicalBlock(scope: !223, file: !50, line: 54, column: 2)
!228 = !DILocation(line: 56, column: 2, scope: !227)
!229 = !DILocation(line: 59, column: 1, scope: !49)
