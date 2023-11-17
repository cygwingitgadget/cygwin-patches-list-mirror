Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7E3E03858CD1; Fri, 17 Nov 2023 19:40:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7E3E03858CD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1700250011;
	bh=hHeXvZvQgCogDb0CGA9BxjjiXw72zCTBhH+DPbhpPnU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=RLznYeZrgPd8w1zqzk1JaLJGjmkLuAEsYJ+x9qnulvnSABIJ6x6P3e8Vv9G7zV4WN
	 zZMnqtOkTr2hpTKSDeGq2qHgiTAoHNO3H7oS5W78G6LzlvqKdj20RH2UuqWyBkYvwy
	 RHoAorWIWWJgWGnlYjkjPXh1VMqYAvbMUbd1cu5Y=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CF37CA806D4; Fri, 17 Nov 2023 20:40:09 +0100 (CET)
Date: Fri, 17 Nov 2023 20:40:09 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-label and /dev/disk/by-uuid
 symlinks
Message-ID: <ZVfBmQiTGOjx14lW@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9c82a61c-02f8-a679-90f2-90e853d47e53@t-online.de>
 <ZVeTfEHgbgLJKFpU@calimero.vinschen.de>
 <57fb24ee-cd4c-0b54-6613-40f817e12571@t-online.de>
 <ZVeZhRmrMlbK7qkz@calimero.vinschen.de>
 <d74801f8-45fb-6a66-cc92-8f021f58c53b@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d74801f8-45fb-6a66-cc92-8f021f58c53b@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov 17 18:53, Christian Franke wrote:
> Corinna Vinschen wrote:
> > On Nov 17 17:45, Christian Franke wrote:
> > > Corinna Vinschen wrote:
> > > > On Nov 17 15:39, Christian Franke wrote:
> > > > > The last two /dev/disk subdirectories :-)
> > > > > 
> > > > > Note a minor difference: On Linux, empty /dev/disk subdirectories apparently
> > > > > never appear. A subdirectory is not listed in /dev/disk if it would be
> > > > > empty. Not worth the effort to emulate.
> > > > Agreed.  This is really great.  I just pushed your patch.
> > > > 
> > > > However, there's something strange in terms of by-label:
> > > > 
> > > > I have two partitions with labels:
> > > > 
> > > >     $ ls -l /dev/disk/by-label
> > > >     total 0
> > > >     lrwxrwxrwx 1 corinna vinschen 0 Nov 17 17:18 blub -> ../../sda3
> > > >     lrwxrwxrwx 1 corinna vinschen 0 Nov 17 17:18 blub2 -> ../../sdb2
> > > >     $
> > > > 
> > > > Now I change the label of sdb2 to the same "blub" string as on sda3:
> > > > 
> > > >     $ ls -l /dev/disk/by-label
> > > >     total 0
> > > >     $
> > > > 
> > > > I'd expected to see only one, due to the name collision, but en empty
> > > > dir is a bit surprising...  And it may occur more often than not, given
> > > > that the default label "New_Volume" probably won't get changed very
> > > > often.
> > > > 
> > > This is intentional and inherited from the very first patch, see the loop
> > > behind qsort(). If a range of identical names appear, all these entries are
> > > removed. If some "random" entry would be kept, it might no longer be the
> > > persistent link the user expects. We could possibly add some hash like done
> > > for by-id or append a number in such cases later. Need some more time to
> > > thing about it....
> > I see.  Admittedly, I don't know how Linux handles this either.
> 
> A quick test on Debian 12 with by-label suggests that the last duplicate
> wins. Also not very sophisticated :-)

Given this is all controlled by rather simple udev rules, see
/usr/lib/udev/rules.d/60-persistent-storage.rules, that's not
really surprising.

> IIRC in the past I've seen in another of these directories (by-id?) that
> '#N' was appended if duplicates occur.

I don't see anything like that in 60-persistent-storage.rules, though.
It has been removed at one point, it seems.

> > > I will sent a patch for the new-features doc soon.
> 
> Attached.

Thanks, pushed.


Corinna
