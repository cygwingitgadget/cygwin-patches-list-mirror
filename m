Return-Path: <cygwin-patches-return-2028-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14000 invoked by alias); 9 Apr 2002 01:58:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13954 invoked from network); 9 Apr 2002 01:58:32 -0000
Message-ID: <001601c1df6a$0d08ea20$0610a8c0@wyw>
From: "Wu Yongwei" <adah@netstd.com>
To: <cygwin@cygwin.com>,
	<cygwin-patches@cygwin.com>
Subject: Re: ip.h & tcp.h
Date: Mon, 08 Apr 2002 18:58:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000F_01C1DFAC.D719DD50"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
X-SW-Source: 2002-q2/txt/msg00012.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_000F_01C1DFAC.D719DD50
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1202

ChangeLog: BSD-style header files ip.h, tcp.h, and udp.h are added, which
include definitions for IP, TCP, and UDP packet header structures.


Positions:
* ip.h.diff is against /usr/include/netinet/ip.h
* tcp.h.diff is against /usr/include/netinet/tcp.h
* udp.h should be added to /usr/include/netinet
* ip.h in /usr/include/cygwin contains only a comment and I suppose it could
be dropped.


BSD licence:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. All advertising materials mentioning features or use of this software
   must display the following acknowledgement:
     This product includes software developed by the University of
     California, Berkeley and its contributors.
4. Neither the name of the University nor the names of its contributors
   may be used to endorse or promote products derived from this software
   without specific prior written permission.

Best regards,

Wu Yongwei

------=_NextPart_000_000F_01C1DFAC.D719DD50
Content-Type: application/octet-stream;
	name="ip.h.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ip.h.diff"
Content-length: 9295

--- ip.h.old	Tue Apr  9 09:34:37 2002=0A=
+++ ip.h	Wed Dec 19 13:57:00 2001=0A=
@@ -1,16 +1,197 @@=0A=
-/* netinet/ip.h=0A=
-=0A=
-   Copyright 1998, 2001 Red Hat, Inc.=0A=
-=0A=
-This file is part of Cygwin.=0A=
-=0A=
-This software is a copyrighted work licensed under the terms of the=0A=
-Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
-details. */=0A=
+/*=0A=
+ * Copyright (c) 1982, 1986, 1993=0A=
+ *      The Regents of the University of California.  All rights reserved.=
=0A=
+ *=0A=
+ * Redistribution and use in source and binary forms, with or without=0A=
+ * modification, are permitted provided that the following conditions=0A=
+ * are met:=0A=
+ * 1. Redistributions of source code must retain the above copyright=0A=
+ *    notice, this list of conditions and the following disclaimer.=0A=
+ * 2. Redistributions in binary form must reproduce the above copyright=0A=
+ *    notice, this list of conditions and the following disclaimer in the=
=0A=
+ *    documentation and/or other materials provided with the distribution.=
=0A=
+ * 3. All advertising materials mentioning features or use of this softwar=
e=0A=
+ *    must display the following acknowledgement:=0A=
+ *      This product includes software developed by the University of=0A=
+ *      California, Berkeley and its contributors.=0A=
+ * 4. Neither the name of the University nor the names of its contributors=
=0A=
+ *    may be used to endorse or promote products derived from this softwar=
e=0A=
+ *    without specific prior written permission.=0A=
+ *=0A=
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND=
=0A=
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE=
=0A=
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURP=
OSE=0A=
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABL=
E=0A=
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENT=
IAL=0A=
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS=
=0A=
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)=
=0A=
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STR=
ICT=0A=
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY W=
AY=0A=
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF=
=0A=
+ * SUCH DAMAGE.=0A=
+ *=0A=
+ *      @(#)ip.h        8.2 (Berkeley) 6/1/94=0A=
+ * $FreeBSD: src/sys/netinet/ip.h,v 1.17 1999/12/22 19:13:20 shin Exp $=0A=
+ */=0A=
=20=0A=
 #ifndef _NETINET_IP_H=0A=
 #define _NETINET_IP_H=0A=
