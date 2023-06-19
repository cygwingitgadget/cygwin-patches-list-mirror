Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 20E953858D28; Mon, 19 Jun 2023 08:56:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 20E953858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1687164962;
	bh=hwkIefGWHMUJ2wq2GtPt8lUBkFye1h/8jqXIw5GrrPA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=vjTC/aHqb+5j6s5IkVbMlOYipfVJUFCU5xejXJ0sw0YoLe3D7NP503xC6v6sTum9Y
	 2G/MZ6o/2EzEa/RHLhEOnEbKrk+HQrSZSoISnA8e4ei3udgL7u4uCE3soD4622jTH8
	 IFZLvtTgNLXp8/djIjZAXPol53Orrg6omvXMQt5I=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 026E5A8078D; Mon, 19 Jun 2023 10:56:00 +0200 (CEST)
Date: Mon, 19 Jun 2023 10:55:59 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Brian Inglis <Brian.Inglis@shaw.ca>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 0/3] use wincap in format_proc_cpuinfo for user_shstk
Message-ID: <ZJAYH8XPa6/fzSGG@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Brian Inglis <Brian.Inglis@shaw.ca>,
	cygwin-patches@cygwin.com
References: <cover.1686934096.git.Brian.Inglis@Shaw.ca>
 <ZIy9JuA2wxH4i37A@calimero.vinschen.de>
 <5786973b-7343-6a8c-38d0-35212d80a2c2@Shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5786973b-7343-6a8c-38d0-35212d80a2c2@Shaw.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jun 16 15:26, Brian Inglis wrote:
> On 2023-06-16 13:51, Corinna Vinschen wrote:
> > Hi Brian,
> > 
> > On Jun 16 11:17, Brian Inglis wrote:
> 
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
> > > Fixes: 41fdb869f998 "fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3 cpuinfo"
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
> > > In test for for AMD/Intel Control flow Enforcement Technology user mode
> > > shadow stack support replace Windows version tests with test of wincap
> > > member addition has_user_shstk with Windows version dependent value
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> > Is that actually the final version?  It's still missing the commit
> > message text explaining things and the "Fixes" line...
> Hi Corinna,
> 
> Is more required above?

No, it's fine, albeit "Fixes:" is supposed to be kind of like a footer,
just where the "Signed-off-by:" is, too.

But it's still only in the cover letter.  As I wrote, it needs to go
into the actual patch, otherwise all the nice info doesn't make it into
the git repo.


Thanks,
Corinna
