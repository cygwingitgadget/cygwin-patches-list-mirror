Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4216F3858031; Fri, 16 Jun 2023 19:49:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4216F3858031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1686944969;
	bh=kVZ657I5NztOBx/JobGxAr3qHLTM/tBHEchma4d8UmY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=bAm/Ife27yiDMvvK5KFYAsqnIVRV0uOTVxug8f5Xi01Hp1264OFn1HCxr9VK4lOYx
	 ytiss/4G30WLdcTtWzHUbsPIDh95pQ1xzpsAIfmkPOtnf7k03ayzGqjowcJL9ixC5D
	 Aod7T2KsNldPSQTvo264iBUKgcOHCi5sM9CekUoQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 7ED79A80940; Fri, 16 Jun 2023 21:49:27 +0200 (CEST)
Date: Fri, 16 Jun 2023 21:49:27 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Philippe Cerfon <philcerf@gmail.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] include/cygwin/limits.h: add XATTR_{NAME,SIZE,LIST}_MAX
Message-ID: <ZIy8x7cxIQhTmO9U@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Philippe Cerfon <philcerf@gmail.com>,
	cygwin-patches@cygwin.com
References: <CAN+za=MhQdD2mzYxqVAm9ZwBUBKsyPiH+9T5xfGXtgxq1X1LAA@mail.gmail.com>
 <f4106af5-ed7a-0df5-a870-b87bb729f862@Shaw.ca>
 <ZH4yDkPXLU9cYsrn@calimero.vinschen.de>
 <CAN+za=MTBHNWV+-4rMoBb_zefPO7OG2grySUFdV-Eoa2aQg_uw@mail.gmail.com>
 <ZH80lgpsfWwCZp+R@calimero.vinschen.de>
 <CAN+za=NXXrn_atWyWi4zUgELkhvm5qecB-hQYFJ7Q4bdFHopFA@mail.gmail.com>
 <ZIBWqTEkn9c9GWfF@calimero.vinschen.de>
 <CAN+za=NjpooX1JrwbgDgX8yzHkn6AwtYH8yCOjzkUspMZd1W6g@mail.gmail.com>
 <ZIx55su+P5zInrqa@calimero.vinschen.de>
 <CAN+za=P4Ra6-4Hc6P1HVODT3B5JtrJvV7bFWt-PkOeiawr=4NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN+za=P4Ra6-4Hc6P1HVODT3B5JtrJvV7bFWt-PkOeiawr=4NQ@mail.gmail.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 16 17:43, Philippe Cerfon wrote:
> Hey.
> 
> On Fri, Jun 16, 2023 at 5:04 PM Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > Oh well. Now that I see it in real life, my idea to use the entire
> > expression inline wasn't that great, it seems...
> 
> ^^
> 
> 
> > I didn't want to keep MAX_EA_NAME_LEN because now that we have an
> > official name for the value, having an unofficial name using a different
> > naming convention is a bit weird.
> >
> > On the other hand, having a macro for the expression certainly looks
> > much cleaner.  Also, only one place to change (should a change ever be
> > necessary).
> 
> Does both make sense.
> 
> 
> > Sorry about that.
> 
> No worries :-)
> 
> 
> > What do you think about something like _XATTR_NAME_MAX_ONDISK_?
> 
> Really with trailing/leading underscores? If you try to keep it out of
> the "official namespace", then I'd would perhaps make more sense to
> mark this as being cygwin specific like CYGWIN_XATTR_NAME_MAX_ONDISK
> or so?
> Also - may be nitpicking - but storage is not really guaranteed to be
> a disk anymore. Maybe ONSTORAGE instead? But admittedly ONDISK sounds
> more common ("on disk format", etc.).

You're right, of course.  Disk is just like everyone talks about it.
Even a SSD has "disk" in it's name :)

> > I can also just push the patches and we discuss this further afterwards,
> > your call.
> 
> Well you know the naming convention used in your code much better than I do.
> 
> Attached patches use _XATTR_NAME_MAX_ONDISK_ as you proposed.
> 
> Just pick whichever name you like best, and either tell me and I
> provide a new patch, or just sed 's/_XATTR_NAME_MAX_ONDISK_/foobar/g'
> (+ maybe align text wrapping of comments if necessary).

Let's keep it at that.  I pushed your patchset.


Thanks!
Corinna
