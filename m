Return-Path: <cygwin-patches-return-6108-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15150 invoked by alias); 2 Jun 2007 15:41:58 -0000
Received: (qmail 15140 invoked by uid 22791); 2 Jun 2007 15:41:57 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-245.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.245)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 02 Jun 2007 15:41:54 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 6B26E2B352; Sat,  2 Jun 2007 11:41:56 -0400 (EDT)
Date: Sat, 02 Jun 2007 15:41:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] "strace ./app.exe" probably runs application from /bin
Message-ID: <20070602154156.GA19696@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <466183F3.5020900@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <466183F3.5020900@t-online.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00054.txt.bz2

On Sat, Jun 02, 2007 at 04:51:31PM +0200, Christian Franke wrote:
>Running an application with strace from current directory may not work 
>as expected.
>The "./" is not passed to CreateProcess() and the default app search 
>rules apply
>(1. strace.exe directory,  2. cwd, ..., 6. PATH)
>
>Therefore, an old version of the same app already installed in /bin may 
>be run instead.
>
>
>Testcase:
>
>$ cd /tmp
>
>$ cp /bin/date.exe ./uname.exe
>
>$ date
>Sat Jun  2 16:34:23     2007
>
>$ uname
>CYGWIN_NT-5.1
>
>$ ./uname
>Sat Jun  2 16:34:24     2007
>
>$ strace -o nul ./uname
>CYGWIN_NT-5.1
>
>Workaround:
>
>$ strace -o nul ././uname
>Sat Jun  2 16:34:25     2007
>
>
>The attached patch should fix this.
>
>2007-06-02  Christian Franke <franke@computer.org>
>
>	* strace.cc (create_child): Don't remove current directory
>	from application path.

Thanks for the problem report and test case but this is pretty clearly
not the right way to deal with the issue.  Putting a special case catch
of "./" around a function call which is intended to deal with paths is
pretty clearly a band-aid.

Let me rephrase the problem:

"cygpath does not properly deal with the current directory"

Thanks for the patch but we won't be applying it in this form.

cgf
