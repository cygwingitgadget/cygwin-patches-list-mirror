Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B6C533858D26; Mon, 24 Feb 2025 11:58:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B6C533858D26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1740398299;
	bh=oMD1NLQQkQX+u1zVKUoAdnsoKN5WaBokm1aMCRvAUWw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=icjwZzYdRHxXEi+N3jJ96WO+2LTwOXmgkhH92LPaLYqF1yLsKDx0hPLrApmlgKz/7
	 jgzageeAvYpKZhokNpkA5WmhqD73AD2o+7Oz1fdUhDKtkoPPZYo/u8jVg5v0vsMtGD
	 UmIVQRyaW9AWr4HGbtN7QTzvokGxjNCO+A5moxns=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B23C3A8052B; Mon, 24 Feb 2025 12:58:17 +0100 (CET)
Date: Mon, 24 Feb 2025 12:58:17 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add spawn family of functions to docs
Message-ID: <Z7xe2UNaIBB3UFXu@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250216214657.2303-1-mark@maxrnd.com>
 <Z7MNyLzVvY_Mm_bH@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7MNyLzVvY_Mm_bH@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Feb 17 11:22, Corinna Vinschen wrote:
> On Feb 16 13:46, Mark Geisert wrote:
> > In the doc tree, change the title of section "Other UNIX system
> > interfaces..." to "Other system interfaces...".  Add the spawn family of
> > functions noting their origin as Windows.
> > 
> > The title change seems warranted as neither the spawn family of
> > functions nor the listed clock_setres() function originated from UNIX
> > systems.
> > 
> > ---
> >  winsup/doc/posix.xml | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> Yeah, this is probably the right thing to do.  I'm jsut waiting
> for Brian in terms of the POSIX doc update.  That's why I wait with
> the eaccess and acl functions as well.

Actually, Jon raised some reservations against adding historical
msvcrt functions to the set of documented POSIX functions on the
IRC channel.

We also have functions like _get_osfhandle and stuff like that.
Do we really want them documented in the list of POSIXy functions?


Corinna
