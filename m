Return-Path: <cygwin-patches-return-5452-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6596 invoked by alias); 17 May 2005 23:31:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6498 invoked from network); 17 May 2005 23:31:40 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 17 May 2005 23:31:40 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 7BAA713C197; Tue, 17 May 2005 19:31:50 -0400 (EDT)
Date: Tue, 17 May 2005 23:31:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] gcc4 fixes
Message-ID: <20050517233150.GB9001@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <428A7520.7FD9925C@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428A7520.7FD9925C@dessent.net>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00048.txt.bz2

On Tue, May 17, 2005 at 03:50:08PM -0700, Brian Dessent wrote:
>
>This is just a trivial change of argument to execl() testcases, which
>supresses the warning 'missing sentinel in function call' in gcc4 that
>causes the tests to fail.
>
>winsup/testsuite
>2005-05-17  Brian Dessent  <brian@dessent.net>
>
>	* winsup.api/signal-into-win32-api.c (main): Use 'NULL' instead
>	of '0' in argument list to avoid compiler warning with gcc4.
>	* winsup.api/ltp/execle01.c (main): Ditto.
>	* winsup.api/ltp/execlp01.c (main): Ditto.
>	* winsup.api/ltp/fcntl07.c (do_exec): Ditto.
>	* winsup.api/ltp/fcntl07B.c (do_exec): Ditto.

Go ahead and check these in but please use GNU formatting conventions,
i.e., it's (char *) NULL, not (char *)NULL.  Actually, isn't just NULL
sufficient?

>This fixes the problem of mmap() not working with gcc4.
>
>winsup/cygwin
>2005-05-17  Brian Dessent  <brian@dessent.net>
>
>	* mmap.cc (mmap64): Move 'granularity' into file scope so that
>	it will be initialized.

Sorry but no.  This is a workaround.  We need to fix the actual problem.

Thanks.

cgf
