Return-Path: <cygwin-patches-return-7255-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30882 invoked by alias); 4 Apr 2011 06:40:25 -0000
Received: (qmail 30871 invoked by uid 22791); 4 Apr 2011 06:40:24 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 04 Apr 2011 06:39:52 +0000
Received: by iyi20 with SMTP id 20so7274764iyi.2        for <cygwin-patches@cygwin.com>; Sun, 03 Apr 2011 23:39:51 -0700 (PDT)
Received: by 10.43.64.196 with SMTP id xj4mr10035666icb.51.1301899191353;        Sun, 03 Apr 2011 23:39:51 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id 19sm3538459ibx.18.2011.04.03.23.39.47        (version=SSLv3 cipher=OTHER);        Sun, 03 Apr 2011 23:39:49 -0700 (PDT)
Subject: Re: [PATCH] make <sys/sysmacros.h> compatible with glibc
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <20110404051942.GA30475@ednor.casa.cgf.cx>
References: <1301873845.3104.26.camel@YAAKOV04>	 <20110403235557.GA15529@ednor.casa.cgf.cx>	 <1301875911.3104.39.camel@YAAKOV04>	 <20110404051942.GA30475@ednor.casa.cgf.cx>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 04 Apr 2011 06:40:00 -0000
Message-ID: <1301899192.3104.66.camel@YAAKOV04>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00021.txt.bz2

On Mon, 2011-04-04 at 01:19 -0400, Christopher Faylor wrote:
> There is a __INSIDE_CYGWIN_NET__ which I apparently added ten years ago
> but my ideas about naming have changed.  I also added
> USE_SYS_TYPES_FD_SET which is closer to what I now prefer but it should
> have had some leading underscores.

I could just manually define __NO_INLINE__; there's no net effect on the
resulting object file.

I suppose YA alternative would be to define these as cygwin_dev_* and
then export them in cygwin.din as gnu_dev_*, but that does seem to be an
overkill.

> Maybe the functions were added to gcc before it had the ability to force
> inlining.

Not AFAICS; originally they were simple macros like we currently have,
but for glibc-2.3.3 (Sept 2003), they were changed, adding both inline
and exported functions simultaneously[1].

Of course, this is not unprecedented: note ntohl and friends, for which
we also provide both inline and exported.

But as I've mentioned before, that where a function is expected,
providing a macro or inline function by itself is inadequate; an
autoconf AC_CHECK_FUNC or cmake CheckFunctionExists call will result in
a false negative if a real function is not present as well.  (Although I
do concede that is seems unlikely in this particular case.)


Yaakov

[1] http://sourceware.org/git/?p=glibc.git;a=commitdiff;h=9a276f8

