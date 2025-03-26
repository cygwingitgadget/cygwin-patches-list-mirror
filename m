Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 07D1E3857032; Wed, 26 Mar 2025 09:33:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 07D1E3857032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1742981631;
	bh=5YgUuiptBwN2b0X9Sf355ZjRCrvDBYi2eb9j3mbKX2Y=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Z1fZzr6abxDdW4pPxuKu0s6xcCgVPLAzrLi8D0gfcBpE9W1t9gwrC++u+H1hKMEQI
	 fMrg1M0g8m1JZg0btyUUAgAKRAnoqI8X/i8V/4Fp7I+i0VpObi2AZ6gZgooAIM8+Cc
	 fgwAJ/MTH7CgiSgpG/A/ljGVRjSBeYBt/pOeUVUo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DEFB8A8067E; Wed, 26 Mar 2025 10:33:48 +0100 (CET)
Date: Wed, 26 Mar 2025 10:33:48 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: thread: Allow fast_mutex to be acquired multiple
 times.
Message-ID: <Z-PJ_IvVeekUwYAA@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250324055340.975-1-takashi.yano@nifty.ne.jp>
 <Z-E6groYVnQAh-kj@calimero.vinschen.de>
 <20250324220522.fc26bee8c8cc50bae0ad742b@nifty.ne.jp>
 <Z-F7rKIQfY2aYHSD@calimero.vinschen.de>
 <20250326181404.847ecfadcad8977024580575@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250326181404.847ecfadcad8977024580575@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Mar 26 18:14, Takashi Yano wrote:
> Hi Corinna,
> 
> On Mon, 24 Mar 2025 16:35:08 +0100
> Corinna Vinschen wrote:
> > On Mar 24 22:05, Takashi Yano wrote:
> > > Hi Corinna,
> > > 
> > > On Mon, 24 Mar 2025 11:57:06 +0100
> > > Corinna Vinschen wrote:
> > > > I wonder if we shouldn't drop the keys list structure entirely, and
> > > > convert "keys" to a simple sequence number + destructor array, as in
> > > > GLibc.  This allows lockless key operations and drop the entire list and
> > > > mutex overhead.  The code would become dirt-easy, see
> > > > https://sourceware.org/cgit/glibc/tree/nptl/pthread_key_create.c
> > > > https://sourceware.org/cgit/glibc/tree/nptl/pthread_key_delete.c
> > > > 
> > > > What do you think?
> > > 
> > > It looks very simple and reasonable to me.
> > > 
> > > > However, for 3.6.1, the below patch should be ok.
> > > 
> > > What about reimplementing pthread_key_create/pthread_key_delete
> > > based on glibc for master branch, and appling this patch to
> > > cygwin-3_6-branch?
> > > 
> > > Shall I try to reimplement them?
> > 
> > That would be great!
> 
> What about the patch attached?
> Is this as you intended?

Yes!

>  private:
> -  static List<pthread_key> keys;
> +  int key_idx;
> +  static class keys_list {
> +    ULONG seq;

GLibc uses uintptr_t for the sequence number to avoid overflow.
So we could use ULONG64 and InterlockedCompareExchange64 here, too.

Looks good to me, thanks!


Corinna
