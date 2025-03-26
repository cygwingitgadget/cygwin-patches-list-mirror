Return-Path: <SRS0=RlaE=WN=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 7DAC0385AC1D
	for <cygwin-patches@cygwin.com>; Wed, 26 Mar 2025 17:18:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7DAC0385AC1D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7DAC0385AC1D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743009494; cv=none;
	b=ixrtYQmPX1+oCNy7kVJiDe+qZtDziL1Ot5lxmkd1JxPtW4lKwC8RnQMrr6K5U7b7rNF/hJu7FYIgX176Y2aBpcKRPKW5a8OlDDh32tNc7L18dPmZCa1lP4yrDJPfGiS9LzKbn4nNMmK4Xf7b3OzZT0qPlQ9xS7Xxo8lLZX3AFKM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743009494; c=relaxed/simple;
	bh=H49DHdopGnR6NmgV+SOWPJlpaSiriplu0xIj4nd2B50=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=o05rwtVhbM5mMTQVcxDFClBgCmugkwEuI9QRAgcareBweM+CNCAxYIXDjsit2QV/WPuUK4RN+vgKKn7QljAPP5ZFBIozs8TWqFW7Y5gw5i7xUTKD0DbMRn7PFXZ7+dvOmoXx+ZssEi8VQj561cKeRpRhFC297zuin6+e0bCfj+M=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7DAC0385AC1D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=JkMiWQE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743009493; x=1743614293;
	i=johannes.schindelin@gmx.de;
	bh=paUbUnw7UZ0Z99SV/76hvDN6othLr+AOlyxK8+IOxog=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JkMiWQE5u4tPgJRAQOjhshsMrpFsSnaZTozlHJSkZKqv6dDmsJaRD5SjyHj3JTfc
	 /0/EMIRedXMLukJ6hLHE3l9kC8sQwB+6Fd7zBrBVsD6hcLcWSsExspennW9tHtYHN
	 VBJhsHMsNEQx7spqKeTTYnMD7puFO+y+ZoOANII/mxdaHY+xQXcbtQdPQRTPRSTqO
	 NeG4Zx2SUru17nFM26yneR96WuRowqnuh62BS6bjveSmE/0d2GjcA4HkPrztxEun3
	 9VkyTEuuQVqs1Q2Pj99buDJsVFNQxVdckILFZ11yde6l14KhekmCyhfPAEAUREOfR
	 wERi5QnR7MbAD+ZBGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeU0k-1tNK9x0Vvw-00pBuO; Wed, 26
 Mar 2025 18:18:13 +0100
Date: Wed, 26 Mar 2025 18:18:12 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeremy Drake <cygwin@jdrake.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] find_fast_cwd_pointer rewrite
In-Reply-To: <dd2918ee-0f21-a2e9-5427-e78be076bc5e@jdrake.com>
Message-ID: <3283c294-d62e-ac18-9fbe-d0e0071a1d64@gmx.de>
References: <dd2918ee-0f21-a2e9-5427-e78be076bc5e@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xLmNPUkNGfCgiYWvJ4HrMZ09RxfEKsg6IiW9+qYiqut5+VdviBV
 aXxHRcJQQ8VelcROMuRa3We06aG1qHXo0CdYnPoB8cAYGbvVGrBd5GCX5B6ItmgfYoNtx45
 p8p9vV/ImPRe2JB/aLn3asb9pGATvDCECFx9PpFOvVex0JcrXtqqHPhcezMX1FvM2Pg1oNq
 uks8vBEZd7K2Gj/yLybnw==
