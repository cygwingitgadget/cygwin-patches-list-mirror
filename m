Return-Path: <cygwin-patches-return-9490-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20220 invoked by alias); 18 Jul 2019 13:15:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19881 invoked by uid 89); 18 Jul 2019 13:15:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.8 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SPF_PASS,URI_HEX autolearn=ham version=3.3.1 spammy=Cygwin, UD:nabble.com, Ken, U*cygwin-patches
X-HELO: mout.gmx.net
Received: from mout.gmx.net (HELO mout.gmx.net) (212.227.15.18) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 18 Jul 2019 13:15:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;	s=badeba3b8450; t=1563455695;	bh=KxbeUFHteaO5iVIlefQlpre3DgPlQLvjOEhdXhUviJk=;	h=X-UI-Sender-Class:Date:From:To:Subject;	b=dLaSRGo1DQ40P4qzm+Xo30P7+pWYb39389+Yn7abLOF158SnX5yTL0bC2VnoQ6xYv	 3lP4iSORqcvCZiLtyveudlPxDFRVABDZOrQFctjHQZuKVFHqWKcREGcoUZtx2WzGa5	 nhCGPxRzsfUgrE3a1fefHpyb1hRWmjMCtwTewPU8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mdren-1i4nkh3Xf3-00PcYM for <cygwin-patches@cygwin.com>; Thu, 18 Jul 2019 15:14:55 +0200
Date: Thu, 18 Jul 2019 13:15:00 -0000
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: fix GCC 8.3 'asm volatile' errors (fwd)
Message-ID: <nycvar.QRO.7.76.6.1907181514100.47@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00010.txt.bz2

Apparently I ran afoul of some overzealous spam filter:

SMTP error from remote server for TEXT command, host: sourceware.org
(209.132.180.131) reason: 552 spam score exceeded threshold


---------- Forwarded message ----------
Date: Thu, 18 Jul 2019 11:01:33 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Cc: Ken Brown <kbrown@cornell.edu>
Subject: Re: [PATCH 4/5] Cygwin: fix GCC 8.3 'asm volatile' errors

Hi,

On Wed, 17 Jul 2019, Corinna Vinschen wrote:

> Hi Ken,
>
> On Jul 16 17:34, Ken Brown wrote:
> > Remove 'volatile'.
>
> What happened to asm volatile?   Can you add a short description (single
> sentence) to the commit msg explaining why this is a problem now?

As it so happens, we discussed this very patch in the MSYS2 Gitter channel =
the other day, and this is what I found:

	winsup/cygwin/miscfuncs.cc:748:5: error:sm qualifier 'volatile' ignored ou=
tside of function body [-Werror]
	748 | asm volatile (" \n\


According to
http://gcc.1065356.n8.nabble.com/C-PATCH-Toplevel-asm-volatile-PR-c-89585-t=
d1569943.html,
it seems that the GCC team meant to demote this to a mere warning.

But of course -Werror will upgrade that to an error.

The patches suggest that the volatile qualifier here is unnecessary and
has no effect. My understanding is that the `asm volatile` construct
prevents assembler code from being optimized away, but only in inline
assembler instructions. Top-level functions, such as that `memset()`
family of functions, should not be subject to optimization anyway, so I
kind of understand why the `volatile` attribute is ignored.

In short: it seems that the `volatile` attribute of a top-level `asm`
block has no effect, and has not had any effect for some time.

Note: I am no longer really good at machine code, so I might be reading
this all wrong. Hopefully it gives you some inspiration for a good
commit message, though?

Ciao,
Dscho
