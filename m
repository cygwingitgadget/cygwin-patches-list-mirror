Return-Path: <cygwin-patches-return-5990-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4795 invoked by alias); 9 Oct 2006 14:02:16 -0000
Received: (qmail 4784 invoked by uid 22791); 9 Oct 2006 14:02:16 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 09 Oct 2006 14:02:05 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 15507544001; Mon,  9 Oct 2006 16:02:03 +0200 (CEST)
Date: Mon, 09 Oct 2006 14:02:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to enable proper handling of Win32 //?/GLOBALROOT/device paths
Message-ID: <20061009140203.GI13105@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20061007114408.GA4843@calimero.vinschen.de> <5DE1FE5AC2164C4BB6BA31575FF42CDA0A4C7F@mutable2.home.mutable.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DE1FE5AC2164C4BB6BA31575FF42CDA0A4C7F@mutable2.home.mutable.net>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00008.txt.bz2

On Oct  7 12:13, d3@mutable.net wrote:
> Thanks for the feedback. I've got a few supporting points though that
> may shed some more light on this.
> 
> On Windows XP the only way to access VSS volumes is by specifying the
> temporary and dynamically generated GLOBALROOT path that the VSS COM API
> creates for you. You cannot persist and map them to a drive or share
> like you can on Server 2003 with the VSS API. 
> [...]
> However Cygwin already specifically allows access to the other form of
> GLOBALROOT access, //./GLOBALROOT, so you can already access most of the
> NT device namespace today. You can use tools like rsync with this form
> to access NT volumes right now. Unfortunately VSS volumes are not
> accessible under this form, which is why I added support for the
> //?/GLOBALROOT form. My patch is just to even out the GLOBALROOT access
> that already exists in Cygwin.
> 
> With my patch you can use a tool like vshadow.exe to create a snapshot
> and then execute a tool like rsync to access them via the dynamic
> GLOBALROOT path, which vshadow provides via an environment variable.
> From my research into using tools like rsync on Win32, this is exactly
> what some people are trying to do as vshadow is known to be the tool
> available from MS for creating VSS snapshot volumes on Windows. Trying
> to use it with rsync is of course failing though. This patch address
> that.

I get the point.  Applied with minor modifications to comments and the
ChangeLog entry.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