UI-OutboundReport: notjunk:1;M01:P0:YAF4QJ7GAGs=;jPQ0K6NDPl6imgx9Io9Ca7uDeeN
 0354+8NzjiTPeDeF90bUR2r573tgXC52dsKQFjKwVrQ4fWpLkkFtaVXHjJe3+UF4JXjXFu6Hv
 HuQZdhkhfJ/8hiqof/S1AF9xd9tM7okntSBSU59dECI2zhz1joAp+H04fNR3efi2nw5N4y8NQ
 UNAZ2Q3a0KeLD2WVgpb1wEk4Jj0qkWUlii0RwE8PnL5wSZKDV30l3tiKfZ//6Vu+KxRTWkmsz
 oIsF2DkSsUIkAATgq+fFqjVhuft2mEtw4ZVib1aGVjv0Yc98PgV36ZF9Ndrg8JdcOwsUVtrx7
 2EMDdi0rUgYQ5O8AYXfohNUh+MJ39UeYmQLhGRFevERVUHDoV+C/Vop26KRQWxwuX9Lp3Xv0n
 zBh7CwYpdkaWNVXwt1jiIGYWQPvaYgmz8ZCFPWVqdN9iQO+Jaq2c6Yvg+6R6xs8LSxZc0uiv+
 7uatCtBPqxEgG06pKEGX9JjWQ4mijZzLWj+AjiSIKBKPjl8iozmhfDubwlIQ2er9KKp2obnzA
 jf1Ao90YCwZ4rgdeRM4bhbQ+vyDx2uDzG4mNOCD7m0I9gEhPqQL0ZXG8zqecV7GPkQwOruqOr
 hYGq2fWoJi2uuXlIw3YkOT1I1jFsFNfbLO85mkJHS5H+mzFRa3N/PXkKmYGLu7dY+si0SRORS
 f6wAsJ5YWppGs4EyezoH/8jnouWRFdSK4zMbd4t5IYlCCwcM16w6TdNKUHF12SJSER+pinXLq
 dIrWD8976s/XkMXAxFJJ047hLvwlrjuRmIvXr/fnHKxaDxvQES78JCcFacqO8feH7nFCuR2mL
 NL9Q3YEz/28poUxneUOAx4K9T0PzD2fXI6pDqDgcd/00HXK5m5L4kh3t4+d0ywj0SxsJN3xAr
 2swLINUOvQXcW0RW20meGp6ck/ncmK4VZRvoIwnAE6G/Zw9KQ9ilvPpKt1qBWr+g6EbYCaaWk
 RE5o8tipj8JcqY3Pp97iTf7Uo2IhnVo9XU37ICQVg3s4p4vTcPMZ8ZXEWGURhMuElhrGuQf8z
 HVShJIRSF/mCpA63pZemrJQeNDe29QmsvuyFmckZu+wdXGdEcv/0J9PcuACTlNPjDn5+Hnac/
 TUbPKZois0u6iCByA2yH+LWPq8hWyUaAPVHZbWTM6gSfY71NcRFwTacM4E6EO/ZMUngIYcKjj
 Fwb1ylVAm8VELf6HVUOH4dlcpH9lT8IeXSB4vdSk7eKO5Wd/R3Qu+D5mmrBRSt5dabxpPgcBe
 sYnUQSjjSXJS89pUcRpOYE0ARxIt8YAoEB6b5AUbwC+RHg9V5bWqy6cx6SdWJkTLbuXPK7tS8
 DcJQxELFzBBWp3Ufjl5j/hjerBPiy9YrpB2tsBPvU4WQrwvo+4tjCO2Y1thOAlSsCxdyhhrXs
 HstOuEImuOXeKNAGkHYZssISF3a+WsrFbClcDvj/9iKOpl8l3CjNI1/y5uzNzJ5Zl8LS8ZAOE
 8dCaLO646OxTLvn6/K46+tdTGxp4f2FRQKM9MjRHgiWuspdiJBbX9XizCqEPl1lU317RrSgH+
 TAlt0EIoZLLSp9jgp7PGTYbhrgf5FAzRWHCU+JVi
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,KAM_ASCII_DIVIDERS,MALFORMED_FREEMAIL,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

first of all: thank you for doing this! I had planned on investing some
time to figure out a "cheap" way to determine opcode lengths and skip
uninteresting ones, and it would invariably have been a lot hackier than
the solution you came up with, and I would probably have taken six months
to find the time to do so.

On Fri, 21 Mar 2025, Jeremy Drake via Cygwin-patches wrote:

