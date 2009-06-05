Return-Path: <cygwin-patches-return-6544-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31813 invoked by alias); 5 Jun 2009 16:27:04 -0000
Received: (qmail 31803 invoked by uid 22791); 5 Jun 2009 16:27:03 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-121.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.121)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 05 Jun 2009 16:26:58 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 9C46E13C0C3 	for <cygwin-patches@cygwin.com>; Fri,  5 Jun 2009 12:26:48 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 625F9644014; Fri,  5 Jun 2009 12:26:48 -0400 (EDT)
Date: Fri, 05 Jun 2009 16:27:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH?]  Separate pthread patches, #2 take 2.
Message-ID: <20090605162647.GA5103@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A270656.8090704@gmail.com> <4A2716AF.9070101@gmail.com> <4A2728F8.8020907@gmail.com> <20090604151053.GX23519@calimero.vinschen.de> <4A29260B.90001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A29260B.90001@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00086.txt.bz2

On Fri, Jun 05, 2009 at 03:04:59PM +0100, Dave Korn wrote:
>winsup/cygwin/ChangeLog
>
>	* winbase.h (ilockexch):  Fix asm constraints.
>	(ilockcmpexch):  Likewise.

Thanks for seeing this through.  It was obviously a lot of work.

cgf
