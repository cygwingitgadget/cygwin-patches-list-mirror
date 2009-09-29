Return-Path: <cygwin-patches-return-6657-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3661 invoked by alias); 29 Sep 2009 22:33:38 -0000
Received: (qmail 3646 invoked by uid 22791); 29 Sep 2009 22:33:37 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-151.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.151)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 29 Sep 2009 22:33:31 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 6128613C002 	for <cygwin-patches@cygwin.com>; Tue, 29 Sep 2009 18:33:21 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 570EB2B352; Tue, 29 Sep 2009 18:33:21 -0400 (EDT)
Date: Tue, 29 Sep 2009 22:33:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] --std=c89 error in sys/signal.h
Message-ID: <20090929223320.GA8901@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC2732D.5090304@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AC2732D.5090304@users.sourceforge.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00111.txt.bz2

On Tue, Sep 29, 2009 at 03:50:53PM -0500, Yaakov (Cygwin/X) wrote:
>Compiling a file which #include's <sys/signal.h> in C89 mode fails:
>
>$ echo "#include <sys/signal.h>" > test.c
>$ gcc -c test.c
>$ gcc -c -std=c89 test.c
>In file included from /usr/include/sys/signal.h:107,
>                  from test.c:1:
>/usr/include/cygwin/signal.h:74: error: expected 
>specifier-qualifier-list before 'pthread_attr_t'
>/usr/include/cygwin/signal.h:80: error: expected 
>specifier-qualifier-list before '__uint32_t'
>/usr/include/cygwin/signal.h:96: error: expected 
>specifier-qualifier-list before 'pid_t'
>/usr/include/cygwin/signal.h:270: error: expected ')' before 'int'
>In file included from test.c:1:
>/usr/include/sys/signal.h:152: error: expected ')' before 'int'
>
>The problem is that both <cygwin/signal.h> and an #ifdef __CYGWIN__ 
>section of <sys/signal.h> need those typedefs from <sys/types.h>, but 
>the latter is only #include'd #ifdef _POSIX_THREADS, which is off in C89 
>mode.
>
>I see two possible solutions:
>
>1) Unconditionally #include <sys/types.h> in <sys/signal.h> (newlib), OR
>2) #include <sys/types.h> in <cygwin/signal.h>.
>
>Since this appears to be Cygwin specific, I went for the latter.  Patch 
>attached.

WDLD?

cgf
