Return-Path: <cygwin-patches-return-7376-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2121 invoked by alias); 18 May 2011 03:47:27 -0000
Received: (qmail 2095 invoked by uid 22791); 18 May 2011 03:47:26 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST
X-Spam-Check-By: sourceware.org
Received: from mail-gw0-f43.google.com (HELO mail-gw0-f43.google.com) (74.125.83.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 18 May 2011 03:47:12 +0000
Received: by gwj21 with SMTP id 21so536419gwj.2        for <cygwin-patches@cygwin.com>; Tue, 17 May 2011 20:47:12 -0700 (PDT)
Received: by 10.236.175.3 with SMTP id y3mr1477749yhl.62.1305690432039;        Tue, 17 May 2011 20:47:12 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id x68sm533349yhn.57.2011.05.17.20.47.10        (version=SSLv3 cipher=OTHER);        Tue, 17 May 2011 20:47:11 -0700 (PDT)
Subject: Re: [PATCH] error.h
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Wed, 18 May 2011 03:47:00 -0000
In-Reply-To: <4DD33E74.9030408@cwilson.fastmail.fm>
References: <1305678052.6192.5.camel@YAAKOV04>	 <4DD33E74.9030408@cwilson.fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Message-ID: <1305690437.4200.6.camel@YAAKOV04>
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00142.txt.bz2

On Tue, 2011-05-17 at 23:35 -0400, Charles Wilson wrote:
> On 5/17/2011 8:20 PM, Yaakov (Cygwin/X) wrote:
> > This patch series adds error.h and the error(3) functions, a GNU
> > extension:
> > 
> > http://www.kernel.org/doc/man-pages/online/pages/man3/error.3.html
> > 
> Shouldn't the definitions in error.h be guarded by #ifdef GNU_SOURCE or
> something

If this were required, it would have been indicated in the
aforementioned documentation.  My extensive[1] testing of these
functions on Linux also showed that this was not required.  (The
_GNU_SOURCE in the test app is only required to pull in
program_invocation_name, a GNU extension declared in <errno.h>.)

> or are we relying on error.h itself, as a non-standard
> header, "hiding" the symbols implicitly?   E.g. if you don't want the
> functions, don't include <error.h>?

Exactly, just as on Linux.


Yaakov

[1] Just how extensive, you ask?  See
http://sourceware.org/bugzilla/show_bug.cgi?id=12766

