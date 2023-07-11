Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C6BF93857733; Tue, 11 Jul 2023 09:45:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C6BF93857733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689068705;
	bh=YyD1ujDKvrqow5P+m2joXgOXYLSp6hYm8slIzNug8gY=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=xknytSbzNVlUKawhj3O5SasdtwZF45jwXtX3oKDi8efvY+fRFTuRj+vwwn029v5EX
	 RNHiAz44gTr05F87Ky5Qqhp07/YFJbIRuNiC/FKlnSicJSn8JkRl2JQ0zWToXKOSW7
	 qDsPcRHJQcs7CjTVy/VXeQYf7/TdUTbT3KTHNHBk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E174DA80CC3; Tue, 11 Jul 2023 11:45:03 +0200 (CEST)
Date: Tue, 11 Jul 2023 11:45:03 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Where should relnote updates for Cygwin DLL patches be going?
Message-ID: <ZK0kn/p8lWKDWVBa@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.BSF.4.63.2307110101090.79963@m0.truegem.net>
 <ZK0Q/o0zIKHWCJtK@calimero.vinschen.de>
 <29a23afe-7b8f-bee9-a18f-ccf6e8a66991@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29a23afe-7b8f-bee9-a18f-ccf6e8a66991@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul 11 01:49, Mark Geisert wrote:
> Hi Corinna,
> 
> Corinna Vinschen wrote:
> > On Jul 11 01:05, Mark Geisert wrote:
> > > AIUI for cygwin-3_4-branch they currently go to release/3.4.8.
> > > For the main|master branch they currently go where?
> > 
> > release/3.5.0
> > 
> > An entry there is only necessary if it doesn't get picked for 3.4
> > anyway.
> 
> Ah, that helps me understand.
> 
> > > I hope to get it right the first time ;-).
> > 
> > Is the release model confusing?  If so, can you explain why?
> 
> I think I haven't been paying close enough attention and have been doing the
> relnote updates by rote.  But there being two active branches and I
> (understandably) don't determine which releases my commits go to means I
> should wait until they show up on the cvs-patches list, then I will know
> which relnote files to update.  That should work OK, right?
> 
> Is it preferred that relnote updates should be separate patches from the code updates?

The relnote may be a patch on its own in a series. And often is, given
that developers are not natural documenters :}

Theoretically it's preferred to be a patch on its own, because mixing
code and docs within the same patch often results in conflicts when
backporting or if it turns out that a patch has to be reverted.
Fortunately we don't have to maintain CVS Changelogs anymore...

However, if you're doing a bugfix of stuff which already *is* in the 3.4
branch (it's what others call the "stable" branch), then the idea is
that we fix it in the 3.4 branch.

For that, the patch goes into the main branch in the first place, then
it's cherry-picked into the 3.4 branch, and the relnote logically goes
into the current release file of the "not-yet-released" 3.4 version.

You can simply grep for CYGWIN_VERSION_DLL_MINOR in the file
winsup/include/cygwin/version.h in the 3.4 branch to see which release
message file is the right one at the moment.  If you do this now, you'll
get

  #define CYGWIN_VERSION_DLL_MINOR 8

Talking about conflicts.  There's always a (small!) chance that your
patch to main doesn't apply cleanly in the 3.4 branch due to other
patches already in the main branch. In that case you have to create two
versions of the patch, one for main, the other for 3.4.  Ideally the 3.4
backport contains a "Conflicts:" tag which explains why the backport
differs from it's sibling in main branch patch.  The relnote still goes
into the 3.4.x release file, though.


HTH,
Corinna
