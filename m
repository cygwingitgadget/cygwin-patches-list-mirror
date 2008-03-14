Return-Path: <cygwin-patches-return-6292-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32127 invoked by alias); 14 Mar 2008 02:46:54 -0000
Received: (qmail 32117 invoked by uid 22791); 14 Mar 2008 02:46:54 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 14 Mar 2008 02:46:36 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JZzwI-0000EY-U4 	for cygwin-patches@cygwin.com; Fri, 14 Mar 2008 02:46:35 +0000
Message-ID: <47D9E70D.ED6C84CB@dessent.net>
Date: Fri, 14 Mar 2008 02:46:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] recognise when an exec()d process terminates due to   unhandled   exception
References: <47D9D8D3.17BC1E3B@dessent.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00066.txt.bz2

Brian Dessent wrote:

> As we all know, Cygwin calls SetErrorMode (SEM_FAILCRITICALERRORS) to
> suppress those pop up GUI messageboxes from the operating system when 

Oh, I forgot to mention:

In the course of testing this I came to realize that because of some
sort of "retry if fork doesn't seem to be working" code (not sure of the
details), every time that this situation comes up we are actually
launching five copies of the binary.  I had at one point a testcase so
pathological that it somehow managed to invoke a MS runtime popup error,
even though it was a pure Cygwin binary.  And you'd get 5 copies of the
thing before it gave up and stopped trying.  You can see it in strace a
lot easier though since strace is running the debugger loop you see the
exceptions.

Brian
