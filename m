Return-Path: <cygwin-patches-return-6519-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20259 invoked by alias); 27 Apr 2009 04:31:59 -0000
Received: (qmail 20233 invoked by uid 22791); 27 Apr 2009 04:31:55 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-58-89.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.58.89)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 27 Apr 2009 04:31:51 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id BD56E13C023 	for <cygwin-patches@cygwin.com>; Mon, 27 Apr 2009 00:31:41 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id AE3432B660; Mon, 27 Apr 2009 00:31:41 -0400 (EDT)
Date: Mon, 27 Apr 2009 04:31:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: sys/socket.h: define SOL_IPV6?
Message-ID: <20090427043141.GA20932@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49F524DF.9040107@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49F524DF.9040107@users.sourceforge.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00061.txt.bz2

On Sun, Apr 26, 2009 at 10:22:07PM -0500, Yaakov (Cygwin/X) wrote:
>Does it make sense to define SOL_IPV6 now?  Patch attached if so.

I think it does.  I've checked in this patch.  I'm sure Corinna will
revert it if I am wrong.

Thanks.

cgf
