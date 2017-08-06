Return-Path: <cygwin-patches-return-8811-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 44811 invoked by alias); 2 Aug 2017 06:23:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7886 invoked by uid 89); 2 Aug 2017 06:21:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.1 required=5.0 tests=AFFECTIONATE_BODY,BAYES_50,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_STOCKGEN,RP_MATCHES_RCVD,SPAM_BODY,SPAM_BODY1,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=texas, Texas, corp, Corp
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 02 Aug 2017 06:21:31 +0000
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id BB54410C4AA;	Wed,  2 Aug 2017 06:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com BB54410C4AA
Authentication-Results: ext-mx04.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx04.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=yselkowi@redhat.com
Received: from localhost.localdomain (ovpn-120-53.rdu2.redhat.com [10.10.120.53])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A35D7E48F;	Wed,  2 Aug 2017 06:21:28 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: newlib@sourceware.org
Cc: cygwin-patches@cygwin.com
Subject: [PATCH] Add elf.h to newlib
Date: Sun, 06 Aug 2017 13:57:00 -0000
Message-Id: <20170802062108.20220-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SW-Source: 2017-q3/txt/msg00013.txt.bz2

This is copied from musl (MIT license).  This is newer and more thorough
than that of FreeBSD currently shipped only on Cygwin.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 newlib/libc/include/elf.h               | 3146 +++++++++++++++++++++++++++++++
 winsup/cygwin/include/elf.h             |   41 -
 winsup/cygwin/include/machine/elf.h     |  117 --
 winsup/cygwin/include/sys/elf.h         |   41 -
 winsup/cygwin/include/sys/elf32.h       |  245 ---
 winsup/cygwin/include/sys/elf64.h       |  248 ---
 winsup/cygwin/include/sys/elf_common.h  | 1110 -----------
 winsup/cygwin/include/sys/elf_generic.h |   88 -
 8 files changed, 3146 insertions(+), 1890 deletions(-)
 create mode 100644 newlib/libc/include/elf.h
 delete mode 100644 winsup/cygwin/include/elf.h
 delete mode 100644 winsup/cygwin/include/machine/elf.h
 delete mode 100644 winsup/cygwin/include/sys/elf.h
 delete mode 100644 winsup/cygwin/include/sys/elf32.h
 delete mode 100644 winsup/cygwin/include/sys/elf64.h
 delete mode 100644 winsup/cygwin/include/sys/elf_common.h
 delete mode 100644 winsup/cygwin/include/sys/elf_generic.h

