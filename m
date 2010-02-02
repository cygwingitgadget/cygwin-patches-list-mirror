Return-Path: <cygwin-patches-return-6942-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18842 invoked by alias); 2 Feb 2010 01:39:18 -0000
Received: (qmail 18829 invoked by uid 22791); 2 Feb 2010 01:39:17 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-58-83.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.58.83)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 02 Feb 2010 01:39:12 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 7630913C0C7 	for <cygwin-patches@cygwin.com>; Mon,  1 Feb 2010 20:39:02 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 1F94B2B35A; Mon,  1 Feb 2010 20:39:02 -0500 (EST)
Date: Tue, 02 Feb 2010 01:39:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add some notes about process startup/shutdown.
Message-ID: <20100202013901.GB31126@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B677EAA.9050304@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B677EAA.9050304@gmail.com>
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
X-SW-Source: 2010-q1/txt/msg00058.txt.bz2

On Tue, Feb 02, 2010 at 01:23:54AM +0000, Dave Korn wrote:
>
>
>  Here's some notes I've been making; reckon they might come in handy for
>anyone who wants to untangle some of this stuff in the future.  Attached the
>whole file rather than gratuitously prefixing every line with a '+' to no
>great effect! :)  There'll be another later, to explain how the cxx abi
>interacts with all this.
>
>winsup/cygwin/ChangeLog:
>
>	* how-crt-and-initfini.txt: Add new document.
>
>  OK?

Yes, very nice except I don't think the name is descriptive enough and
in keeping with the other stuff in the series.

Maybe how-startup-shutdown-work.txt ?

cgf
