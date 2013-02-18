Return-Path: <cygwin-patches-return-7811-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23448 invoked by alias); 18 Feb 2013 16:51:37 -0000
Received: (qmail 23409 invoked by uid 22791); 18 Feb 2013 16:51:33 -0000
X-SWARE-Spam-Status: No, hits=1.1 required=5.0	tests=BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,KHOP_SPAMHAUS_DROP,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,RP_MATCHES_RCVD,SARE_SUB_OBFU_Q1
X-Spam-Check-By: sourceware.org
Received: from nm6-vm0.bullet.mail.bf1.yahoo.com (HELO nm6-vm0.bullet.mail.bf1.yahoo.com) (98.139.213.146)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 18 Feb 2013 16:51:24 +0000
Received: from [98.139.212.151] by nm6.bullet.mail.bf1.yahoo.com with NNFMP; 18 Feb 2013 16:51:23 -0000
Received: from [98.139.212.226] by tm8.bullet.mail.bf1.yahoo.com with NNFMP; 18 Feb 2013 16:51:23 -0000
Received: from [127.0.0.1] by omp1035.mail.bf1.yahoo.com with NNFMP; 18 Feb 2013 16:51:23 -0000
Received: (qmail 75633 invoked by uid 60001); 18 Feb 2013 16:51:23 -0000
Received: from [50.143.179.35] by web141004.mail.bf1.yahoo.com via HTTP; Mon, 18 Feb 2013 08:51:22 PST
Message-ID: <1361206282.74694.YahooMailNeo@web141004.mail.bf1.yahoo.com>
Date: Mon, 18 Feb 2013 16:51:00 -0000
From: Dennis de Champeaux <atlantisician@yahoo.com>
Reply-To: Dennis de Champeaux <ddcc@ontooo.com>
Subject: Qsort defects (in C-library)
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00022.txt.bz2



// I hope this is the proper mailing list

Qsort defects

Qsort was described in a 1993 paper by Bentley & McIlroy.

Let me start with the good news.
Someone replaced a 2nd recursive call at the bottom by tail recursion.

Here the bad news.
Someone modified the code with an "improvement", which has seriously
damaged the performance.
The idea of the "improvement" was to keep track of whether during
partitioning a swap had occurred.=A0 If not it was deemed good to call
up insertion sort with:

=A0=A0=A0=A0=A0=A0 if (swap_cnt =3D=3D 0) {=A0 /* Switch to insertion sort =
*/
=A0=A0=A0=A0=A0=A0=A0 for (pm =3D (char *) a + es; pm < (char *) a + n * es=
; pm +=3D es)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (pl =3D pm; pl > (char *) a && cmp(pl=
 - es, pl) > 0;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pl -=3D es)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 swap(pl, pl - es);
=A0=A0=A0=A0=A0=A0=A0 return;
=A0=A0=A0 }=20

This causes qsort to descend in quadratic explosions on around 3% of
the 630 problems of the Bentley-test bench (described in the paper).

The fix: remove this code fragment and remove the stuff involving
swap_cnt.

There is actually still another problem hiding in the code, which is
also part of the 1993 description.=A0 There is no test on the ordering
of the recursive calls (or on how to recurse/ iterate).

The proper way (to limit stack space with log2(N)) is to tackle the
shortest segment first.=A0 In pseudo code:
=A0=A0=A0=A0=A0 if (leftSegment <=3D rightSegment) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0 qsort(leftSegment);
=A0=A0=A0=A0=A0=A0=A0=A0=A0 qsort(rightSegment);
=A0=A0=A0=A0=A0 } else {
=A0=A0=A0=A0=A0=A0=A0=A0=A0 qsort(rightSegment);
=A0=A0=A0=A0=A0=A0=A0=A0=A0 qsort(leftSegment);
=A0=A0=A0=A0=A0 }