=20=0A=
-#include <cygwin/ip.h>=0A=
+/* Added by Wu Yongwei */=0A=
+#ifndef LITTLE_ENDIAN=0A=
+#define LITTLE_ENDIAN   1234=0A=
+#define BIG_ENDIAN      4321=0A=
+#endif=0A=
+#ifndef BYTE_ORDER=0A=
+#define BYTE_ORDER      LITTLE_ENDIAN=0A=
+#endif=0A=
+=0A=
+/*=0A=
+ * Definitions for internet protocol version 4.=0A=
+ * Per RFC 791, September 1981.=0A=
+ */=0A=
+#define IPVERSION       4=0A=
+=0A=
+/*=0A=
+ * Structure of an internet header, naked of options.=0A=
+ */=0A=
+struct ip {=0A=
+#ifdef _IP_VHL=0A=
+        u_char  ip_vhl;                 /* version << 4 | header length >>=
 2 */=0A=
+#else=0A=
+#if BYTE_ORDER =3D=3D LITTLE_ENDIAN=0A=
+        u_int   ip_hl:4,                /* header length */=0A=
+                ip_v:4;                 /* version */=0A=
+#endif=0A=
+#if BYTE_ORDER =3D=3D BIG_ENDIAN=0A=
+        u_int   ip_v:4,                 /* version */=0A=
+                ip_hl:4;                /* header length */=0A=
+#endif=0A=
+#endif /* not _IP_VHL */=0A=
+        u_char  ip_tos;                 /* type of service */=0A=
+        u_short ip_len;                 /* total length */=0A=
+        u_short ip_id;                  /* identification */=0A=
+        u_short ip_off;                 /* fragment offset field */=0A=
+#define IP_RF 0x8000                    /* reserved fragment flag */=0A=
+#define IP_DF 0x4000                    /* dont fragment flag */=0A=
+#define IP_MF 0x2000                    /* more fragments flag */=0A=
+#define IP_OFFMASK 0x1fff               /* mask for fragmenting bits */=0A=
+        u_char  ip_ttl;                 /* time to live */=0A=
+        u_char  ip_p;                   /* protocol */=0A=
+        u_short ip_sum;                 /* checksum */=0A=
+        struct  in_addr ip_src,ip_dst;  /* source and dest address */=0A=
+};=0A=
+=0A=
+#ifdef _IP_VHL=0A=
+#define IP_MAKE_VHL(v, hl)      ((v) << 4 | (hl))=0A=
+#define IP_VHL_HL(vhl)          ((vhl) & 0x0f)=0A=
+#define IP_VHL_V(vhl)           ((vhl) >> 4)=0A=
+#define IP_VHL_BORING           0x45=0A=
+#endif=0A=
+=0A=
+#define IP_MAXPACKET    65535           /* maximum packet size */=0A=
+=0A=
+/*=0A=
+ * Definitions for IP type of service (ip_tos)=0A=
+ */=0A=
+#define IPTOS_LOWDELAY          0x10=0A=
+#define IPTOS_THROUGHPUT        0x08=0A=
+#define IPTOS_RELIABILITY       0x04=0A=
+#define IPTOS_MINCOST           0x02=0A=
+/* ECN bits proposed by Sally Floyd */=0A=
+#define IPTOS_CE                0x01    /* congestion experienced */=0A=
+#define IPTOS_ECT               0x02    /* ECN-capable transport */=0A=
+=0A=
+=0A=
+/*=0A=
+ * Definitions for IP precedence (also in ip_tos) (hopefully unused)=0A=
+ */=0A=
+#define IPTOS_PREC_NETCONTROL           0xe0=0A=
+#define IPTOS_PREC_INTERNETCONTROL      0xc0=0A=
+#define IPTOS_PREC_CRITIC_ECP           0xa0=0A=
+#define IPTOS_PREC_FLASHOVERRIDE        0x80=0A=
+#define IPTOS_PREC_FLASH                0x60=0A=
+#define IPTOS_PREC_IMMEDIATE            0x40=0A=
+#define IPTOS_PREC_PRIORITY             0x20=0A=
+#define IPTOS_PREC_ROUTINE              0x00=0A=
+=0A=
+/*=0A=
+ * Definitions for options.=0A=
+ */=0A=
+#define IPOPT_COPIED(o)         ((o)&0x80)=0A=
+#define IPOPT_CLASS(o)          ((o)&0x60)=0A=
+#define IPOPT_NUMBER(o)         ((o)&0x1f)=0A=
+=0A=
+#define IPOPT_CONTROL           0x00=0A=
+#define IPOPT_RESERVED1         0x20=0A=
+#define IPOPT_DEBMEAS           0x40=0A=
+#define IPOPT_RESERVED2         0x60=0A=
+=0A=
+#define IPOPT_EOL               0               /* end of option list */=
=0A=
+#define IPOPT_NOP               1               /* no operation */=0A=
+=0A=
+#define IPOPT_RR                7               /* record packet route */=
=0A=
+#define IPOPT_TS                68              /* timestamp */=0A=
+#define IPOPT_SECURITY          130             /* provide s,c,h,tcc */=0A=
+#define IPOPT_LSRR              131             /* loose source route */=
=0A=
+#define IPOPT_SATID             136             /* satnet id */=0A=
+#define IPOPT_SSRR              137             /* strict source route */=
=0A=
+#define IPOPT_RA                148             /* router alert */=0A=
+=0A=
+/*=0A=
+ * Offsets to fields in options other than EOL and NOP.=0A=
+ */=0A=
+#define IPOPT_OPTVAL            0               /* option ID */=0A=
+#define IPOPT_OLEN              1               /* option length */=0A=
+#define IPOPT_OFFSET            2               /* offset within option */=
=0A=
+#define IPOPT_MINOFF            4               /* min value of above */=
=0A=
+=0A=
+/*=0A=
+ * Time stamp option structure.=0A=
+ */=0A=
+struct  ip_timestamp {=0A=
+        u_char  ipt_code;               /* IPOPT_TS */=0A=
+        u_char  ipt_len;                /* size of structure (variable) */=
=0A=
+        u_char  ipt_ptr;                /* index of current entry */=0A=
+#if BYTE_ORDER =3D=3D LITTLE_ENDIAN=0A=
+        u_int   ipt_flg:4,              /* flags, see below */=0A=
+                ipt_oflw:4;             /* overflow counter */=0A=
+#endif=0A=
+#if BYTE_ORDER =3D=3D BIG_ENDIAN=0A=
+        u_int   ipt_oflw:4,             /* overflow counter */=0A=
+                ipt_flg:4;              /* flags, see below */=0A=
+#endif=0A=
+        union ipt_timestamp {=0A=
+                n_long  ipt_time[1];=0A=
+                struct  ipt_ta {=0A=
+                        struct in_addr ipt_addr;=0A=
+                        n_long ipt_time;=0A=
+                } ipt_ta[1];=0A=
+        } ipt_timestamp;=0A=
+};=0A=
+=0A=
+/* flag bits for ipt_flg */=0A=
+#define IPOPT_TS_TSONLY         0               /* timestamps only */=0A=
+#define IPOPT_TS_TSANDADDR      1               /* timestamps and addresse=
s */=0A=
+#define IPOPT_TS_PRESPEC        3               /* specified modules only =
*/=0A=
+=0A=
+/* bits for security (not byte swapped) */=0A=
+#define IPOPT_SECUR_UNCLASS     0x0000=0A=
+#define IPOPT_SECUR_CONFID      0xf135=0A=
+#define IPOPT_SECUR_EFTO        0x789a=0A=
+#define IPOPT_SECUR_MMMM        0xbc4d=0A=
+#define IPOPT_SECUR_RESTR       0xaf13=0A=
+#define IPOPT_SECUR_SECRET      0xd788=0A=
+#define IPOPT_SECUR_TOPSECRET   0x6bc5=0A=
+=0A=
+/*=0A=
+ * Internet implementation parameters.=0A=
+ */=0A=
+#define MAXTTL          255             /* maximum time to live (seconds) =
*/=0A=
+#define IPDEFTTL        64              /* default ttl, from RFC 1340 */=
=0A=
+#define IPFRAGTTL       60              /* time to live for frags, slowhz =
*/=0A=
+#define IPTTLDEC        1               /* subtracted when forwarding */=
=0A=
+=0A=
+#define IP_MSS          576             /* default maximum segment size */=
=0A=
=20=0A=
-#endif /* _NETINET_IP_H */=0A=
+#endif=0A=

