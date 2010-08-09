Return-Path: <cygwin-patches-return-7062-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9918 invoked by alias); 9 Aug 2010 08:21:03 -0000
Received: (qmail 9899 invoked by uid 22791); 9 Aug 2010 08:21:01 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 09 Aug 2010 08:20:56 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 781AE6D4364; Mon,  9 Aug 2010 10:20:53 +0200 (CEST)
Date: Mon, 09 Aug 2010 08:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] implement /proc/filesystems
Message-ID: <20100809082053.GD17925@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1281334969.6576.8.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1281334969.6576.8.camel@YAAKOV04>
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
X-SW-Source: 2010-q3/txt/msg00022.txt.bz2

On Aug  9 01:22, Yaakov S wrote:
> 	* fhandler_proc.cc: Add /proc/filesystems virtual file.
> 	(format_proc_filesystems): New function.
> 	* mount.cc (fs_names): Move to global scope. Redefine as array
> 	of { "name", block_device? } structs.
> 	(fillout_mntent): Use name member of fs_names.
> 	* mount.h (fs_names): New prototype.

Thank you!  Patch applied.  I added an entry to the docs as well.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