diff --git a/newlib/libc/include/elf.h b/newlib/libc/include/elf.h
new file mode 100644
index 000000000..1b62db530
--- /dev/null
+++ b/newlib/libc/include/elf.h
@@ -0,0 +1,3146 @@
+/*
+From musl include/elf.h
+
+Copyright Â© 2005-2014 Rich Felker, et al.
+
+Permission is hereby granted, free of charge, to any person obtaining
+a copy of this software and associated documentation files (the
+"Software"), to deal in the Software without restriction, including
+without limitation the rights to use, copy, modify, merge, publish,
+distribute, sublicense, and/or sell copies of the Software, and to
+permit persons to whom the Software is furnished to do so, subject to
+the following conditions:
+
+The above copyright notice and this permission notice shall be
+included in all copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+*/
+
+#ifndef _ELF_H
+#define _ELF_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <stdint.h>
+
+typedef uint16_t Elf32_Half;
+typedef uint16_t Elf64_Half;
+
+typedef uint32_t Elf32_Word;
+typedef	int32_t  Elf32_Sword;
+typedef uint32_t Elf64_Word;
+typedef	int32_t  Elf64_Sword;
+
+typedef uint64_t Elf32_Xword;
+typedef	int64_t  Elf32_Sxword;
+typedef uint64_t Elf64_Xword;
+typedef	int64_t  Elf64_Sxword;
+
+typedef uint32_t Elf32_Addr;
+typedef uint64_t Elf64_Addr;
+
+typedef uint32_t Elf32_Off;
+typedef uint64_t Elf64_Off;
+
+typedef uint16_t Elf32_Section;
+typedef uint16_t Elf64_Section;
+
+typedef Elf32_Half Elf32_Versym;
+typedef Elf64_Half Elf64_Versym;
+
+#define EI_NIDENT (16)
+
+typedef struct {
+  unsigned char	e_ident[EI_NIDENT];
+  Elf32_Half	e_type;
+  Elf32_Half	e_machine;
+  Elf32_Word	e_version;
+  Elf32_Addr	e_entry;
+  Elf32_Off	e_phoff;
+  Elf32_Off	e_shoff;
+  Elf32_Word	e_flags;
+  Elf32_Half	e_ehsize;
+  Elf32_Half	e_phentsize;
+  Elf32_Half	e_phnum;
+  Elf32_Half	e_shentsize;
+  Elf32_Half	e_shnum;
+  Elf32_Half	e_shstrndx;
+} Elf32_Ehdr;
+
+typedef struct {
+  unsigned char	e_ident[EI_NIDENT];
+  Elf64_Half	e_type;
+  Elf64_Half	e_machine;
+  Elf64_Word	e_version;
+  Elf64_Addr	e_entry;
+  Elf64_Off	e_phoff;
+  Elf64_Off	e_shoff;
+  Elf64_Word	e_flags;
+  Elf64_Half	e_ehsize;
+  Elf64_Half	e_phentsize;
+  Elf64_Half	e_phnum;
+  Elf64_Half	e_shentsize;
+  Elf64_Half	e_shnum;
+  Elf64_Half	e_shstrndx;
+} Elf64_Ehdr;
+
+#define EI_MAG0		0
+#define ELFMAG0		0x7f
+
+#define EI_MAG1		1
+#define ELFMAG1		'E'
+
+#define EI_MAG2		2
+#define ELFMAG2		'L'
+
+#define EI_MAG3		3
+#define ELFMAG3		'F'
+
+
+#define	ELFMAG		"\177ELF"
+#define	SELFMAG		4
+
+#define EI_CLASS	4
+#define ELFCLASSNONE	0
+#define ELFCLASS32	1
+#define ELFCLASS64	2
+#define ELFCLASSNUM	3
+
+#define EI_DATA		5
+#define ELFDATANONE	0
+#define ELFDATA2LSB	1
+#define ELFDATA2MSB	2
+#define ELFDATANUM	3
+
+#define EI_VERSION	6
+
+
+#define EI_OSABI	7
+#define ELFOSABI_NONE		0
+#define ELFOSABI_SYSV		0
+#define ELFOSABI_HPUX		1
+#define ELFOSABI_NETBSD		2
+#define ELFOSABI_LINUX		3
+#define ELFOSABI_GNU		3
+#define ELFOSABI_SOLARIS	6
+#define ELFOSABI_AIX		7
+#define ELFOSABI_IRIX		8
+#define ELFOSABI_FREEBSD	9
+#define ELFOSABI_TRU64		10
+#define ELFOSABI_MODESTO	11
+#define ELFOSABI_OPENBSD	12
+#define ELFOSABI_ARM		97
+#define ELFOSABI_STANDALONE	255
+
+#define EI_ABIVERSION	8
+
+#define EI_PAD		9
+
+
+
+#define ET_NONE		0
+#define ET_REL		1
+#define ET_EXEC		2
+#define ET_DYN		3
+#define ET_CORE		4
+#define	ET_NUM		5
+#define ET_LOOS		0xfe00
+#define ET_HIOS		0xfeff
+#define ET_LOPROC	0xff00
+#define ET_HIPROC	0xffff
+
+
+
+#define EM_NONE		 0
+#define EM_M32		 1
+#define EM_SPARC	 2
+#define EM_386		 3
+#define EM_68K		 4
+#define EM_88K		 5
+#define EM_860		 7
+#define EM_MIPS		 8
+#define EM_S370		 9
+#define EM_MIPS_RS3_LE	10
+
+#define EM_PARISC	15
+#define EM_VPP500	17
+#define EM_SPARC32PLUS	18
+#define EM_960		19
+#define EM_PPC		20
+#define EM_PPC64	21
+#define EM_S390		22
+
+#define EM_V800		36
+#define EM_FR20		37
+#define EM_RH32		38
+#define EM_RCE		39
+#define EM_ARM		40
+#define EM_FAKE_ALPHA	41
+#define EM_SH		42
+#define EM_SPARCV9	43
+#define EM_TRICORE	44
+#define EM_ARC		45
+#define EM_H8_300	46
+#define EM_H8_300H	47
+#define EM_H8S		48
+#define EM_H8_500	49
+#define EM_IA_64	50
+#define EM_MIPS_X	51
+#define EM_COLDFIRE	52
+#define EM_68HC12	53
+#define EM_MMA		54
+#define EM_PCP		55
+#define EM_NCPU		56
+#define EM_NDR1		57
+#define EM_STARCORE	58
+#define EM_ME16		59
+#define EM_ST100	60
+#define EM_TINYJ	61
+#define EM_X86_64	62
+#define EM_PDSP		63
+
+#define EM_FX66		66
+#define EM_ST9PLUS	67
+#define EM_ST7		68
+#define EM_68HC16	69
+#define EM_68HC11	70
+#define EM_68HC08	71
+#define EM_68HC05	72
+#define EM_SVX		73
+#define EM_ST19		74
+#define EM_VAX		75
+#define EM_CRIS		76
+#define EM_JAVELIN	77
+#define EM_FIREPATH	78
+#define EM_ZSP		79
+#define EM_MMIX		80
+#define EM_HUANY	81
+#define EM_PRISM	82
+#define EM_AVR		83
+#define EM_FR30		84
+#define EM_D10V		85
+#define EM_D30V		86
+#define EM_V850		87
+#define EM_M32R		88
+#define EM_MN10300	89
+#define EM_MN10200	90
+#define EM_PJ		91
+#define EM_OR1K		92
+#define EM_OPENRISC	92
+#define EM_ARC_A5	93
+#define EM_ARC_COMPACT	93
+#define EM_XTENSA	94
+#define EM_VIDEOCORE	95
+#define EM_TMM_GPP	96
+#define EM_NS32K	97
+#define EM_TPC		98
+#define EM_SNP1K	99
+#define EM_ST200	100
+#define EM_IP2K		101
+#define EM_MAX		102
+#define EM_CR		103
+#define EM_F2MC16	104
+#define EM_MSP430	105
+#define EM_BLACKFIN	106
+#define EM_SE_C33	107
+#define EM_SEP		108
+#define EM_ARCA		109
+#define EM_UNICORE	110
+#define EM_EXCESS	111
+#define EM_DXP		112
+#define EM_ALTERA_NIOS2 113
+#define EM_CRX		114
+#define EM_XGATE	115
+#define EM_C166		116
+#define EM_M16C		117
+#define EM_DSPIC30F	118
+#define EM_CE		119
+#define EM_M32C		120
+#define EM_TSK3000	131
+#define EM_RS08		132
+#define EM_SHARC	133
+#define EM_ECOG2	134
+#define EM_SCORE7	135
+#define EM_DSP24	136
+#define EM_VIDEOCORE3	137
+#define EM_LATTICEMICO32 138
+#define EM_SE_C17	139
+#define EM_TI_C6000	140
+#define EM_TI_C2000	141
+#define EM_TI_C5500	142
+#define EM_TI_ARP32	143
+#define EM_TI_PRU	144
+#define EM_MMDSP_PLUS	160
+#define EM_CYPRESS_M8C	161
+#define EM_R32C		162
+#define EM_TRIMEDIA	163
+#define EM_QDSP6	164
+#define EM_8051		165
+#define EM_STXP7X	166
+#define EM_NDS32	167
+#define EM_ECOG1X	168
+#define EM_MAXQ30	169
+#define EM_XIMO16	170
+#define EM_MANIK	171
+#define EM_CRAYNV2	172
+#define EM_RX		173
+#define EM_METAG	174
+#define EM_MCST_ELBRUS	175
+#define EM_ECOG16	176
+#define EM_CR16		177
+#define EM_ETPU		178
+#define EM_SLE9X	179
+#define EM_L10M		180
+#define EM_K10M		181
+#define EM_AARCH64	183
+#define EM_AVR32	185
+#define EM_STM8		186
+#define EM_TILE64	187
+#define EM_TILEPRO	188
+#define EM_MICROBLAZE	189
+#define EM_CUDA		190
+#define EM_TILEGX	191
+#define EM_CLOUDSHIELD	192
+#define EM_COREA_1ST	193
+#define EM_COREA_2ND	194
+#define EM_ARC_COMPACT2	195
+#define EM_OPEN8	196
+#define EM_RL78		197
+#define EM_VIDEOCORE5	198
+#define EM_78KOR	199
+#define EM_56800EX	200
+#define EM_BA1		201
+#define EM_BA2		202
+#define EM_XCORE	203
+#define EM_MCHP_PIC	204
+#define EM_KM32		210
+#define EM_KMX32	211
+#define EM_EMX16	212
+#define EM_EMX8		213
+#define EM_KVARC	214
+#define EM_CDP		215
+#define EM_COGE		216
+#define EM_COOL		217
+#define EM_NORC		218
+#define EM_CSR_KALIMBA	219
+#define EM_Z80		220
+#define EM_VISIUM	221
+#define EM_FT32		222
+#define EM_MOXIE	223
+#define EM_AMDGPU	224
+#define EM_RISCV	243
+#define EM_BPF		247
+#define EM_NUM		248
+
+#define EM_ALPHA	0x9026
+
+#define EV_NONE		0
+#define EV_CURRENT	1
+#define EV_NUM		2
+
+typedef struct {
+  Elf32_Word	sh_name;
+  Elf32_Word	sh_type;
+  Elf32_Word	sh_flags;
+  Elf32_Addr	sh_addr;
+  Elf32_Off	sh_offset;
+  Elf32_Word	sh_size;
+  Elf32_Word	sh_link;
+  Elf32_Word	sh_info;
+  Elf32_Word	sh_addralign;
+  Elf32_Word	sh_entsize;
+} Elf32_Shdr;
+
+typedef struct {
+  Elf64_Word	sh_name;
+  Elf64_Word	sh_type;
+  Elf64_Xword	sh_flags;
+  Elf64_Addr	sh_addr;
+  Elf64_Off	sh_offset;
+  Elf64_Xword	sh_size;
+  Elf64_Word	sh_link;
+  Elf64_Word	sh_info;
+  Elf64_Xword	sh_addralign;
+  Elf64_Xword	sh_entsize;
+} Elf64_Shdr;
+
+
+
+#define SHN_UNDEF	0
+#define SHN_LORESERVE	0xff00
+#define SHN_LOPROC	0xff00
+#define SHN_BEFORE	0xff00
+
+#define SHN_AFTER	0xff01
+
+#define SHN_HIPROC	0xff1f
+#define SHN_LOOS	0xff20
+#define SHN_HIOS	0xff3f
+#define SHN_ABS		0xfff1
+#define SHN_COMMON	0xfff2
+#define SHN_XINDEX	0xffff
+#define SHN_HIRESERVE	0xffff
+
+
+
+#define SHT_NULL	  0
+#define SHT_PROGBITS	  1
+#define SHT_SYMTAB	  2
+#define SHT_STRTAB	  3
+#define SHT_RELA	  4
+#define SHT_HASH	  5
+#define SHT_DYNAMIC	  6
+#define SHT_NOTE	  7
+#define SHT_NOBITS	  8
+#define SHT_REL		  9
+#define SHT_SHLIB	  10
+#define SHT_DYNSYM	  11
+#define SHT_INIT_ARRAY	  14
+#define SHT_FINI_ARRAY	  15
+#define SHT_PREINIT_ARRAY 16
+#define SHT_GROUP	  17
+#define SHT_SYMTAB_SHNDX  18
+#define	SHT_NUM		  19
+#define SHT_LOOS	  0x60000000
+#define SHT_GNU_ATTRIBUTES 0x6ffffff5
+#define SHT_GNU_HASH	  0x6ffffff6
+#define SHT_GNU_LIBLIST	  0x6ffffff7
+#define SHT_CHECKSUM	  0x6ffffff8
+#define SHT_LOSUNW	  0x6ffffffa
+#define SHT_SUNW_move	  0x6ffffffa
+#define SHT_SUNW_COMDAT   0x6ffffffb
+#define SHT_SUNW_syminfo  0x6ffffffc
+#define SHT_GNU_verdef	  0x6ffffffd
+#define SHT_GNU_verneed	  0x6ffffffe
+#define SHT_GNU_versym	  0x6fffffff
+#define SHT_HISUNW	  0x6fffffff
+#define SHT_HIOS	  0x6fffffff
+#define SHT_LOPROC	  0x70000000
+#define SHT_HIPROC	  0x7fffffff
+#define SHT_LOUSER	  0x80000000
+#define SHT_HIUSER	  0x8fffffff
+
+#define SHF_WRITE	     (1 << 0)
+#define SHF_ALLOC	     (1 << 1)
+#define SHF_EXECINSTR	     (1 << 2)
+#define SHF_MERGE	     (1 << 4)
+#define SHF_STRINGS	     (1 << 5)
+#define SHF_INFO_LINK	     (1 << 6)
+#define SHF_LINK_ORDER	     (1 << 7)
+#define SHF_OS_NONCONFORMING (1 << 8)
+
+#define SHF_GROUP	     (1 << 9)
+#define SHF_TLS		     (1 << 10)
+#define SHF_COMPRESSED	     (1 << 11)
+#define SHF_MASKOS	     0x0ff00000
+#define SHF_MASKPROC	     0xf0000000
+#define SHF_ORDERED	     (1 << 30)
+#define SHF_EXCLUDE	     (1U << 31)
+
+typedef struct {
+  Elf32_Word	ch_type;
+  Elf32_Word	ch_size;
+  Elf32_Word	ch_addralign;
+} Elf32_Chdr;
+
+typedef struct {
+  Elf64_Word	ch_type;
+  Elf64_Word	ch_reserved;
+  Elf64_Xword	ch_size;
+  Elf64_Xword	ch_addralign;
+} Elf64_Chdr;
+
+#define ELFCOMPRESS_ZLIB	1
+#define ELFCOMPRESS_LOOS	0x60000000
+#define ELFCOMPRESS_HIOS	0x6fffffff
+#define ELFCOMPRESS_LOPROC	0x70000000
+#define ELFCOMPRESS_HIPROC	0x7fffffff
+
+
+#define GRP_COMDAT	0x1
+
+typedef struct {
+  Elf32_Word	st_name;
+  Elf32_Addr	st_value;
+  Elf32_Word	st_size;
+  unsigned char	st_info;
+  unsigned char	st_other;
+  Elf32_Section	st_shndx;
+} Elf32_Sym;
+
+typedef struct {
+  Elf64_Word	st_name;
+  unsigned char	st_info;
+  unsigned char st_other;
+  Elf64_Section	st_shndx;
+  Elf64_Addr	st_value;
+  Elf64_Xword	st_size;
+} Elf64_Sym;
+
+typedef struct {
+  Elf32_Half si_boundto;
+  Elf32_Half si_flags;
+} Elf32_Syminfo;
+
+typedef struct {
+  Elf64_Half si_boundto;
+  Elf64_Half si_flags;
+} Elf64_Syminfo;
+
+#define SYMINFO_BT_SELF		0xffff
+#define SYMINFO_BT_PARENT	0xfffe
+#define SYMINFO_BT_LOWRESERVE	0xff00
+
+#define SYMINFO_FLG_DIRECT	0x0001
+#define SYMINFO_FLG_PASSTHRU	0x0002
+#define SYMINFO_FLG_COPY	0x0004
+#define SYMINFO_FLG_LAZYLOAD	0x0008
+
+#define SYMINFO_NONE		0
+#define SYMINFO_CURRENT		1
+#define SYMINFO_NUM		2
+
+#define ELF32_ST_BIND(val)		(((unsigned char) (val)) >> 4)
+#define ELF32_ST_TYPE(val)		((val) & 0xf)
+#define ELF32_ST_INFO(bind, type)	(((bind) << 4) + ((type) & 0xf))
+
+#define ELF64_ST_BIND(val)		ELF32_ST_BIND (val)
+#define ELF64_ST_TYPE(val)		ELF32_ST_TYPE (val)
+#define ELF64_ST_INFO(bind, type)	ELF32_ST_INFO ((bind), (type))
+
+#define STB_LOCAL	0
+#define STB_GLOBAL	1
+#define STB_WEAK	2
+#define	STB_NUM		3
+#define STB_LOOS	10
+#define STB_GNU_UNIQUE	10
+#define STB_HIOS	12
+#define STB_LOPROC	13
+#define STB_HIPROC	15
+
+#define STT_NOTYPE	0
+#define STT_OBJECT	1
+#define STT_FUNC	2
+#define STT_SECTION	3
+#define STT_FILE	4
+#define STT_COMMON	5
+#define STT_TLS		6
+#define	STT_NUM		7
+#define STT_LOOS	10
+#define STT_GNU_IFUNC	10
+#define STT_HIOS	12
+#define STT_LOPROC	13
+#define STT_HIPROC	15
+
+#define STN_UNDEF	0
+
+#define ELF32_ST_VISIBILITY(o)	((o) & 0x03)
+#define ELF64_ST_VISIBILITY(o)	ELF32_ST_VISIBILITY (o)
+
+#define STV_DEFAULT	0
+#define STV_INTERNAL	1
+#define STV_HIDDEN	2
+#define STV_PROTECTED	3
+
+
+
+
+typedef struct {
+  Elf32_Addr	r_offset;
+  Elf32_Word	r_info;
+} Elf32_Rel;
+
+typedef struct {
+  Elf64_Addr	r_offset;
+  Elf64_Xword	r_info;
+} Elf64_Rel;
+
+
+
+typedef struct {
+  Elf32_Addr	r_offset;
+  Elf32_Word	r_info;
+  Elf32_Sword	r_addend;
+} Elf32_Rela;
+
+typedef struct {
+  Elf64_Addr	r_offset;
+  Elf64_Xword	r_info;
+  Elf64_Sxword	r_addend;
+} Elf64_Rela;
+
+
+
+#define ELF32_R_SYM(val)		((val) >> 8)
+#define ELF32_R_TYPE(val)		((val) & 0xff)
+#define ELF32_R_INFO(sym, type)		(((sym) << 8) + ((type) & 0xff))
+
+#define ELF64_R_SYM(i)			((i) >> 32)
+#define ELF64_R_TYPE(i)			((i) & 0xffffffff)
+#define ELF64_R_INFO(sym,type)		((((Elf64_Xword) (sym)) << 32) + (type))
+
+
+
+typedef struct {
+  Elf32_Word	p_type;
+  Elf32_Off	p_offset;
+  Elf32_Addr	p_vaddr;
+  Elf32_Addr	p_paddr;
+  Elf32_Word	p_filesz;
+  Elf32_Word	p_memsz;
+  Elf32_Word	p_flags;
+  Elf32_Word	p_align;
+} Elf32_Phdr;
+
+typedef struct {
+  Elf64_Word	p_type;
+  Elf64_Word	p_flags;
+  Elf64_Off	p_offset;
+  Elf64_Addr	p_vaddr;
+  Elf64_Addr	p_paddr;
+  Elf64_Xword	p_filesz;
+  Elf64_Xword	p_memsz;
+  Elf64_Xword	p_align;
+} Elf64_Phdr;
+
+
+
+#define	PT_NULL		0
+#define PT_LOAD		1
+#define PT_DYNAMIC	2
+#define PT_INTERP	3
+#define PT_NOTE		4
+#define PT_SHLIB	5
+#define PT_PHDR		6
+#define PT_TLS		7
+#define	PT_NUM		8
+#define PT_LOOS		0x60000000
+#define PT_GNU_EH_FRAME	0x6474e550
+#define PT_GNU_STACK	0x6474e551
+#define PT_GNU_RELRO	0x6474e552
+#define PT_LOSUNW	0x6ffffffa
+#define PT_SUNWBSS	0x6ffffffa
+#define PT_SUNWSTACK	0x6ffffffb
+#define PT_HISUNW	0x6fffffff
+#define PT_HIOS		0x6fffffff
+#define PT_LOPROC	0x70000000
+#define PT_HIPROC	0x7fffffff
+
+
+#define PN_XNUM 0xffff
+
+
+#define PF_X		(1 << 0)
+#define PF_W		(1 << 1)
+#define PF_R		(1 << 2)
+#define PF_MASKOS	0x0ff00000
+#define PF_MASKPROC	0xf0000000
+
+
+
+#define NT_PRSTATUS	1
+#define NT_FPREGSET	2
+#define NT_PRPSINFO	3
+#define NT_PRXREG	4
+#define NT_TASKSTRUCT	4
+#define NT_PLATFORM	5
+#define NT_AUXV		6
+#define NT_GWINDOWS	7
+#define NT_ASRS		8
+#define NT_PSTATUS	10
+#define NT_PSINFO	13
+#define NT_PRCRED	14
+#define NT_UTSNAME	15
+#define NT_LWPSTATUS	16
+#define NT_LWPSINFO	17
+#define NT_PRFPXREG	20
+#define NT_SIGINFO	0x53494749
+#define NT_FILE		0x46494c45
+#define NT_PRXFPREG	0x46e62b7f
+#define NT_PPC_VMX	0x100
+#define NT_PPC_SPE	0x101
+#define NT_PPC_VSX	0x102
+#define NT_386_TLS	0x200
+#define NT_386_IOPERM	0x201
+#define NT_X86_XSTATE	0x202
+#define NT_S390_HIGH_GPRS	0x300
+#define NT_S390_TIMER	0x301
+#define NT_S390_TODCMP	0x302
+#define NT_S390_TODPREG	0x303
+#define NT_S390_CTRS	0x304
+#define NT_S390_PREFIX	0x305
+#define NT_S390_LAST_BREAK	0x306
+#define NT_S390_SYSTEM_CALL	0x307
+#define NT_S390_TDB	0x308
+#define NT_ARM_VFP	0x400
+#define NT_ARM_TLS	0x401
+#define NT_ARM_HW_BREAK	0x402
+#define NT_ARM_HW_WATCH	0x403
+#define NT_ARM_SYSTEM_CALL	0x404
+#define NT_METAG_CBUF	0x500
+#define NT_METAG_RPIPE	0x501
+#define NT_METAG_TLS	0x502
+#define NT_VERSION	1
+
+
+
+
+typedef struct {
+  Elf32_Sword d_tag;
+  union {
+      Elf32_Word d_val;
+      Elf32_Addr d_ptr;
+  } d_un;
+} Elf32_Dyn;
+
+typedef struct {
+  Elf64_Sxword d_tag;
+  union {
+      Elf64_Xword d_val;
+      Elf64_Addr d_ptr;
+  } d_un;
+} Elf64_Dyn;
+
+
+
+#define DT_NULL		0
+#define DT_NEEDED	1
+#define DT_PLTRELSZ	2
+#define DT_PLTGOT	3
+#define DT_HASH		4
+#define DT_STRTAB	5
+#define DT_SYMTAB	6
+#define DT_RELA		7
+#define DT_RELASZ	8
+#define DT_RELAENT	9
+#define DT_STRSZ	10
+#define DT_SYMENT	11
+#define DT_INIT		12
+#define DT_FINI		13
+#define DT_SONAME	14
+#define DT_RPATH	15
+#define DT_SYMBOLIC	16
+#define DT_REL		17
+#define DT_RELSZ	18
+#define DT_RELENT	19
+#define DT_PLTREL	20
+#define DT_DEBUG	21
+#define DT_TEXTREL	22
+#define DT_JMPREL	23
+#define	DT_BIND_NOW	24
+#define	DT_INIT_ARRAY	25
+#define	DT_FINI_ARRAY	26
+#define	DT_INIT_ARRAYSZ	27
+#define	DT_FINI_ARRAYSZ	28
+#define DT_RUNPATH	29
+#define DT_FLAGS	30
+#define DT_ENCODING	32
+#define DT_PREINIT_ARRAY 32
+#define DT_PREINIT_ARRAYSZ 33
+#define	DT_NUM		34
+#define DT_LOOS		0x6000000d
+#define DT_HIOS		0x6ffff000
+#define DT_LOPROC	0x70000000
+#define DT_HIPROC	0x7fffffff
+#define	DT_PROCNUM	DT_MIPS_NUM
+
+#define DT_VALRNGLO	0x6ffffd00
+#define DT_GNU_PRELINKED 0x6ffffdf5
+#define DT_GNU_CONFLICTSZ 0x6ffffdf6
+#define DT_GNU_LIBLISTSZ 0x6ffffdf7
+#define DT_CHECKSUM	0x6ffffdf8
+#define DT_PLTPADSZ	0x6ffffdf9
+#define DT_MOVEENT	0x6ffffdfa
+#define DT_MOVESZ	0x6ffffdfb
+#define DT_FEATURE_1	0x6ffffdfc
+#define DT_POSFLAG_1	0x6ffffdfd
+
+#define DT_SYMINSZ	0x6ffffdfe
+#define DT_SYMINENT	0x6ffffdff
+#define DT_VALRNGHI	0x6ffffdff
+#define DT_VALTAGIDX(tag)	(DT_VALRNGHI - (tag))
+#define DT_VALNUM 12
+
+#define DT_ADDRRNGLO	0x6ffffe00
+#define DT_GNU_HASH	0x6ffffef5
+#define DT_TLSDESC_PLT	0x6ffffef6
+#define DT_TLSDESC_GOT	0x6ffffef7
+#define DT_GNU_CONFLICT	0x6ffffef8
+#define DT_GNU_LIBLIST	0x6ffffef9
+#define DT_CONFIG	0x6ffffefa
+#define DT_DEPAUDIT	0x6ffffefb
+#define DT_AUDIT	0x6ffffefc
+#define	DT_PLTPAD	0x6ffffefd
+#define	DT_MOVETAB	0x6ffffefe
+#define DT_SYMINFO	0x6ffffeff
+#define DT_ADDRRNGHI	0x6ffffeff
+#define DT_ADDRTAGIDX(tag)	(DT_ADDRRNGHI - (tag))
+#define DT_ADDRNUM 11
+
+
+
+#define DT_VERSYM	0x6ffffff0
+
+#define DT_RELACOUNT	0x6ffffff9
+#define DT_RELCOUNT	0x6ffffffa
+
+
+#define DT_FLAGS_1	0x6ffffffb
+#define	DT_VERDEF	0x6ffffffc
+
+#define	DT_VERDEFNUM	0x6ffffffd
+#define	DT_VERNEED	0x6ffffffe
+
+#define	DT_VERNEEDNUM	0x6fffffff
+#define DT_VERSIONTAGIDX(tag)	(DT_VERNEEDNUM - (tag))
+#define DT_VERSIONTAGNUM 16
+
+
+
+#define DT_AUXILIARY    0x7ffffffd
+#define DT_FILTER       0x7fffffff
+#define DT_EXTRATAGIDX(tag)	((Elf32_Word)-((Elf32_Sword) (tag) <<1>>1)-1)
+#define DT_EXTRANUM	3
+
+
+#define DF_ORIGIN	0x00000001
+#define DF_SYMBOLIC	0x00000002
+#define DF_TEXTREL	0x00000004
+#define DF_BIND_NOW	0x00000008
+#define DF_STATIC_TLS	0x00000010
+
+
+
+#define DF_1_NOW	0x00000001
+#define DF_1_GLOBAL	0x00000002
+#define DF_1_GROUP	0x00000004
+#define DF_1_NODELETE	0x00000008
+#define DF_1_LOADFLTR	0x00000010
+#define DF_1_INITFIRST	0x00000020
+#define DF_1_NOOPEN	0x00000040
+#define DF_1_ORIGIN	0x00000080
+#define DF_1_DIRECT	0x00000100
+#define DF_1_TRANS	0x00000200
+#define DF_1_INTERPOSE	0x00000400
+#define DF_1_NODEFLIB	0x00000800
+#define DF_1_NODUMP	0x00001000
+#define DF_1_CONFALT	0x00002000
+#define DF_1_ENDFILTEE	0x00004000
+#define	DF_1_DISPRELDNE	0x00008000
+#define	DF_1_DISPRELPND	0x00010000
+#define	DF_1_NODIRECT	0x00020000
+#define	DF_1_IGNMULDEF	0x00040000
+#define	DF_1_NOKSYMS	0x00080000
+#define	DF_1_NOHDR	0x00100000
+#define	DF_1_EDITED	0x00200000
+#define	DF_1_NORELOC	0x00400000
+#define	DF_1_SYMINTPOSE	0x00800000
+#define	DF_1_GLOBAUDIT	0x01000000
+#define	DF_1_SINGLETON	0x02000000
+
+#define DTF_1_PARINIT	0x00000001
+#define DTF_1_CONFEXP	0x00000002
+
+
+#define DF_P1_LAZYLOAD	0x00000001
+#define DF_P1_GROUPPERM	0x00000002
+
+
+
+
+typedef struct {
+  Elf32_Half	vd_version;
+  Elf32_Half	vd_flags;
+  Elf32_Half	vd_ndx;
+  Elf32_Half	vd_cnt;
+  Elf32_Word	vd_hash;
+  Elf32_Word	vd_aux;
+  Elf32_Word	vd_next;
+} Elf32_Verdef;
+
+typedef struct {
+  Elf64_Half	vd_version;
+  Elf64_Half	vd_flags;
+  Elf64_Half	vd_ndx;
+  Elf64_Half	vd_cnt;
+  Elf64_Word	vd_hash;
+  Elf64_Word	vd_aux;
+  Elf64_Word	vd_next;
+} Elf64_Verdef;
+
+
+
+#define VER_DEF_NONE	0
+#define VER_DEF_CURRENT	1
+#define VER_DEF_NUM	2
+
+
+#define VER_FLG_BASE	0x1
+#define VER_FLG_WEAK	0x2
+
+
+#define	VER_NDX_LOCAL		0
+#define	VER_NDX_GLOBAL		1
+#define	VER_NDX_LORESERVE	0xff00
+#define	VER_NDX_ELIMINATE	0xff01
+
+
+
+typedef struct {
+  Elf32_Word	vda_name;
+  Elf32_Word	vda_next;
+} Elf32_Verdaux;
+
+typedef struct {
+  Elf64_Word	vda_name;
+  Elf64_Word	vda_next;
+} Elf64_Verdaux;
+
+
+
+
+typedef struct {
+  Elf32_Half	vn_version;
+  Elf32_Half	vn_cnt;
+  Elf32_Word	vn_file;
+  Elf32_Word	vn_aux;
+  Elf32_Word	vn_next;
+} Elf32_Verneed;
+
+typedef struct {
+  Elf64_Half	vn_version;
+  Elf64_Half	vn_cnt;
+  Elf64_Word	vn_file;
+  Elf64_Word	vn_aux;
+  Elf64_Word	vn_next;
+} Elf64_Verneed;
+
+
+
+#define VER_NEED_NONE	 0
+#define VER_NEED_CURRENT 1
+#define VER_NEED_NUM	 2
+
+
+
+typedef struct {
+  Elf32_Word	vna_hash;
+  Elf32_Half	vna_flags;
+  Elf32_Half	vna_other;
+  Elf32_Word	vna_name;
+  Elf32_Word	vna_next;
+} Elf32_Vernaux;
+
+typedef struct {
+  Elf64_Word	vna_hash;
+  Elf64_Half	vna_flags;
+  Elf64_Half	vna_other;
+  Elf64_Word	vna_name;
+  Elf64_Word	vna_next;
+} Elf64_Vernaux;
+
+
+
+#define VER_FLG_WEAK	0x2
+
+
+
+typedef struct {
+  uint32_t a_type;
+  union {
+      uint32_t a_val;
+  } a_un;
+} Elf32_auxv_t;
+
+typedef struct {
+  uint64_t a_type;
+  union {
+      uint64_t a_val;
+  } a_un;
+} Elf64_auxv_t;
+
+
+
+#define AT_NULL		0
+#define AT_IGNORE	1
+#define AT_EXECFD	2
+#define AT_PHDR		3
+#define AT_PHENT	4
+#define AT_PHNUM	5
+#define AT_PAGESZ	6
+#define AT_BASE		7
+#define AT_FLAGS	8
+#define AT_ENTRY	9
+#define AT_NOTELF	10
+#define AT_UID		11
+#define AT_EUID		12
+#define AT_GID		13
+#define AT_EGID		14
+#define AT_CLKTCK	17
+
+
+#define AT_PLATFORM	15
+#define AT_HWCAP	16
+
+
+
+
+#define AT_FPUCW	18
+
+
+#define AT_DCACHEBSIZE	19
+#define AT_ICACHEBSIZE	20
+#define AT_UCACHEBSIZE	21
+
+
+
+#define AT_IGNOREPPC	22
+
+#define	AT_SECURE	23
+
+#define AT_BASE_PLATFORM 24
+
+#define AT_RANDOM	25
+
+#define AT_HWCAP2	26
+
+#define AT_EXECFN	31
+
+
+
+#define AT_SYSINFO	32
+#define AT_SYSINFO_EHDR	33
+
+
+
+#define AT_L1I_CACHESHAPE	34
+#define AT_L1D_CACHESHAPE	35
+#define AT_L2_CACHESHAPE	36
+#define AT_L3_CACHESHAPE	37
+
+
+
+
+typedef struct {
+  Elf32_Word n_namesz;
+  Elf32_Word n_descsz;
+  Elf32_Word n_type;
+} Elf32_Nhdr;
+
+typedef struct {
+  Elf64_Word n_namesz;
+  Elf64_Word n_descsz;
+  Elf64_Word n_type;
+} Elf64_Nhdr;
+
+
+
+
+#define ELF_NOTE_SOLARIS	"SUNW Solaris"
+
+
+#define ELF_NOTE_GNU		"GNU"
+
+
+
+
+
+#define ELF_NOTE_PAGESIZE_HINT	1
+
+
+#define NT_GNU_ABI_TAG	1
+#define ELF_NOTE_ABI	NT_GNU_ABI_TAG
+
+
+
+#define ELF_NOTE_OS_LINUX	0
+#define ELF_NOTE_OS_GNU		1
+#define ELF_NOTE_OS_SOLARIS2	2
+#define ELF_NOTE_OS_FREEBSD	3
+
+#define NT_GNU_BUILD_ID	3
+#define NT_GNU_GOLD_VERSION	4
+
+
+
+typedef struct {
+  Elf32_Xword m_value;
+  Elf32_Word m_info;
+  Elf32_Word m_poffset;
+  Elf32_Half m_repeat;
+  Elf32_Half m_stride;
+} Elf32_Move;
+
+typedef struct {
+  Elf64_Xword m_value;
+  Elf64_Xword m_info;
+  Elf64_Xword m_poffset;
+  Elf64_Half m_repeat;
+  Elf64_Half m_stride;
+} Elf64_Move;
+
+
+#define ELF32_M_SYM(info)	((info) >> 8)
+#define ELF32_M_SIZE(info)	((unsigned char) (info))
+#define ELF32_M_INFO(sym, size)	(((sym) << 8) + (unsigned char) (size))
+
+#define ELF64_M_SYM(info)	ELF32_M_SYM (info)
+#define ELF64_M_SIZE(info)	ELF32_M_SIZE (info)
+#define ELF64_M_INFO(sym, size)	ELF32_M_INFO (sym, size)
+
+#define EF_CPU32	0x00810000
+
+#define R_68K_NONE	0
+#define R_68K_32	1
+#define R_68K_16	2
+#define R_68K_8		3
+#define R_68K_PC32	4
+#define R_68K_PC16	5
+#define R_68K_PC8	6
+#define R_68K_GOT32	7
+#define R_68K_GOT16	8
+#define R_68K_GOT8	9
+#define R_68K_GOT32O	10
+#define R_68K_GOT16O	11
+#define R_68K_GOT8O	12
+#define R_68K_PLT32	13
+#define R_68K_PLT16	14
+#define R_68K_PLT8	15
+#define R_68K_PLT32O	16
+#define R_68K_PLT16O	17
+#define R_68K_PLT8O	18
+#define R_68K_COPY	19
+#define R_68K_GLOB_DAT	20
+#define R_68K_JMP_SLOT	21
+#define R_68K_RELATIVE	22
+#define R_68K_NUM	23
+
+#define R_386_NONE	   0
+#define R_386_32	   1
+#define R_386_PC32	   2
+#define R_386_GOT32	   3
+#define R_386_PLT32	   4
+#define R_386_COPY	   5
+#define R_386_GLOB_DAT	   6
+#define R_386_JMP_SLOT	   7
+#define R_386_RELATIVE	   8
+#define R_386_GOTOFF	   9
+#define R_386_GOTPC	   10
+#define R_386_32PLT	   11
+#define R_386_TLS_TPOFF	   14
+#define R_386_TLS_IE	   15
+#define R_386_TLS_GOTIE	   16
+#define R_386_TLS_LE	   17
+#define R_386_TLS_GD	   18
+#define R_386_TLS_LDM	   19
+#define R_386_16	   20
+#define R_386_PC16	   21
+#define R_386_8		   22
+#define R_386_PC8	   23
+#define R_386_TLS_GD_32	   24
+#define R_386_TLS_GD_PUSH  25
+#define R_386_TLS_GD_CALL  26
+#define R_386_TLS_GD_POP   27
+#define R_386_TLS_LDM_32   28
+#define R_386_TLS_LDM_PUSH 29
+#define R_386_TLS_LDM_CALL 30
+#define R_386_TLS_LDM_POP  31
+#define R_386_TLS_LDO_32   32
+#define R_386_TLS_IE_32	   33
+#define R_386_TLS_LE_32	   34
+#define R_386_TLS_DTPMOD32 35
+#define R_386_TLS_DTPOFF32 36
+#define R_386_TLS_TPOFF32  37
+#define R_386_SIZE32       38
+#define R_386_TLS_GOTDESC  39
+#define R_386_TLS_DESC_CALL 40
+#define R_386_TLS_DESC     41
+#define R_386_IRELATIVE	   42
+#define R_386_GOT32X	   43
+#define R_386_NUM	   44
+
+
+
+
+
+#define STT_SPARC_REGISTER	13
+
+
+
+#define EF_SPARCV9_MM		3
+#define EF_SPARCV9_TSO		0
+#define EF_SPARCV9_PSO		1
+#define EF_SPARCV9_RMO		2
+#define EF_SPARC_LEDATA		0x800000
+#define EF_SPARC_EXT_MASK	0xFFFF00
+#define EF_SPARC_32PLUS		0x000100
+#define EF_SPARC_SUN_US1	0x000200
+#define EF_SPARC_HAL_R1		0x000400
+#define EF_SPARC_SUN_US3	0x000800
+
+
+
+#define R_SPARC_NONE		0
+#define R_SPARC_8		1
+#define R_SPARC_16		2
+#define R_SPARC_32		3
+#define R_SPARC_DISP8		4
+#define R_SPARC_DISP16		5
+#define R_SPARC_DISP32		6
+#define R_SPARC_WDISP30		7
+#define R_SPARC_WDISP22		8
+#define R_SPARC_HI22		9
+#define R_SPARC_22		10
+#define R_SPARC_13		11
+#define R_SPARC_LO10		12
+#define R_SPARC_GOT10		13
+#define R_SPARC_GOT13		14
+#define R_SPARC_GOT22		15
+#define R_SPARC_PC10		16
+#define R_SPARC_PC22		17
+#define R_SPARC_WPLT30		18
+#define R_SPARC_COPY		19
+#define R_SPARC_GLOB_DAT	20
+#define R_SPARC_JMP_SLOT	21
+#define R_SPARC_RELATIVE	22
+#define R_SPARC_UA32		23
+
+
+
+#define R_SPARC_PLT32		24
+#define R_SPARC_HIPLT22		25
+#define R_SPARC_LOPLT10		26
+#define R_SPARC_PCPLT32		27
+#define R_SPARC_PCPLT22		28
+#define R_SPARC_PCPLT10		29
+#define R_SPARC_10		30
+#define R_SPARC_11		31
+#define R_SPARC_64		32
+#define R_SPARC_OLO10		33
+#define R_SPARC_HH22		34
+#define R_SPARC_HM10		35
+#define R_SPARC_LM22		36
+#define R_SPARC_PC_HH22		37
+#define R_SPARC_PC_HM10		38
+#define R_SPARC_PC_LM22		39
+#define R_SPARC_WDISP16		40
+#define R_SPARC_WDISP19		41
+#define R_SPARC_GLOB_JMP	42
+#define R_SPARC_7		43
+#define R_SPARC_5		44
+#define R_SPARC_6		45
+#define R_SPARC_DISP64		46
+#define R_SPARC_PLT64		47
+#define R_SPARC_HIX22		48
+#define R_SPARC_LOX10		49
+#define R_SPARC_H44		50
+#define R_SPARC_M44		51
+#define R_SPARC_L44		52
+#define R_SPARC_REGISTER	53
+#define R_SPARC_UA64		54
+#define R_SPARC_UA16		55
+#define R_SPARC_TLS_GD_HI22	56
+#define R_SPARC_TLS_GD_LO10	57
+#define R_SPARC_TLS_GD_ADD	58
+#define R_SPARC_TLS_GD_CALL	59
+#define R_SPARC_TLS_LDM_HI22	60
+#define R_SPARC_TLS_LDM_LO10	61
+#define R_SPARC_TLS_LDM_ADD	62
+#define R_SPARC_TLS_LDM_CALL	63
+#define R_SPARC_TLS_LDO_HIX22	64
+#define R_SPARC_TLS_LDO_LOX10	65
+#define R_SPARC_TLS_LDO_ADD	66
+#define R_SPARC_TLS_IE_HI22	67
+#define R_SPARC_TLS_IE_LO10	68
+#define R_SPARC_TLS_IE_LD	69
+#define R_SPARC_TLS_IE_LDX	70
+#define R_SPARC_TLS_IE_ADD	71
+#define R_SPARC_TLS_LE_HIX22	72
+#define R_SPARC_TLS_LE_LOX10	73
+#define R_SPARC_TLS_DTPMOD32	74
+#define R_SPARC_TLS_DTPMOD64	75
+#define R_SPARC_TLS_DTPOFF32	76
+#define R_SPARC_TLS_DTPOFF64	77
+#define R_SPARC_TLS_TPOFF32	78
+#define R_SPARC_TLS_TPOFF64	79
+#define R_SPARC_GOTDATA_HIX22	80
+#define R_SPARC_GOTDATA_LOX10	81
+#define R_SPARC_GOTDATA_OP_HIX22	82
+#define R_SPARC_GOTDATA_OP_LOX10	83
+#define R_SPARC_GOTDATA_OP	84
+#define R_SPARC_H34		85
+#define R_SPARC_SIZE32		86
+#define R_SPARC_SIZE64		87
+#define R_SPARC_GNU_VTINHERIT	250
+#define R_SPARC_GNU_VTENTRY	251
+#define R_SPARC_REV32		252
+
+#define R_SPARC_NUM		253
+
+
+
+#define DT_SPARC_REGISTER 0x70000001
+#define DT_SPARC_NUM	2
+
+
+#define EF_MIPS_NOREORDER   1
+#define EF_MIPS_PIC	    2
+#define EF_MIPS_CPIC	    4
+#define EF_MIPS_XGOT	    8
+#define EF_MIPS_64BIT_WHIRL 16
+#define EF_MIPS_ABI2	    32
+#define EF_MIPS_ABI_ON32    64
+#define EF_MIPS_FP64	    512
+#define EF_MIPS_NAN2008     1024
+#define EF_MIPS_ARCH	    0xf0000000
+
+
+
+#define EF_MIPS_ARCH_1	    0x00000000
+#define EF_MIPS_ARCH_2	    0x10000000
+#define EF_MIPS_ARCH_3	    0x20000000
+#define EF_MIPS_ARCH_4	    0x30000000
+#define EF_MIPS_ARCH_5	    0x40000000
+#define EF_MIPS_ARCH_32     0x50000000
+#define EF_MIPS_ARCH_64     0x60000000
+#define EF_MIPS_ARCH_32R2   0x70000000
+#define EF_MIPS_ARCH_64R2   0x80000000
+
+
+#define E_MIPS_ARCH_1	  0x00000000
+#define E_MIPS_ARCH_2	  0x10000000
+#define E_MIPS_ARCH_3	  0x20000000
+#define E_MIPS_ARCH_4	  0x30000000
+#define E_MIPS_ARCH_5	  0x40000000
+#define E_MIPS_ARCH_32	  0x50000000
+#define E_MIPS_ARCH_64	  0x60000000
+
+
+
+#define SHN_MIPS_ACOMMON    0xff00
+#define SHN_MIPS_TEXT	    0xff01
+#define SHN_MIPS_DATA	    0xff02
+#define SHN_MIPS_SCOMMON    0xff03
+#define SHN_MIPS_SUNDEFINED 0xff04
+
+
+
+#define SHT_MIPS_LIBLIST       0x70000000
+#define SHT_MIPS_MSYM	       0x70000001
+#define SHT_MIPS_CONFLICT      0x70000002
+#define SHT_MIPS_GPTAB	       0x70000003
+#define SHT_MIPS_UCODE	       0x70000004
+#define SHT_MIPS_DEBUG	       0x70000005
+#define SHT_MIPS_REGINFO       0x70000006
+#define SHT_MIPS_PACKAGE       0x70000007
+#define SHT_MIPS_PACKSYM       0x70000008
+#define SHT_MIPS_RELD	       0x70000009
+#define SHT_MIPS_IFACE         0x7000000b
+#define SHT_MIPS_CONTENT       0x7000000c
+#define SHT_MIPS_OPTIONS       0x7000000d
+#define SHT_MIPS_SHDR	       0x70000010
+#define SHT_MIPS_FDESC	       0x70000011
+#define SHT_MIPS_EXTSYM	       0x70000012
+#define SHT_MIPS_DENSE	       0x70000013
+#define SHT_MIPS_PDESC	       0x70000014
+#define SHT_MIPS_LOCSYM	       0x70000015
+#define SHT_MIPS_AUXSYM	       0x70000016
+#define SHT_MIPS_OPTSYM	       0x70000017
+#define SHT_MIPS_LOCSTR	       0x70000018
+#define SHT_MIPS_LINE	       0x70000019
+#define SHT_MIPS_RFDESC	       0x7000001a
+#define SHT_MIPS_DELTASYM      0x7000001b
+#define SHT_MIPS_DELTAINST     0x7000001c
+#define SHT_MIPS_DELTACLASS    0x7000001d
+#define SHT_MIPS_DWARF         0x7000001e
+#define SHT_MIPS_DELTADECL     0x7000001f
+#define SHT_MIPS_SYMBOL_LIB    0x70000020
+#define SHT_MIPS_EVENTS	       0x70000021
+#define SHT_MIPS_TRANSLATE     0x70000022
+#define SHT_MIPS_PIXIE	       0x70000023
+#define SHT_MIPS_XLATE	       0x70000024
+#define SHT_MIPS_XLATE_DEBUG   0x70000025
+#define SHT_MIPS_WHIRL	       0x70000026
+#define SHT_MIPS_EH_REGION     0x70000027
+#define SHT_MIPS_XLATE_OLD     0x70000028
+#define SHT_MIPS_PDR_EXCEPTION 0x70000029
+
+
+
+#define SHF_MIPS_GPREL	 0x10000000
+#define SHF_MIPS_MERGE	 0x20000000
+#define SHF_MIPS_ADDR	 0x40000000
+#define SHF_MIPS_STRINGS 0x80000000
+#define SHF_MIPS_NOSTRIP 0x08000000
+#define SHF_MIPS_LOCAL	 0x04000000
+#define SHF_MIPS_NAMES	 0x02000000
+#define SHF_MIPS_NODUPE	 0x01000000
+
+
+
+
+
+#define STO_MIPS_DEFAULT		0x0
+#define STO_MIPS_INTERNAL		0x1
+#define STO_MIPS_HIDDEN			0x2
+#define STO_MIPS_PROTECTED		0x3
+#define STO_MIPS_PLT			0x8
+#define STO_MIPS_SC_ALIGN_UNUSED	0xff
+
+
+#define STB_MIPS_SPLIT_COMMON		13
+
+
+
+typedef union {
+  struct {
+      Elf32_Word gt_current_g_value;
+      Elf32_Word gt_unused;
+  } gt_header;
+  struct {
+      Elf32_Word gt_g_value;
+      Elf32_Word gt_bytes;
+  } gt_entry;
+} Elf32_gptab;
+
+
+
+typedef struct {
+  Elf32_Word	ri_gprmask;
+  Elf32_Word	ri_cprmask[4];
+  Elf32_Sword	ri_gp_value;
+} Elf32_RegInfo;
+
+
+
+typedef struct {
+  unsigned char kind;
+
+  unsigned char size;
+  Elf32_Section section;
+
+  Elf32_Word info;
+} Elf_Options;
+
+
+
+#define ODK_NULL	0
+#define ODK_REGINFO	1
+#define ODK_EXCEPTIONS	2
+#define ODK_PAD		3
+#define ODK_HWPATCH	4
+#define ODK_FILL	5
+#define ODK_TAGS	6
+#define ODK_HWAND	7
+#define ODK_HWOR	8
+
+
+
+#define OEX_FPU_MIN	0x1f
+#define OEX_FPU_MAX	0x1f00
+#define OEX_PAGE0	0x10000
+#define OEX_SMM		0x20000
+#define OEX_FPDBUG	0x40000
+#define OEX_PRECISEFP	OEX_FPDBUG
+#define OEX_DISMISS	0x80000
+
+#define OEX_FPU_INVAL	0x10
+#define OEX_FPU_DIV0	0x08
+#define OEX_FPU_OFLO	0x04
+#define OEX_FPU_UFLO	0x02
+#define OEX_FPU_INEX	0x01
+
+
+
+#define OHW_R4KEOP	0x1
+#define OHW_R8KPFETCH	0x2
+#define OHW_R5KEOP	0x4
+#define OHW_R5KCVTL	0x8
+
+#define OPAD_PREFIX	0x1
+#define OPAD_POSTFIX	0x2
+#define OPAD_SYMBOL	0x4
+
+
+
+typedef struct {
+  Elf32_Word hwp_flags1;
+  Elf32_Word hwp_flags2;
+} Elf_Options_Hw;
+
+
+
+#define OHWA0_R4KEOP_CHECKED	0x00000001
+#define OHWA1_R4KEOP_CLEAN	0x00000002
+
+
+
+#define R_MIPS_NONE		0
+#define R_MIPS_16		1
+#define R_MIPS_32		2
+#define R_MIPS_REL32		3
+#define R_MIPS_26		4
+#define R_MIPS_HI16		5
+#define R_MIPS_LO16		6
+#define R_MIPS_GPREL16		7
+#define R_MIPS_LITERAL		8
+#define R_MIPS_GOT16		9
+#define R_MIPS_PC16		10
+#define R_MIPS_CALL16		11
+#define R_MIPS_GPREL32		12
+
+#define R_MIPS_SHIFT5		16
+#define R_MIPS_SHIFT6		17
+#define R_MIPS_64		18
+#define R_MIPS_GOT_DISP		19
+#define R_MIPS_GOT_PAGE		20
+#define R_MIPS_GOT_OFST		21
+#define R_MIPS_GOT_HI16		22
+#define R_MIPS_GOT_LO16		23
+#define R_MIPS_SUB		24
+#define R_MIPS_INSERT_A		25
+#define R_MIPS_INSERT_B		26
+#define R_MIPS_DELETE		27
+#define R_MIPS_HIGHER		28
+#define R_MIPS_HIGHEST		29
+#define R_MIPS_CALL_HI16	30
+#define R_MIPS_CALL_LO16	31
+#define R_MIPS_SCN_DISP		32
+#define R_MIPS_REL16		33
+#define R_MIPS_ADD_IMMEDIATE	34
+#define R_MIPS_PJUMP		35
+#define R_MIPS_RELGOT		36
+#define R_MIPS_JALR		37
+#define R_MIPS_TLS_DTPMOD32	38
+#define R_MIPS_TLS_DTPREL32	39
+#define R_MIPS_TLS_DTPMOD64	40
+#define R_MIPS_TLS_DTPREL64	41
+#define R_MIPS_TLS_GD		42
+#define R_MIPS_TLS_LDM		43
+#define R_MIPS_TLS_DTPREL_HI16	44
+#define R_MIPS_TLS_DTPREL_LO16	45
+#define R_MIPS_TLS_GOTTPREL	46
+#define R_MIPS_TLS_TPREL32	47
+#define R_MIPS_TLS_TPREL64	48
+#define R_MIPS_TLS_TPREL_HI16	49
+#define R_MIPS_TLS_TPREL_LO16	50
+#define R_MIPS_GLOB_DAT		51
+#define R_MIPS_COPY		126
+#define R_MIPS_JUMP_SLOT        127
+
+#define R_MIPS_NUM		128
+
+
+
+#define PT_MIPS_REGINFO	0x70000000
+#define PT_MIPS_RTPROC  0x70000001
+#define PT_MIPS_OPTIONS 0x70000002
+#define PT_MIPS_ABIFLAGS 0x70000003
+
+
+
+#define PF_MIPS_LOCAL	0x10000000
+
+
+
+#define DT_MIPS_RLD_VERSION  0x70000001
+#define DT_MIPS_TIME_STAMP   0x70000002
+#define DT_MIPS_ICHECKSUM    0x70000003
+#define DT_MIPS_IVERSION     0x70000004
+#define DT_MIPS_FLAGS	     0x70000005
+#define DT_MIPS_BASE_ADDRESS 0x70000006
+#define DT_MIPS_MSYM	     0x70000007
+#define DT_MIPS_CONFLICT     0x70000008
+#define DT_MIPS_LIBLIST	     0x70000009
+#define DT_MIPS_LOCAL_GOTNO  0x7000000a
+#define DT_MIPS_CONFLICTNO   0x7000000b
+#define DT_MIPS_LIBLISTNO    0x70000010
+#define DT_MIPS_SYMTABNO     0x70000011
+#define DT_MIPS_UNREFEXTNO   0x70000012
+#define DT_MIPS_GOTSYM	     0x70000013
+#define DT_MIPS_HIPAGENO     0x70000014
+#define DT_MIPS_RLD_MAP	     0x70000016
+#define DT_MIPS_DELTA_CLASS  0x70000017
+#define DT_MIPS_DELTA_CLASS_NO    0x70000018
+
+#define DT_MIPS_DELTA_INSTANCE    0x70000019
+#define DT_MIPS_DELTA_INSTANCE_NO 0x7000001a
+
+#define DT_MIPS_DELTA_RELOC  0x7000001b
+#define DT_MIPS_DELTA_RELOC_NO 0x7000001c
+
+#define DT_MIPS_DELTA_SYM    0x7000001d
+
+#define DT_MIPS_DELTA_SYM_NO 0x7000001e
+
+#define DT_MIPS_DELTA_CLASSSYM 0x70000020
+
+#define DT_MIPS_DELTA_CLASSSYM_NO 0x70000021
+
+#define DT_MIPS_CXX_FLAGS    0x70000022
+#define DT_MIPS_PIXIE_INIT   0x70000023
+#define DT_MIPS_SYMBOL_LIB   0x70000024
+#define DT_MIPS_LOCALPAGE_GOTIDX 0x70000025
+#define DT_MIPS_LOCAL_GOTIDX 0x70000026
+#define DT_MIPS_HIDDEN_GOTIDX 0x70000027
+#define DT_MIPS_PROTECTED_GOTIDX 0x70000028
+#define DT_MIPS_OPTIONS	     0x70000029
+#define DT_MIPS_INTERFACE    0x7000002a
+#define DT_MIPS_DYNSTR_ALIGN 0x7000002b
+#define DT_MIPS_INTERFACE_SIZE 0x7000002c
+#define DT_MIPS_RLD_TEXT_RESOLVE_ADDR 0x7000002d
+
+#define DT_MIPS_PERF_SUFFIX  0x7000002e
+
+#define DT_MIPS_COMPACT_SIZE 0x7000002f
+#define DT_MIPS_GP_VALUE     0x70000030
+#define DT_MIPS_AUX_DYNAMIC  0x70000031
+
+#define DT_MIPS_PLTGOT	     0x70000032
+
+#define DT_MIPS_RWPLT        0x70000034
+#define DT_MIPS_RLD_MAP_REL  0x70000035
+#define DT_MIPS_NUM	     0x36
+
+
+
+#define RHF_NONE		   0
+#define RHF_QUICKSTART		   (1 << 0)
+#define RHF_NOTPOT		   (1 << 1)
+#define RHF_NO_LIBRARY_REPLACEMENT (1 << 2)
+#define RHF_NO_MOVE		   (1 << 3)
+#define RHF_SGI_ONLY		   (1 << 4)
+#define RHF_GUARANTEE_INIT	   (1 << 5)
+#define RHF_DELTA_C_PLUS_PLUS	   (1 << 6)
+#define RHF_GUARANTEE_START_INIT   (1 << 7)
+#define RHF_PIXIE		   (1 << 8)
+#define RHF_DEFAULT_DELAY_LOAD	   (1 << 9)
+#define RHF_REQUICKSTART	   (1 << 10)
+#define RHF_REQUICKSTARTED	   (1 << 11)
+#define RHF_CORD		   (1 << 12)
+#define RHF_NO_UNRES_UNDEF	   (1 << 13)
+#define RHF_RLD_ORDER_SAFE	   (1 << 14)
+
+
+
+typedef struct {
+  Elf32_Word l_name;
+  Elf32_Word l_time_stamp;
+  Elf32_Word l_checksum;
+  Elf32_Word l_version;
+  Elf32_Word l_flags;
+} Elf32_Lib;
+
+typedef struct {
+  Elf64_Word l_name;
+  Elf64_Word l_time_stamp;
+  Elf64_Word l_checksum;
+  Elf64_Word l_version;
+  Elf64_Word l_flags;
+} Elf64_Lib;
+
+
+
+
+#define LL_NONE		  0
+#define LL_EXACT_MATCH	  (1 << 0)
+#define LL_IGNORE_INT_VER (1 << 1)
+#define LL_REQUIRE_MINOR  (1 << 2)
+#define LL_EXPORTS	  (1 << 3)
+#define LL_DELAY_LOAD	  (1 << 4)
+#define LL_DELTA	  (1 << 5)
+
+
+
+typedef Elf32_Addr Elf32_Conflict;
+
+typedef struct {
+  Elf32_Half version;
+  unsigned char isa_level;
+  unsigned char isa_rev;
+  unsigned char gpr_size;
+  unsigned char cpr1_size;
+  unsigned char cpr2_size;
+  unsigned char fp_abi;
+  Elf32_Word isa_ext;
+  Elf32_Word ases;
+  Elf32_Word flags1;
+  Elf32_Word flags2;
+} Elf_MIPS_ABIFlags_v0;
+
+#define MIPS_AFL_REG_NONE	0x00
+#define MIPS_AFL_REG_32		0x01
+#define MIPS_AFL_REG_64		0x02
+#define MIPS_AFL_REG_128	0x03
+
+#define MIPS_AFL_ASE_DSP	0x00000001
+#define MIPS_AFL_ASE_DSPR2	0x00000002
+#define MIPS_AFL_ASE_EVA	0x00000004
+#define MIPS_AFL_ASE_MCU	0x00000008
+#define MIPS_AFL_ASE_MDMX	0x00000010
+#define MIPS_AFL_ASE_MIPS3D	0x00000020
+#define MIPS_AFL_ASE_MT		0x00000040
+#define MIPS_AFL_ASE_SMARTMIPS	0x00000080
+#define MIPS_AFL_ASE_VIRT	0x00000100
+#define MIPS_AFL_ASE_MSA	0x00000200
+#define MIPS_AFL_ASE_MIPS16	0x00000400
+#define MIPS_AFL_ASE_MICROMIPS	0x00000800
+#define MIPS_AFL_ASE_XPA	0x00001000
+#define MIPS_AFL_ASE_MASK	0x00001fff
+
+#define MIPS_AFL_EXT_XLR	  1
+#define MIPS_AFL_EXT_OCTEON2	  2
+#define MIPS_AFL_EXT_OCTEONP	  3
+#define MIPS_AFL_EXT_LOONGSON_3A  4
+#define MIPS_AFL_EXT_OCTEON	  5
+#define MIPS_AFL_EXT_5900	  6
+#define MIPS_AFL_EXT_4650	  7
+#define MIPS_AFL_EXT_4010	  8
+#define MIPS_AFL_EXT_4100	  9
+#define MIPS_AFL_EXT_3900	  10
+#define MIPS_AFL_EXT_10000	  11
+#define MIPS_AFL_EXT_SB1	  12
+#define MIPS_AFL_EXT_4111	  13
+#define MIPS_AFL_EXT_4120	  14
+#define MIPS_AFL_EXT_5400	  15
+#define MIPS_AFL_EXT_5500	  16
+#define MIPS_AFL_EXT_LOONGSON_2E  17
+#define MIPS_AFL_EXT_LOONGSON_2F  18
+
+#define MIPS_AFL_FLAGS1_ODDSPREG  1
+
+enum
+{
+  Val_GNU_MIPS_ABI_FP_ANY = 0,
+  Val_GNU_MIPS_ABI_FP_DOUBLE = 1,
+  Val_GNU_MIPS_ABI_FP_SINGLE = 2,
+  Val_GNU_MIPS_ABI_FP_SOFT = 3,
+  Val_GNU_MIPS_ABI_FP_OLD_64 = 4,
+  Val_GNU_MIPS_ABI_FP_XX = 5,
+  Val_GNU_MIPS_ABI_FP_64 = 6,
+  Val_GNU_MIPS_ABI_FP_64A = 7,
+  Val_GNU_MIPS_ABI_FP_MAX = 7
+};
+
+
+
+
+#define EF_PARISC_TRAPNIL	0x00010000
+#define EF_PARISC_EXT		0x00020000
+#define EF_PARISC_LSB		0x00040000
+#define EF_PARISC_WIDE		0x00080000
+#define EF_PARISC_NO_KABP	0x00100000
+
+#define EF_PARISC_LAZYSWAP	0x00400000
+#define EF_PARISC_ARCH		0x0000ffff
+
+
+
+#define EFA_PARISC_1_0		    0x020b
+#define EFA_PARISC_1_1		    0x0210
+#define EFA_PARISC_2_0		    0x0214
+
+
+
+#define SHN_PARISC_ANSI_COMMON	0xff00
+
+#define SHN_PARISC_HUGE_COMMON	0xff01
+
+
+
+#define SHT_PARISC_EXT		0x70000000
+#define SHT_PARISC_UNWIND	0x70000001
+#define SHT_PARISC_DOC		0x70000002
+
+
+
+#define SHF_PARISC_SHORT	0x20000000
+#define SHF_PARISC_HUGE		0x40000000
+#define SHF_PARISC_SBP		0x80000000
+
+
+
+#define STT_PARISC_MILLICODE	13
+
+#define STT_HP_OPAQUE		(STT_LOOS + 0x1)
+#define STT_HP_STUB		(STT_LOOS + 0x2)
+
+
+
+#define R_PARISC_NONE		0
+#define R_PARISC_DIR32		1
+#define R_PARISC_DIR21L		2
+#define R_PARISC_DIR17R		3
+#define R_PARISC_DIR17F		4
+#define R_PARISC_DIR14R		6
+#define R_PARISC_PCREL32	9
+#define R_PARISC_PCREL21L	10
+#define R_PARISC_PCREL17R	11
+#define R_PARISC_PCREL17F	12
+#define R_PARISC_PCREL14R	14
+#define R_PARISC_DPREL21L	18
+#define R_PARISC_DPREL14R	22
+#define R_PARISC_GPREL21L	26
+#define R_PARISC_GPREL14R	30
+#define R_PARISC_LTOFF21L	34
+#define R_PARISC_LTOFF14R	38
+#define R_PARISC_SECREL32	41
+#define R_PARISC_SEGBASE	48
+#define R_PARISC_SEGREL32	49
+#define R_PARISC_PLTOFF21L	50
+#define R_PARISC_PLTOFF14R	54
+#define R_PARISC_LTOFF_FPTR32	57
+#define R_PARISC_LTOFF_FPTR21L	58
+#define R_PARISC_LTOFF_FPTR14R	62
+#define R_PARISC_FPTR64		64
+#define R_PARISC_PLABEL32	65
+#define R_PARISC_PLABEL21L	66
+#define R_PARISC_PLABEL14R	70
+#define R_PARISC_PCREL64	72
+#define R_PARISC_PCREL22F	74
+#define R_PARISC_PCREL14WR	75
+#define R_PARISC_PCREL14DR	76
+#define R_PARISC_PCREL16F	77
+#define R_PARISC_PCREL16WF	78
+#define R_PARISC_PCREL16DF	79
+#define R_PARISC_DIR64		80
+#define R_PARISC_DIR14WR	83
+#define R_PARISC_DIR14DR	84
+#define R_PARISC_DIR16F		85
+#define R_PARISC_DIR16WF	86
+#define R_PARISC_DIR16DF	87
+#define R_PARISC_GPREL64	88
+#define R_PARISC_GPREL14WR	91
+#define R_PARISC_GPREL14DR	92
+#define R_PARISC_GPREL16F	93
+#define R_PARISC_GPREL16WF	94
+#define R_PARISC_GPREL16DF	95
+#define R_PARISC_LTOFF64	96
+#define R_PARISC_LTOFF14WR	99
+#define R_PARISC_LTOFF14DR	100
+#define R_PARISC_LTOFF16F	101
+#define R_PARISC_LTOFF16WF	102
+#define R_PARISC_LTOFF16DF	103
+#define R_PARISC_SECREL64	104
+#define R_PARISC_SEGREL64	112
+#define R_PARISC_PLTOFF14WR	115
+#define R_PARISC_PLTOFF14DR	116
+#define R_PARISC_PLTOFF16F	117
+#define R_PARISC_PLTOFF16WF	118
+#define R_PARISC_PLTOFF16DF	119
+#define R_PARISC_LTOFF_FPTR64	120
+#define R_PARISC_LTOFF_FPTR14WR	123
+#define R_PARISC_LTOFF_FPTR14DR	124
+#define R_PARISC_LTOFF_FPTR16F	125
+#define R_PARISC_LTOFF_FPTR16WF	126
+#define R_PARISC_LTOFF_FPTR16DF	127
+#define R_PARISC_LORESERVE	128
+#define R_PARISC_COPY		128
+#define R_PARISC_IPLT		129
+#define R_PARISC_EPLT		130
+#define R_PARISC_TPREL32	153
+#define R_PARISC_TPREL21L	154
+#define R_PARISC_TPREL14R	158
+#define R_PARISC_LTOFF_TP21L	162
+#define R_PARISC_LTOFF_TP14R	166
+#define R_PARISC_LTOFF_TP14F	167
+#define R_PARISC_TPREL64	216
+#define R_PARISC_TPREL14WR	219
+#define R_PARISC_TPREL14DR	220
+#define R_PARISC_TPREL16F	221
+#define R_PARISC_TPREL16WF	222
+#define R_PARISC_TPREL16DF	223
+#define R_PARISC_LTOFF_TP64	224
+#define R_PARISC_LTOFF_TP14WR	227
+#define R_PARISC_LTOFF_TP14DR	228
+#define R_PARISC_LTOFF_TP16F	229
+#define R_PARISC_LTOFF_TP16WF	230
+#define R_PARISC_LTOFF_TP16DF	231
+#define R_PARISC_GNU_VTENTRY	232
+#define R_PARISC_GNU_VTINHERIT	233
+#define R_PARISC_TLS_GD21L	234
+#define R_PARISC_TLS_GD14R	235
+#define R_PARISC_TLS_GDCALL	236
+#define R_PARISC_TLS_LDM21L	237
+#define R_PARISC_TLS_LDM14R	238
+#define R_PARISC_TLS_LDMCALL	239
+#define R_PARISC_TLS_LDO21L	240
+#define R_PARISC_TLS_LDO14R	241
+#define R_PARISC_TLS_DTPMOD32	242
+#define R_PARISC_TLS_DTPMOD64	243
+#define R_PARISC_TLS_DTPOFF32	244
+#define R_PARISC_TLS_DTPOFF64	245
+#define R_PARISC_TLS_LE21L	R_PARISC_TPREL21L
+#define R_PARISC_TLS_LE14R	R_PARISC_TPREL14R
+#define R_PARISC_TLS_IE21L	R_PARISC_LTOFF_TP21L
+#define R_PARISC_TLS_IE14R	R_PARISC_LTOFF_TP14R
+#define R_PARISC_TLS_TPREL32	R_PARISC_TPREL32
+#define R_PARISC_TLS_TPREL64	R_PARISC_TPREL64
+#define R_PARISC_HIRESERVE	255
+
+
+
+#define PT_HP_TLS		(PT_LOOS + 0x0)
+#define PT_HP_CORE_NONE		(PT_LOOS + 0x1)
+#define PT_HP_CORE_VERSION	(PT_LOOS + 0x2)
+#define PT_HP_CORE_KERNEL	(PT_LOOS + 0x3)
+#define PT_HP_CORE_COMM		(PT_LOOS + 0x4)
+#define PT_HP_CORE_PROC		(PT_LOOS + 0x5)
+#define PT_HP_CORE_LOADABLE	(PT_LOOS + 0x6)
+#define PT_HP_CORE_STACK	(PT_LOOS + 0x7)
+#define PT_HP_CORE_SHM		(PT_LOOS + 0x8)
+#define PT_HP_CORE_MMF		(PT_LOOS + 0x9)
+#define PT_HP_PARALLEL		(PT_LOOS + 0x10)
+#define PT_HP_FASTBIND		(PT_LOOS + 0x11)
+#define PT_HP_OPT_ANNOT		(PT_LOOS + 0x12)
+#define PT_HP_HSL_ANNOT		(PT_LOOS + 0x13)
+#define PT_HP_STACK		(PT_LOOS + 0x14)
+
+#define PT_PARISC_ARCHEXT	0x70000000
+#define PT_PARISC_UNWIND	0x70000001
+
+
+
+#define PF_PARISC_SBP		0x08000000
+
+#define PF_HP_PAGE_SIZE		0x00100000
+#define PF_HP_FAR_SHARED	0x00200000
+#define PF_HP_NEAR_SHARED	0x00400000
+#define PF_HP_CODE		0x01000000
+#define PF_HP_MODIFY		0x02000000
+#define PF_HP_LAZYSWAP		0x04000000
+#define PF_HP_SBP		0x08000000
+
+
+
+
+
+
+#define EF_ALPHA_32BIT		1
+#define EF_ALPHA_CANRELAX	2
+
+
+
+
+#define SHT_ALPHA_DEBUG		0x70000001
+#define SHT_ALPHA_REGINFO	0x70000002
+
+
+
+#define SHF_ALPHA_GPREL		0x10000000
+
+
+#define STO_ALPHA_NOPV		0x80
+#define STO_ALPHA_STD_GPLOAD	0x88
+
+
+
+#define R_ALPHA_NONE		0
+#define R_ALPHA_REFLONG		1
+#define R_ALPHA_REFQUAD		2
+#define R_ALPHA_GPREL32		3
+#define R_ALPHA_LITERAL		4
+#define R_ALPHA_LITUSE		5
+#define R_ALPHA_GPDISP		6
+#define R_ALPHA_BRADDR		7
+#define R_ALPHA_HINT		8
+#define R_ALPHA_SREL16		9
+#define R_ALPHA_SREL32		10
+#define R_ALPHA_SREL64		11
+#define R_ALPHA_GPRELHIGH	17
+#define R_ALPHA_GPRELLOW	18
+#define R_ALPHA_GPREL16		19
+#define R_ALPHA_COPY		24
+#define R_ALPHA_GLOB_DAT	25
+#define R_ALPHA_JMP_SLOT	26
+#define R_ALPHA_RELATIVE	27
+#define R_ALPHA_TLS_GD_HI	28
+#define R_ALPHA_TLSGD		29
+#define R_ALPHA_TLS_LDM		30
+#define R_ALPHA_DTPMOD64	31
+#define R_ALPHA_GOTDTPREL	32
+#define R_ALPHA_DTPREL64	33
+#define R_ALPHA_DTPRELHI	34
+#define R_ALPHA_DTPRELLO	35
+#define R_ALPHA_DTPREL16	36
+#define R_ALPHA_GOTTPREL	37
+#define R_ALPHA_TPREL64		38
+#define R_ALPHA_TPRELHI		39
+#define R_ALPHA_TPRELLO		40
+#define R_ALPHA_TPREL16		41
+
+#define R_ALPHA_NUM		46
+
+
+#define LITUSE_ALPHA_ADDR	0
+#define LITUSE_ALPHA_BASE	1
+#define LITUSE_ALPHA_BYTOFF	2
+#define LITUSE_ALPHA_JSR	3
+#define LITUSE_ALPHA_TLS_GD	4
+#define LITUSE_ALPHA_TLS_LDM	5
+
+
+#define DT_ALPHA_PLTRO		(DT_LOPROC + 0)
+#define DT_ALPHA_NUM		1
+
+
+
+
+#define EF_PPC_EMB		0x80000000
+
+
+#define EF_PPC_RELOCATABLE	0x00010000
+#define EF_PPC_RELOCATABLE_LIB	0x00008000
+
+
+
+#define R_PPC_NONE		0
+#define R_PPC_ADDR32		1
+#define R_PPC_ADDR24		2
+#define R_PPC_ADDR16		3
+#define R_PPC_ADDR16_LO		4
+#define R_PPC_ADDR16_HI		5
+#define R_PPC_ADDR16_HA		6
+#define R_PPC_ADDR14		7
+#define R_PPC_ADDR14_BRTAKEN	8
+#define R_PPC_ADDR14_BRNTAKEN	9
+#define R_PPC_REL24		10
+#define R_PPC_REL14		11
+#define R_PPC_REL14_BRTAKEN	12
+#define R_PPC_REL14_BRNTAKEN	13
+#define R_PPC_GOT16		14
+#define R_PPC_GOT16_LO		15
+#define R_PPC_GOT16_HI		16
+#define R_PPC_GOT16_HA		17
+#define R_PPC_PLTREL24		18
+#define R_PPC_COPY		19
+#define R_PPC_GLOB_DAT		20
+#define R_PPC_JMP_SLOT		21
+#define R_PPC_RELATIVE		22
+#define R_PPC_LOCAL24PC		23
+#define R_PPC_UADDR32		24
+#define R_PPC_UADDR16		25
+#define R_PPC_REL32		26
+#define R_PPC_PLT32		27
+#define R_PPC_PLTREL32		28
+#define R_PPC_PLT16_LO		29
+#define R_PPC_PLT16_HI		30
+#define R_PPC_PLT16_HA		31
+#define R_PPC_SDAREL16		32
+#define R_PPC_SECTOFF		33
+#define R_PPC_SECTOFF_LO	34
+#define R_PPC_SECTOFF_HI	35
+#define R_PPC_SECTOFF_HA	36
+
+
+#define R_PPC_TLS		67
+#define R_PPC_DTPMOD32		68
+#define R_PPC_TPREL16		69
+#define R_PPC_TPREL16_LO	70
+#define R_PPC_TPREL16_HI	71
+#define R_PPC_TPREL16_HA	72
+#define R_PPC_TPREL32		73
+#define R_PPC_DTPREL16		74
+#define R_PPC_DTPREL16_LO	75
+#define R_PPC_DTPREL16_HI	76
+#define R_PPC_DTPREL16_HA	77
+#define R_PPC_DTPREL32		78
+#define R_PPC_GOT_TLSGD16	79
+#define R_PPC_GOT_TLSGD16_LO	80
+#define R_PPC_GOT_TLSGD16_HI	81
+#define R_PPC_GOT_TLSGD16_HA	82
+#define R_PPC_GOT_TLSLD16	83
+#define R_PPC_GOT_TLSLD16_LO	84
+#define R_PPC_GOT_TLSLD16_HI	85
+#define R_PPC_GOT_TLSLD16_HA	86
+#define R_PPC_GOT_TPREL16	87
+#define R_PPC_GOT_TPREL16_LO	88
+#define R_PPC_GOT_TPREL16_HI	89
+#define R_PPC_GOT_TPREL16_HA	90
+#define R_PPC_GOT_DTPREL16	91
+#define R_PPC_GOT_DTPREL16_LO	92
+#define R_PPC_GOT_DTPREL16_HI	93
+#define R_PPC_GOT_DTPREL16_HA	94
+#define R_PPC_TLSGD		95
+#define R_PPC_TLSLD		96
+
+
+#define R_PPC_EMB_NADDR32	101
+#define R_PPC_EMB_NADDR16	102
+#define R_PPC_EMB_NADDR16_LO	103
+#define R_PPC_EMB_NADDR16_HI	104
+#define R_PPC_EMB_NADDR16_HA	105
+#define R_PPC_EMB_SDAI16	106
+#define R_PPC_EMB_SDA2I16	107
+#define R_PPC_EMB_SDA2REL	108
+#define R_PPC_EMB_SDA21		109
+#define R_PPC_EMB_MRKREF	110
+#define R_PPC_EMB_RELSEC16	111
+#define R_PPC_EMB_RELST_LO	112
+#define R_PPC_EMB_RELST_HI	113
+#define R_PPC_EMB_RELST_HA	114
+#define R_PPC_EMB_BIT_FLD	115
+#define R_PPC_EMB_RELSDA	116
+
+
+#define R_PPC_DIAB_SDA21_LO	180
+#define R_PPC_DIAB_SDA21_HI	181
+#define R_PPC_DIAB_SDA21_HA	182
+#define R_PPC_DIAB_RELSDA_LO	183
+#define R_PPC_DIAB_RELSDA_HI	184
+#define R_PPC_DIAB_RELSDA_HA	185
+
+
+#define R_PPC_IRELATIVE		248
+
+
+#define R_PPC_REL16		249
+#define R_PPC_REL16_LO		250
+#define R_PPC_REL16_HI		251
+#define R_PPC_REL16_HA		252
+
+
+
+#define R_PPC_TOC16		255
+
+
+#define DT_PPC_GOT		(DT_LOPROC + 0)
+#define DT_PPC_OPT		(DT_LOPROC + 1)
+#define DT_PPC_NUM		2
+
+#define PPC_OPT_TLS		1
+
+
+#define R_PPC64_NONE		R_PPC_NONE
+#define R_PPC64_ADDR32		R_PPC_ADDR32
+#define R_PPC64_ADDR24		R_PPC_ADDR24
+#define R_PPC64_ADDR16		R_PPC_ADDR16
+#define R_PPC64_ADDR16_LO	R_PPC_ADDR16_LO
+#define R_PPC64_ADDR16_HI	R_PPC_ADDR16_HI
+#define R_PPC64_ADDR16_HA	R_PPC_ADDR16_HA
+#define R_PPC64_ADDR14		R_PPC_ADDR14
+#define R_PPC64_ADDR14_BRTAKEN	R_PPC_ADDR14_BRTAKEN
+#define R_PPC64_ADDR14_BRNTAKEN	R_PPC_ADDR14_BRNTAKEN
+#define R_PPC64_REL24		R_PPC_REL24
+#define R_PPC64_REL14		R_PPC_REL14
+#define R_PPC64_REL14_BRTAKEN	R_PPC_REL14_BRTAKEN
+#define R_PPC64_REL14_BRNTAKEN	R_PPC_REL14_BRNTAKEN
+#define R_PPC64_GOT16		R_PPC_GOT16
+#define R_PPC64_GOT16_LO	R_PPC_GOT16_LO
+#define R_PPC64_GOT16_HI	R_PPC_GOT16_HI
+#define R_PPC64_GOT16_HA	R_PPC_GOT16_HA
+
+#define R_PPC64_COPY		R_PPC_COPY
+#define R_PPC64_GLOB_DAT	R_PPC_GLOB_DAT
+#define R_PPC64_JMP_SLOT	R_PPC_JMP_SLOT
+#define R_PPC64_RELATIVE	R_PPC_RELATIVE
+
+#define R_PPC64_UADDR32		R_PPC_UADDR32
+#define R_PPC64_UADDR16		R_PPC_UADDR16
+#define R_PPC64_REL32		R_PPC_REL32
+#define R_PPC64_PLT32		R_PPC_PLT32
+#define R_PPC64_PLTREL32	R_PPC_PLTREL32
+#define R_PPC64_PLT16_LO	R_PPC_PLT16_LO
+#define R_PPC64_PLT16_HI	R_PPC_PLT16_HI
+#define R_PPC64_PLT16_HA	R_PPC_PLT16_HA
+
+#define R_PPC64_SECTOFF		R_PPC_SECTOFF
+#define R_PPC64_SECTOFF_LO	R_PPC_SECTOFF_LO
+#define R_PPC64_SECTOFF_HI	R_PPC_SECTOFF_HI
+#define R_PPC64_SECTOFF_HA	R_PPC_SECTOFF_HA
+#define R_PPC64_ADDR30		37
+#define R_PPC64_ADDR64		38
+#define R_PPC64_ADDR16_HIGHER	39
+#define R_PPC64_ADDR16_HIGHERA	40
+#define R_PPC64_ADDR16_HIGHEST	41
+#define R_PPC64_ADDR16_HIGHESTA	42
+#define R_PPC64_UADDR64		43
+#define R_PPC64_REL64		44
+#define R_PPC64_PLT64		45
+#define R_PPC64_PLTREL64	46
+#define R_PPC64_TOC16		47
+#define R_PPC64_TOC16_LO	48
+#define R_PPC64_TOC16_HI	49
+#define R_PPC64_TOC16_HA	50
+#define R_PPC64_TOC		51
+#define R_PPC64_PLTGOT16	52
+#define R_PPC64_PLTGOT16_LO	53
+#define R_PPC64_PLTGOT16_HI	54
+#define R_PPC64_PLTGOT16_HA	55
+
+#define R_PPC64_ADDR16_DS	56
+#define R_PPC64_ADDR16_LO_DS	57
+#define R_PPC64_GOT16_DS	58
+#define R_PPC64_GOT16_LO_DS	59
+#define R_PPC64_PLT16_LO_DS	60
+#define R_PPC64_SECTOFF_DS	61
+#define R_PPC64_SECTOFF_LO_DS	62
+#define R_PPC64_TOC16_DS	63
+#define R_PPC64_TOC16_LO_DS	64
+#define R_PPC64_PLTGOT16_DS	65
+#define R_PPC64_PLTGOT16_LO_DS	66
+
+
+#define R_PPC64_TLS		67
+#define R_PPC64_DTPMOD64	68
+#define R_PPC64_TPREL16		69
+#define R_PPC64_TPREL16_LO	70
+#define R_PPC64_TPREL16_HI	71
+#define R_PPC64_TPREL16_HA	72
+#define R_PPC64_TPREL64		73
+#define R_PPC64_DTPREL16	74
+#define R_PPC64_DTPREL16_LO	75
+#define R_PPC64_DTPREL16_HI	76
+#define R_PPC64_DTPREL16_HA	77
+#define R_PPC64_DTPREL64	78
+#define R_PPC64_GOT_TLSGD16	79
+#define R_PPC64_GOT_TLSGD16_LO	80
+#define R_PPC64_GOT_TLSGD16_HI	81
+#define R_PPC64_GOT_TLSGD16_HA	82
+#define R_PPC64_GOT_TLSLD16	83
+#define R_PPC64_GOT_TLSLD16_LO	84
+#define R_PPC64_GOT_TLSLD16_HI	85
+#define R_PPC64_GOT_TLSLD16_HA	86
+#define R_PPC64_GOT_TPREL16_DS	87
+#define R_PPC64_GOT_TPREL16_LO_DS 88
+#define R_PPC64_GOT_TPREL16_HI	89
+#define R_PPC64_GOT_TPREL16_HA	90
+#define R_PPC64_GOT_DTPREL16_DS	91
+#define R_PPC64_GOT_DTPREL16_LO_DS 92
+#define R_PPC64_GOT_DTPREL16_HI	93
+#define R_PPC64_GOT_DTPREL16_HA	94
+#define R_PPC64_TPREL16_DS	95
+#define R_PPC64_TPREL16_LO_DS	96
+#define R_PPC64_TPREL16_HIGHER	97
+#define R_PPC64_TPREL16_HIGHERA	98
+#define R_PPC64_TPREL16_HIGHEST	99
+#define R_PPC64_TPREL16_HIGHESTA 100
+#define R_PPC64_DTPREL16_DS	101
+#define R_PPC64_DTPREL16_LO_DS	102
+#define R_PPC64_DTPREL16_HIGHER	103
+#define R_PPC64_DTPREL16_HIGHERA 104
+#define R_PPC64_DTPREL16_HIGHEST 105
+#define R_PPC64_DTPREL16_HIGHESTA 106
+#define R_PPC64_TLSGD		107
+#define R_PPC64_TLSLD		108
+#define R_PPC64_TOCSAVE		109
+#define R_PPC64_ADDR16_HIGH	110
+#define R_PPC64_ADDR16_HIGHA	111
+#define R_PPC64_TPREL16_HIGH	112
+#define R_PPC64_TPREL16_HIGHA	113
+#define R_PPC64_DTPREL16_HIGH	114
+#define R_PPC64_DTPREL16_HIGHA	115
+
+
+#define R_PPC64_JMP_IREL	247
+#define R_PPC64_IRELATIVE	248
+#define R_PPC64_REL16		249
+#define R_PPC64_REL16_LO	250
+#define R_PPC64_REL16_HI	251
+#define R_PPC64_REL16_HA	252
+
+#define EF_PPC64_ABI	3
+
+#define DT_PPC64_GLINK  (DT_LOPROC + 0)
+#define DT_PPC64_OPD	(DT_LOPROC + 1)
+#define DT_PPC64_OPDSZ	(DT_LOPROC + 2)
+#define DT_PPC64_OPT	(DT_LOPROC + 3)
+#define DT_PPC64_NUM	4
+
+#define PPC64_OPT_TLS		1
+#define PPC64_OPT_MULTI_TOC	2
+
+#define STO_PPC64_LOCAL_BIT	5
+#define STO_PPC64_LOCAL_MASK	0xe0
+#define PPC64_LOCAL_ENTRY_OFFSET(x) (1 << (((x)&0xe0)>>5) & 0xfc)
+
+
+#define EF_ARM_RELEXEC		0x01
+#define EF_ARM_HASENTRY		0x02
+#define EF_ARM_INTERWORK	0x04
+#define EF_ARM_APCS_26		0x08
+#define EF_ARM_APCS_FLOAT	0x10
+#define EF_ARM_PIC		0x20
+#define EF_ARM_ALIGN8		0x40
+#define EF_ARM_NEW_ABI		0x80
+#define EF_ARM_OLD_ABI		0x100
+#define EF_ARM_SOFT_FLOAT	0x200
+#define EF_ARM_VFP_FLOAT	0x400
+#define EF_ARM_MAVERICK_FLOAT	0x800
+
+#define EF_ARM_ABI_FLOAT_SOFT	0x200
+#define EF_ARM_ABI_FLOAT_HARD	0x400
+
+
+#define EF_ARM_SYMSARESORTED	0x04
+#define EF_ARM_DYNSYMSUSESEGIDX	0x08
+#define EF_ARM_MAPSYMSFIRST	0x10
+#define EF_ARM_EABIMASK		0XFF000000
+
+
+#define EF_ARM_BE8	    0x00800000
+#define EF_ARM_LE8	    0x00400000
+
+#define EF_ARM_EABI_VERSION(flags)	((flags) & EF_ARM_EABIMASK)
+#define EF_ARM_EABI_UNKNOWN	0x00000000
+#define EF_ARM_EABI_VER1	0x01000000
+#define EF_ARM_EABI_VER2	0x02000000
+#define EF_ARM_EABI_VER3	0x03000000
+#define EF_ARM_EABI_VER4	0x04000000
+#define EF_ARM_EABI_VER5	0x05000000
+
+
+#define STT_ARM_TFUNC		STT_LOPROC
+#define STT_ARM_16BIT		STT_HIPROC
+
+
+#define SHF_ARM_ENTRYSECT	0x10000000
+#define SHF_ARM_COMDEF		0x80000000
+
+
+
+#define PF_ARM_SB		0x10000000
+
+#define PF_ARM_PI		0x20000000
+#define PF_ARM_ABS		0x40000000
+
+
+#define PT_ARM_EXIDX		(PT_LOPROC + 1)
+
+
+#define SHT_ARM_EXIDX		(SHT_LOPROC + 1)
+#define SHT_ARM_PREEMPTMAP	(SHT_LOPROC + 2)
+#define SHT_ARM_ATTRIBUTES	(SHT_LOPROC + 3)
+
+#define R_AARCH64_NONE            0
+#define R_AARCH64_P32_ABS32	1
+#define R_AARCH64_P32_COPY	180
+#define R_AARCH64_P32_GLOB_DAT	181
+#define R_AARCH64_P32_JUMP_SLOT	182
+#define R_AARCH64_P32_RELATIVE	183
+#define R_AARCH64_P32_TLS_DTPMOD 184
+#define R_AARCH64_P32_TLS_DTPREL 185
+#define R_AARCH64_P32_TLS_TPREL	186
+#define R_AARCH64_P32_TLSDESC	187
+#define R_AARCH64_P32_IRELATIVE	188
+#define R_AARCH64_ABS64         257
+#define R_AARCH64_ABS32         258
+#define R_AARCH64_ABS16		259
+#define R_AARCH64_PREL64	260
+#define R_AARCH64_PREL32	261
+#define R_AARCH64_PREL16	262
+#define R_AARCH64_MOVW_UABS_G0	263
+#define R_AARCH64_MOVW_UABS_G0_NC 264
+#define R_AARCH64_MOVW_UABS_G1	265
+#define R_AARCH64_MOVW_UABS_G1_NC 266
+#define R_AARCH64_MOVW_UABS_G2	267
+#define R_AARCH64_MOVW_UABS_G2_NC 268
+#define R_AARCH64_MOVW_UABS_G3	269
+#define R_AARCH64_MOVW_SABS_G0	270
+#define R_AARCH64_MOVW_SABS_G1	271
+#define R_AARCH64_MOVW_SABS_G2	272
+#define R_AARCH64_LD_PREL_LO19	273
+#define R_AARCH64_ADR_PREL_LO21	274
+#define R_AARCH64_ADR_PREL_PG_HI21 275
+#define R_AARCH64_ADR_PREL_PG_HI21_NC 276
+#define R_AARCH64_ADD_ABS_LO12_NC 277
+#define R_AARCH64_LDST8_ABS_LO12_NC 278
+#define R_AARCH64_TSTBR14	279
+#define R_AARCH64_CONDBR19	280
+#define R_AARCH64_JUMP26	282
+#define R_AARCH64_CALL26	283
+#define R_AARCH64_LDST16_ABS_LO12_NC 284
+#define R_AARCH64_LDST32_ABS_LO12_NC 285
+#define R_AARCH64_LDST64_ABS_LO12_NC 286
+#define R_AARCH64_MOVW_PREL_G0	287
+#define R_AARCH64_MOVW_PREL_G0_NC 288
+#define R_AARCH64_MOVW_PREL_G1	289
+#define R_AARCH64_MOVW_PREL_G1_NC 290
+#define R_AARCH64_MOVW_PREL_G2	291
+#define R_AARCH64_MOVW_PREL_G2_NC 292
+#define R_AARCH64_MOVW_PREL_G3	293
+#define R_AARCH64_LDST128_ABS_LO12_NC 299
+#define R_AARCH64_MOVW_GOTOFF_G0 300
+#define R_AARCH64_MOVW_GOTOFF_G0_NC 301
+#define R_AARCH64_MOVW_GOTOFF_G1 302
+#define R_AARCH64_MOVW_GOTOFF_G1_NC 303
+#define R_AARCH64_MOVW_GOTOFF_G2 304
+#define R_AARCH64_MOVW_GOTOFF_G2_NC 305
+#define R_AARCH64_MOVW_GOTOFF_G3 306
+#define R_AARCH64_GOTREL64	307
+#define R_AARCH64_GOTREL32	308
+#define R_AARCH64_GOT_LD_PREL19	309
+#define R_AARCH64_LD64_GOTOFF_LO15 310
+#define R_AARCH64_ADR_GOT_PAGE	311
+#define R_AARCH64_LD64_GOT_LO12_NC 312
+#define R_AARCH64_LD64_GOTPAGE_LO15 313
+#define R_AARCH64_TLSGD_ADR_PREL21 512
+#define R_AARCH64_TLSGD_ADR_PAGE21 513
+#define R_AARCH64_TLSGD_ADD_LO12_NC 514
+#define R_AARCH64_TLSGD_MOVW_G1	515
+#define R_AARCH64_TLSGD_MOVW_G0_NC 516
+#define R_AARCH64_TLSLD_ADR_PREL21 517
+#define R_AARCH64_TLSLD_ADR_PAGE21 518
+#define R_AARCH64_TLSLD_ADD_LO12_NC 519
+#define R_AARCH64_TLSLD_MOVW_G1	520
+#define R_AARCH64_TLSLD_MOVW_G0_NC 521
+#define R_AARCH64_TLSLD_LD_PREL19 522
+#define R_AARCH64_TLSLD_MOVW_DTPREL_G2 523
+#define R_AARCH64_TLSLD_MOVW_DTPREL_G1 524
+#define R_AARCH64_TLSLD_MOVW_DTPREL_G1_NC 525
+#define R_AARCH64_TLSLD_MOVW_DTPREL_G0 526
+#define R_AARCH64_TLSLD_MOVW_DTPREL_G0_NC 527
+#define R_AARCH64_TLSLD_ADD_DTPREL_HI12 528
+#define R_AARCH64_TLSLD_ADD_DTPREL_LO12 529
+#define R_AARCH64_TLSLD_ADD_DTPREL_LO12_NC 530
+#define R_AARCH64_TLSLD_LDST8_DTPREL_LO12 531
+#define R_AARCH64_TLSLD_LDST8_DTPREL_LO12_NC 532
+#define R_AARCH64_TLSLD_LDST16_DTPREL_LO12 533
+#define R_AARCH64_TLSLD_LDST16_DTPREL_LO12_NC 534
+#define R_AARCH64_TLSLD_LDST32_DTPREL_LO12 535
+#define R_AARCH64_TLSLD_LDST32_DTPREL_LO12_NC 536
+#define R_AARCH64_TLSLD_LDST64_DTPREL_LO12 537
+#define R_AARCH64_TLSLD_LDST64_DTPREL_LO12_NC 538
+#define R_AARCH64_TLSIE_MOVW_GOTTPREL_G1 539
+#define R_AARCH64_TLSIE_MOVW_GOTTPREL_G0_NC 540
+#define R_AARCH64_TLSIE_ADR_GOTTPREL_PAGE21 541
+#define R_AARCH64_TLSIE_LD64_GOTTPREL_LO12_NC 542
+#define R_AARCH64_TLSIE_LD_GOTTPREL_PREL19 543
+#define R_AARCH64_TLSLE_MOVW_TPREL_G2 544
+#define R_AARCH64_TLSLE_MOVW_TPREL_G1 545
+#define R_AARCH64_TLSLE_MOVW_TPREL_G1_NC 546
+#define R_AARCH64_TLSLE_MOVW_TPREL_G0 547
+#define R_AARCH64_TLSLE_MOVW_TPREL_G0_NC 548
+#define R_AARCH64_TLSLE_ADD_TPREL_HI12 549
+#define R_AARCH64_TLSLE_ADD_TPREL_LO12 550
+#define R_AARCH64_TLSLE_ADD_TPREL_LO12_NC 551
+#define R_AARCH64_TLSLE_LDST8_TPREL_LO12 552
+#define R_AARCH64_TLSLE_LDST8_TPREL_LO12_NC 553
+#define R_AARCH64_TLSLE_LDST16_TPREL_LO12 554
+#define R_AARCH64_TLSLE_LDST16_TPREL_LO12_NC 555
+#define R_AARCH64_TLSLE_LDST32_TPREL_LO12 556
+#define R_AARCH64_TLSLE_LDST32_TPREL_LO12_NC 557
+#define R_AARCH64_TLSLE_LDST64_TPREL_LO12 558
+#define R_AARCH64_TLSLE_LDST64_TPREL_LO12_NC 559
+#define R_AARCH64_TLSDESC_LD_PREL19 560
+#define R_AARCH64_TLSDESC_ADR_PREL21 561
+#define R_AARCH64_TLSDESC_ADR_PAGE21 562
+#define R_AARCH64_TLSDESC_LD64_LO12 563
+#define R_AARCH64_TLSDESC_ADD_LO12 564
+#define R_AARCH64_TLSDESC_OFF_G1 565
+#define R_AARCH64_TLSDESC_OFF_G0_NC 566
+#define R_AARCH64_TLSDESC_LDR	567
+#define R_AARCH64_TLSDESC_ADD	568
+#define R_AARCH64_TLSDESC_CALL	569
+#define R_AARCH64_TLSLE_LDST128_TPREL_LO12 570
+#define R_AARCH64_TLSLE_LDST128_TPREL_LO12_NC 571
+#define R_AARCH64_TLSLD_LDST128_DTPREL_LO12 572
+#define R_AARCH64_TLSLD_LDST128_DTPREL_LO12_NC 573
+#define R_AARCH64_COPY         1024
+#define R_AARCH64_GLOB_DAT     1025
+#define R_AARCH64_JUMP_SLOT    1026
+#define R_AARCH64_RELATIVE     1027
+#define R_AARCH64_TLS_DTPMOD   1028
+#define R_AARCH64_TLS_DTPMOD64 1028
+#define R_AARCH64_TLS_DTPREL   1029
+#define R_AARCH64_TLS_DTPREL64 1029
+#define R_AARCH64_TLS_TPREL    1030
+#define R_AARCH64_TLS_TPREL64  1030
+#define R_AARCH64_TLSDESC      1031
+
+
+#define R_ARM_NONE		0
+#define R_ARM_PC24		1
+#define R_ARM_ABS32		2
+#define R_ARM_REL32		3
+#define R_ARM_PC13		4
+#define R_ARM_ABS16		5
+#define R_ARM_ABS12		6
+#define R_ARM_THM_ABS5		7
+#define R_ARM_ABS8		8
+#define R_ARM_SBREL32		9
+#define R_ARM_THM_PC22		10
+#define R_ARM_THM_PC8		11
+#define R_ARM_AMP_VCALL9	12
+#define R_ARM_TLS_DESC		13
+#define R_ARM_THM_SWI8		14
+#define R_ARM_XPC25		15
+#define R_ARM_THM_XPC22		16
+#define R_ARM_TLS_DTPMOD32	17
+#define R_ARM_TLS_DTPOFF32	18
+#define R_ARM_TLS_TPOFF32	19
+#define R_ARM_COPY		20
+#define R_ARM_GLOB_DAT		21
+#define R_ARM_JUMP_SLOT		22
+#define R_ARM_RELATIVE		23
+#define R_ARM_GOTOFF		24
+#define R_ARM_GOTPC		25
+#define R_ARM_GOT32		26
+#define R_ARM_PLT32		27
+#define R_ARM_CALL		28
+#define R_ARM_JUMP24		29
+#define R_ARM_THM_JUMP24	30
+#define R_ARM_BASE_ABS		31
+#define R_ARM_ALU_PCREL_7_0	32
+#define R_ARM_ALU_PCREL_15_8	33
+#define R_ARM_ALU_PCREL_23_15	34
+#define R_ARM_LDR_SBREL_11_0	35
+#define R_ARM_ALU_SBREL_19_12	36
+#define R_ARM_ALU_SBREL_27_20	37
+#define R_ARM_TARGET1		38
+#define R_ARM_SBREL31		39
+#define R_ARM_V4BX		40
+#define R_ARM_TARGET2		41
+#define R_ARM_PREL31		42
+#define R_ARM_MOVW_ABS_NC	43
+#define R_ARM_MOVT_ABS		44
+#define R_ARM_MOVW_PREL_NC	45
+#define R_ARM_MOVT_PREL		46
+#define R_ARM_THM_MOVW_ABS_NC	47
+#define R_ARM_THM_MOVT_ABS	48
+#define R_ARM_THM_MOVW_PREL_NC	49
+#define R_ARM_THM_MOVT_PREL	50
+#define R_ARM_THM_JUMP19	51
+#define R_ARM_THM_JUMP6		52
+#define R_ARM_THM_ALU_PREL_11_0	53
+#define R_ARM_THM_PC12		54
+#define R_ARM_ABS32_NOI		55
+#define R_ARM_REL32_NOI		56
+#define R_ARM_ALU_PC_G0_NC	57
+#define R_ARM_ALU_PC_G0		58
+#define R_ARM_ALU_PC_G1_NC	59
+#define R_ARM_ALU_PC_G1		60
+#define R_ARM_ALU_PC_G2		61
+#define R_ARM_LDR_PC_G1		62
+#define R_ARM_LDR_PC_G2		63
+#define R_ARM_LDRS_PC_G0	64
+#define R_ARM_LDRS_PC_G1	65
+#define R_ARM_LDRS_PC_G2	66
+#define R_ARM_LDC_PC_G0		67
+#define R_ARM_LDC_PC_G1		68
+#define R_ARM_LDC_PC_G2		69
+#define R_ARM_ALU_SB_G0_NC	70
+#define R_ARM_ALU_SB_G0		71
+#define R_ARM_ALU_SB_G1_NC	72
+#define R_ARM_ALU_SB_G1		73
+#define R_ARM_ALU_SB_G2		74
+#define R_ARM_LDR_SB_G0		75
+#define R_ARM_LDR_SB_G1		76
+#define R_ARM_LDR_SB_G2		77
+#define R_ARM_LDRS_SB_G0	78
+#define R_ARM_LDRS_SB_G1	79
+#define R_ARM_LDRS_SB_G2	80
+#define R_ARM_LDC_SB_G0		81
+#define R_ARM_LDC_SB_G1		82
+#define R_ARM_LDC_SB_G2		83
+#define R_ARM_MOVW_BREL_NC	84
+#define R_ARM_MOVT_BREL		85
+#define R_ARM_MOVW_BREL		86
+#define R_ARM_THM_MOVW_BREL_NC	87
+#define R_ARM_THM_MOVT_BREL	88
+#define R_ARM_THM_MOVW_BREL	89
+#define R_ARM_TLS_GOTDESC	90
+#define R_ARM_TLS_CALL		91
+#define R_ARM_TLS_DESCSEQ	92
+#define R_ARM_THM_TLS_CALL	93
+#define R_ARM_PLT32_ABS		94
+#define R_ARM_GOT_ABS		95
+#define R_ARM_GOT_PREL		96
+#define R_ARM_GOT_BREL12	97
+#define R_ARM_GOTOFF12		98
+#define R_ARM_GOTRELAX		99
+#define R_ARM_GNU_VTENTRY	100
+#define R_ARM_GNU_VTINHERIT	101
+#define R_ARM_THM_PC11		102
+#define R_ARM_THM_PC9		103
+#define R_ARM_TLS_GD32		104
+
+#define R_ARM_TLS_LDM32		105
+
+#define R_ARM_TLS_LDO32		106
+
+#define R_ARM_TLS_IE32		107
+
+#define R_ARM_TLS_LE32		108
+#define R_ARM_TLS_LDO12		109
+#define R_ARM_TLS_LE12		110
+#define R_ARM_TLS_IE12GP	111
+#define R_ARM_ME_TOO		128
+#define R_ARM_THM_TLS_DESCSEQ	129
+#define R_ARM_THM_TLS_DESCSEQ16	129
+#define R_ARM_THM_TLS_DESCSEQ32	130
+#define R_ARM_THM_GOT_BREL12	131
+#define R_ARM_IRELATIVE		160
+#define R_ARM_RXPC25		249
+#define R_ARM_RSBREL32		250
+#define R_ARM_THM_RPC22		251
+#define R_ARM_RREL32		252
+#define R_ARM_RABS22		253
+#define R_ARM_RPC24		254
+#define R_ARM_RBASE		255
+
+#define R_ARM_NUM		256
+
+
+
+
+#define EF_IA_64_MASKOS		0x0000000f
+#define EF_IA_64_ABI64		0x00000010
+#define EF_IA_64_ARCH		0xff000000
+
+
+#define PT_IA_64_ARCHEXT	(PT_LOPROC + 0)
+#define PT_IA_64_UNWIND		(PT_LOPROC + 1)
+#define PT_IA_64_HP_OPT_ANOT	(PT_LOOS + 0x12)
+#define PT_IA_64_HP_HSL_ANOT	(PT_LOOS + 0x13)
+#define PT_IA_64_HP_STACK	(PT_LOOS + 0x14)
+
+
+#define PF_IA_64_NORECOV	0x80000000
+
+
+#define SHT_IA_64_EXT		(SHT_LOPROC + 0)
+#define SHT_IA_64_UNWIND	(SHT_LOPROC + 1)
+
+
+#define SHF_IA_64_SHORT		0x10000000
+#define SHF_IA_64_NORECOV	0x20000000
+
+
+#define DT_IA_64_PLT_RESERVE	(DT_LOPROC + 0)
+#define DT_IA_64_NUM		1
+
+
+#define R_IA64_NONE		0x00
+#define R_IA64_IMM14		0x21
+#define R_IA64_IMM22		0x22
+#define R_IA64_IMM64		0x23
+#define R_IA64_DIR32MSB		0x24
+#define R_IA64_DIR32LSB		0x25
+#define R_IA64_DIR64MSB		0x26
+#define R_IA64_DIR64LSB		0x27
+#define R_IA64_GPREL22		0x2a
+#define R_IA64_GPREL64I		0x2b
+#define R_IA64_GPREL32MSB	0x2c
+#define R_IA64_GPREL32LSB	0x2d
+#define R_IA64_GPREL64MSB	0x2e
+#define R_IA64_GPREL64LSB	0x2f
+#define R_IA64_LTOFF22		0x32
+#define R_IA64_LTOFF64I		0x33
+#define R_IA64_PLTOFF22		0x3a
+#define R_IA64_PLTOFF64I	0x3b
+#define R_IA64_PLTOFF64MSB	0x3e
+#define R_IA64_PLTOFF64LSB	0x3f
+#define R_IA64_FPTR64I		0x43
+#define R_IA64_FPTR32MSB	0x44
+#define R_IA64_FPTR32LSB	0x45
+#define R_IA64_FPTR64MSB	0x46
+#define R_IA64_FPTR64LSB	0x47
+#define R_IA64_PCREL60B		0x48
+#define R_IA64_PCREL21B		0x49
+#define R_IA64_PCREL21M		0x4a
+#define R_IA64_PCREL21F		0x4b
+#define R_IA64_PCREL32MSB	0x4c
+#define R_IA64_PCREL32LSB	0x4d
+#define R_IA64_PCREL64MSB	0x4e
+#define R_IA64_PCREL64LSB	0x4f
+#define R_IA64_LTOFF_FPTR22	0x52
+#define R_IA64_LTOFF_FPTR64I	0x53
+#define R_IA64_LTOFF_FPTR32MSB	0x54
+#define R_IA64_LTOFF_FPTR32LSB	0x55
+#define R_IA64_LTOFF_FPTR64MSB	0x56
+#define R_IA64_LTOFF_FPTR64LSB	0x57
+#define R_IA64_SEGREL32MSB	0x5c
+#define R_IA64_SEGREL32LSB	0x5d
+#define R_IA64_SEGREL64MSB	0x5e
+#define R_IA64_SEGREL64LSB	0x5f
+#define R_IA64_SECREL32MSB	0x64
+#define R_IA64_SECREL32LSB	0x65
+#define R_IA64_SECREL64MSB	0x66
+#define R_IA64_SECREL64LSB	0x67
+#define R_IA64_REL32MSB		0x6c
+#define R_IA64_REL32LSB		0x6d
+#define R_IA64_REL64MSB		0x6e
+#define R_IA64_REL64LSB		0x6f
+#define R_IA64_LTV32MSB		0x74
+#define R_IA64_LTV32LSB		0x75
+#define R_IA64_LTV64MSB		0x76
+#define R_IA64_LTV64LSB		0x77
+#define R_IA64_PCREL21BI	0x79
+#define R_IA64_PCREL22		0x7a
+#define R_IA64_PCREL64I		0x7b
+#define R_IA64_IPLTMSB		0x80
+#define R_IA64_IPLTLSB		0x81
+#define R_IA64_COPY		0x84
+#define R_IA64_SUB		0x85
+#define R_IA64_LTOFF22X		0x86
+#define R_IA64_LDXMOV		0x87
+#define R_IA64_TPREL14		0x91
+#define R_IA64_TPREL22		0x92
+#define R_IA64_TPREL64I		0x93
+#define R_IA64_TPREL64MSB	0x96
+#define R_IA64_TPREL64LSB	0x97
+#define R_IA64_LTOFF_TPREL22	0x9a
+#define R_IA64_DTPMOD64MSB	0xa6
+#define R_IA64_DTPMOD64LSB	0xa7
+#define R_IA64_LTOFF_DTPMOD22	0xaa
+#define R_IA64_DTPREL14		0xb1
+#define R_IA64_DTPREL22		0xb2
+#define R_IA64_DTPREL64I	0xb3
+#define R_IA64_DTPREL32MSB	0xb4
+#define R_IA64_DTPREL32LSB	0xb5
+#define R_IA64_DTPREL64MSB	0xb6
+#define R_IA64_DTPREL64LSB	0xb7
+#define R_IA64_LTOFF_DTPREL22	0xba
+
+
+#define EF_SH_MACH_MASK		0x1f
+#define EF_SH_UNKNOWN		0x0
+#define EF_SH1			0x1
+#define EF_SH2			0x2
+#define EF_SH3			0x3
+#define EF_SH_DSP		0x4
+#define EF_SH3_DSP		0x5
+#define EF_SH4AL_DSP		0x6
+#define EF_SH3E			0x8
+#define EF_SH4			0x9
+#define EF_SH2E			0xb
+#define EF_SH4A			0xc
+#define EF_SH2A			0xd
+#define EF_SH4_NOFPU		0x10
+#define EF_SH4A_NOFPU		0x11
+#define EF_SH4_NOMMU_NOFPU	0x12
+#define EF_SH2A_NOFPU		0x13
+#define EF_SH3_NOMMU		0x14
+#define EF_SH2A_SH4_NOFPU	0x15
+#define EF_SH2A_SH3_NOFPU	0x16
+#define EF_SH2A_SH4		0x17
+#define EF_SH2A_SH3E		0x18
+
+#define	R_SH_NONE		0
+#define	R_SH_DIR32		1
+#define	R_SH_REL32		2
+#define	R_SH_DIR8WPN		3
+#define	R_SH_IND12W		4
+#define	R_SH_DIR8WPL		5
+#define	R_SH_DIR8WPZ		6
+#define	R_SH_DIR8BP		7
+#define	R_SH_DIR8W		8
+#define	R_SH_DIR8L		9
+#define	R_SH_SWITCH16		25
+#define	R_SH_SWITCH32		26
+#define	R_SH_USES		27
+#define	R_SH_COUNT		28
+#define	R_SH_ALIGN		29
+#define	R_SH_CODE		30
+#define	R_SH_DATA		31
+#define	R_SH_LABEL		32
+#define	R_SH_SWITCH8		33
+#define	R_SH_GNU_VTINHERIT	34
+#define	R_SH_GNU_VTENTRY	35
+#define	R_SH_TLS_GD_32		144
+#define	R_SH_TLS_LD_32		145
+#define	R_SH_TLS_LDO_32		146
+#define	R_SH_TLS_IE_32		147
+#define	R_SH_TLS_LE_32		148
+#define	R_SH_TLS_DTPMOD32	149
+#define	R_SH_TLS_DTPOFF32	150
+#define	R_SH_TLS_TPOFF32	151
+#define	R_SH_GOT32		160
+#define	R_SH_PLT32		161
+#define	R_SH_COPY		162
+#define	R_SH_GLOB_DAT		163
+#define	R_SH_JMP_SLOT		164
+#define	R_SH_RELATIVE		165
+#define	R_SH_GOTOFF		166
+#define	R_SH_GOTPC		167
+#define	R_SH_GOT20		201
+#define	R_SH_GOTOFF20		202
+#define	R_SH_GOTFUNCDESC	203
+#define	R_SH_GOTFUNCDEST20	204
+#define	R_SH_GOTOFFFUNCDESC	205
+#define	R_SH_GOTOFFFUNCDEST20	206
+#define	R_SH_FUNCDESC		207
+#define	R_SH_FUNCDESC_VALUE	208
+
+#define	R_SH_NUM		256
+
+
+
+#define R_390_NONE		0
+#define R_390_8			1
+#define R_390_12		2
+#define R_390_16		3
+#define R_390_32		4
+#define R_390_PC32		5
+#define R_390_GOT12		6
+#define R_390_GOT32		7
+#define R_390_PLT32		8
+#define R_390_COPY		9
+#define R_390_GLOB_DAT		10
+#define R_390_JMP_SLOT		11
+#define R_390_RELATIVE		12
+#define R_390_GOTOFF32		13
+#define R_390_GOTPC		14
+#define R_390_GOT16		15
+#define R_390_PC16		16
+#define R_390_PC16DBL		17
+#define R_390_PLT16DBL		18
+#define R_390_PC32DBL		19
+#define R_390_PLT32DBL		20
+#define R_390_GOTPCDBL		21
+#define R_390_64		22
+#define R_390_PC64		23
+#define R_390_GOT64		24
+#define R_390_PLT64		25
+#define R_390_GOTENT		26
+#define R_390_GOTOFF16		27
+#define R_390_GOTOFF64		28
+#define R_390_GOTPLT12		29
+#define R_390_GOTPLT16		30
+#define R_390_GOTPLT32		31
+#define R_390_GOTPLT64		32
+#define R_390_GOTPLTENT		33
+#define R_390_PLTOFF16		34
+#define R_390_PLTOFF32		35
+#define R_390_PLTOFF64		36
+#define R_390_TLS_LOAD		37
+#define R_390_TLS_GDCALL	38
+
+#define R_390_TLS_LDCALL	39
+
+#define R_390_TLS_GD32		40
+
+#define R_390_TLS_GD64		41
+
+#define R_390_TLS_GOTIE12	42
+
+#define R_390_TLS_GOTIE32	43
+
+#define R_390_TLS_GOTIE64	44
+
+#define R_390_TLS_LDM32		45
+
+#define R_390_TLS_LDM64		46
+
+#define R_390_TLS_IE32		47
+
+#define R_390_TLS_IE64		48
+
+#define R_390_TLS_IEENT		49
+
+#define R_390_TLS_LE32		50
+
+#define R_390_TLS_LE64		51
+
+#define R_390_TLS_LDO32		52
+
+#define R_390_TLS_LDO64		53
+
+#define R_390_TLS_DTPMOD	54
+#define R_390_TLS_DTPOFF	55
+#define R_390_TLS_TPOFF		56
+
+#define R_390_20		57
+#define R_390_GOT20		58
+#define R_390_GOTPLT20		59
+#define R_390_TLS_GOTIE20	60
+
+
+#define R_390_NUM		61
+
+
+
+#define R_CRIS_NONE		0
+#define R_CRIS_8		1
+#define R_CRIS_16		2
+#define R_CRIS_32		3
+#define R_CRIS_8_PCREL		4
+#define R_CRIS_16_PCREL		5
+#define R_CRIS_32_PCREL		6
+#define R_CRIS_GNU_VTINHERIT	7
+#define R_CRIS_GNU_VTENTRY	8
+#define R_CRIS_COPY		9
+#define R_CRIS_GLOB_DAT		10
+#define R_CRIS_JUMP_SLOT	11
+#define R_CRIS_RELATIVE		12
+#define R_CRIS_16_GOT		13
+#define R_CRIS_32_GOT		14
+#define R_CRIS_16_GOTPLT	15
+#define R_CRIS_32_GOTPLT	16
+#define R_CRIS_32_GOTREL	17
+#define R_CRIS_32_PLT_GOTREL	18
+#define R_CRIS_32_PLT_PCREL	19
+
+#define R_CRIS_NUM		20
+
+
+
+#define R_X86_64_NONE		0
+#define R_X86_64_64		1
+#define R_X86_64_PC32		2
+#define R_X86_64_GOT32		3
+#define R_X86_64_PLT32		4
+#define R_X86_64_COPY		5
+#define R_X86_64_GLOB_DAT	6
+#define R_X86_64_JUMP_SLOT	7
+#define R_X86_64_RELATIVE	8
+#define R_X86_64_GOTPCREL	9
+
+#define R_X86_64_32		10
+#define R_X86_64_32S		11
+#define R_X86_64_16		12
+#define R_X86_64_PC16		13
+#define R_X86_64_8		14
+#define R_X86_64_PC8		15
+#define R_X86_64_DTPMOD64	16
+#define R_X86_64_DTPOFF64	17
+#define R_X86_64_TPOFF64	18
+#define R_X86_64_TLSGD		19
+
+#define R_X86_64_TLSLD		20
+
+#define R_X86_64_DTPOFF32	21
+#define R_X86_64_GOTTPOFF	22
+
+#define R_X86_64_TPOFF32	23
+#define R_X86_64_PC64		24
+#define R_X86_64_GOTOFF64	25
+#define R_X86_64_GOTPC32	26
+#define R_X86_64_GOT64		27
+#define R_X86_64_GOTPCREL64	28
+#define R_X86_64_GOTPC64	29
+#define R_X86_64_GOTPLT64	30
+#define R_X86_64_PLTOFF64	31
+#define R_X86_64_SIZE32		32
+#define R_X86_64_SIZE64		33
+
+#define R_X86_64_GOTPC32_TLSDESC 34
+#define R_X86_64_TLSDESC_CALL   35
+
+#define R_X86_64_TLSDESC        36
+#define R_X86_64_IRELATIVE	37
+#define R_X86_64_RELATIVE64	38
+#define R_X86_64_GOTPCRELX	41
+#define R_X86_64_REX_GOTPCRELX	42
+#define R_X86_64_NUM		43
+
+
+
+#define R_MN10300_NONE		0
+#define R_MN10300_32		1
+#define R_MN10300_16		2
+#define R_MN10300_8		3
+#define R_MN10300_PCREL32	4
+#define R_MN10300_PCREL16	5
+#define R_MN10300_PCREL8	6
+#define R_MN10300_GNU_VTINHERIT	7
+#define R_MN10300_GNU_VTENTRY	8
+#define R_MN10300_24		9
+#define R_MN10300_GOTPC32	10
+#define R_MN10300_GOTPC16	11
+#define R_MN10300_GOTOFF32	12
+#define R_MN10300_GOTOFF24	13
+#define R_MN10300_GOTOFF16	14
+#define R_MN10300_PLT32		15
+#define R_MN10300_PLT16		16
+#define R_MN10300_GOT32		17
+#define R_MN10300_GOT24		18
+#define R_MN10300_GOT16		19
+#define R_MN10300_COPY		20
+#define R_MN10300_GLOB_DAT	21
+#define R_MN10300_JMP_SLOT	22
+#define R_MN10300_RELATIVE	23
+
+#define R_MN10300_NUM		24
+
+
+
+#define R_M32R_NONE		0
+#define R_M32R_16		1
+#define R_M32R_32		2
+#define R_M32R_24		3
+#define R_M32R_10_PCREL		4
+#define R_M32R_18_PCREL		5
+#define R_M32R_26_PCREL		6
+#define R_M32R_HI16_ULO		7
+#define R_M32R_HI16_SLO		8
+#define R_M32R_LO16		9
+#define R_M32R_SDA16		10
+#define R_M32R_GNU_VTINHERIT	11
+#define R_M32R_GNU_VTENTRY	12
+
+#define R_M32R_16_RELA		33
+#define R_M32R_32_RELA		34
+#define R_M32R_24_RELA		35
+#define R_M32R_10_PCREL_RELA	36
+#define R_M32R_18_PCREL_RELA	37
+#define R_M32R_26_PCREL_RELA	38
+#define R_M32R_HI16_ULO_RELA	39
+#define R_M32R_HI16_SLO_RELA	40
+#define R_M32R_LO16_RELA	41
+#define R_M32R_SDA16_RELA	42
+#define R_M32R_RELA_GNU_VTINHERIT	43
+#define R_M32R_RELA_GNU_VTENTRY	44
+#define R_M32R_REL32		45
+
+#define R_M32R_GOT24		48
+#define R_M32R_26_PLTREL	49
+#define R_M32R_COPY		50
+#define R_M32R_GLOB_DAT		51
+#define R_M32R_JMP_SLOT		52
+#define R_M32R_RELATIVE		53
+#define R_M32R_GOTOFF		54
+#define R_M32R_GOTPC24		55
+#define R_M32R_GOT16_HI_ULO	56
+
+#define R_M32R_GOT16_HI_SLO	57
+
+#define R_M32R_GOT16_LO		58
+#define R_M32R_GOTPC_HI_ULO	59
+
+#define R_M32R_GOTPC_HI_SLO	60
+
+#define R_M32R_GOTPC_LO		61
+
+#define R_M32R_GOTOFF_HI_ULO	62
+
+#define R_M32R_GOTOFF_HI_SLO	63
+
+#define R_M32R_GOTOFF_LO	64
+#define R_M32R_NUM		256
+
+#define R_MICROBLAZE_NONE 0
+#define R_MICROBLAZE_32 1
+#define R_MICROBLAZE_32_PCREL 2
+#define R_MICROBLAZE_64_PCREL 3
+#define R_MICROBLAZE_32_PCREL_LO 4
+#define R_MICROBLAZE_64 5
+#define R_MICROBLAZE_32_LO 6
+#define R_MICROBLAZE_SRO32 7
+#define R_MICROBLAZE_SRW32 8
+#define R_MICROBLAZE_64_NONE 9
+#define R_MICROBLAZE_32_SYM_OP_SYM 10
+#define R_MICROBLAZE_GNU_VTINHERIT 11
+#define R_MICROBLAZE_GNU_VTENTRY 12
+#define R_MICROBLAZE_GOTPC_64 13
+#define R_MICROBLAZE_GOT_64 14
+#define R_MICROBLAZE_PLT_64 15
+#define R_MICROBLAZE_REL 16
+#define R_MICROBLAZE_JUMP_SLOT 17
+#define R_MICROBLAZE_GLOB_DAT 18
+#define R_MICROBLAZE_GOTOFF_64 19
+#define R_MICROBLAZE_GOTOFF_32 20
+#define R_MICROBLAZE_COPY 21
+#define R_MICROBLAZE_TLS 22
+#define R_MICROBLAZE_TLSGD 23
+#define R_MICROBLAZE_TLSLD 24
+#define R_MICROBLAZE_TLSDTPMOD32 25
+#define R_MICROBLAZE_TLSDTPREL32 26
+#define R_MICROBLAZE_TLSDTPREL64 27
+#define R_MICROBLAZE_TLSGOTTPREL32 28
+#define R_MICROBLAZE_TLSTPREL32	 29
+
+#define DT_NIOS2_GP             0x70000002
+
+#define R_NIOS2_NONE		0
+#define R_NIOS2_S16		1
+#define R_NIOS2_U16		2
+#define R_NIOS2_PCREL16		3
+#define R_NIOS2_CALL26		4
+#define R_NIOS2_IMM5		5
+#define R_NIOS2_CACHE_OPX	6
+#define R_NIOS2_IMM6		7
+#define R_NIOS2_IMM8		8
+#define R_NIOS2_HI16		9
+#define R_NIOS2_LO16		10
+#define R_NIOS2_HIADJ16		11
+#define R_NIOS2_BFD_RELOC_32	12
+#define R_NIOS2_BFD_RELOC_16	13
+#define R_NIOS2_BFD_RELOC_8	14
+#define R_NIOS2_GPREL		15
+#define R_NIOS2_GNU_VTINHERIT	16
+#define R_NIOS2_GNU_VTENTRY	17
+#define R_NIOS2_UJMP		18
+#define R_NIOS2_CJMP		19
+#define R_NIOS2_CALLR		20
+#define R_NIOS2_ALIGN		21
+#define R_NIOS2_GOT16		22
+#define R_NIOS2_CALL16		23
+#define R_NIOS2_GOTOFF_LO	24
+#define R_NIOS2_GOTOFF_HA	25
+#define R_NIOS2_PCREL_LO	26
+#define R_NIOS2_PCREL_HA	27
+#define R_NIOS2_TLS_GD16	28
+#define R_NIOS2_TLS_LDM16	29
+#define R_NIOS2_TLS_LDO16	30
+#define R_NIOS2_TLS_IE16	31
+#define R_NIOS2_TLS_LE16	32
+#define R_NIOS2_TLS_DTPMOD	33
+#define R_NIOS2_TLS_DTPREL	34
+#define R_NIOS2_TLS_TPREL	35
+#define R_NIOS2_COPY		36
+#define R_NIOS2_GLOB_DAT	37
+#define R_NIOS2_JUMP_SLOT	38
+#define R_NIOS2_RELATIVE	39
+#define R_NIOS2_GOTOFF		40
+#define R_NIOS2_CALL26_NOAT	41
+#define R_NIOS2_GOT_LO		42
+#define R_NIOS2_GOT_HA		43
+#define R_NIOS2_CALL_LO		44
+#define R_NIOS2_CALL_HA		45
+
+#define R_OR1K_NONE		0
+#define R_OR1K_32		1
+#define R_OR1K_16		2
+#define R_OR1K_8		3
+#define R_OR1K_LO_16_IN_INSN	4
+#define R_OR1K_HI_16_IN_INSN	5
+#define R_OR1K_INSN_REL_26	6
+#define R_OR1K_GNU_VTENTRY	7
+#define R_OR1K_GNU_VTINHERIT	8
+#define R_OR1K_32_PCREL		9
+#define R_OR1K_16_PCREL		10
+#define R_OR1K_8_PCREL		11
+#define R_OR1K_GOTPC_HI16	12
+#define R_OR1K_GOTPC_LO16	13
+#define R_OR1K_GOT16		14
+#define R_OR1K_PLT26		15
+#define R_OR1K_GOTOFF_HI16	16
+#define R_OR1K_GOTOFF_LO16	17
+#define R_OR1K_COPY		18
+#define R_OR1K_GLOB_DAT		19
+#define R_OR1K_JMP_SLOT		20
+#define R_OR1K_RELATIVE		21
+#define R_OR1K_TLS_GD_HI16	22
+#define R_OR1K_TLS_GD_LO16	23
+#define R_OR1K_TLS_LDM_HI16	24
+#define R_OR1K_TLS_LDM_LO16	25
+#define R_OR1K_TLS_LDO_HI16	26
+#define R_OR1K_TLS_LDO_LO16	27
+#define R_OR1K_TLS_IE_HI16	28
+#define R_OR1K_TLS_IE_LO16	29
+#define R_OR1K_TLS_LE_HI16	30
+#define R_OR1K_TLS_LE_LO16	31
+#define R_OR1K_TLS_TPOFF	32
+#define R_OR1K_TLS_DTPOFF	33
+#define R_OR1K_TLS_DTPMOD	34
+
+#define R_BPF_NONE		0
+#define R_BPF_MAP_FD		1
+
+#ifdef __cplusplus
+}
+#endif
+
+
+#endif
diff --git a/winsup/cygwin/include/elf.h b/winsup/cygwin/include/elf.h
deleted file mode 100644
index c094a1c78..000000000
--- a/winsup/cygwin/include/elf.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*-
- * Copyright (c) 2001 David E. O'Brien.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGE.
- *
- * $FreeBSD$
- */
-
-/*
- * This is a Solaris compatibility header
- */
-
-#ifndef	_ELF_H_
-#define	_ELF_H_
-
-#include <sys/types.h>
-#include <machine/elf.h>
-#include <sys/elf32.h>
-#include <sys/elf64.h>
-
-#endif /* !_ELF_H_ */
diff --git a/winsup/cygwin/include/machine/elf.h b/winsup/cygwin/include/machine/elf.h
deleted file mode 100644
index 94278118f..000000000
--- a/winsup/cygwin/include/machine/elf.h
+++ /dev/null
@@ -1,117 +0,0 @@
-/*-
- * Copyright (c) 1996-1997 John D. Polstra.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGE.
- *
- * $FreeBSD$
- */
-
-#ifndef _MACHINE_ELF_H_
-#define	_MACHINE_ELF_H_ 1
-
-/*
- * ELF definitions for the i386 architecture.
- */
-
-#include <sys/elf32.h>	/* Definitions common to all 32 bit architectures. */
-#if defined(__ELF_WORD_SIZE) && __ELF_WORD_SIZE == 64
-#include <sys/elf64.h>	/* Definitions common to all 64 bit architectures. */
-#endif
-
-#ifndef __ELF_WORD_SIZE
-#define	__ELF_WORD_SIZE	32	/* Used by <sys/elf_generic.h> */
-#endif
-
-#include <sys/elf_generic.h>
-
-#define	ELF_ARCH	EM_386
-
-#define	ELF_MACHINE_OK(x) ((x) == EM_386 || (x) == EM_486)
-
-/*
- * Auxiliary vector entries for passing information to the interpreter.
- *
- * The i386 supplement to the SVR4 ABI specification names this "auxv_t",
- * but POSIX lays claim to all symbols ending with "_t".
- */
-
-typedef struct {	/* Auxiliary vector entry on initial stack */
-	int	a_type;			/* Entry type. */
-	union {
-		long	a_val;		/* Integer value. */
-		void	*a_ptr;		/* Address. */
-		void	(*a_fcn)(void);	/* Function pointer (not used). */
-	} a_un;
-} Elf32_Auxinfo;
-
-#if __ELF_WORD_SIZE == 64
-/* Fake for amd64 loader support */
-typedef struct {
-	int fake;
-} Elf64_Auxinfo;
-#endif
-
-__ElfType(Auxinfo);
-
-/* Values for a_type. */
-#define	AT_NULL		0	/* Terminates the vector. */
-#define	AT_IGNORE	1	/* Ignored entry. */
-#define	AT_EXECFD	2	/* File descriptor of program to load. */
-#define	AT_PHDR		3	/* Program header of program already loaded. */
-#define	AT_PHENT	4	/* Size of each program header entry. */
-#define	AT_PHNUM	5	/* Number of program header entries. */
-#define	AT_PAGESZ	6	/* Page size in bytes. */
-#define	AT_BASE		7	/* Interpreter's base address. */
-#define	AT_FLAGS	8	/* Flags (unused for i386). */
-#define	AT_ENTRY	9	/* Where interpreter should transfer control. */
-#define	AT_NOTELF	10	/* Program is not ELF ?? */
-#define	AT_UID		11	/* Real uid. */
-#define	AT_EUID		12	/* Effective uid. */
-#define	AT_GID		13	/* Real gid. */
-#define	AT_EGID		14	/* Effective gid. */
-#define	AT_EXECPATH	15	/* Path to the executable. */
-#define	AT_CANARY	16	/* Canary for SSP. */
-#define	AT_CANARYLEN	17	/* Length of the canary. */
-#define	AT_OSRELDATE	18	/* OSRELDATE. */
-#define	AT_NCPUS	19	/* Number of CPUs. */
-#define	AT_PAGESIZES	20	/* Pagesizes. */
-#define	AT_PAGESIZESLEN	21	/* Number of pagesizes. */
-#define	AT_STACKPROT	23	/* Initial stack protection. */
-
-#define	AT_COUNT	24	/* Count of defined aux entry types. */
-
-/*
- * Relocation types.
- */
-
-#define	R_386_COUNT	38	/* Count of defined relocation types. */
-
-/* Define "machine" characteristics */
-#define	ELF_TARG_CLASS	ELFCLASS32
-#define	ELF_TARG_DATA	ELFDATA2LSB
-#define	ELF_TARG_MACH	EM_386
-#define	ELF_TARG_VER	1
-
-#define	ET_DYN_LOAD_ADDR 0x01001000
-
-#endif /* !_MACHINE_ELF_H_ */
diff --git a/winsup/cygwin/include/sys/elf.h b/winsup/cygwin/include/sys/elf.h
deleted file mode 100644
index b2d6b77c9..000000000
--- a/winsup/cygwin/include/sys/elf.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*-
- * Copyright (c) 2001 David E. O'Brien.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGE.
- *
- * $FreeBSD$
- */
-
-/*
- * This is a Solaris compatibility header
- */
-
-#ifndef	_SYS_ELF_H_
-#define	_SYS_ELF_H_
-
-#include <sys/types.h>
-#include <machine/elf.h>
-#include <sys/elf32.h>
-#include <sys/elf64.h>
-
-#endif /* !_SYS_ELF_H_ */
diff --git a/winsup/cygwin/include/sys/elf32.h b/winsup/cygwin/include/sys/elf32.h
deleted file mode 100644
index 62bf7be68..000000000
--- a/winsup/cygwin/include/sys/elf32.h
+++ /dev/null
@@ -1,245 +0,0 @@
-/*-
- * Copyright (c) 1996-1998 John D. Polstra.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGE.
- *
- * $FreeBSD$
- */
-
-#ifndef _SYS_ELF32_H_
-#define _SYS_ELF32_H_ 1
-
-#include <sys/elf_common.h>
-
-/*
- * ELF definitions common to all 32-bit architectures.
- */
-
-typedef uint32_t	Elf32_Addr;
-typedef uint16_t	Elf32_Half;
-typedef uint32_t	Elf32_Off;
-typedef int32_t		Elf32_Sword;
-typedef uint32_t	Elf32_Word;
-typedef uint64_t	Elf32_Lword;
-
-typedef Elf32_Word	Elf32_Hashelt;
-
-/* Non-standard class-dependent datatype used for abstraction. */
-typedef Elf32_Word	Elf32_Size;
-typedef Elf32_Sword	Elf32_Ssize;
-
-/*
- * ELF header.
- */
-
-typedef struct {
-	unsigned char	e_ident[EI_NIDENT];	/* File identification. */
-	Elf32_Half	e_type;		/* File type. */
-	Elf32_Half	e_machine;	/* Machine architecture. */
-	Elf32_Word	e_version;	/* ELF format version. */
-	Elf32_Addr	e_entry;	/* Entry point. */
-	Elf32_Off	e_phoff;	/* Program header file offset. */
-	Elf32_Off	e_shoff;	/* Section header file offset. */
-	Elf32_Word	e_flags;	/* Architecture-specific flags. */
-	Elf32_Half	e_ehsize;	/* Size of ELF header in bytes. */
-	Elf32_Half	e_phentsize;	/* Size of program header entry. */
-	Elf32_Half	e_phnum;	/* Number of program header entries. */
-	Elf32_Half	e_shentsize;	/* Size of section header entry. */
-	Elf32_Half	e_shnum;	/* Number of section header entries. */
-	Elf32_Half	e_shstrndx;	/* Section name strings section. */
-} Elf32_Ehdr;
-
-/*
- * Section header.
- */
-
-typedef struct {
-	Elf32_Word	sh_name;	/* Section name (index into the
-					   section header string table). */
-	Elf32_Word	sh_type;	/* Section type. */
-	Elf32_Word	sh_flags;	/* Section flags. */
-	Elf32_Addr	sh_addr;	/* Address in memory image. */
-	Elf32_Off	sh_offset;	/* Offset in file. */
-	Elf32_Word	sh_size;	/* Size in bytes. */
-	Elf32_Word	sh_link;	/* Index of a related section. */
-	Elf32_Word	sh_info;	/* Depends on section type. */
-	Elf32_Word	sh_addralign;	/* Alignment in bytes. */
-	Elf32_Word	sh_entsize;	/* Size of each entry in section. */
-} Elf32_Shdr;
-
-/*
- * Program header.
- */
-
-typedef struct {
-	Elf32_Word	p_type;		/* Entry type. */
-	Elf32_Off	p_offset;	/* File offset of contents. */
-	Elf32_Addr	p_vaddr;	/* Virtual address in memory image. */
-	Elf32_Addr	p_paddr;	/* Physical address (not used). */
-	Elf32_Word	p_filesz;	/* Size of contents in file. */
-	Elf32_Word	p_memsz;	/* Size of contents in memory. */
-	Elf32_Word	p_flags;	/* Access permission flags. */
-	Elf32_Word	p_align;	/* Alignment in memory and file. */
-} Elf32_Phdr;
-
-/*
- * Dynamic structure.  The ".dynamic" section contains an array of them.
- */
-
-typedef struct {
-	Elf32_Sword	d_tag;		/* Entry type. */
-	union {
-		Elf32_Word	d_val;	/* Integer value. */
-		Elf32_Addr	d_ptr;	/* Address value. */
-	} d_un;
-} Elf32_Dyn;
-
-/*
- * Relocation entries.
- */
-
-/* Relocations that don't need an addend field. */
-typedef struct {
-	Elf32_Addr	r_offset;	/* Location to be relocated. */
-	Elf32_Word	r_info;		/* Relocation type and symbol index. */
-} Elf32_Rel;
-
-/* Relocations that need an addend field. */
-typedef struct {
-	Elf32_Addr	r_offset;	/* Location to be relocated. */
-	Elf32_Word	r_info;		/* Relocation type and symbol index. */
-	Elf32_Sword	r_addend;	/* Addend. */
-} Elf32_Rela;
-
-/* Macros for accessing the fields of r_info. */
-#define ELF32_R_SYM(info)	((info) >> 8)
-#define ELF32_R_TYPE(info)	((unsigned char)(info))
-
-/* Macro for constructing r_info from field values. */
-#define ELF32_R_INFO(sym, type)	(((sym) << 8) + (unsigned char)(type))
-
-/*
- *	Note entry header
- */
-typedef Elf_Note Elf32_Nhdr;
-
-/*
- *	Move entry
- */
-typedef struct {
-	Elf32_Lword	m_value;	/* symbol value */
-	Elf32_Word 	m_info;		/* size + index */
-	Elf32_Word	m_poffset;	/* symbol offset */
-	Elf32_Half	m_repeat;	/* repeat count */
-	Elf32_Half	m_stride;	/* stride info */
-} Elf32_Move;
-
-/*
- *	The macros compose and decompose values for Move.r_info
- *
- *	sym = ELF32_M_SYM(M.m_info)
- *	size = ELF32_M_SIZE(M.m_info)
- *	M.m_info = ELF32_M_INFO(sym, size)
- */
-#define	ELF32_M_SYM(info)	((info)>>8)
-#define	ELF32_M_SIZE(info)	((unsigned char)(info))
-#define	ELF32_M_INFO(sym, size)	(((sym)<<8)+(unsigned char)(size))
-
-/*
- *	Hardware/Software capabilities entry
- */
-typedef struct {
-	Elf32_Word	c_tag;		/* how to interpret value */
-	union {
-		Elf32_Word	c_val;
-		Elf32_Addr	c_ptr;
-	} c_un;
-} Elf32_Cap;
-
-/*
- * Symbol table entries.
- */
-
-typedef struct {
-	Elf32_Word	st_name;	/* String table index of name. */
-	Elf32_Addr	st_value;	/* Symbol value. */
-	Elf32_Word	st_size;	/* Size of associated object. */
-	unsigned char	st_info;	/* Type and binding information. */
-	unsigned char	st_other;	/* Reserved (not used). */
-	Elf32_Half	st_shndx;	/* Section index of symbol. */
-} Elf32_Sym;
-
-/* Macros for accessing the fields of st_info. */
-#define ELF32_ST_BIND(info)		((info) >> 4)
-#define ELF32_ST_TYPE(info)		((info) & 0xf)
-
-/* Macro for constructing st_info from field values. */
-#define ELF32_ST_INFO(bind, type)	(((bind) << 4) + ((type) & 0xf))
-
-/* Macro for accessing the fields of st_other. */
-#define ELF32_ST_VISIBILITY(oth)	((oth) & 0x3)
-
-/* Structures used by Sun & GNU symbol versioning. */
-typedef struct
-{
-	Elf32_Half	vd_version;
-	Elf32_Half	vd_flags;
-	Elf32_Half	vd_ndx;
-	Elf32_Half	vd_cnt;
-	Elf32_Word	vd_hash;
-	Elf32_Word	vd_aux;
-	Elf32_Word	vd_next;
-} Elf32_Verdef;
-
-typedef struct
-{
-	Elf32_Word	vda_name;
-	Elf32_Word	vda_next;
-} Elf32_Verdaux;
-
-typedef struct
-{
-	Elf32_Half	vn_version;
-	Elf32_Half	vn_cnt;
-	Elf32_Word	vn_file;
-	Elf32_Word	vn_aux;
-	Elf32_Word	vn_next;
-} Elf32_Verneed;
-
-typedef struct
-{
-	Elf32_Word	vna_hash;
-	Elf32_Half	vna_flags;
-	Elf32_Half	vna_other;
-	Elf32_Word	vna_name;
-	Elf32_Word	vna_next;
-} Elf32_Vernaux;
-
-typedef Elf32_Half Elf32_Versym;
-
-typedef struct {
-	Elf32_Half	si_boundto;	/* direct bindings - symbol bound to */
-	Elf32_Half	si_flags;	/* per symbol flags */
-} Elf32_Syminfo;
-
-#endif /* !_SYS_ELF32_H_ */
diff --git a/winsup/cygwin/include/sys/elf64.h b/winsup/cygwin/include/sys/elf64.h
deleted file mode 100644
index 4ec7d341e..000000000
--- a/winsup/cygwin/include/sys/elf64.h
+++ /dev/null
@@ -1,248 +0,0 @@
-/*-
- * Copyright (c) 1996-1998 John D. Polstra.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGE.
- *
- * $FreeBSD$
- */
-
-#ifndef _SYS_ELF64_H_
-#define _SYS_ELF64_H_ 1
-
-#include <sys/elf_common.h>
-
-/*
- * ELF definitions common to all 64-bit architectures.
- */
-
-typedef uint64_t	Elf64_Addr;
-typedef uint16_t	Elf64_Half;
-typedef uint64_t	Elf64_Off;
-typedef int32_t		Elf64_Sword;
-typedef int64_t		Elf64_Sxword;
-typedef uint32_t	Elf64_Word;
-typedef uint64_t	Elf64_Lword;
-typedef uint64_t	Elf64_Xword;
-
-/*
- * Types of dynamic symbol hash table bucket and chain elements.
- *
- * This is inconsistent among 64 bit architectures, so a machine dependent
- * typedef is required.
- */
-
-typedef Elf64_Word	Elf64_Hashelt;
-
-/* Non-standard class-dependent datatype used for abstraction. */
-typedef Elf64_Xword	Elf64_Size;
-typedef Elf64_Sxword	Elf64_Ssize;
-
-/*
- * ELF header.
- */
-
-typedef struct {
-	unsigned char	e_ident[EI_NIDENT];	/* File identification. */
-	Elf64_Half	e_type;		/* File type. */
-	Elf64_Half	e_machine;	/* Machine architecture. */
-	Elf64_Word	e_version;	/* ELF format version. */
-	Elf64_Addr	e_entry;	/* Entry point. */
-	Elf64_Off	e_phoff;	/* Program header file offset. */
-	Elf64_Off	e_shoff;	/* Section header file offset. */
-	Elf64_Word	e_flags;	/* Architecture-specific flags. */
-	Elf64_Half	e_ehsize;	/* Size of ELF header in bytes. */
-	Elf64_Half	e_phentsize;	/* Size of program header entry. */
-	Elf64_Half	e_phnum;	/* Number of program header entries. */
-	Elf64_Half	e_shentsize;	/* Size of section header entry. */
-	Elf64_Half	e_shnum;	/* Number of section header entries. */
-	Elf64_Half	e_shstrndx;	/* Section name strings section. */
-} Elf64_Ehdr;
-
-/*
- * Section header.
- */
-
-typedef struct {
-	Elf64_Word	sh_name;	/* Section name (index into the
-					   section header string table). */
-	Elf64_Word	sh_type;	/* Section type. */
-	Elf64_Xword	sh_flags;	/* Section flags. */
-	Elf64_Addr	sh_addr;	/* Address in memory image. */
-	Elf64_Off	sh_offset;	/* Offset in file. */
-	Elf64_Xword	sh_size;	/* Size in bytes. */
-	Elf64_Word	sh_link;	/* Index of a related section. */
-	Elf64_Word	sh_info;	/* Depends on section type. */
-	Elf64_Xword	sh_addralign;	/* Alignment in bytes. */
-	Elf64_Xword	sh_entsize;	/* Size of each entry in section. */
-} Elf64_Shdr;
-
-/*
- * Program header.
- */
-
-typedef struct {
-	Elf64_Word	p_type;		/* Entry type. */
-	Elf64_Word	p_flags;	/* Access permission flags. */
-	Elf64_Off	p_offset;	/* File offset of contents. */
-	Elf64_Addr	p_vaddr;	/* Virtual address in memory image. */
-	Elf64_Addr	p_paddr;	/* Physical address (not used). */
-	Elf64_Xword	p_filesz;	/* Size of contents in file. */
-	Elf64_Xword	p_memsz;	/* Size of contents in memory. */
-	Elf64_Xword	p_align;	/* Alignment in memory and file. */
-} Elf64_Phdr;
-
-/*
- * Dynamic structure.  The ".dynamic" section contains an array of them.
- */
-
-typedef struct {
-	Elf64_Sxword	d_tag;		/* Entry type. */
-	union {
-		Elf64_Xword	d_val;	/* Integer value. */
-		Elf64_Addr	d_ptr;	/* Address value. */
-	} d_un;
-} Elf64_Dyn;
-
-/*
- * Relocation entries.
- */
-
-/* Relocations that don't need an addend field. */
-typedef struct {
-	Elf64_Addr	r_offset;	/* Location to be relocated. */
-	Elf64_Xword	r_info;		/* Relocation type and symbol index. */
-} Elf64_Rel;
-
-/* Relocations that need an addend field. */
-typedef struct {
-	Elf64_Addr	r_offset;	/* Location to be relocated. */
-	Elf64_Xword	r_info;		/* Relocation type and symbol index. */
-	Elf64_Sxword	r_addend;	/* Addend. */
-} Elf64_Rela;
-
-/* Macros for accessing the fields of r_info. */
-#define	ELF64_R_SYM(info)	((info) >> 32)
-#define	ELF64_R_TYPE(info)	((info) & 0xffffffffL)
-
-/* Macro for constructing r_info from field values. */
-#define	ELF64_R_INFO(sym, type)	(((sym) << 32) + ((type) & 0xffffffffL))
-
-#define	ELF64_R_TYPE_DATA(info)	(((Elf64_Xword)(info)<<32)>>40)
-#define	ELF64_R_TYPE_ID(info)	(((Elf64_Xword)(info)<<56)>>56)
-#define	ELF64_R_TYPE_INFO(data, type)	\
-				(((Elf64_Xword)(data)<<8)+(Elf64_Xword)(type))
-
-/*
- *	Note entry header
- */
-typedef Elf_Note Elf64_Nhdr;
-
-/*
- *	Move entry
- */
-typedef struct {
-	Elf64_Lword	m_value;	/* symbol value */
-	Elf64_Xword 	m_info;		/* size + index */
-	Elf64_Xword	m_poffset;	/* symbol offset */
-	Elf64_Half	m_repeat;	/* repeat count */
-	Elf64_Half	m_stride;	/* stride info */
-} Elf64_Move;
-
-#define	ELF64_M_SYM(info)	((info)>>8)
-#define	ELF64_M_SIZE(info)	((unsigned char)(info))
-#define	ELF64_M_INFO(sym, size)	(((sym)<<8)+(unsigned char)(size))
-
-/*
- *	Hardware/Software capabilities entry
- */
-typedef struct {
-	Elf64_Xword	c_tag;		/* how to interpret value */
-	union {
-		Elf64_Xword	c_val;
-		Elf64_Addr	c_ptr;
-	} c_un;
-} Elf64_Cap;
-
-/*
- * Symbol table entries.
- */
-
-typedef struct {
-	Elf64_Word	st_name;	/* String table index of name. */
-	unsigned char	st_info;	/* Type and binding information. */
-	unsigned char	st_other;	/* Reserved (not used). */
-	Elf64_Half	st_shndx;	/* Section index of symbol. */
-	Elf64_Addr	st_value;	/* Symbol value. */
-	Elf64_Xword	st_size;	/* Size of associated object. */
-} Elf64_Sym;
-
-/* Macros for accessing the fields of st_info. */
-#define	ELF64_ST_BIND(info)		((info) >> 4)
-#define	ELF64_ST_TYPE(info)		((info) & 0xf)
-
-/* Macro for constructing st_info from field values. */
-#define	ELF64_ST_INFO(bind, type)	(((bind) << 4) + ((type) & 0xf))
-
-/* Macro for accessing the fields of st_other. */
-#define	ELF64_ST_VISIBILITY(oth)	((oth) & 0x3)
-
-/* Structures used by Sun & GNU-style symbol versioning. */
-typedef struct {
-	Elf64_Half	vd_version;
-	Elf64_Half	vd_flags;
-	Elf64_Half	vd_ndx;
-	Elf64_Half	vd_cnt;
-	Elf64_Word	vd_hash;
-	Elf64_Word	vd_aux;
-	Elf64_Word	vd_next;
-} Elf64_Verdef;
-
-typedef struct {
-	Elf64_Word	vda_name;
-	Elf64_Word	vda_next;
-} Elf64_Verdaux;
-
-typedef struct {
-	Elf64_Half	vn_version;
-	Elf64_Half	vn_cnt;
-	Elf64_Word	vn_file;
-	Elf64_Word	vn_aux;
-	Elf64_Word	vn_next;
-} Elf64_Verneed;
-
-typedef struct {
-	Elf64_Word	vna_hash;
-	Elf64_Half	vna_flags;
-	Elf64_Half	vna_other;
-	Elf64_Word	vna_name;
-	Elf64_Word	vna_next;
-} Elf64_Vernaux;
-
-typedef Elf64_Half Elf64_Versym;
-
-typedef struct {
-	Elf64_Half	si_boundto;	/* direct bindings - symbol bound to */
-	Elf64_Half	si_flags;	/* per symbol flags */
-} Elf64_Syminfo;
-
-#endif /* !_SYS_ELF64_H_ */
diff --git a/winsup/cygwin/include/sys/elf_common.h b/winsup/cygwin/include/sys/elf_common.h
deleted file mode 100644
index 4b1025613..000000000
--- a/winsup/cygwin/include/sys/elf_common.h
+++ /dev/null
@@ -1,1110 +0,0 @@
-/*-
- * Copyright (c) 2000, 2001, 2008, 2011, David E. O'Brien
- * Copyright (c) 1998 John D. Polstra.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGE.
- *
- * $FreeBSD$
- */
-
-#ifndef _SYS_ELF_COMMON_H_
-#define	_SYS_ELF_COMMON_H_ 1
-
-/*
- * ELF definitions that are independent of architecture or word size.
- */
-
-/*
- * Note header.  The ".note" section contains an array of notes.  Each
- * begins with this header, aligned to a word boundary.  Immediately
- * following the note header is n_namesz bytes of name, padded to the
- * next word boundary.  Then comes n_descsz bytes of descriptor, again
- * padded to a word boundary.  The values of n_namesz and n_descsz do
- * not include the padding.
- */
-
-typedef struct {
-	u_int32_t	n_namesz;	/* Length of name. */
-	u_int32_t	n_descsz;	/* Length of descriptor. */
-	u_int32_t	n_type;		/* Type of this note. */
-} Elf_Note;
-
-/*
- * The header for GNU-style hash sections.
- */
-
-typedef struct {
-	u_int32_t	gh_nbuckets;	/* Number of hash buckets. */
-	u_int32_t	gh_symndx;	/* First visible symbol in .dynsym. */
-	u_int32_t	gh_maskwords;	/* #maskwords used in bloom filter. */
-	u_int32_t	gh_shift2;	/* Bloom filter shift count. */
-} Elf_GNU_Hash_Header;
-
-/* Indexes into the e_ident array.  Keep synced with
-   http://www.sco.com/developers/gabi/latest/ch4.eheader.html */
-#define	EI_MAG0		0	/* Magic number, byte 0. */
-#define	EI_MAG1		1	/* Magic number, byte 1. */
-#define	EI_MAG2		2	/* Magic number, byte 2. */
-#define	EI_MAG3		3	/* Magic number, byte 3. */
-#define	EI_CLASS	4	/* Class of machine. */
-#define	EI_DATA		5	/* Data format. */
-#define	EI_VERSION	6	/* ELF format version. */
-#define	EI_OSABI	7	/* Operating system / ABI identification */
-#define	EI_ABIVERSION	8	/* ABI version */
-#define	OLD_EI_BRAND	8	/* Start of architecture identification. */
-#define	EI_PAD		9	/* Start of padding (per SVR4 ABI). */
-#define	EI_NIDENT	16	/* Size of e_ident array. */
-
-/* Values for the magic number bytes. */
-#define	ELFMAG0		0x7f
-#define	ELFMAG1		'E'
-#define	ELFMAG2		'L'
-#define	ELFMAG3		'F'
-#define	ELFMAG		"\177ELF"	/* magic string */
-#define	SELFMAG		4		/* magic string size */
-
-/* Values for e_ident[EI_VERSION] and e_version. */
-#define	EV_NONE		0
-#define	EV_CURRENT	1
-
-/* Values for e_ident[EI_CLASS]. */
-#define	ELFCLASSNONE	0	/* Unknown class. */
-#define	ELFCLASS32	1	/* 32-bit architecture. */
-#define	ELFCLASS64	2	/* 64-bit architecture. */
-
-/* Values for e_ident[EI_DATA]. */
-#define	ELFDATANONE	0	/* Unknown data format. */
-#define	ELFDATA2LSB	1	/* 2's complement little-endian. */
-#define	ELFDATA2MSB	2	/* 2's complement big-endian. */
-
-/* Values for e_ident[EI_OSABI]. */
-#define	ELFOSABI_NONE		0	/* UNIX System V ABI */
-#define	ELFOSABI_HPUX		1	/* HP-UX operating system */
-#define	ELFOSABI_NETBSD		2	/* NetBSD */
-#define	ELFOSABI_LINUX		3	/* GNU/Linux */
-#define	ELFOSABI_HURD		4	/* GNU/Hurd */
-#define	ELFOSABI_86OPEN		5	/* 86Open common IA32 ABI */
-#define	ELFOSABI_SOLARIS	6	/* Solaris */
-#define	ELFOSABI_AIX		7	/* AIX */
-#define	ELFOSABI_IRIX		8	/* IRIX */
-#define	ELFOSABI_FREEBSD	9	/* FreeBSD */
-#define	ELFOSABI_TRU64		10	/* TRU64 UNIX */
-#define	ELFOSABI_MODESTO	11	/* Novell Modesto */
-#define	ELFOSABI_OPENBSD	12	/* OpenBSD */
-#define	ELFOSABI_OPENVMS	13	/* Open VMS */
-#define	ELFOSABI_NSK		14	/* HP Non-Stop Kernel */
-#define	ELFOSABI_AROS		15	/* Amiga Research OS */
-#define	ELFOSABI_ARM		97	/* ARM */
-#define	ELFOSABI_STANDALONE	255	/* Standalone (embedded) application */
-
-#define	ELFOSABI_SYSV		ELFOSABI_NONE	/* symbol used in old spec */
-#define	ELFOSABI_MONTEREY	ELFOSABI_AIX	/* Monterey */
-
-/* e_ident */
-#define	IS_ELF(ehdr)	((ehdr).e_ident[EI_MAG0] == ELFMAG0 && \
-			 (ehdr).e_ident[EI_MAG1] == ELFMAG1 && \
-			 (ehdr).e_ident[EI_MAG2] == ELFMAG2 && \
-			 (ehdr).e_ident[EI_MAG3] == ELFMAG3)
-
-/* Values for e_type. */
-#define	ET_NONE		0	/* Unknown type. */
-#define	ET_REL		1	/* Relocatable. */
-#define	ET_EXEC		2	/* Executable. */
-#define	ET_DYN		3	/* Shared object. */
-#define	ET_CORE		4	/* Core file. */
-#define	ET_LOOS		0xfe00	/* First operating system specific. */
-#define	ET_HIOS		0xfeff	/* Last operating system-specific. */
-#define	ET_LOPROC	0xff00	/* First processor-specific. */
-#define	ET_HIPROC	0xffff	/* Last processor-specific. */
-
-/* Values for e_machine. */
-#define	EM_NONE		0	/* Unknown machine. */
-#define	EM_M32		1	/* AT&T WE32100. */
-#define	EM_SPARC	2	/* Sun SPARC. */
-#define	EM_386		3	/* Intel i386. */
-#define	EM_68K		4	/* Motorola 68000. */
-#define	EM_88K		5	/* Motorola 88000. */
-#define	EM_860		7	/* Intel i860. */
-#define	EM_MIPS		8	/* MIPS R3000 Big-Endian only. */
-#define	EM_S370		9	/* IBM System/370. */
-#define	EM_MIPS_RS3_LE	10	/* MIPS R3000 Little-Endian. */
-#define	EM_PARISC	15	/* HP PA-RISC. */
-#define	EM_VPP500	17	/* Fujitsu VPP500. */
-#define	EM_SPARC32PLUS	18	/* SPARC v8plus. */
-#define	EM_960		19	/* Intel 80960. */
-#define	EM_PPC		20	/* PowerPC 32-bit. */
-#define	EM_PPC64	21	/* PowerPC 64-bit. */
-#define	EM_S390		22	/* IBM System/390. */
-#define	EM_V800		36	/* NEC V800. */
-#define	EM_FR20		37	/* Fujitsu FR20. */
-#define	EM_RH32		38	/* TRW RH-32. */
-#define	EM_RCE		39	/* Motorola RCE. */
-#define	EM_ARM		40	/* ARM. */
-#define	EM_SH		42	/* Hitachi SH. */
-#define	EM_SPARCV9	43	/* SPARC v9 64-bit. */
-#define	EM_TRICORE	44	/* Siemens TriCore embedded processor. */
-#define	EM_ARC		45	/* Argonaut RISC Core. */
-#define	EM_H8_300	46	/* Hitachi H8/300. */
-#define	EM_H8_300H	47	/* Hitachi H8/300H. */
-#define	EM_H8S		48	/* Hitachi H8S. */
-#define	EM_H8_500	49	/* Hitachi H8/500. */
-#define	EM_IA_64	50	/* Intel IA-64 Processor. */
-#define	EM_MIPS_X	51	/* Stanford MIPS-X. */
-#define	EM_COLDFIRE	52	/* Motorola ColdFire. */
-#define	EM_68HC12	53	/* Motorola M68HC12. */
-#define	EM_MMA		54	/* Fujitsu MMA. */
-#define	EM_PCP		55	/* Siemens PCP. */
-#define	EM_NCPU		56	/* Sony nCPU. */
-#define	EM_NDR1		57	/* Denso NDR1 microprocessor. */
-#define	EM_STARCORE	58	/* Motorola Star*Core processor. */
-#define	EM_ME16		59	/* Toyota ME16 processor. */
-#define	EM_ST100	60	/* STMicroelectronics ST100 processor. */
-#define	EM_TINYJ	61	/* Advanced Logic Corp. TinyJ processor. */
-#define	EM_X86_64	62	/* Advanced Micro Devices x86-64 */
-#define	EM_AMD64	EM_X86_64	/* Advanced Micro Devices x86-64 (compat) */
-#define	EM_PDSP		63	/* Sony DSP Processor. */
-#define	EM_FX66		66	/* Siemens FX66 microcontroller. */
-#define	EM_ST9PLUS	67	/* STMicroelectronics ST9+ 8/16
-				   microcontroller. */
-#define	EM_ST7		68	/* STmicroelectronics ST7 8-bit
-				   microcontroller. */
-#define	EM_68HC16	69	/* Motorola MC68HC16 microcontroller. */
-#define	EM_68HC11	70	/* Motorola MC68HC11 microcontroller. */
-#define	EM_68HC08	71	/* Motorola MC68HC08 microcontroller. */
-#define	EM_68HC05	72	/* Motorola MC68HC05 microcontroller. */
-#define	EM_SVX		73	/* Silicon Graphics SVx. */
-#define	EM_ST19		74	/* STMicroelectronics ST19 8-bit mc. */
-#define	EM_VAX		75	/* Digital VAX. */
-#define	EM_CRIS		76	/* Axis Communications 32-bit embedded
-				   processor. */
-#define	EM_JAVELIN	77	/* Infineon Technologies 32-bit embedded
-				   processor. */
-#define	EM_FIREPATH	78	/* Element 14 64-bit DSP Processor. */
-#define	EM_ZSP		79	/* LSI Logic 16-bit DSP Processor. */
-#define	EM_MMIX		80	/* Donald Knuth's educational 64-bit proc. */
-#define	EM_HUANY	81	/* Harvard University machine-independent
-				   object files. */
-#define	EM_PRISM	82	/* SiTera Prism. */
-#define	EM_AVR		83	/* Atmel AVR 8-bit microcontroller. */
-#define	EM_FR30		84	/* Fujitsu FR30. */
-#define	EM_D10V		85	/* Mitsubishi D10V. */
-#define	EM_D30V		86	/* Mitsubishi D30V. */
-#define	EM_V850		87	/* NEC v850. */
-#define	EM_M32R		88	/* Mitsubishi M32R. */
-#define	EM_MN10300	89	/* Matsushita MN10300. */
-#define	EM_MN10200	90	/* Matsushita MN10200. */
-#define	EM_PJ		91	/* picoJava. */
-#define	EM_OPENRISC	92	/* OpenRISC 32-bit embedded processor. */
-#define	EM_ARC_A5	93	/* ARC Cores Tangent-A5. */
-#define	EM_XTENSA	94	/* Tensilica Xtensa Architecture. */
-#define	EM_VIDEOCORE	95	/* Alphamosaic VideoCore processor. */
-#define	EM_TMM_GPP	96	/* Thompson Multimedia General Purpose
-				   Processor. */
-#define	EM_NS32K	97	/* National Semiconductor 32000 series. */
-#define	EM_TPC		98	/* Tenor Network TPC processor. */
-#define	EM_SNP1K	99	/* Trebia SNP 1000 processor. */
-#define	EM_ST200	100	/* STMicroelectronics ST200 microcontroller. */
-#define	EM_IP2K		101	/* Ubicom IP2xxx microcontroller family. */
-#define	EM_MAX		102	/* MAX Processor. */
-#define	EM_CR		103	/* National Semiconductor CompactRISC
-				   microprocessor. */
-#define	EM_F2MC16	104	/* Fujitsu F2MC16. */
-#define	EM_MSP430	105	/* Texas Instruments embedded microcontroller
-				   msp430. */
-#define	EM_BLACKFIN	106	/* Analog Devices Blackfin (DSP) processor. */
-#define	EM_SE_C33	107	/* S1C33 Family of Seiko Epson processors. */
-#define	EM_SEP		108	/* Sharp embedded microprocessor. */
-#define	EM_ARCA		109	/* Arca RISC Microprocessor. */
-#define	EM_UNICORE	110	/* Microprocessor series from PKU-Unity Ltd.
-				   and MPRC of Peking University */
-
-/* Non-standard or deprecated. */
-#define	EM_486		6	/* Intel i486. */
-#define	EM_MIPS_RS4_BE	10	/* MIPS R4000 Big-Endian */
-#define	EM_ALPHA_STD	41	/* Digital Alpha (standard value). */
-#define	EM_ALPHA	0x9026	/* Alpha (written in the absence of an ABI) */
-
-/* Special section indexes. */
-#define	SHN_UNDEF	     0		/* Undefined, missing, irrelevant. */
-#define	SHN_LORESERVE	0xff00		/* First of reserved range. */
-#define	SHN_LOPROC	0xff00		/* First processor-specific. */
-#define	SHN_HIPROC	0xff1f		/* Last processor-specific. */
-#define	SHN_LOOS	0xff20		/* First operating system-specific. */
-#define	SHN_HIOS	0xff3f		/* Last operating system-specific. */
-#define	SHN_ABS		0xfff1		/* Absolute values. */
-#define	SHN_COMMON	0xfff2		/* Common data. */
-#define	SHN_XINDEX	0xffff		/* Escape -- index stored elsewhere. */
-#define	SHN_HIRESERVE	0xffff		/* Last of reserved range. */
-
-/* sh_type */
-#define	SHT_NULL		0	/* inactive */
-#define	SHT_PROGBITS		1	/* program defined information */
-#define	SHT_SYMTAB		2	/* symbol table section */
-#define	SHT_STRTAB		3	/* string table section */
-#define	SHT_RELA		4	/* relocation section with addends */
-#define	SHT_HASH		5	/* symbol hash table section */
-#define	SHT_DYNAMIC		6	/* dynamic section */
-#define	SHT_NOTE		7	/* note section */
-#define	SHT_NOBITS		8	/* no space section */
-#define	SHT_REL			9	/* relocation section - no addends */
-#define	SHT_SHLIB		10	/* reserved - purpose unknown */
-#define	SHT_DYNSYM		11	/* dynamic symbol table section */
-#define	SHT_INIT_ARRAY		14	/* Initialization function pointers. */
-#define	SHT_FINI_ARRAY		15	/* Termination function pointers. */
-#define	SHT_PREINIT_ARRAY	16	/* Pre-initialization function ptrs. */
-#define	SHT_GROUP		17	/* Section group. */
-#define	SHT_SYMTAB_SHNDX	18	/* Section indexes (see SHN_XINDEX). */
-#define	SHT_LOOS		0x60000000	/* First of OS specific semantics */
-#define	SHT_LOSUNW		0x6ffffff4
-#define	SHT_SUNW_dof		0x6ffffff4
-#define	SHT_SUNW_cap		0x6ffffff5
-#define	SHT_SUNW_SIGNATURE	0x6ffffff6
-#define	SHT_GNU_HASH		0x6ffffff6
-#define	SHT_SUNW_ANNOTATE	0x6ffffff7
-#define	SHT_SUNW_DEBUGSTR	0x6ffffff8
-#define	SHT_SUNW_DEBUG		0x6ffffff9
-#define	SHT_SUNW_move		0x6ffffffa
-#define	SHT_SUNW_COMDAT		0x6ffffffb
-#define	SHT_SUNW_syminfo	0x6ffffffc
-#define	SHT_SUNW_verdef		0x6ffffffd
-#define	SHT_GNU_verdef		0x6ffffffd	/* Symbol versions provided */
-#define	SHT_SUNW_verneed	0x6ffffffe
-#define	SHT_GNU_verneed		0x6ffffffe	/* Symbol versions required */
-#define	SHT_SUNW_versym		0x6fffffff
-#define	SHT_GNU_versym		0x6fffffff	/* Symbol version table */
-#define	SHT_HISUNW		0x6fffffff
-#define	SHT_HIOS		0x6fffffff	/* Last of OS specific semantics */
-#define	SHT_LOPROC		0x70000000	/* reserved range for processor */
-#define	SHT_AMD64_UNWIND	0x70000001	/* unwind information */
-#define	SHT_MIPS_REGINFO	0x70000006
-#define	SHT_MIPS_OPTIONS	0x7000000d
-#define	SHT_MIPS_DWARF		0x7000001e	/* MIPS gcc uses MIPS_DWARF */
-#define	SHT_HIPROC		0x7fffffff	/* specific section header types */
-#define	SHT_LOUSER		0x80000000	/* reserved range for application */
-#define	SHT_HIUSER		0xffffffff	/* specific indexes */
-
-/* Flags for sh_flags. */
-#define	SHF_WRITE		0x1	/* Section contains writable data. */
-#define	SHF_ALLOC		0x2	/* Section occupies memory. */
-#define	SHF_EXECINSTR		0x4	/* Section contains instructions. */
-#define	SHF_MERGE		0x10	/* Section may be merged. */
-#define	SHF_STRINGS		0x20	/* Section contains strings. */
-#define	SHF_INFO_LINK		0x40	/* sh_info holds section index. */
-#define	SHF_LINK_ORDER		0x80	/* Special ordering requirements. */
-#define	SHF_OS_NONCONFORMING	0x100	/* OS-specific processing required. */
-#define	SHF_GROUP		0x200	/* Member of section group. */
-#define	SHF_TLS			0x400	/* Section contains TLS data. */
-#define	SHF_MASKOS	0x0ff00000	/* OS-specific semantics. */
-#define	SHF_MASKPROC	0xf0000000	/* Processor-specific semantics. */
-
-/* Values for p_type. */
-#define	PT_NULL		0	/* Unused entry. */
-#define	PT_LOAD		1	/* Loadable segment. */
-#define	PT_DYNAMIC	2	/* Dynamic linking information segment. */
-#define	PT_INTERP	3	/* Pathname of interpreter. */
-#define	PT_NOTE		4	/* Auxiliary information. */
-#define	PT_SHLIB	5	/* Reserved (not used). */
-#define	PT_PHDR		6	/* Location of program header itself. */
-#define	PT_TLS		7	/* Thread local storage segment */
-#define	PT_LOOS		0x60000000	/* First OS-specific. */
-#define	PT_SUNW_UNWIND	0x6464e550	/* amd64 UNWIND program header */
-#define	PT_GNU_EH_FRAME	0x6474e550
-#define	PT_GNU_STACK	0x6474e551
-#define	PT_GNU_RELRO	0x6474e552
-#define	PT_LOSUNW	0x6ffffffa
-#define	PT_SUNWBSS	0x6ffffffa	/* Sun Specific segment */
-#define	PT_SUNWSTACK	0x6ffffffb	/* describes the stack segment */
-#define	PT_SUNWDTRACE	0x6ffffffc	/* private */
-#define	PT_SUNWCAP	0x6ffffffd	/* hard/soft capabilities segment */
-#define	PT_HISUNW	0x6fffffff
-#define	PT_HIOS		0x6fffffff	/* Last OS-specific. */
-#define	PT_LOPROC	0x70000000	/* First processor-specific type. */
-#define	PT_HIPROC	0x7fffffff	/* Last processor-specific type. */
-
-/* Values for p_flags. */
-#define	PF_X		0x1		/* Executable. */
-#define	PF_W		0x2		/* Writable. */
-#define	PF_R		0x4		/* Readable. */
-#define	PF_MASKOS	0x0ff00000	/* Operating system-specific. */
-#define	PF_MASKPROC	0xf0000000	/* Processor-specific. */
-
-/* Extended program header index. */
-#define	PN_XNUM		0xffff
-
-/* Values for d_tag. */
-#define	DT_NULL		0	/* Terminating entry. */
-#define	DT_NEEDED	1	/* String table offset of a needed shared
-				   library. */
-#define	DT_PLTRELSZ	2	/* Total size in bytes of PLT relocations. */
-#define	DT_PLTGOT	3	/* Processor-dependent address. */
-#define	DT_HASH		4	/* Address of symbol hash table. */
-#define	DT_STRTAB	5	/* Address of string table. */
-#define	DT_SYMTAB	6	/* Address of symbol table. */
-#define	DT_RELA		7	/* Address of ElfNN_Rela relocations. */
-#define	DT_RELASZ	8	/* Total size of ElfNN_Rela relocations. */
-#define	DT_RELAENT	9	/* Size of each ElfNN_Rela relocation entry. */
-#define	DT_STRSZ	10	/* Size of string table. */
-#define	DT_SYMENT	11	/* Size of each symbol table entry. */
-#define	DT_INIT		12	/* Address of initialization function. */
-#define	DT_FINI		13	/* Address of finalization function. */
-#define	DT_SONAME	14	/* String table offset of shared object
-				   name. */
-#define	DT_RPATH	15	/* String table offset of library path. [sup] */
-#define	DT_SYMBOLIC	16	/* Indicates "symbolic" linking. [sup] */
-#define	DT_REL		17	/* Address of ElfNN_Rel relocations. */
-#define	DT_RELSZ	18	/* Total size of ElfNN_Rel relocations. */
-#define	DT_RELENT	19	/* Size of each ElfNN_Rel relocation. */
-#define	DT_PLTREL	20	/* Type of relocation used for PLT. */
-#define	DT_DEBUG	21	/* Reserved (not used). */
-#define	DT_TEXTREL	22	/* Indicates there may be relocations in
-				   non-writable segments. [sup] */
-#define	DT_JMPREL	23	/* Address of PLT relocations. */
-#define	DT_BIND_NOW	24	/* [sup] */
-#define	DT_INIT_ARRAY	25	/* Address of the array of pointers to
-				   initialization functions */
-#define	DT_FINI_ARRAY	26	/* Address of the array of pointers to
-				   termination functions */
-#define	DT_INIT_ARRAYSZ	27	/* Size in bytes of the array of
-				   initialization functions. */
-#define	DT_FINI_ARRAYSZ	28	/* Size in bytes of the array of
-				   termination functions. */
-#define	DT_RUNPATH	29	/* String table offset of a null-terminated
-				   library search path string. */
-#define	DT_FLAGS	30	/* Object specific flag values. */
-#define	DT_ENCODING	32	/* Values greater than or equal to DT_ENCODING
-				   and less than DT_LOOS follow the rules for
-				   the interpretation of the d_un union
-				   as follows: even == 'd_ptr', odd == 'd_val'
-				   or none */
-#define	DT_PREINIT_ARRAY 32	/* Address of the array of pointers to
-				   pre-initialization functions. */
-#define	DT_PREINIT_ARRAYSZ 33	/* Size in bytes of the array of
-				   pre-initialization functions. */
-#define	DT_MAXPOSTAGS	34	/* number of positive tags */
-#define	DT_LOOS		0x6000000d	/* First OS-specific */
-#define	DT_SUNW_AUXILIARY	0x6000000d	/* symbol auxiliary name */
-#define	DT_SUNW_RTLDINF		0x6000000e	/* ld.so.1 info (private) */
-#define	DT_SUNW_FILTER		0x6000000f	/* symbol filter name */
-#define	DT_SUNW_CAP		0x60000010	/* hardware/software */
-#define	DT_HIOS		0x6ffff000	/* Last OS-specific */
-
-/*
- * DT_* entries which fall between DT_VALRNGHI & DT_VALRNGLO use the
- * Dyn.d_un.d_val field of the Elf*_Dyn structure.
- */
-#define	DT_VALRNGLO	0x6ffffd00
-#define	DT_CHECKSUM	0x6ffffdf8	/* elf checksum */
-#define	DT_PLTPADSZ	0x6ffffdf9	/* pltpadding size */
-#define	DT_MOVEENT	0x6ffffdfa	/* move table entry size */
-#define	DT_MOVESZ	0x6ffffdfb	/* move table size */
-#define	DT_FEATURE_1	0x6ffffdfc	/* feature holder */
-#define	DT_POSFLAG_1	0x6ffffdfd	/* flags for DT_* entries, effecting */
-					/*	the following DT_* entry. */
-					/*	See DF_P1_* definitions */
-#define	DT_SYMINSZ	0x6ffffdfe	/* syminfo table size (in bytes) */
-#define	DT_SYMINENT	0x6ffffdff	/* syminfo entry size (in bytes) */
-#define	DT_VALRNGHI	0x6ffffdff
-
-/*
- * DT_* entries which fall between DT_ADDRRNGHI & DT_ADDRRNGLO use the
- * Dyn.d_un.d_ptr field of the Elf*_Dyn structure.
- *
- * If any adjustment is made to the ELF object after it has been
- * built, these entries will need to be adjusted.
- */
-#define	DT_ADDRRNGLO	0x6ffffe00
-#define	DT_GNU_HASH	0x6ffffef5	/* GNU-style hash table */
-#define	DT_CONFIG	0x6ffffefa	/* configuration information */
-#define	DT_DEPAUDIT	0x6ffffefb	/* dependency auditing */
-#define	DT_AUDIT	0x6ffffefc	/* object auditing */
-#define	DT_PLTPAD	0x6ffffefd	/* pltpadding (sparcv9) */
-#define	DT_MOVETAB	0x6ffffefe	/* move table */
-#define	DT_SYMINFO	0x6ffffeff	/* syminfo table */
-#define	DT_ADDRRNGHI	0x6ffffeff
-
-#define	DT_VERSYM	0x6ffffff0	/* Address of versym section. */
-#define	DT_RELACOUNT	0x6ffffff9	/* number of RELATIVE relocations */
-#define	DT_RELCOUNT	0x6ffffffa	/* number of RELATIVE relocations */
-#define	DT_FLAGS_1	0x6ffffffb	/* state flags - see DF_1_* defs */
-#define	DT_VERDEF	0x6ffffffc	/* Address of verdef section. */
-#define	DT_VERDEFNUM	0x6ffffffd	/* Number of elems in verdef section */
-#define	DT_VERNEED	0x6ffffffe	/* Address of verneed section. */
-#define	DT_VERNEEDNUM	0x6fffffff	/* Number of elems in verneed section */
-
-#define	DT_LOPROC	0x70000000	/* First processor-specific type. */
-#define	DT_DEPRECATED_SPARC_REGISTER	0x7000001
-#define	DT_AUXILIARY	0x7ffffffd	/* shared library auxiliary name */
-#define	DT_USED		0x7ffffffe	/* ignored - same as needed */
-#define	DT_FILTER	0x7fffffff	/* shared library filter name */
-#define	DT_HIPROC	0x7fffffff	/* Last processor-specific type. */
-
-/* Values for DT_FLAGS */
-#define	DF_ORIGIN	0x0001	/* Indicates that the object being loaded may
-				   make reference to the $ORIGIN substitution
-				   string */
-#define	DF_SYMBOLIC	0x0002	/* Indicates "symbolic" linking. */
-#define	DF_TEXTREL	0x0004	/* Indicates there may be relocations in
-				   non-writable segments. */
-#define	DF_BIND_NOW	0x0008	/* Indicates that the dynamic linker should
-				   process all relocations for the object
-				   containing this entry before transferring
-				   control to the program. */
-#define	DF_STATIC_TLS	0x0010	/* Indicates that the shared object or
-				   executable contains code using a static
-				   thread-local storage scheme. */
-
-/* Values for DT_FLAGS_1 */
-#define	DF_1_BIND_NOW	0x00000001	/* Same as DF_BIND_NOW */
-#define	DF_1_GLOBAL	0x00000002	/* Set the RTLD_GLOBAL for object */
-#define	DF_1_NODELETE	0x00000008	/* Set the RTLD_NODELETE for object */
-#define	DF_1_LOADFLTR	0x00000010	/* Immediate loading of filtees */
-#define	DF_1_NOOPEN     0x00000040	/* Do not allow loading on dlopen() */
-#define	DF_1_ORIGIN	0x00000080	/* Process $ORIGIN */
-#define	DF_1_NODEFLIB	0x00000800	/* Do not search default paths */
-
-/* Values for n_type.  Used in core files. */
-#define	NT_PRSTATUS	1	/* Process status. */
-#define	NT_FPREGSET	2	/* Floating point registers. */
-#define	NT_PRPSINFO	3	/* Process state info. */
-#define	NT_THRMISC	7	/* Thread miscellaneous info. */
-
-/* Symbol Binding - ELFNN_ST_BIND - st_info */
-#define	STB_LOCAL	0	/* Local symbol */
-#define	STB_GLOBAL	1	/* Global symbol */
-#define	STB_WEAK	2	/* like global - lower precedence */
-#define	STB_LOOS	10	/* Reserved range for operating system */
-#define	STB_HIOS	12	/*   specific semantics. */
-#define	STB_LOPROC	13	/* reserved range for processor */
-#define	STB_HIPROC	15	/*   specific semantics. */
-
-/* Symbol type - ELFNN_ST_TYPE - st_info */
-#define	STT_NOTYPE	0	/* Unspecified type. */
-#define	STT_OBJECT	1	/* Data object. */
-#define	STT_FUNC	2	/* Function. */
-#define	STT_SECTION	3	/* Section. */
-#define	STT_FILE	4	/* Source file. */
-#define	STT_COMMON	5	/* Uninitialized common block. */
-#define	STT_TLS		6	/* TLS object. */
-#define	STT_NUM		7
-#define	STT_LOOS	10	/* Reserved range for operating system */
-#define	STT_GNU_IFUNC	10
-#define	STT_HIOS	12	/*   specific semantics. */
-#define	STT_LOPROC	13	/* reserved range for processor */
-#define	STT_HIPROC	15	/*   specific semantics. */
-
-/* Symbol visibility - ELFNN_ST_VISIBILITY - st_other */
-#define	STV_DEFAULT	0x0	/* Default visibility (see binding). */
-#define	STV_INTERNAL	0x1	/* Special meaning in relocatable objects. */
-#define	STV_HIDDEN	0x2	/* Not visible. */
-#define	STV_PROTECTED	0x3	/* Visible but not preemptible. */
-#define	STV_EXPORTED	0x4
-#define	STV_SINGLETON	0x5
-#define	STV_ELIMINATE	0x6
-
-/* Special symbol table indexes. */
-#define	STN_UNDEF	0	/* Undefined symbol index. */
-
-/* Symbol versioning flags. */
-#define	VER_DEF_CURRENT	1
-#define	VER_DEF_IDX(x)	VER_NDX(x)
-
-#define	VER_FLG_BASE	0x01
-#define	VER_FLG_WEAK	0x02
-
-#define	VER_NEED_CURRENT	1
-#define	VER_NEED_WEAK	(1u << 15)
-#define	VER_NEED_HIDDEN	VER_NDX_HIDDEN
-#define	VER_NEED_IDX(x)	VER_NDX(x)
-
-#define	VER_NDX_LOCAL	0
-#define	VER_NDX_GLOBAL	1
-#define	VER_NDX_GIVEN	2
-
-#define	VER_NDX_HIDDEN	(1u << 15)
-#define	VER_NDX(x)	((x) & ~(1u << 15))
-
-#define	CA_SUNW_NULL	0
-#define	CA_SUNW_HW_1	1		/* first hardware capabilities entry */
-#define	CA_SUNW_SF_1	2		/* first software capabilities entry */
-
-/*
- * Syminfo flag values
- */
-#define	SYMINFO_FLG_DIRECT	0x0001	/* symbol ref has direct association */
-					/*	to object containing defn. */
-#define	SYMINFO_FLG_PASSTHRU	0x0002	/* ignored - see SYMINFO_FLG_FILTER */
-#define	SYMINFO_FLG_COPY	0x0004	/* symbol is a copy-reloc */
-#define	SYMINFO_FLG_LAZYLOAD	0x0008	/* object containing defn should be */
-					/*	lazily-loaded */
-#define	SYMINFO_FLG_DIRECTBIND	0x0010	/* ref should be bound directly to */
-					/*	object containing defn. */
-#define	SYMINFO_FLG_NOEXTDIRECT	0x0020	/* don't let an external reference */
-					/*	directly bind to this symbol */
-#define	SYMINFO_FLG_FILTER	0x0002	/* symbol ref is associated to a */
-#define	SYMINFO_FLG_AUXILIARY	0x0040	/* 	standard or auxiliary filter */
-
-/*
- * Syminfo.si_boundto values.
- */
-#define	SYMINFO_BT_SELF		0xffff	/* symbol bound to self */
-#define	SYMINFO_BT_PARENT	0xfffe	/* symbol bound to parent */
-#define	SYMINFO_BT_NONE		0xfffd	/* no special symbol binding */
-#define	SYMINFO_BT_EXTERN	0xfffc	/* symbol defined as external */
-#define	SYMINFO_BT_LOWRESERVE	0xff00	/* beginning of reserved entries */
-
-/*
- * Syminfo version values.
- */
-#define	SYMINFO_NONE		0	/* Syminfo version */
-#define	SYMINFO_CURRENT		1
-#define	SYMINFO_NUM		2
-
-/*
- * Relocation types.
- *
- * All machine architectures are defined here to allow tools on one to
- * handle others.
- */
-
-#define	R_386_NONE		0	/* No relocation. */
-#define	R_386_32		1	/* Add symbol value. */
-#define	R_386_PC32		2	/* Add PC-relative symbol value. */
-#define	R_386_GOT32		3	/* Add PC-relative GOT offset. */
-#define	R_386_PLT32		4	/* Add PC-relative PLT offset. */
-#define	R_386_COPY		5	/* Copy data from shared object. */
-#define	R_386_GLOB_DAT		6	/* Set GOT entry to data address. */
-#define	R_386_JMP_SLOT		7	/* Set GOT entry to code address. */
-#define	R_386_RELATIVE		8	/* Add load address of shared object. */
-#define	R_386_GOTOFF		9	/* Add GOT-relative symbol address. */
-#define	R_386_GOTPC		10	/* Add PC-relative GOT table address. */
-#define	R_386_TLS_TPOFF		14	/* Negative offset in static TLS block */
-#define	R_386_TLS_IE		15	/* Absolute address of GOT for -ve static TLS */
-#define	R_386_TLS_GOTIE		16	/* GOT entry for negative static TLS block */
-#define	R_386_TLS_LE		17	/* Negative offset relative to static TLS */
-#define	R_386_TLS_GD		18	/* 32 bit offset to GOT (index,off) pair */
-#define	R_386_TLS_LDM		19	/* 32 bit offset to GOT (index,zero) pair */
-#define	R_386_16		20
-#define	R_386_PC16		21
-#define	R_386_8			22
-#define	R_386_PC8		23
-#define	R_386_TLS_GD_32		24	/* 32 bit offset to GOT (index,off) pair */
-#define	R_386_TLS_GD_PUSH	25	/* pushl instruction for Sun ABI GD sequence */
-#define	R_386_TLS_GD_CALL	26	/* call instruction for Sun ABI GD sequence */
-#define	R_386_TLS_GD_POP	27	/* popl instruction for Sun ABI GD sequence */
-#define	R_386_TLS_LDM_32	28	/* 32 bit offset to GOT (index,zero) pair */
-#define	R_386_TLS_LDM_PUSH	29	/* pushl instruction for Sun ABI LD sequence */
-#define	R_386_TLS_LDM_CALL	30	/* call instruction for Sun ABI LD sequence */
-#define	R_386_TLS_LDM_POP	31	/* popl instruction for Sun ABI LD sequence */
-#define	R_386_TLS_LDO_32	32	/* 32 bit offset from start of TLS block */
-#define	R_386_TLS_IE_32		33	/* 32 bit offset to GOT static TLS offset entry */
-#define	R_386_TLS_LE_32		34	/* 32 bit offset within static TLS block */
-#define	R_386_TLS_DTPMOD32	35	/* GOT entry containing TLS index */
-#define	R_386_TLS_DTPOFF32	36	/* GOT entry containing TLS offset */
-#define	R_386_TLS_TPOFF32	37	/* GOT entry of -ve static TLS offset */
-#define	R_386_IRELATIVE		42	/* PLT entry resolved indirectly at runtime */
-
-#define	R_ARM_NONE		0	/* No relocation. */
-#define	R_ARM_PC24		1
-#define	R_ARM_ABS32		2
-#define	R_ARM_REL32		3
-#define	R_ARM_PC13		4
-#define	R_ARM_ABS16		5
-#define	R_ARM_ABS12		6
-#define	R_ARM_THM_ABS5		7
-#define	R_ARM_ABS8		8
-#define	R_ARM_SBREL32		9
-#define	R_ARM_THM_PC22		10
-#define	R_ARM_THM_PC8		11
-#define	R_ARM_AMP_VCALL9	12
-#define	R_ARM_SWI24		13
-#define	R_ARM_THM_SWI8		14
-#define	R_ARM_XPC25		15
-#define	R_ARM_THM_XPC22		16
-/* TLS relocations */
-#define	R_ARM_TLS_DTPMOD32	17	/* ID of module containing symbol */
-#define	R_ARM_TLS_DTPOFF32	18	/* Offset in TLS block */
-#define	R_ARM_TLS_TPOFF32	19	/* Offset in static TLS block */
-#define	R_ARM_COPY		20	/* Copy data from shared object. */
-#define	R_ARM_GLOB_DAT		21	/* Set GOT entry to data address. */
-#define	R_ARM_JUMP_SLOT		22	/* Set GOT entry to code address. */
-#define	R_ARM_RELATIVE		23	/* Add load address of shared object. */
-#define	R_ARM_GOTOFF		24	/* Add GOT-relative symbol address. */
-#define	R_ARM_GOTPC		25	/* Add PC-relative GOT table address. */
-#define	R_ARM_GOT32		26	/* Add PC-relative GOT offset. */
-#define	R_ARM_PLT32		27	/* Add PC-relative PLT offset. */
-#define	R_ARM_GNU_VTENTRY	100
-#define	R_ARM_GNU_VTINHERIT	101
-#define	R_ARM_RSBREL32		250
-#define	R_ARM_THM_RPC22		251
-#define	R_ARM_RREL32		252
-#define	R_ARM_RABS32		253
-#define	R_ARM_RPC24		254
-#define	R_ARM_RBASE		255
-
-/*	Name			Value	   Field	Calculation */
-#define	R_IA_64_NONE		0	/* None */
-#define	R_IA_64_IMM14		0x21	/* immediate14	S + A */
-#define	R_IA_64_IMM22		0x22	/* immediate22	S + A */
-#define	R_IA_64_IMM64		0x23	/* immediate64	S + A */
-#define	R_IA_64_DIR32MSB	0x24	/* word32 MSB	S + A */
-#define	R_IA_64_DIR32LSB	0x25	/* word32 LSB	S + A */
-#define	R_IA_64_DIR64MSB	0x26	/* word64 MSB	S + A */
-#define	R_IA_64_DIR64LSB	0x27	/* word64 LSB	S + A */
-#define	R_IA_64_GPREL22		0x2a	/* immediate22	@gprel(S + A) */
-#define	R_IA_64_GPREL64I	0x2b	/* immediate64	@gprel(S + A) */
-#define	R_IA_64_GPREL32MSB	0x2c	/* word32 MSB	@gprel(S + A) */
-#define	R_IA_64_GPREL32LSB	0x2d	/* word32 LSB	@gprel(S + A) */
-#define	R_IA_64_GPREL64MSB	0x2e	/* word64 MSB	@gprel(S + A) */
-#define	R_IA_64_GPREL64LSB	0x2f	/* word64 LSB	@gprel(S + A) */
-#define	R_IA_64_LTOFF22		0x32	/* immediate22	@ltoff(S + A) */
-#define	R_IA_64_LTOFF64I	0x33	/* immediate64	@ltoff(S + A) */
-#define	R_IA_64_PLTOFF22	0x3a	/* immediate22	@pltoff(S + A) */
-#define	R_IA_64_PLTOFF64I	0x3b	/* immediate64	@pltoff(S + A) */
-#define	R_IA_64_PLTOFF64MSB	0x3e	/* word64 MSB	@pltoff(S + A) */
-#define	R_IA_64_PLTOFF64LSB	0x3f	/* word64 LSB	@pltoff(S + A) */
-#define	R_IA_64_FPTR64I		0x43	/* immediate64	@fptr(S + A) */
-#define	R_IA_64_FPTR32MSB	0x44	/* word32 MSB	@fptr(S + A) */
-#define	R_IA_64_FPTR32LSB	0x45	/* word32 LSB	@fptr(S + A) */
-#define	R_IA_64_FPTR64MSB	0x46	/* word64 MSB	@fptr(S + A) */
-#define	R_IA_64_FPTR64LSB	0x47	/* word64 LSB	@fptr(S + A) */
-#define	R_IA_64_PCREL60B	0x48	/* immediate60 form1 S + A - P */
-#define	R_IA_64_PCREL21B	0x49	/* immediate21 form1 S + A - P */
-#define	R_IA_64_PCREL21M	0x4a	/* immediate21 form2 S + A - P */
-#define	R_IA_64_PCREL21F	0x4b	/* immediate21 form3 S + A - P */
-#define	R_IA_64_PCREL32MSB	0x4c	/* word32 MSB	S + A - P */
-#define	R_IA_64_PCREL32LSB	0x4d	/* word32 LSB	S + A - P */
-#define	R_IA_64_PCREL64MSB	0x4e	/* word64 MSB	S + A - P */
-#define	R_IA_64_PCREL64LSB	0x4f	/* word64 LSB	S + A - P */
-#define	R_IA_64_LTOFF_FPTR22	0x52	/* immediate22	@ltoff(@fptr(S + A)) */
-#define	R_IA_64_LTOFF_FPTR64I	0x53	/* immediate64	@ltoff(@fptr(S + A)) */
-#define	R_IA_64_LTOFF_FPTR32MSB	0x54	/* word32 MSB	@ltoff(@fptr(S + A)) */
-#define	R_IA_64_LTOFF_FPTR32LSB	0x55	/* word32 LSB	@ltoff(@fptr(S + A)) */
-#define	R_IA_64_LTOFF_FPTR64MSB	0x56	/* word64 MSB	@ltoff(@fptr(S + A)) */
-#define	R_IA_64_LTOFF_FPTR64LSB	0x57	/* word64 LSB	@ltoff(@fptr(S + A)) */
-#define	R_IA_64_SEGREL32MSB	0x5c	/* word32 MSB	@segrel(S + A) */
-#define	R_IA_64_SEGREL32LSB	0x5d	/* word32 LSB	@segrel(S + A) */
-#define	R_IA_64_SEGREL64MSB	0x5e	/* word64 MSB	@segrel(S + A) */
-#define	R_IA_64_SEGREL64LSB	0x5f	/* word64 LSB	@segrel(S + A) */
-#define	R_IA_64_SECREL32MSB	0x64	/* word32 MSB	@secrel(S + A) */
-#define	R_IA_64_SECREL32LSB	0x65	/* word32 LSB	@secrel(S + A) */
-#define	R_IA_64_SECREL64MSB	0x66	/* word64 MSB	@secrel(S + A) */
-#define	R_IA_64_SECREL64LSB	0x67	/* word64 LSB	@secrel(S + A) */
-#define	R_IA_64_REL32MSB	0x6c	/* word32 MSB	BD + A */
-#define	R_IA_64_REL32LSB	0x6d	/* word32 LSB	BD + A */
-#define	R_IA_64_REL64MSB	0x6e	/* word64 MSB	BD + A */
-#define	R_IA_64_REL64LSB	0x6f	/* word64 LSB	BD + A */
-#define	R_IA_64_LTV32MSB	0x74	/* word32 MSB	S + A */
-#define	R_IA_64_LTV32LSB	0x75	/* word32 LSB	S + A */
-#define	R_IA_64_LTV64MSB	0x76	/* word64 MSB	S + A */
-#define	R_IA_64_LTV64LSB	0x77	/* word64 LSB	S + A */
-#define	R_IA_64_PCREL21BI	0x79	/* immediate21 form1 S + A - P */
-#define	R_IA_64_PCREL22		0x7a	/* immediate22	S + A - P */
-#define	R_IA_64_PCREL64I	0x7b	/* immediate64	S + A - P */
-#define	R_IA_64_IPLTMSB		0x80	/* function descriptor MSB special */
-#define	R_IA_64_IPLTLSB		0x81	/* function descriptor LSB speciaal */
-#define	R_IA_64_SUB		0x85	/* immediate64	A - S */
-#define	R_IA_64_LTOFF22X	0x86	/* immediate22	special */
-#define	R_IA_64_LDXMOV		0x87	/* immediate22	special */
-#define	R_IA_64_TPREL14		0x91	/* imm14	@tprel(S + A) */
-#define	R_IA_64_TPREL22		0x92	/* imm22	@tprel(S + A) */
-#define	R_IA_64_TPREL64I	0x93	/* imm64	@tprel(S + A) */
-#define	R_IA_64_TPREL64MSB	0x96	/* word64 MSB	@tprel(S + A) */
-#define	R_IA_64_TPREL64LSB	0x97	/* word64 LSB	@tprel(S + A) */
-#define	R_IA_64_LTOFF_TPREL22	0x9a	/* imm22	@ltoff(@tprel(S+A)) */
-#define	R_IA_64_DTPMOD64MSB	0xa6	/* word64 MSB	@dtpmod(S + A) */
-#define	R_IA_64_DTPMOD64LSB	0xa7	/* word64 LSB	@dtpmod(S + A) */
-#define	R_IA_64_LTOFF_DTPMOD22	0xaa	/* imm22	@ltoff(@dtpmod(S+A)) */
-#define	R_IA_64_DTPREL14	0xb1	/* imm14	@dtprel(S + A) */
-#define	R_IA_64_DTPREL22	0xb2	/* imm22	@dtprel(S + A) */
-#define	R_IA_64_DTPREL64I	0xb3	/* imm64	@dtprel(S + A) */
-#define	R_IA_64_DTPREL32MSB	0xb4	/* word32 MSB	@dtprel(S + A) */
-#define	R_IA_64_DTPREL32LSB	0xb5	/* word32 LSB	@dtprel(S + A) */
-#define	R_IA_64_DTPREL64MSB	0xb6	/* word64 MSB	@dtprel(S + A) */
-#define	R_IA_64_DTPREL64LSB	0xb7	/* word64 LSB	@dtprel(S + A) */
-#define	R_IA_64_LTOFF_DTPREL22	0xba	/* imm22	@ltoff(@dtprel(S+A)) */
-
-/* Linux style aliases */
-#define	R_IA64_NONE		R_IA_64_NONE
-#define	R_IA64_IMM14		R_IA_64_IMM14
-#define	R_IA64_IMM22		R_IA_64_IMM22
-#define	R_IA64_IMM64		R_IA_64_IMM64
-#define	R_IA64_DIR32MSB		R_IA_64_DIR32MSB
-#define	R_IA64_DIR32LSB		R_IA_64_DIR32LSB
-#define	R_IA64_DIR64MSB		R_IA_64_DIR64MSB
-#define	R_IA64_DIR64LSB		R_IA_64_DIR64LSB
-#define	R_IA64_GPREL22		R_IA_64_GPREL22
-#define	R_IA64_GPREL64I		R_IA_64_GPREL64I
-#define	R_IA64_GPREL32MSB	R_IA_64_GPREL32MSB
-#define	R_IA64_GPREL32LSB	R_IA_64_GPREL32LSB
-#define	R_IA64_GPREL64MSB	R_IA_64_GPREL64MSB
-#define	R_IA64_GPREL64LSB	R_IA_64_GPREL64LSB
-#define	R_IA64_LTOFF22		R_IA_64_LTOFF22
-#define	R_IA64_LTOFF64I		R_IA_64_LTOFF64I
-#define	R_IA64_PLTOFF22		R_IA_64_PLTOFF22
-#define	R_IA64_PLTOFF64I	R_IA_64_PLTOFF64I
-#define	R_IA64_PLTOFF64MSB	R_IA_64_PLTOFF64MSB
-#define	R_IA64_PLTOFF64LSB	R_IA_64_PLTOFF64LSB
-#define	R_IA64_FPTR64I		R_IA_64_FPTR64I
-#define	R_IA64_FPTR32MSB	R_IA_64_FPTR32MSB
-#define	R_IA64_FPTR32LSB	R_IA_64_FPTR32LSB
-#define	R_IA64_FPTR64MSB	R_IA_64_FPTR64MSB
-#define	R_IA64_FPTR64LSB	R_IA_64_FPTR64LSB
-#define	R_IA64_PCREL60B		R_IA_64_PCREL60B
-#define	R_IA64_PCREL21B		R_IA_64_PCREL21B
-#define	R_IA64_PCREL21M		R_IA_64_PCREL21M
-#define	R_IA64_PCREL21F		R_IA_64_PCREL21F
-#define	R_IA64_PCREL32MSB	R_IA_64_PCREL32MSB
-#define	R_IA64_PCREL32LSB	R_IA_64_PCREL32LSB
-#define	R_IA64_PCREL64MSB	R_IA_64_PCREL64MSB
-#define	R_IA64_PCREL64LSB	R_IA_64_PCREL64LSB
-#define	R_IA64_LTOFF_FPTR22	R_IA_64_LTOFF_FPTR22
-#define	R_IA64_LTOFF_FPTR64I	R_IA_64_LTOFF_FPTR64I
-#define	R_IA64_LTOFF_FPTR32MSB	R_IA_64_LTOFF_FPTR32MSB
-#define	R_IA64_LTOFF_FPTR32LSB	R_IA_64_LTOFF_FPTR32LSB
-#define	R_IA64_LTOFF_FPTR64MSB	R_IA_64_LTOFF_FPTR64MSB
-#define	R_IA64_LTOFF_FPTR64LSB	R_IA_64_LTOFF_FPTR64LSB
-#define	R_IA64_SEGREL32MSB	R_IA_64_SEGREL32MSB
-#define	R_IA64_SEGREL32LSB	R_IA_64_SEGREL32LSB
-#define	R_IA64_SEGREL64MSB	R_IA_64_SEGREL64MSB
-#define	R_IA64_SEGREL64LSB	R_IA_64_SEGREL64LSB
-#define	R_IA64_SECREL32MSB	R_IA_64_SECREL32MSB
-#define	R_IA64_SECREL32LSB	R_IA_64_SECREL32LSB
-#define	R_IA64_SECREL64MSB	R_IA_64_SECREL64MSB
-#define	R_IA64_SECREL64LSB	R_IA_64_SECREL64LSB
-#define	R_IA64_REL32MSB		R_IA_64_REL32MSB
-#define	R_IA64_REL32LSB		R_IA_64_REL32LSB
-#define	R_IA64_REL64MSB		R_IA_64_REL64MSB
-#define	R_IA64_REL64LSB		R_IA_64_REL64LSB
-#define	R_IA64_LTV32MSB		R_IA_64_LTV32MSB
-#define	R_IA64_LTV32LSB		R_IA_64_LTV32LSB
-#define	R_IA64_LTV64MSB		R_IA_64_LTV64MSB
-#define	R_IA64_LTV64LSB		R_IA_64_LTV64LSB
-#define	R_IA64_PCREL21BI	R_IA_64_PCREL21BI
-#define	R_IA64_PCREL22		R_IA_64_PCREL22
-#define	R_IA64_PCREL64I		R_IA_64_PCREL64I
-#define	R_IA64_IPLTMSB		R_IA_64_IPLTMSB
-#define	R_IA64_IPLTLSB		R_IA_64_IPLTLSB
-#define	R_IA64_SUB		R_IA_64_SUB
-#define	R_IA64_LTOFF22X		R_IA_64_LTOFF22X
-#define	R_IA64_LDXMOV		R_IA_64_LDXMOV
-#define	R_IA64_TPREL14		R_IA_64_TPREL14
-#define	R_IA64_TPREL22		R_IA_64_TPREL22
-#define	R_IA64_TPREL64I		R_IA_64_TPREL64I
-#define	R_IA64_TPREL64MSB	R_IA_64_TPREL64MSB
-#define	R_IA64_TPREL64LSB	R_IA_64_TPREL64LSB
-#define	R_IA64_LTOFF_TPREL22	R_IA_64_LTOFF_TPREL22
-#define	R_IA64_DTPMOD64MSB	R_IA_64_DTPMOD64MSB
-#define	R_IA64_DTPMOD64LSB	R_IA_64_DTPMOD64LSB
-#define	R_IA64_LTOFF_DTPMOD22	R_IA_64_LTOFF_DTPMOD22
-#define	R_IA64_DTPREL14		R_IA_64_DTPREL14
-#define	R_IA64_DTPREL22		R_IA_64_DTPREL22
-#define	R_IA64_DTPREL64I	R_IA_64_DTPREL64I
-#define	R_IA64_DTPREL32MSB	R_IA_64_DTPREL32MSB
-#define	R_IA64_DTPREL32LSB	R_IA_64_DTPREL32LSB
-#define	R_IA64_DTPREL64MSB	R_IA_64_DTPREL64MSB
-#define	R_IA64_DTPREL64LSB	R_IA_64_DTPREL64LSB
-#define	R_IA64_LTOFF_DTPREL22	R_IA_64_LTOFF_DTPREL22
-
-#define	R_MIPS_NONE	0	/* No reloc */
-#define	R_MIPS_16	1	/* Direct 16 bit */
-#define	R_MIPS_32	2	/* Direct 32 bit */
-#define	R_MIPS_REL32	3	/* PC relative 32 bit */
-#define	R_MIPS_26	4	/* Direct 26 bit shifted */
-#define	R_MIPS_HI16	5	/* High 16 bit */
-#define	R_MIPS_LO16	6	/* Low 16 bit */
-#define	R_MIPS_GPREL16	7	/* GP relative 16 bit */
-#define	R_MIPS_LITERAL	8	/* 16 bit literal entry */
-#define	R_MIPS_GOT16	9	/* 16 bit GOT entry */
-#define	R_MIPS_PC16	10	/* PC relative 16 bit */
-#define	R_MIPS_CALL16	11	/* 16 bit GOT entry for function */
-#define	R_MIPS_GPREL32	12	/* GP relative 32 bit */
-#define	R_MIPS_64	18	/* Direct 64 bit */
-#define	R_MIPS_GOTHI16	21	/* GOT HI 16 bit */
-#define	R_MIPS_GOTLO16	22	/* GOT LO 16 bit */
-#define	R_MIPS_CALLHI16 30	/* upper 16 bit GOT entry for function */
-#define	R_MIPS_CALLLO16 31	/* lower 16 bit GOT entry for function */
-
-#define	R_PPC_NONE		0	/* No relocation. */
-#define	R_PPC_ADDR32		1
-#define	R_PPC_ADDR24		2
-#define	R_PPC_ADDR16		3
-#define	R_PPC_ADDR16_LO		4
-#define	R_PPC_ADDR16_HI		5
-#define	R_PPC_ADDR16_HA		6
-#define	R_PPC_ADDR14		7
-#define	R_PPC_ADDR14_BRTAKEN	8
-#define	R_PPC_ADDR14_BRNTAKEN	9
-#define	R_PPC_REL24		10
-#define	R_PPC_REL14		11
-#define	R_PPC_REL14_BRTAKEN	12
-#define	R_PPC_REL14_BRNTAKEN	13
-#define	R_PPC_GOT16		14
-#define	R_PPC_GOT16_LO		15
-#define	R_PPC_GOT16_HI		16
-#define	R_PPC_GOT16_HA		17
-#define	R_PPC_PLTREL24		18
-#define	R_PPC_COPY		19
-#define	R_PPC_GLOB_DAT		20
-#define	R_PPC_JMP_SLOT		21
-#define	R_PPC_RELATIVE		22
-#define	R_PPC_LOCAL24PC		23
-#define	R_PPC_UADDR32		24
-#define	R_PPC_UADDR16		25
-#define	R_PPC_REL32		26
-#define	R_PPC_PLT32		27
-#define	R_PPC_PLTREL32		28
-#define	R_PPC_PLT16_LO		29
-#define	R_PPC_PLT16_HI		30
-#define	R_PPC_PLT16_HA		31
-#define	R_PPC_SDAREL16		32
-#define	R_PPC_SECTOFF		33
-#define	R_PPC_SECTOFF_LO	34
-#define	R_PPC_SECTOFF_HI	35
-#define	R_PPC_SECTOFF_HA	36
-
-/*
- * 64-bit relocations
- */
-#define	R_PPC64_ADDR64		38
-#define	R_PPC64_ADDR16_HIGHER	39
-#define	R_PPC64_ADDR16_HIGHERA	40
-#define	R_PPC64_ADDR16_HIGHEST	41
-#define	R_PPC64_ADDR16_HIGHESTA	42
-#define	R_PPC64_UADDR64		43
-#define	R_PPC64_REL64		44
-#define	R_PPC64_PLT64		45
-#define	R_PPC64_PLTREL64	46
-#define	R_PPC64_TOC16		47
-#define	R_PPC64_TOC16_LO	48
-#define	R_PPC64_TOC16_HI	49
-#define	R_PPC64_TOC16_HA	50
-#define	R_PPC64_TOC		51
-#define	R_PPC64_DTPMOD64	68
-#define	R_PPC64_TPREL64		73
-#define	R_PPC64_DTPREL64	78
-
-/*
- * TLS relocations
- */
-#define	R_PPC_TLS		67
-#define	R_PPC_DTPMOD32		68
-#define	R_PPC_TPREL16		69
-#define	R_PPC_TPREL16_LO	70
-#define	R_PPC_TPREL16_HI	71
-#define	R_PPC_TPREL16_HA	72
-#define	R_PPC_TPREL32		73
-#define	R_PPC_DTPREL16		74
-#define	R_PPC_DTPREL16_LO	75
-#define	R_PPC_DTPREL16_HI	76
-#define	R_PPC_DTPREL16_HA	77
-#define	R_PPC_DTPREL32		78
-#define	R_PPC_GOT_TLSGD16	79
-#define	R_PPC_GOT_TLSGD16_LO	80
-#define	R_PPC_GOT_TLSGD16_HI	81
-#define	R_PPC_GOT_TLSGD16_HA	82
-#define	R_PPC_GOT_TLSLD16	83
-#define	R_PPC_GOT_TLSLD16_LO	84
-#define	R_PPC_GOT_TLSLD16_HI	85
-#define	R_PPC_GOT_TLSLD16_HA	86
-#define	R_PPC_GOT_TPREL16	87
-#define	R_PPC_GOT_TPREL16_LO	88
-#define	R_PPC_GOT_TPREL16_HI	89
-#define	R_PPC_GOT_TPREL16_HA	90
-
-/*
- * The remaining relocs are from the Embedded ELF ABI, and are not in the
- *  SVR4 ELF ABI.
- */
-
-#define	R_PPC_EMB_NADDR32	101
-#define	R_PPC_EMB_NADDR16	102
-#define	R_PPC_EMB_NADDR16_LO	103
-#define	R_PPC_EMB_NADDR16_HI	104
-#define	R_PPC_EMB_NADDR16_HA	105
-#define	R_PPC_EMB_SDAI16	106
-#define	R_PPC_EMB_SDA2I16	107
-#define	R_PPC_EMB_SDA2REL	108
-#define	R_PPC_EMB_SDA21		109
-#define	R_PPC_EMB_MRKREF	110
-#define	R_PPC_EMB_RELSEC16	111
-#define	R_PPC_EMB_RELST_LO	112
-#define	R_PPC_EMB_RELST_HI	113
-#define	R_PPC_EMB_RELST_HA	114
-#define	R_PPC_EMB_BIT_FLD	115
-#define	R_PPC_EMB_RELSDA	116
-
-#define	R_SH_NONE		0
-#define	R_SH_DIR32		1
-#define	R_SH_REL32		2
-#define	R_SH_DIR8WPN		3
-#define	R_SH_IND12W		4
-#define	R_SH_DIR8WPL		5
-#define	R_SH_DIR8WPZ		6
-#define	R_SH_DIR8BP		7
-#define	R_SH_DIR8W		8
-#define	R_SH_DIR8L		9
-#define	R_SH_GOT32		0xa0
-#define	R_SH_PLT32		0xa1
-#define	R_SH_COPY		0xa2
-#define	R_SH_GLOB_DAT		0xa3
-#define	R_SH_JMP_SLOT		0xa4
-#define	R_SH_RELATIVE		0xa5
-#define	R_SH_GOTOFF		0xa6
-#define	R_SH_GOTPC		0xa7
-
-#define	R_SPARC_NONE		0
-#define	R_SPARC_8		1
-#define	R_SPARC_16		2
-#define	R_SPARC_32		3
-#define	R_SPARC_DISP8		4
-#define	R_SPARC_DISP16		5
-#define	R_SPARC_DISP32		6
-#define	R_SPARC_WDISP30		7
-#define	R_SPARC_WDISP22		8
-#define	R_SPARC_HI22		9
-#define	R_SPARC_22		10
-#define	R_SPARC_13		11
-#define	R_SPARC_LO10		12
-#define	R_SPARC_GOT10		13
-#define	R_SPARC_GOT13		14
-#define	R_SPARC_GOT22		15
-#define	R_SPARC_PC10		16
-#define	R_SPARC_PC22		17
-#define	R_SPARC_WPLT30		18
-#define	R_SPARC_COPY		19
-#define	R_SPARC_GLOB_DAT	20
-#define	R_SPARC_JMP_SLOT	21
-#define	R_SPARC_RELATIVE	22
-#define	R_SPARC_UA32		23
-#define	R_SPARC_PLT32		24
-#define	R_SPARC_HIPLT22		25
-#define	R_SPARC_LOPLT10		26
-#define	R_SPARC_PCPLT32		27
-#define	R_SPARC_PCPLT22		28
-#define	R_SPARC_PCPLT10		29
-#define	R_SPARC_10		30
-#define	R_SPARC_11		31
-#define	R_SPARC_64		32
-#define	R_SPARC_OLO10		33
-#define	R_SPARC_HH22		34
-#define	R_SPARC_HM10		35
-#define	R_SPARC_LM22		36
-#define	R_SPARC_PC_HH22		37
-#define	R_SPARC_PC_HM10		38
-#define	R_SPARC_PC_LM22		39
-#define	R_SPARC_WDISP16		40
-#define	R_SPARC_WDISP19		41
-#define	R_SPARC_GLOB_JMP	42
-#define	R_SPARC_7		43
-#define	R_SPARC_5		44
-#define	R_SPARC_6		45
-#define	R_SPARC_DISP64		46
-#define	R_SPARC_PLT64		47
-#define	R_SPARC_HIX22		48
-#define	R_SPARC_LOX10		49
-#define	R_SPARC_H44		50
-#define	R_SPARC_M44		51
-#define	R_SPARC_L44		52
-#define	R_SPARC_REGISTER	53
-#define	R_SPARC_UA64		54
-#define	R_SPARC_UA16		55
-#define	R_SPARC_TLS_GD_HI22	56
-#define	R_SPARC_TLS_GD_LO10	57
-#define	R_SPARC_TLS_GD_ADD	58
-#define	R_SPARC_TLS_GD_CALL	59
-#define	R_SPARC_TLS_LDM_HI22	60
-#define	R_SPARC_TLS_LDM_LO10	61
-#define	R_SPARC_TLS_LDM_ADD	62
-#define	R_SPARC_TLS_LDM_CALL	63
-#define	R_SPARC_TLS_LDO_HIX22	64
-#define	R_SPARC_TLS_LDO_LOX10	65
-#define	R_SPARC_TLS_LDO_ADD	66
-#define	R_SPARC_TLS_IE_HI22	67
-#define	R_SPARC_TLS_IE_LO10	68
-#define	R_SPARC_TLS_IE_LD	69
-#define	R_SPARC_TLS_IE_LDX	70
-#define	R_SPARC_TLS_IE_ADD	71
-#define	R_SPARC_TLS_LE_HIX22	72
-#define	R_SPARC_TLS_LE_LOX10	73
-#define	R_SPARC_TLS_DTPMOD32	74
-#define	R_SPARC_TLS_DTPMOD64	75
-#define	R_SPARC_TLS_DTPOFF32	76
-#define	R_SPARC_TLS_DTPOFF64	77
-#define	R_SPARC_TLS_TPOFF32	78
-#define	R_SPARC_TLS_TPOFF64	79
-
-#define	R_X86_64_NONE		0	/* No relocation. */
-#define	R_X86_64_64		1	/* Add 64 bit symbol value. */
-#define	R_X86_64_PC32		2	/* PC-relative 32 bit signed sym value. */
-#define	R_X86_64_GOT32		3	/* PC-relative 32 bit GOT offset. */
-#define	R_X86_64_PLT32		4	/* PC-relative 32 bit PLT offset. */
-#define	R_X86_64_COPY		5	/* Copy data from shared object. */
-#define	R_X86_64_GLOB_DAT	6	/* Set GOT entry to data address. */
-#define	R_X86_64_JMP_SLOT	7	/* Set GOT entry to code address. */
-#define	R_X86_64_RELATIVE	8	/* Add load address of shared object. */
-#define	R_X86_64_GOTPCREL	9	/* Add 32 bit signed pcrel offset to GOT. */
-#define	R_X86_64_32		10	/* Add 32 bit zero extended symbol value */
-#define	R_X86_64_32S		11	/* Add 32 bit sign extended symbol value */
-#define	R_X86_64_16		12	/* Add 16 bit zero extended symbol value */
-#define	R_X86_64_PC16		13	/* Add 16 bit signed extended pc relative symbol value */
-#define	R_X86_64_8		14	/* Add 8 bit zero extended symbol value */
-#define	R_X86_64_PC8		15	/* Add 8 bit signed extended pc relative symbol value */
-#define	R_X86_64_DTPMOD64	16	/* ID of module containing symbol */
-#define	R_X86_64_DTPOFF64	17	/* Offset in TLS block */
-#define	R_X86_64_TPOFF64	18	/* Offset in static TLS block */
-#define	R_X86_64_TLSGD		19	/* PC relative offset to GD GOT entry */
-#define	R_X86_64_TLSLD		20	/* PC relative offset to LD GOT entry */
-#define	R_X86_64_DTPOFF32	21	/* Offset in TLS block */
-#define	R_X86_64_GOTTPOFF	22	/* PC relative offset to IE GOT entry */
-#define	R_X86_64_TPOFF32	23	/* Offset in static TLS block */
-#define	R_X86_64_IRELATIVE	37
-
-#define	R_390_NONE		0
-#define	R_390_8			1
-#define	R_390_12		2
-#define	R_390_16		3
-#define	R_390_32		4
-#define	R_390_PC32		5
-#define	R_390_GOT12		6
-#define	R_390_GOT32		7
-#define	R_390_PLT32		8
-#define	R_390_COPY		9
-#define	R_390_GLOB_DAT		10
-#define	R_390_JMP_SLOT		11
-#define	R_390_RELATIVE		12
-#define	R_390_GOTOFF		13
-#define	R_390_GOTPC		14
-#define	R_390_GOT16		15
-#define	R_390_PC16		16
-#define	R_390_PC16DBL		17
-#define	R_390_PLT16DBL		18
-#define	R_390_PC32DBL		19
-#define	R_390_PLT32DBL		20
-#define	R_390_GOTPCDBL		21
-#define	R_390_64		22
-#define	R_390_PC64		23
-#define	R_390_GOT64		24
-#define	R_390_PLT64		25
-#define	R_390_GOTENT		26
-
-#endif /* !_SYS_ELF_COMMON_H_ */
diff --git a/winsup/cygwin/include/sys/elf_generic.h b/winsup/cygwin/include/sys/elf_generic.h
deleted file mode 100644
index 95a682f25..000000000
--- a/winsup/cygwin/include/sys/elf_generic.h
+++ /dev/null
@@ -1,88 +0,0 @@
-/*-
- * Copyright (c) 1998 John D. Polstra.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGE.
- *
- * $FreeBSD$
- */
-
-#ifndef _SYS_ELF_GENERIC_H_
-#define	_SYS_ELF_GENERIC_H_ 1
-
-#include <sys/cdefs.h>
-
-/*
- * Definitions of generic ELF names which relieve applications from
- * needing to know the word size.
- */
-
-#if __ELF_WORD_SIZE != 32 && __ELF_WORD_SIZE != 64
-#error "__ELF_WORD_SIZE must be defined as 32 or 64"
-#endif
-
-#define	ELF_CLASS	__CONCAT(ELFCLASS,__ELF_WORD_SIZE)
-
-#if BYTE_ORDER == LITTLE_ENDIAN
-#define	ELF_DATA	ELFDATA2LSB
-#elif BYTE_ORDER == BIG_ENDIAN
-#define	ELF_DATA	ELFDATA2MSB
-#else
-#error "Unknown byte order"
-#endif
-
-#define	__elfN(x)	__CONCAT(__CONCAT(__CONCAT(elf,__ELF_WORD_SIZE),_),x)
-#define	__ElfN(x)	__CONCAT(__CONCAT(__CONCAT(Elf,__ELF_WORD_SIZE),_),x)
-#define	__ELFN(x)	__CONCAT(__CONCAT(__CONCAT(ELF,__ELF_WORD_SIZE),_),x)
-#define	__ElfType(x)	typedef __ElfN(x) __CONCAT(Elf_,x)
-
-__ElfType(Addr);
-__ElfType(Half);
-__ElfType(Off);
-__ElfType(Sword);
-__ElfType(Word);
-__ElfType(Ehdr);
-__ElfType(Shdr);
-__ElfType(Phdr);
-__ElfType(Dyn);
-__ElfType(Rel);
-__ElfType(Rela);
-__ElfType(Sym);
-__ElfType(Verdef);
-__ElfType(Verdaux);
-__ElfType(Verneed);
-__ElfType(Vernaux);
-__ElfType(Versym);
-
-/* Non-standard ELF types. */
-__ElfType(Hashelt);
-__ElfType(Size);
-__ElfType(Ssize);
-
-#define	ELF_R_SYM	__ELFN(R_SYM)
-#define	ELF_R_TYPE	__ELFN(R_TYPE)
-#define	ELF_R_INFO	__ELFN(R_INFO)
-#define	ELF_ST_BIND	__ELFN(ST_BIND)
-#define	ELF_ST_TYPE	__ELFN(ST_TYPE)
-#define	ELF_ST_INFO	__ELFN(ST_INFO)
-
-#endif /* !_SYS_ELF_GENERIC_H_ */
-- 
2.13.2
