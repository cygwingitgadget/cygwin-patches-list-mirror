Return-Path: <cygwin-patches-return-5955-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14075 invoked by alias); 17 Aug 2006 20:24:31 -0000
Received: (qmail 14061 invoked by uid 22791); 17 Aug 2006 20:24:30 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-229.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.229)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 17 Aug 2006 20:24:28 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 18C1013C042; Thu, 17 Aug 2006 16:24:27 -0400 (EDT)
Date: Thu, 17 Aug 2006 20:24:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Prevent closing a NULL pinfo handle
Message-ID: <20060817202427.GF22061@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0608171502550.2408@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0608171502550.2408@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00050.txt.bz2

On Thu, Aug 17, 2006 at 03:09:13PM -0500, Brian Ford wrote:
>I confess to not having a clue what is really going on here, but I'm
>seeing the following errors from a CVS build (yes, I know debugging has
>been turned on), and it looks like this would be the right thing to do:
>
>CloseHandle(moreinfo->myself_pinfo) 0x0 failed
>child_info_spawn::~child_info_spawn():125, Win32 error 6
>
>2006-08-17  Brian Ford  <Brian.Ford@FlightSafety.com>
>
>	* child_info.h (~child_info_spawn): Prevent closing a NULL handle.
>
>Although, I suspect if the correct thing to do were that simple, it would
>already have been noticed and fixed?  And yes, I know that functionally
>this doesn't make much difference.

Sorry.  This is not the right fix.  I'll look into it when I have the time although
I am not seeing this particular problem.

cgf
