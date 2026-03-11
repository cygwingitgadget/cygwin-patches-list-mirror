Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2E5564BB5883; Wed, 11 Mar 2026 20:04:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2E5564BB5883
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1773259478;
	bh=URtNFbQ/1d43q+kTDyvZ3zshivpvknonVcsMsVNFH6o=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=MMtfmSnbLfSN1tRxc4Eps/C0U2w3ofOf7Ln/YgDzulu9WQ5OVlEiorKvwSeerLj3g
	 k5ltkL7uXb3G0i+UQjuDiiLa9JmRNL7pSMUWPRWFqm3dDdCceTpGfVyeXCMWBOlTP+
	 O1HZuCnErK0RwnG0hK8vauMkLhcVEeMk4Q98MvlQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0B603A80C14; Wed, 11 Mar 2026 21:04:36 +0100 (CET)
Date: Wed, 11 Mar 2026 21:04:35 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: HYPER-V VMs: Cygwin /bin/getent group 'Virtual Machines' cannot
 find the group
Message-ID: <abHK08sEpyuTN-_w@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CANH4o6P07DG5XcSooXkAE5ShWkkz1hVBSMn6k2iaLycSEEA_0A@mail.gmail.com>
 <CA+1jF5oHw71rv-OH893R+DdNpnRUQAtp=WS_fXvxe1WBsC0H6w@mail.gmail.com>
 <abGHUBD2oHK6bo5K@calimero.vinschen.de>
 <be24eeb3-bf47-4636-ae7f-f1a8d6ec0417@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be24eeb3-bf47-4636-ae7f-f1a8d6ec0417@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Mar 11 11:11, Brian Inglis wrote:
> On 2026-03-11 09:16, Corinna Vinschen via Cygwin wrote:
> > Done in the main branch.
> 
> Are these default behaviour with other builtin symbols, or do they need
> enabled with a db_enum value?

They are not enumerated and they really don't have to be.

> Why not also use the ..._ID_BASE_RID symbols rather than unobvious arg.id
> hex value comparisons, to tie the comparisons together consistently?

Yeah, I missed that, I could have used SECURITY_VIRTUALSERVER_ID_BASE_RID
in this place, too.  Thanks for pointing this out.

> The other arg.id hex value comparisons could also do with similar treatment;
> are there any missing value symbols, do you know?

I don't know. They were partially missing once in the mingw-w64 headers.

You can't do that with the SECURITY_*_AUTHORITY values because those
are arrays with all members but the last one having a meaning.

I still don't get why the SIDs have to be *that* complicated...

> So are PTC with any advice if SHTDI?

Yes, but no advice.  It's just a kind of diligence job, fetch the value
from w32api/winnt.h and use it, isn't it?


Corinna