------=_NextPart_000_000F_01C1DFAC.D719DD50
Content-Type: application/octet-stream;
	name="tcp.h.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="tcp.h.diff"
Content-length: 6894

--- tcp.h.old	Tue Apr  9 09:39:30 2002=0A=
+++ tcp.h	Wed Dec 19 13:55:59 2001=0A=
@@ -1,16 +1,142 @@=0A=
-/* netinet/tcp.h=0A=
+/*=0A=
+ * Copyright (c) 1982, 1986, 1993=0A=
+ *      The Regents of the University of California.  All rights reserved.=
=0A=
+ *=0A=
+ * Redistribution and use in source and binary forms, with or without=0A=
+ * modification, are permitted provided that the following conditions=0A=
+ * are met:=0A=
+ * 1. Redistributions of source code must retain the above copyright=0A=
+ *    notice, this list of conditions and the following disclaimer.=0A=
+ * 2. Redistributions in binary form must reproduce the above copyright=0A=
+ *    notice, this list of conditions and the following disclaimer in the=
=0A=
+ *    documentation and/or other materials provided with the distribution.=
=0A=
+ * 3. All advertising materials mentioning features or use of this softwar=
e=0A=
+ *    must display the following acknowledgement:=0A=
+ *      This product includes software developed by the University of=0A=
+ *      California, Berkeley and its contributors.=0A=
+ * 4. Neither the name of the University nor the names of its contributors=
=0A=
+ *    may be used to endorse or promote products derived from this softwar=
e=0A=
+ *    without specific prior written permission.=0A=
+ *=0A=
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND=
=0A=
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE=
=0A=
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURP=
OSE=0A=
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABL=
E=0A=
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENT=
IAL=0A=
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS=
=0A=
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)=
=0A=
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STR=
ICT=0A=
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY W=
AY=0A=
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF=
=0A=
+ * SUCH DAMAGE.=0A=
+ *=0A=
+ *      @(#)tcp.h       8.1 (Berkeley) 6/10/93=0A=
+ * $FreeBSD: src/sys/netinet/tcp.h,v 1.13 2000/01/09 19:17:25 shin Exp $=
=0A=
+ */=0A=
=20=0A=
-   Copyright 2000, 2001 Red Hat, Inc.=0A=
+#ifndef _NETINET_TCP_H=0A=
+#define _NETINET_TCP_H=0A=
=20=0A=
-This file is part of Cygwin.=0A=
+/* Added by Wu Yongwei */=0A=
+#ifndef LITTLE_ENDIAN=0A=
+#define LITTLE_ENDIAN   1234=0A=
+#define BIG_ENDIAN      4321=0A=
+#endif=0A=
+#ifndef BYTE_ORDER=0A=
+#define BYTE_ORDER     LITTLE_ENDIAN=0A=
+#endif=0A=
=20=0A=
-This software is a copyrighted work licensed under the terms of the=0A=
-Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
-details. */=0A=
+typedef u_int32_t tcp_seq;=0A=
+typedef u_int32_t tcp_cc;               /* connection count per rfc1644 */=
=0A=
=20=0A=
-#ifndef _NETINET_TCP_H=0A=
-#define _NETINET_TCP_H=0A=
+#define tcp6_seq        tcp_seq /* for KAME src sync over BSD*'s */=0A=
+#define tcp6hdr         tcphdr  /* for KAME src sync over BSD*'s */=0A=
+=0A=
+/*=0A=
+ * TCP header.=0A=
+ * Per RFC 793, September, 1981.=0A=
+ */=0A=
+struct tcphdr {=0A=
+        u_short th_sport;               /* source port */=0A=
+        u_short th_dport;               /* destination port */=0A=
+        tcp_seq th_seq;                 /* sequence number */=0A=
+        tcp_seq th_ack;                 /* acknowledgement number */=0A=
+#if BYTE_ORDER =3D=3D LITTLE_ENDIAN=0A=
+        u_int   th_x2:4,                /* (unused) */=0A=
+                th_off:4;               /* data offset */=0A=
+#endif=0A=
+#if BYTE_ORDER =3D=3D BIG_ENDIAN=0A=
+        u_int   th_off:4,               /* data offset */=0A=
+                th_x2:4;                /* (unused) */=0A=
+#endif=0A=
+        u_char  th_flags;=0A=
+#define TH_FIN  0x01=0A=
+#define TH_SYN  0x02=0A=
+#define TH_RST  0x04=0A=
+#define TH_PUSH 0x08=0A=
+#define TH_ACK  0x10=0A=
+#define TH_URG  0x20=0A=
+#define TH_FLAGS (TH_FIN|TH_SYN|TH_RST|TH_ACK|TH_URG)=0A=
+=0A=
+        u_short th_win;                 /* window */=0A=
+        u_short th_sum;                 /* checksum */=0A=
+        u_short th_urp;                 /* urgent pointer */=0A=
+};=0A=
+=0A=
+#define TCPOPT_EOL              0=0A=
+#define TCPOPT_NOP              1=0A=
+#define TCPOPT_MAXSEG           2=0A=
+#define TCPOLEN_MAXSEG          4=0A=
+#define TCPOPT_WINDOW           3=0A=
+#define TCPOLEN_WINDOW          3=0A=
+#define TCPOPT_SACK_PERMITTED   4               /* Experimental */=0A=
+#define TCPOLEN_SACK_PERMITTED  2=0A=
+#define TCPOPT_SACK             5               /* Experimental */=0A=
+#define TCPOPT_TIMESTAMP        8=0A=
+#define TCPOLEN_TIMESTAMP       10=0A=
+#define TCPOLEN_TSTAMP_APPA     (TCPOLEN_TIMESTAMP+2) /* appendix A */=0A=
+#define TCPOPT_TSTAMP_HDR               \=0A=
+    (TCPOPT_NOP<<24|TCPOPT_NOP<<16|TCPOPT_TIMESTAMP<<8|TCPOLEN_TIMESTAMP)=
=0A=
+=0A=
+#define TCPOPT_CC               11              /* CC options: RFC-1644 */=
=0A=
+#define TCPOPT_CCNEW            12=0A=
+#define TCPOPT_CCECHO           13=0A=
+#define TCPOLEN_CC              6=0A=
+#define TCPOLEN_CC_APPA         (TCPOLEN_CC+2)=0A=
+#define TCPOPT_CC_HDR(ccopt)            \=0A=
+    (TCPOPT_NOP<<24|TCPOPT_NOP<<16|(ccopt)<<8|TCPOLEN_CC)=0A=
+=0A=
+/*=0A=
+ * Default maximum segment size for TCP.=0A=
+ * With an IP MSS of 576, this is 536,=0A=
+ * but 512 is probably more convenient.=0A=
+ * This should be defined as MIN(512, IP_MSS - sizeof (struct tcpiphdr)).=
=0A=
+ */=0A=
+#define TCP_MSS 512=0A=
+=0A=
+/*=0A=
+ * Default maximum segment size for TCP6.=0A=
+ * With an IP6 MSS of 1280, this is 1220,=0A=
+ * but 1024 is probably more convenient. (xxx kazu in doubt)=0A=
+ * This should be defined as MIN(1024, IP6_MSS - sizeof (struct tcpip6hdr)=
)=0A=
+ */=0A=
+#define TCP6_MSS        1024=0A=
+=0A=
+#define TCP_MAXWIN      65535   /* largest value for (unscaled) window */=
=0A=
+#define TTCP_CLIENT_SND_WND     4096    /* dflt send window for T/TCP clie=
nt */=0A=
+=0A=
+#define TCP_MAX_WINSHIFT        14      /* maximum window shift */=0A=
+=0A=
+#define TCP_MAXHLEN     (0xf<<2)        /* max length of header in bytes *=
/=0A=
+#define TCP_MAXOLEN     (TCP_MAXHLEN - sizeof(struct tcphdr))=0A=
+                                        /* max space left for options */=
=0A=
=20=0A=
-/* Maybe add some definitions, someday */=0A=
+/*=0A=
+ * User-settable options (used with setsockopt).=0A=
+ */=0A=
+#define TCP_NODELAY     0x01    /* don't delay send to coalesce packets */=
=0A=
+#define TCP_MAXSEG      0x02    /* set maximum segment size */=0A=
+#define TCP_NOPUSH      0x04    /* don't push last block of write */=0A=
+#define TCP_NOOPT       0x08    /* don't use TCP options */=0A=
=20=0A=
 #endif=0A=