> The second patch of this series might be a little difficult to deal
> with, but I included a diff of the changes from the upstream
> udis86-1.7.2 tarball (retrieved from
> https://downloads.sourceforge.net/udis86/udis86-1.7.2.tar.gz),
> and I'm copying it again here.

As Corinna requested, I would also suggest to split the patch into two,
one which copies udis86 verbatim, and a follow-up to make it compile in
Cygwin.

I use a similar strategy to vendor in `mimalloc` in Git for Windows, which
makes re-importing newer versions less painful.

And while I agree with you that
https://sourceforge.net/projects/udis86/files/ is unlikely to see any
updates, the original author added 84 commits in
https://github.com/vmt/udis86/compare/a4913cb77e2e...master since v1.7.2,
so there _might_ be changes in the future that might make a re-import
desirable.

As to this patch series: I am very much in favor of integrating it, even
if it does seem a bit like overkill to include a disassembler in Cygwin
(but who knows, maybe it would come in handy at some stage in case someone
really desires assembly to accompany any stackdumps?).

=46rom my reading, the `find_fast_cwd_pointer()` logic will be eminently
easier to understand, and will be less prone to problems with new Windows
Insider versions, which I find really enticing.

If I would change a thing, it would only be to extend the loop condition
to include `&& ud_insn_mnemonic (&ud_obj) !=3D UD_Iret`, so as to avoid
running outside the function.

I am also very excited that this adds ARM64 support!

Ciao,
Johannes

>
> diff -ur udis86-1.7.2/libudis86/decode.c udis86/decode.c
> --- udis86-1.7.2/libudis86/decode.c
> +++ udis86/decode.c
> @@ -23,8 +23,9 @@
>   * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE US=
E OF THIS
>   * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   */
> -#include "udint.h"
> +#include "winsup.h"
>  #include "types.h"
> +#include "udint.h"
>  #include "decode.h"
>
>  #ifndef __UD_STANDALONE__
> @@ -204,7 +205,7 @@
>  decode_prefixes(struct ud *u)
>  {
>    int done =3D 0;
> -  uint8_t curr, last =3D 0;
> +  uint8_t curr =3D 0, last =3D 0;
>    UD_RETURN_ON_ERROR(u);
>
>    do {
> @@ -653,12 +654,12 @@
>        break;
>      case OP_F:
>        u->br_far  =3D 1;
> -      /* intended fall through */
> +      fallthrough;
>      case OP_M:
>        if (MODRM_MOD(modrm(u)) =3D=3D 3) {
>          UDERR(u, "expected modrm.mod !=3D 3\n");
>        }
> -      /* intended fall through */
> +      fallthrough;
>      case OP_E:
>        decode_modrm_rm(u, operand, REGCLASS_GPR, size);
>        break;
> @@ -677,7 +678,7 @@
>        if (MODRM_MOD(modrm(u)) !=3D 3) {
>          UDERR(u, "expected modrm.mod =3D=3D 3\n");
>        }
> -      /* intended fall through */
> +      fallthrough;
>      case OP_Q:
>        decode_modrm_rm(u, operand, REGCLASS_MMX, size);
>        break;
> @@ -688,7 +689,7 @@
>        if (MODRM_MOD(modrm(u)) !=3D 3) {
>          UDERR(u, "expected modrm.mod =3D=3D 3\n");
>        }
> -      /* intended fall through */
> +      fallthrough;
>      case OP_W:
>        decode_modrm_rm(u, operand, REGCLASS_XMM, size);
>        break;
> diff -ur udis86-1.7.2/libudis86/decode.h udis86/decode.h
> --- udis86-1.7.2/libudis86/decode.h
> +++ udis86/decode.h
> @@ -183,8 +183,8 @@
>    return (primary_opcode & 0x02) !=3D 0;
>  }
>
> -extern struct ud_itab_entry ud_itab[];
> -extern struct ud_lookup_table_list_entry ud_lookup_table_list[];
> +extern const struct ud_itab_entry ud_itab[];
> +extern const struct ud_lookup_table_list_entry ud_lookup_table_list[];
>
>  #endif /* UD_DECODE_H */
>
> diff -ur udis86-1.7.2/libudis86/extern.h udis86/extern.h
> --- udis86-1.7.2/libudis86/extern.h
> +++ udis86/extern.h
> @@ -60,9 +60,11 @@
>
>  extern unsigned int ud_disassemble(struct ud*);
>
> +#ifndef __INSIDE_CYGWIN__
>  extern void ud_translate_intel(struct ud*);
>
>  extern void ud_translate_att(struct ud*);
> +#endif /* __INSIDE_CYGWIN__ */
>
>  extern const char* ud_insn_asm(const struct ud* u);
>
> @@ -82,7 +84,9 @@
>
>  extern enum ud_mnemonic_code ud_insn_mnemonic(const struct ud *u);
>
> +#ifndef __INSIDE_CYGWIN__
>  extern const char* ud_lookup_mnemonic(enum ud_mnemonic_code c);
> +#endif /* __INSIDE_CYGWIN__ */
>
>  extern void ud_set_user_opaque_data(struct ud*, void*);
>
> diff -ur udis86-1.7.2/libudis86/itab.c udis86/itab.c
> --- udis86-1.7.2/libudis86/itab.c
> +++ udis86/itab.c
> @@ -1,4 +1,5 @@
>  /* itab.c -- generated by udis86:scripts/ud_itab.py, do no edit */
> +#include "winsup.h"
>  #include "decode.h"
>
>  #define GROUP(n) (0x8000 | (n))
> @@ -5028,7 +5029,7 @@
>  };
>
>
> -struct ud_lookup_table_list_entry ud_lookup_table_list[] =3D {
> +const struct ud_lookup_table_list_entry ud_lookup_table_list[] =3D {
>      /* 000 */ { ud_itab__0, UD_TAB__OPC_TABLE, "table0" },
>      /* 001 */ { ud_itab__1, UD_TAB__OPC_MODE, "/m" },
>      /* 002 */ { ud_itab__2, UD_TAB__OPC_MODE, "/m" },
> @@ -6294,7 +6295,7 @@
>  #define O_sIv     { OP_sI,       SZ_V     }
>  #define O_sIz     { OP_sI,       SZ_Z     }
>
> -struct ud_itab_entry ud_itab[] =3D {
> +const struct ud_itab_entry ud_itab[] =3D {
>    /* 0000 */ { UD_Iinvalid, O_NONE, O_NONE, O_NONE, P_none },
>    /* 0001 */ { UD_Iadd, O_Eb, O_Gb, O_NONE, P_aso|P_rexr|P_rexx|P_rexb =
},
>    /* 0002 */ { UD_Iadd, O_Ev, O_Gv, O_NONE, P_aso|P_oso|P_rexw|P_rexr|P=
_rexx|P_rexb },
> @@ -7749,6 +7750,7 @@
>  };
>
>
> +#ifndef __INSIDE_CYGWIN__
>  const char * ud_mnemonics_str[] =3D {
>  "invalid",
>      "3dnow",
> @@ -8399,3 +8401,4 @@
>      "movbe",
>      "crc32"
>  };
> +#endif /* __INSIDE_CYGWIN__ */
> diff -ur udis86-1.7.2/libudis86/itab.h udis86/itab.h
> --- udis86-1.7.2/libudis86/itab.h
> +++ udis86/itab.h
> @@ -673,6 +673,8 @@
>      UD_MAX_MNEMONIC_CODE
>  } UD_ATTR_PACKED;
>
> +#ifndef __INSIDE_CYGWIN__
>  extern const char * ud_mnemonics_str[];
> +#endif /* __INSIDE_CYGWIN__ */
>
>  #endif /* UD_ITAB_H */
> Only in udis86-1.7.2/libudis86/: Makefile.am
> Only in udis86-1.7.2/libudis86/: Makefile.in
> Only in udis86-1.7.2/libudis86/: syn.c
> Only in udis86-1.7.2/libudis86/: syn.h
> Only in udis86-1.7.2/libudis86/: syn-att.c
> Only in udis86-1.7.2/libudis86/: syn-intel.c
> diff -ur udis86-1.7.2/libudis86/types.h udis86/types.h
> --- udis86-1.7.2/libudis86/types.h
> +++ udis86/types.h
> @@ -36,6 +36,14 @@
>  #endif
>  #endif /* __KERNEL__ */
>
> +#ifdef __INSIDE_CYGWIN__
> +# include <inttypes.h>
> +# ifndef __UD_STANDALONE__
> +#  define __UD_STANDALONE__ 1
> +# endif
> +#endif /* __INSIDE_CYGWIN__ */
> +
> +
>  #if defined(_MSC_VER) || defined(__BORLANDC__)
>  # include <stdint.h>
>  # include <stdio.h>
> @@ -221,8 +229,8 @@
>    uint8_t   modrm;
>    uint8_t   primary_opcode;
>    void *    user_opaque_data;
> -  struct ud_itab_entry * itab_entry;
> -  struct ud_lookup_table_list_entry *le;
> +  const struct ud_itab_entry * itab_entry;
> +  const struct ud_lookup_table_list_entry *le;
>  };
>
>  /* --------------------------------------------------------------------=
---------
> @@ -235,8 +243,10 @@
>  typedef struct ud             ud_t;
>  typedef struct ud_operand     ud_operand_t;
>
> +#ifndef __INSIDE_CYGWIN__
>  #define UD_SYN_INTEL          ud_translate_intel
>  #define UD_SYN_ATT            ud_translate_att
> +#endif /* __INSIDE_CYGWIN__ */
>  #define UD_EOI                (-1)
>  #define UD_INP_CACHE_SZ       32
>  #define UD_VENDOR_AMD         0
> diff -ur udis86-1.7.2/libudis86/udint.h udis86/udint.h
> --- udis86-1.7.2/libudis86/udint.h
> +++ udis86/udint.h
> @@ -26,9 +26,11 @@
>  #ifndef _UDINT_H_
>  #define _UDINT_H_
>
> -#ifdef HAVE_CONFIG_H
> -# include <config.h>
> -#endif /* HAVE_CONFIG_H */
> +#ifndef __INSIDE_CYGWIN__
> +# ifdef HAVE_CONFIG_H
> +#  include <config.h>
> +# endif /* HAVE_CONFIG_H */
> +#endif /* __INSIDE_CYGWIN__ */
>
>  #if defined(UD_DEBUG) && HAVE_ASSERT_H
>  # include <assert.h>
> diff -ur udis86-1.7.2/libudis86/udis86.c udis86/udis86.c
> --- udis86-1.7.2/libudis86/udis86.c
> +++ udis86/udis86.c
> @@ -24,8 +24,9 @@
>   * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   */
>
> -#include "udint.h"
> +#include "winsup.h"
>  #include "extern.h"
> +#include "udint.h"
>  #include "decode.h"
>
>  #if !defined(__UD_STANDALONE__)
> @@ -34,6 +35,10 @@
>  # endif
>  #endif /* !__UD_STANDALONE__ */
>
> +#ifdef __INSIDE_CYGWIN__
> +#define sprintf __small_sprintf
> +#endif /* __INSIDE_CYGWIN__ */
> +
>  static void ud_inp_init(struct ud *u);
>
>  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> @@ -324,6 +329,7 @@
>  }
>
>
> +#ifndef __INSIDE_CYGWIN__
>  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>   * ud_lookup_mnemonic
>   *    Looks up mnemonic code in the mnemonic string table.
> @@ -339,6 +345,7 @@
>      return NULL;
>    }
>  }
> +#endif /* __INSIDE_CYGWIN__ */
>
>
>  /*
>
> Jeremy Drake (4):
>   Cygwin: factor out find_fast_cwd_pointer to arch-specific file.
>   Cygwin: vendor libudis86 1.7.2
>   Cygwin: use udis86 to find fast cwd pointer on x64
>   Cygwin: add find_fast_cwd_pointer_aarch64.
>
>  winsup/cygwin/Makefile.am                     |   14 +-
>  winsup/cygwin/fastcwd_aarch64.cc              |  185 +
>  winsup/cygwin/path.cc                         |  145 +-
>  winsup/cygwin/udis86/decode.c                 | 1113 +++
>  winsup/cygwin/udis86/decode.h                 |  195 +
>  winsup/cygwin/udis86/extern.h                 |  109 +
>  winsup/cygwin/udis86/itab.c                   | 8404 +++++++++++++++++
>  winsup/cygwin/udis86/itab.h                   |  680 ++
>  winsup/cygwin/udis86/types.h                  |  260 +
>  winsup/cygwin/udis86/udint.h                  |   91 +
>  .../cygwin/udis86/udis86-modifications.diff   |  252 +
>  winsup/cygwin/udis86/udis86.c                 |  464 +
>  winsup/cygwin/x86_64/fastcwd_x86_64.cc        |  159 +
>  13 files changed, 11948 insertions(+), 123 deletions(-)
>  create mode 100644 winsup/cygwin/fastcwd_aarch64.cc
>  create mode 100644 winsup/cygwin/udis86/decode.c
>  create mode 100644 winsup/cygwin/udis86/decode.h
>  create mode 100644 winsup/cygwin/udis86/extern.h
>  create mode 100644 winsup/cygwin/udis86/itab.c
>  create mode 100644 winsup/cygwin/udis86/itab.h
>  create mode 100644 winsup/cygwin/udis86/types.h
>  create mode 100644 winsup/cygwin/udis86/udint.h
>  create mode 100644 winsup/cygwin/udis86/udis86-modifications.diff
>  create mode 100644 winsup/cygwin/udis86/udis86.c
>  create mode 100644 winsup/cygwin/x86_64/fastcwd_x86_64.cc
>
> --
> 2.48.1.windows.1
>
>