Here a rewrite of the code at the bottom:
=A0=A0=A0 int left =3D=A0 pb - pa;
=A0=A0=A0 int right =3D pd - pc;
=A0=A0=A0 if ( left <=3D right ) {
=A0=A0=A0=A0=A0=A0 if ( left > es ) qsort(a, left / es, es, cmp);
=A0=A0=A0=A0=A0=A0 if ( right > es ) {
=A0=A0=A0=A0=A0=A0 // Iterate rather than recurse to save stack space
=A0=A0=A0=A0=A0=A0 a =3D pn - right;
=A0=A0=A0=A0=A0=A0 n =3D right / es;
=A0=A0=A0=A0=A0=A0 goto loop;
=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0 } else {
=A0=A0=A0=A0=A0=A0 if ( right > es ) qsort(pn - right, right / es, es, cmp);
=A0=A0=A0=A0=A0=A0 if ( left > es ) {
=A0=A0=A0=A0=A0=A0 // Iterate rather than recurse to save stack space
=A0=A0=A0=A0=A0=A0 n =3D left / es;
=A0=A0=A0=A0=A0=A0 goto loop;
=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0 }

Here the modified total code:
// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
/*
FUNCTION
<<qsort>>---sort an array

INDEX
=A0=A0=A0 qsort

ANSI_SYNOPSIS
=A0=A0=A0 #include <stdlib.h>
=A0=A0=A0 void qsort(void *<[base]>, size_t <[nmemb]>, size_t <[size]>,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int (*<[compar]>)(const void *, const void *=
) );

TRAD_SYNOPSIS
=A0=A0=A0 #include <stdlib.h>
=A0=A0=A0 qsort(<[base]>, <[nmemb]>, <[size]>, <[compar]> )
=A0=A0=A0 char *<[base]>;
=A0=A0=A0 size_t <[nmemb]>;
=A0=A0=A0 size_t <[size]>;
=A0=A0=A0 int (*<[compar]>)();

DESCRIPTION
<<qsort>> sorts an array (beginning at <[base]>) of <[nmemb]> objects.
<[size]> describes the size of each element of the array.

You must supply a pointer to a comparison function, using the argument
shown as <[compar]>.=A0 (This permits sorting objects of unknown
properties.)=A0 Define the comparison function to accept two arguments,
each a pointer to an element of the array starting at <[base]>.=A0 The
result of <<(*<[compar]>)>> must be negative if the first argument is
less than the second, zero if the two arguments match, and positive if
the first argument is greater than the second (where ``less than'' and
``greater than'' refer to whatever arbitrary ordering is appropriate).

The array is sorted in place; that is, when <<qsort>> returns, the
array elements beginning at <[base]> have been reordered.

RETURNS
<<qsort>> does not return a result.

PORTABILITY
<<qsort>> is required by ANSI (without specifying the sorting algorithm).
*/

/*-
=A0* Copyright (c) 1992, 1993
=A0*=A0=A0=A0 The Regents of the University of California.=A0 All rights re=
served.
=A0*
=A0* Redistribution and use in source and binary forms, with or without
=A0* modification, are permitted provided that the following conditions
=A0* are met:
=A0* 1. Redistributions of source code must retain the above copyright
=A0*=A0=A0=A0 notice, this list of conditions and the following disclaimer.
=A0* 2. Redistributions in binary form must reproduce the above copyright
=A0*=A0=A0=A0 notice, this list of conditions and the following disclaimer =
in the
=A0*=A0=A0=A0 documentation and/or other materials provided with the distri=
bution.
=A0* 3. All advertising materials mentioning features or use of this softwa=
re
=A0*=A0=A0=A0 must display the following acknowledgement:
=A0*=A0=A0=A0 This product includes software developed by the University of
=A0*=A0=A0=A0 California, Berkeley and its contributors.
=A0* 4. Neither the name of the University nor the names of its contributors
=A0*=A0=A0=A0 may be used to endorse or promote products derived from this =
software
=A0*=A0=A0=A0 without specific prior written permission.
=A0*
=A0* THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
=A0* ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
=A0* IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PUR=
POSE
=A0* ARE DISCLAIMED.=A0 IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LI=
ABLE
=A0* FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUEN=
TIAL
=A0* DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
=A0* OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
=A0* HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, ST=
RICT
=A0* LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY =
WAY
=A0* OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
=A0* SUCH DAMAGE.
=A0*/

/*
This code deviates from the one described in a 1993 paper by Bentley &
McIlroy.=A0 The modification of replacing the 2nd recursive call by tail
recursion is OK.

The addition of swap_cnt and a 2nd invocation of insertion sort is
wrong because it leads to quadratic explosions in 3% of the
distributions generated by the Bentley bench-test, see the paper.
Hence this addition is removed.

An ordering has been imposed on the two recursive/iterative invocations.
This guarantees a log2(N) limit on the required stack space.
*/

#include <_ansi.h>
#include <stdlib.h>

#ifndef __GNUC__
#define inline
#endif

static inline char=A0=A0=A0 *med3 _PARAMS((char *, char *, char *, int (*)(=
)));
static inline void=A0=A0=A0=A0 swapfunc _PARAMS((char *, char *, int, int));

#define min(a, b)=A0=A0=A0 (a) < (b) ? a : b

/*
=A0* Qsort routine from Bentley & McIlroy's "Engineering a Sort Function".
=A0*/
#define swapcode(TYPE, parmi, parmj, n) {=A0=A0=A0=A0=A0=A0=A0=A0 \
=A0=A0=A0 long i =3D (n) / sizeof (TYPE);=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 \
=A0=A0=A0 register TYPE *pi =3D (TYPE *) (parmi);=A0=A0=A0=A0=A0=A0=A0=A0 \
=A0=A0=A0 register TYPE *pj =3D (TYPE *) (parmj);=A0=A0=A0=A0=A0=A0=A0=A0 \
=A0=A0=A0 do {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 \
=A0=A0=A0=A0=A0=A0=A0 register=A0 TYPE=A0=A0=A0 t =3D *pi;=A0=A0=A0=A0=A0=
=A0=A0 \
=A0=A0=A0=A0=A0=A0=A0 *pi++ =3D *pj;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \
=A0=A0=A0=A0=A0=A0=A0 *pj++ =3D t;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \
=A0=A0=A0=A0=A0=A0=A0 } while (--i > 0);=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 \
}

#define SWAPINIT(a, es) swaptype =3D ((char *)a - (char *)0) % sizeof(long)=
 || \
=A0=A0=A0 es % sizeof(long) ? 2 : es =3D=3D sizeof(long)? 0 : 1;

static inline void
_DEFUN(swapfunc, (a, b, n, swaptype),
=A0=A0=A0 char *a _AND
=A0=A0=A0 char *b _AND
=A0=A0=A0 int n _AND
=A0=A0=A0 int swaptype)
{
=A0=A0=A0 if(swaptype <=3D 1)
=A0=A0=A0=A0=A0=A0=A0 swapcode(long, a, b, n)
=A0=A0=A0 else
=A0=A0=A0=A0=A0=A0=A0 swapcode(char, a, b, n)
}

#define swap(a, b)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 \
=A0=A0=A0 if (swaptype =3D=3D 0) {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \
=A0=A0=A0=A0=A0=A0=A0 long t =3D *(long *)(a);=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \
=A0=A0=A0=A0=A0=A0=A0 *(long *)(a) =3D *(long *)(b);=A0=A0=A0=A0=A0=A0=A0 \
=A0=A0=A0=A0=A0=A0=A0 *(long *)(b) =3D t;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \
=A0=A0=A0 } else=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 \
=A0=A0=A0=A0=A0=A0=A0 swapfunc(a, b, es, swaptype)

#define vecswap(a, b, n)=A0=A0=A0=A0 if ((n) > 0) swapfunc(a, b, n, swaptyp=
e)

