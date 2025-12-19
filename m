Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E097F4BA2E05; Fri, 19 Dec 2025 16:04:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E097F4BA2E05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766160271;
	bh=tvzS6zKEpqWapkR8kMvxj/rDdC2sTEH+Ms56ebS4biQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=BCJxGtTKShcJkDiClqJObYH/97/LYVuzjihZ2pb8bWlbpfDyiL3iXj1WUEZClaopW
	 7gg+geN9z/pmXj7Syr5j4zG2Ei8NmWQ3f7qM6A5OA9K2f/ZytkOyfIKMlqoB/boObD
	 arYv/jZlIf2Un53ZwTyCzhC52PmGD5MZRRV0Pbs4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 07938A80BEF; Fri, 19 Dec 2025 17:04:30 +0100 (CET)
Date: Fri, 19 Dec 2025 17:04:29 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/3] Cygwin: newgrp(1): fix POSIX compatibility
Message-ID: <aUV3jfJU8GXjydt9@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251210173201.193740-1-corinna-cygwin@cygwin.com>
 <20251219225313.c96ee56ee33537d51fdd3ce0@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251219225313.c96ee56ee33537d51fdd3ce0@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec 19 22:53, Takashi Yano wrote:
> Hi Corinna,
> 
> On Wed, 10 Dec 2025 18:31:58 +0100
> Corinna Vinschen wrote:
> > From: Corinna Vinschen <corinna@vinschen.de>
> > 
> > As outlined in the thread starting at
> > https://cygwin.com/pipermail/cygwin/2025-December/259055.html,
> > newgrp(1) didn't allow numerical group IDs.  While this is in line with
> > the shadow-utils version of newgrp(1), it's not what POSIX allows.
> > Fix up the code and the documentation to be more in line with POSIX.
> > 
> > Corinna Vinschen (3):
> >   Cygwin: newgrp(1): improve POSIX compatibility
> >   Cygwin: doc: utils.xml: improve newgrp(1) documentation
> >   Cygwin: add release note for newgrp(1) fixes
> > 
> >  winsup/cygwin/release/3.6.6 |  3 +++
> >  winsup/doc/utils.xml        | 27 ++++++++++++++++-----------
> >  winsup/utils/newgrp.c       | 30 ++++++++++++++++++++----------
> >  3 files changed, 39 insertions(+), 21 deletions(-)
> > 
> > -- 
> > 2.52.0
> > 
> 
> Shouldn't this patch series apply for cygwin-3_6-branch as well?
> I'm asking because these paches are not cherry picked in to
> cygwin-3_6-branch, but documented in release/3.6.6.

Oops, right.  Thanks for letting me know, pushed!


Corinna
