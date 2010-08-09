Return-Path: <cygwin-patches-return-7063-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16465 invoked by alias); 9 Aug 2010 14:15:25 -0000
Received: (qmail 16453 invoked by uid 22791); 9 Aug 2010 14:15:24 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-4.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.4)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 09 Aug 2010 14:15:17 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 8420413C061	for <cygwin-patches@cygwin.com>; Mon,  9 Aug 2010 10:15:15 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 788492B352; Mon,  9 Aug 2010 10:15:15 -0400 (EDT)
Date: Mon, 09 Aug 2010 14:15:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] implement /proc/filesystems
Message-ID: <20100809141515.GC12979@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1281334969.6576.8.camel@YAAKOV04> <20100809082053.GD17925@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100809082053.GD17925@calimero.vinschen.de>
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
X-SW-Source: 2010-q3/txt/msg00023.txt.bz2

On Mon, Aug 09, 2010 at 10:20:53AM +0200, Corinna Vinschen wrote:
>On Aug  9 01:22, Yaakov S wrote:
>> 	* fhandler_proc.cc: Add /proc/filesystems virtual file.
>> 	(format_proc_filesystems): New function.
>> 	* mount.cc (fs_names): Move to global scope. Redefine as array
>> 	of { "name", block_device? } structs.
>> 	(fillout_mntent): Use name member of fs_names.
>> 	* mount.h (fs_names): New prototype.
>
>Thank you!  Patch applied.  I added an entry to the docs as well.

Thanks for the new functionality Yaakov.

cgf