------=_NextPart_000_000F_01C1DFAC.D719DD50
Content-Type: application/octet-stream;
	name="udp.h"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="udp.h"
Content-length: 2473

/*=0A=
 * Copyright (c) 1982, 1986, 1993=0A=
 *	The Regents of the University of California.  All rights reserved.=0A=
 *=0A=
 * Redistribution and use in source and binary forms, with or without=0A=
 * modification, are permitted provided that the following conditions=0A=
 * are met:=0A=
 * 1. Redistributions of source code must retain the above copyright=0A=
 *    notice, this list of conditions and the following disclaimer.=0A=
 * 2. Redistributions in binary form must reproduce the above copyright=0A=
 *    notice, this list of conditions and the following disclaimer in the=
=0A=
 *    documentation and/or other materials provided with the distribution.=
=0A=
 * 3. All advertising materials mentioning features or use of this software=
=0A=
 *    must display the following acknowledgement:=0A=
 *	This product includes software developed by the University of=0A=
 *	California, Berkeley and its contributors.=0A=
 * 4. Neither the name of the University nor the names of its contributors=
=0A=
 *    may be used to endorse or promote products derived from this software=
=0A=
 *    without specific prior written permission.=0A=
 *=0A=
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND=
=0A=
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE=0A=
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPO=
SE=0A=
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE=
=0A=
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTI=
AL=0A=
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS=
=0A=
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)=0A=
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRI=
CT=0A=
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WA=
Y=0A=
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF=
=0A=
 * SUCH DAMAGE.=0A=
 *=0A=
 *	@(#)udp.h	8.1 (Berkeley) 6/10/93=0A=
 * $FreeBSD: src/sys/netinet/udp.h,v 1.7 1999/08/28 00:49:34 peter Exp $=0A=
 */=0A=
=0A=
#ifndef _NETINET_UDP_H=0A=
#define _NETINET_UDP_H=0A=
=0A=
/*=0A=
 * Udp protocol header.=0A=
 * Per RFC 768, September, 1981.=0A=
 */=0A=
struct udphdr {=0A=
	u_short	uh_sport;		/* source port */=0A=
	u_short	uh_dport;		/* destination port */=0A=
	u_short	uh_ulen;		/* udp length */=0A=
	u_short	uh_sum;			/* udp checksum */=0A=
};=0A=
=0A=
#endif=0A=

------=_NextPart_000_000F_01C1DFAC.D719DD50--
