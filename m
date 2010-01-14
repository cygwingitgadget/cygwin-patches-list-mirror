Return-Path: <cygwin-patches-return-6917-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10681 invoked by alias); 14 Jan 2010 16:54:16 -0000
Received: (qmail 10668 invoked by uid 22791); 14 Jan 2010 16:54:15 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-52-118.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.52.118)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 14 Jan 2010 16:54:11 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 6662113C0C7 	for <cygwin-patches@cygwin.com>; Thu, 14 Jan 2010 11:54:01 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 60F862B35A; Thu, 14 Jan 2010 11:54:01 -0500 (EST)
Date: Thu, 14 Jan 2010 16:54:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC, take 2
Message-ID: <20100114165401.GG9964@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20100114163556.GF14511@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100114163556.GF14511@calimero.vinschen.de>
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
X-SW-Source: 2010-q1/txt/msg00033.txt.bz2

On Thu, Jan 14, 2010 at 05:35:56PM +0100, Corinna Vinschen wrote:
>Hi,
>
>here's the next iteration of the patch.  It takes the comments to the
>first iteration into account, adds the pipe2 call, and uses O_CLOEXEC in
>the POSIX IPC foo_open calls.  I also ran all three testcases provided
>by Eric as well as a handcrafted test for open, which I created from the
>pipe2 testcase.  All tests ran successfully.
>
>I'd appreciate another review.

Ship it!

cgf
