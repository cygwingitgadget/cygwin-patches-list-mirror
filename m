Return-Path: <cygwin-patches-return-6901-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11799 invoked by alias); 13 Jan 2010 21:49:43 -0000
Received: (qmail 11779 invoked by uid 22791); 13 Jan 2010 21:49:42 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-52-118.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.52.118)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 13 Jan 2010 21:49:38 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 0B2A913C0C7 	for <cygwin-patches@cygwin.com>; Wed, 13 Jan 2010 16:49:29 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id F28D32B35A; Wed, 13 Jan 2010 16:49:28 -0500 (EST)
Date: Wed, 13 Jan 2010 21:49:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
Message-ID: <20100113214928.GA2156@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20100113212537.GB14511@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100113212537.GB14511@calimero.vinschen.de>
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
X-SW-Source: 2010-q1/txt/msg00017.txt.bz2

On Wed, Jan 13, 2010 at 10:25:37PM +0100, Corinna Vinschen wrote:
>Hi,
>
>the below patch implements the Linux dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
>extension.  I hope I didn't miss anything important since it affects
>quite a few fhandlers.  Fortunately most is mechanical change, except
>for a few places (dtable.cc, pipe.cc, fhandeler_fifo.cc, syscalls.cc).
>Nevertheless, I'd be glad if somebody could have a second look into
>this.
>
>Eric, you asked for it in the first place, do you have a fine testcase
>for this functionality?

The number of times that you typed:

  sa_buf = close_on_exec ()
              ? sec_user_nih ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid())
              : sec_user ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid());

implies that this should be a macro or a function.

Could the setting of close_on_exec be handled in the syscalls.cc open()
so that it doesn't have to be done so many times?  You could have
build_fh_name set the noexec flag so that close_on_exec() would still
work in the fhandler_*::open functions.

cgf
