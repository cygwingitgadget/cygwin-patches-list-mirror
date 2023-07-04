Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D8D313858D35; Tue,  4 Jul 2023 14:55:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D8D313858D35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1688482537;
	bh=L1lTuWg7f2PsHaoz/U7FMdU7r3QKO6Hp2zgYk0q9mZU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=jRLFNS0H0lbrBxKuaHs95asO0unWSIHMfK6A4uWdntt1OoSjXnSan+bV3YIiSltEJ
	 2w4Xp/FreUyvBiVkd97/NMxSwMzwDpqHIfAVqykuLQfloZg8qBJlzGJTBMrK5xYkY5
	 o7yYU4wVenOYo24bkMKu5jhTKqQ9c9Tk2hMwxtJ0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 05E66A80F7A; Tue,  4 Jul 2023 16:55:36 +0200 (CEST)
Date: Tue, 4 Jul 2023 16:55:35 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Make <sys/cpuset.h> safe for c89 compilations
Message-ID: <ZKQy5w2OlDmv/5iF@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230704005141.5334-1-mark@maxrnd.com>
 <ZKQtr5+C7B+gLQtT@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZKQtr5+C7B+gLQtT@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Jul  4 16:33, Corinna Vinschen wrote:
> On Jul  3 17:51, Mark Geisert wrote:
> > Four modifications to include/sys/cpuset.h:
> > * Change C++-style comments to C-style also supported by C++
> > * Change "inline" to "__inline" on code lines
> > * Add "#include <sys/cdefs.h>" to make sure __inline is defined
> > * Don't declare loop variables on for-loop init clauses
> > 
> > Tested by first reproducing the reported issue with home-grown test
> > programs by compiling with gcc option "-std=c89", then compiling again
> > using the modified <sys/cpuset.h>. Other "-std=" options tested too.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin-patches/2023q3/012308.html
> > Fixes: 315e5fbd99ec ("Cygwin: Fix type mismatch on sys/cpuset.h")
> > Signed-off-by: Mark Geisert <mark@maxrnd.com>
> > 
> > ---
> >  winsup/cygwin/include/sys/cpuset.h | 49 ++++++++++++++++--------------
> >  winsup/cygwin/release/3.4.7        |  3 ++
> >  2 files changed, 30 insertions(+), 22 deletions(-)
> 
> Pushed.

FYI, I missed to notice that you added the release message to the
already existing 3.4.7 release.  I moved it into a new file for 3.4.8.


Corinna
