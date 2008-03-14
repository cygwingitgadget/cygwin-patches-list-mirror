Return-Path: <cygwin-patches-return-6295-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26895 invoked by alias); 14 Mar 2008 14:13:58 -0000
Received: (qmail 26879 invoked by uid 22791); 14 Mar 2008 14:13:55 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-250.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.250)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 14 Mar 2008 14:13:33 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 7280E6D967A; Fri, 14 Mar 2008 10:13:31 -0400 (EDT)
Date: Fri, 14 Mar 2008 14:13:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] recognise when an exec()d process terminates due to 	unhandled   exception
Message-ID: <20080314141331.GB20808@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47D9D8D3.17BC1E3B@dessent.net> <47D9E70D.ED6C84CB@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47D9E70D.ED6C84CB@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00069.txt.bz2

On Thu, Mar 13, 2008 at 07:46:37PM -0700, Brian Dessent wrote:
>Brian Dessent wrote:
>
>> As we all know, Cygwin calls SetErrorMode (SEM_FAILCRITICALERRORS) to
>> suppress those pop up GUI messageboxes from the operating system when 
>
>Oh, I forgot to mention:
>
>In the course of testing this I came to realize that because of some
>sort of "retry if fork doesn't seem to be working" code (not sure of the
>details), every time that this situation comes up we are actually
>launching five copies of the binary.

That was going to be my first observation, actually.  I'm still trying
to digest the patch but it seems like it wouldn't work well with the
fork retry code.

cgf
