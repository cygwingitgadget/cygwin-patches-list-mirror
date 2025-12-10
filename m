Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 16FDE4BA2E00; Wed, 10 Dec 2025 19:48:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 16FDE4BA2E00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1765396102;
	bh=goeZx/DPIc0ik6jEDWdKjpge+1VgqvQVdjCYhR8HKOQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=PJIZGIqIxfMzsF+LbjGXVonlxOG74lUoBlKkvHSnplhcftfw5as47fyvj+r++OUlq
	 5Xumnpzk4KZhxQSukcB23LcJMvSA0Y2Ljol6T9ohHko7Knm+L1iA7XU2a6Ka+FC1Oz
	 +l9iDGmwUjLdZnOxq7oCgcjGc5JIxDFNHULtf3gI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 98681A80D1A; Wed, 10 Dec 2025 20:48:19 +0100 (CET)
Date: Wed, 10 Dec 2025 20:48:19 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/3] Cygwin: newgrp(1): fix POSIX compatibility
Message-ID: <aTnOg24ThxuPNRIQ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251210173201.193740-1-corinna-cygwin@cygwin.com>
 <67ef9614-59ec-49b9-ad75-6117e0e3b643@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67ef9614-59ec-49b9-ad75-6117e0e3b643@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Dec 10 19:34, Jon Turney wrote:
> On 10/12/2025 17:31, Corinna Vinschen wrote:
> > From: Corinna Vinschen <corinna@vinschen.de>
> > 
> > As outlined in the thread starting at
> > https://cygwin.com/pipermail/cygwin/2025-December/259055.html,
> > newgrp(1) didn't allow numerical group IDs.  While this is in line with
> > the shadow-utils version of newgrp(1), it's not what POSIX allows.
> > Fix up the code and the documentation to be more in line with POSIX.
> > 
> > Corinna Vinschen (3):
> >    Cygwin: newgrp(1): improve POSIX compatibility
> >    Cygwin: doc: utils.xml: improve newgrp(1) documentation
> >    Cygwin: add release note for newgrp(1) fixes
> > 
> >   winsup/cygwin/release/3.6.6 |  3 +++
> >   winsup/doc/utils.xml        | 27 ++++++++++++++++-----------
> >   winsup/utils/newgrp.c       | 30 ++++++++++++++++++++----------
> >   3 files changed, 39 insertions(+), 21 deletions(-)
> 
> This is good. No notes :)

Thanks, pushed.


Corinna
