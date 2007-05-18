Return-Path: <cygwin-patches-return-6089-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13628 invoked by alias); 18 May 2007 19:45:33 -0000
Received: (qmail 13608 invoked by uid 22791); 18 May 2007 19:45:32 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-68.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 18 May 2007 19:45:29 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id F3A052B353; Fri, 18 May 2007 15:45:26 -0400 (EDT)
Date: Fri, 18 May 2007 19:45:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Segfault on unaligned lseek() on /dev/sdX (was: [ITP] 	ddrescue  1.3)
Message-ID: <20070518194526.GA3586@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <464DF837.6020304@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <464DF837.6020304@t-online.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00035.txt.bz2

On Fri, May 18, 2007 at 09:02:15PM +0200, Christian Franke wrote:
>Hi,
>
>Cygwin 1.5.24-2 segfaults on unaligned lseek() on raw block devices with 
>sector size >512 bytes.
>
>Testcases:
>$ dd skip=1000 bs=2047 if=/dev/scd0 of=/dev/null
>
>$ ddrescue -c 1 /dev/scd0 file.iso
>
>
>This is due to a fixed 512 byte buffer in fhandler_dev_floppy::lseek().
>It is still present in HEAD revision.
>
>The attached patch should fix. It should work for any sector size.
>(Smoke-)tested with 1.5.24-2 (too busy to test with current CVS, sorry).
>
>2007-05-18  Christian Franke <franke@computer.org>
>
>	* fhandler_floppy.cc (fhandler_dev_floppy::lseek): Fixed segfault on
>	unaligned seek due to fixed size buffer.
>

It seems like this could be done without the heavyweight use of malloc,
like use an automatic array of length 512 + 4 and calculate an aligned
address from that.

cgf