static inline char *
_DEFUN(med3, (a, b, c, cmp),
=A0=A0=A0 char *a _AND
=A0=A0=A0 char *b _AND
=A0=A0=A0 char *c _AND
=A0=A0=A0 int (*cmp)())
{
=A0=A0=A0 return cmp(a, b) < 0 ?
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (cmp(b, c) < 0 ? b : (cmp(a, c) < 0 ? c : a =
))
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 :(cmp(b, c) > 0 ? b : (cmp(a, c) < =
0 ? a : c ));
}

void
_DEFUN(qsort, (a, n, es, cmp),
=A0=A0=A0 void *a _AND
=A0=A0=A0 size_t n _AND
=A0=A0=A0 size_t es _AND
=A0=A0=A0 int (*cmp)())
{
=A0=A0=A0 char *pa, *pb, *pc, *pd, *pl, *pm, *pn;
=A0=A0=A0 int d, r, swaptype;
=A0=A0=A0 // int swap_cnt;

loop:=A0=A0=A0 SWAPINIT(a, es);
=A0=A0=A0 // swap_cnt =3D 0;
=A0=A0=A0 if (n < 7) {
=A0=A0=A0=A0=A0=A0=A0 for (pm =3D (char *) a + es; pm < (char *) a + n * es=
; pm +=3D es)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (pl =3D pm; pl > (char *) a && cmp(pl=
 - es, pl) > 0;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pl -=3D es)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 swap(pl, pl - es);
=A0=A0=A0=A0=A0=A0=A0 return;
=A0=A0=A0 }
=A0=A0=A0 pm =3D (char *) a + (n / 2) * es;
=A0=A0=A0 if (n > 7) {
=A0=A0=A0=A0=A0=A0=A0 pl =3D a;
=A0=A0=A0=A0=A0=A0=A0 pn =3D (char *) a + (n - 1) * es;
=A0=A0=A0=A0=A0=A0=A0 if (n > 40) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d =3D (n / 8) * es;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pl =3D med3(pl, pl + d, pl + 2 * d, cmp);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pm =3D med3(pm - d, pm, pm + d, cmp);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pn =3D med3(pn - 2 * d, pn - d, pn, cmp);
=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0 pm =3D med3(pl, pm, pn, cmp);
=A0=A0=A0 }
=A0=A0=A0 swap(a, pm);
=A0=A0=A0 pa =3D pb =3D (char *) a + es;

=A0=A0=A0 pc =3D pd =3D (char *) a + (n - 1) * es;
=A0=A0=A0 for (;;) {
=A0=A0=A0=A0=A0=A0=A0 while (pb <=3D pc && (r =3D cmp(pb, a)) <=3D 0) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (r =3D=3D 0) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // swap_cnt =3D 1;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 swap(pa, pb);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pa +=3D es;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pb +=3D es;
=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0 while (pb <=3D pc && (r =3D cmp(pc, a)) >=3D 0) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (r =3D=3D 0) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // swap_cnt =3D 1;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 swap(pc, pd);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pd -=3D es;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pc -=3D es;
=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0 if (pb > pc)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
=A0=A0=A0=A0=A0=A0=A0 swap(pb, pc);
=A0=A0=A0=A0=A0=A0=A0 // swap_cnt =3D 1;
=A0=A0=A0=A0=A0=A0=A0 pb +=3D es;
=A0=A0=A0=A0=A0=A0=A0 pc -=3D es;
=A0=A0=A0 }
=A0=A0=A0 /*
=A0=A0=A0 if (swap_cnt =3D=3D 0) {=A0 // Switch to insertion sort
=A0=A0=A0=A0=A0=A0=A0 for (pm =3D (char *) a + es; pm < (char *) a + n * es=
; pm +=3D es)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (pl =3D pm; pl > (char *) a && cmp(pl=
 - es, pl) > 0;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pl -=3D es)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 swap(pl, pl - es);
=A0=A0=A0=A0=A0=A0=A0 return;
=A0=A0=A0 }
=A0=A0=A0 */

=A0=A0=A0 pn =3D (char *) a + n * es;
=A0=A0=A0 r =3D min(pa - (char *)a, pb - pa);
=A0=A0=A0 vecswap(a, pb - r, r);
=A0=A0=A0 r =3D min(pd - pc, pn - pd - es);
=A0=A0=A0 vecswap(pb, pn - r, r);
=A0=A0=A0 /* Replaced to limit the required stack size to log2(N)
=A0=A0=A0 if ((r =3D pb - pa) > es)
=A0=A0=A0=A0=A0=A0=A0 qsort(a, r / es, es, cmp);
=A0=A0=A0 if ((r =3D pd - pc) > es) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // Iterate rather than recurse to save st=
ack space
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // qsort(pn - r, r / es, es, cmp);
=A0=A0=A0=A0=A0=A0=A0 a =3D pn - r;
=A0=A0=A0=A0=A0=A0=A0 n =3D r / es;
=A0=A0=A0=A0=A0=A0=A0 goto loop;
=A0=A0=A0 }
=A0=A0=A0 */
=A0=A0=A0=A0=A0=A0=A0 int left =3D=A0 pb - pa;
=A0=A0=A0 int right =3D pd - pc;
=A0=A0=A0 if ( left <=3D right ) {
=A0=A0=A0=A0=A0 if ( left > es ) qsort(a, left / es, es, cmp);
=A0=A0=A0=A0=A0 if ( right > es ) {
=A0=A0=A0=A0=A0=A0=A0 // Iterate rather than recurse to save stack space
=A0=A0=A0=A0=A0=A0=A0 a =3D pn - right;
=A0=A0=A0=A0=A0=A0=A0 n =3D right / es;
=A0=A0=A0=A0=A0=A0=A0 goto loop;
=A0=A0=A0=A0=A0 }
=A0=A0=A0 } else {
=A0=A0=A0=A0=A0 if ( right > es ) qsort(pn - right, right / es, es, cmp);
=A0=A0=A0=A0=A0 if ( left > es ) {
=A0=A0=A0=A0=A0=A0=A0 // Iterate rather than recurse to save stack space
=A0=A0=A0=A0=A0=A0=A0 n =3D left / es;
=A0=A0=A0=A0=A0=A0=A0 goto loop;
=A0=A0=A0=A0=A0 }
=A0=A0=A0 }
} // end qsort

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




---------------------------------------------------------------------------=
-------------
Home page: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 rs6.risingnet.net/~ddcc
Health Info Anytime for Everyone:=A0=A0 www.HealthCheck4Me.info
Exercise for the Mind:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 www.SuDoKuChallenge.us
Marketing site:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 www.OntoOO.com
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >>=A0=A0Do NOT buy Dell, M=
ac, Ford, Chrysler=A0=A0<<
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >>=A0=A0=A0=A0=A0=A0=A0=A0=
 Boycott Chinese Products=A0=A0=A0=A0=A0=A0 <<=A0
