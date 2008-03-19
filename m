Return-Path: <cygwin-patches-return-6314-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16133 invoked by alias); 19 Mar 2008 21:03:12 -0000
Received: (qmail 16115 invoked by uid 22791); 19 Mar 2008 21:03:10 -0000
X-Spam-Check-By: sourceware.org
Received: from rv-out-0910.google.com (HELO rv-out-0910.google.com) (209.85.198.185)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 19 Mar 2008 21:02:44 +0000
Received: by rv-out-0910.google.com with SMTP id b22so308221rvf.38         for <cygwin-patches@cygwin.com>; Wed, 19 Mar 2008 14:02:42 -0700 (PDT)
Received: by 10.141.193.1 with SMTP id v1mr498526rvp.73.1205960562598;         Wed, 19 Mar 2008 14:02:42 -0700 (PDT)
Received: from orlando ( [85.241.2.231])         by mx.google.com with ESMTPS id w40sm5927544ugc.45.2008.03.19.14.02.40         (version=TLSv1/SSLv3 cipher=OTHER);         Wed, 19 Mar 2008 14:02:41 -0700 (PDT)
From: Pedro Alves <pedro_alves@portugalmail.pt>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] better stackdumps
Date: Wed, 19 Mar 2008 21:03:00 -0000
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
References: <47E05D34.FCC2E30A@dessent.net> <20080319030027.GC22446@ednor.casa.cgf.cx> <47E137C7.8AE02BC4@dessent.net>
In-Reply-To: <47E137C7.8AE02BC4@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain;   charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200803192102.48661.pedro_alves@portugalmail.pt>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00088.txt.bz2

A Wednesday 19 March 2008 15:56:55, Brian Dessent wrote:
> Christopher Faylor wrote:
> > Sorry, but I don't like this concept.  This bloats the cygwin DLL for a
> > condition that would be better served by either using gdb or generating
> > a real coredump.
>
> I hear you, but part of the motivation for writing this was a recent
> thread the other week on the gdb list where the poster asked how to get
> symbols in a Cygwin stackdump file.  I suggested the same thing, setting
> error_start=dumper to get a real core dump.  They did, and the result
> was completely useless.  Here is what dumper gives you for the same
> simple testcase:
>
> $ gdb
> (gdb) core a.exe.core
> [New process 1]
> [New process 0]
> [New process 0]
> #0  0x7c90eb94 in ?? ()
> (gdb) thr apply all bt
>
> Thread 3 (process 0):
> #0  0x7c90eb94 in ?? ()
>
> Thread 2 (process 0):
> #0  0x7c90eb94 in ?? ()
>
> Thread 1 (process 1):
> #0  0x7c90eb94 in ?? ()
>
> You can't even make out the names of any of the loaded modules from the
> core:
>

Sorry I missed the discussion at gdb@.  What does info sharelibrary say?
The last I looked at this, it worked.  Is this broken in gdb head
and on the cygwin distributed gdb?

> that this patch introduces.  Plus without being able to recognise that
> signal wrappers obscure the location of the real entrypoints to
> many/most Cygwin functions, the backtrace used by this method looks very
> bad and doesn't give useful information for routines in Cygwin -- and
> being able to do that processing is much easier when you're in the
> actual module that has the wrappers as you can simply test against
> &_sigfe.

Is this something that would be nice to have in gdb then?

-- 
Pedro Alves
