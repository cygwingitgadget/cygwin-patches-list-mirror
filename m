Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 175EE385DDF6; Wed, 15 Jan 2025 11:42:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 175EE385DDF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736941344;
	bh=MBTOvNUvte2M9BRf4KjmTAT1WulyA6lEPDszEE7CN10=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Rm/t6k0004cTU4MQOrjvbSIa2mq3J8xpGcm+7csgnE6to/228LkQrth5Ki9YRVPyk
	 loFaFSjWjTOXT/Xu89cO+VmcGQIkPbRj0v7TL1XVrtWZJ7weQZ0KVESYeOpwmwPGtW
	 mXBSbEFZ9eNDa+k8CzvvSp2TfN6GCnBdeYS2X+TM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6200EA80D2F; Wed, 15 Jan 2025 12:42:22 +0100 (CET)
Date: Wed, 15 Jan 2025 12:42:22 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: mmap: allow remapping part of an existing
 anonymous, mapping
Message-ID: <Z4efHkMExl3Npx0m@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <a9ebb720-13a9-4903-adfb-ca0ff9a4d82d@cornell.edu>
 <9b717926-06fb-4d34-a473-a709316de429@cornell.edu>
 <Z32MB5VR4vCszv9J@calimero.vinschen.de>
 <de64c367-6695-4109-bbcb-591356a7470e@cornell.edu>
 <Z36Yr7cdOFXrWt2h@calimero.vinschen.de>
 <05430d18-35fd-4957-8277-5ae3077b3bf3@cornell.edu>
 <Z4TyYc2jPepx-rCn@calimero.vinschen.de>
 <1376bc44-bd98-4bda-b599-3ce4b6ed1bb9@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1376bc44-bd98-4bda-b599-3ce4b6ed1bb9@cornell.edu>
List-Id: <cygwin-patches.cygwin.com>

On Jan 13 17:36, Ken Brown wrote:
> On 1/13/2025 6:00 AM, Corinna Vinschen wrote:
> > On Jan 11 18:43, Ken Brown wrote:
> > > Another question: Adding this array to mmap_record, we have two flexible
> > > arrays in the class: one for page_map and one for the protection array. My
> > > understanding is that a class or struct can have only one flexible array
> > > member, and it has to be at the end.  What's the best way to deal with that?
> > > The only thing I can think of is to use a pointer instead of an array for
> > > the protections, and then allocate memory for it separately when an
> > > mmap_record is created.  Or is there a better way?
> > 
> > Excellent question. Right now the page map is a bitwise array, one bit
> > per page.  From the top of my head I think the best way to deal with
> > that is to just change the existing page_map to a uint8_t per page and
> > store the mapping state in the upper bits and the protection in the
> > lower bits.
> > 
> > Alternatively, define a bitfield, kind of like this:
> > 
> >    struct {
> >      uint8_t	protection:3;
> >      uint8_t	mapped:1;
> >    } page_map[0];
> Thanks.  Both of these ideas are better than what I had in mind.  By the
> way, I forgot about __PROT_ATTACH when I said we need 3 bits for the
> protection, so it's actually 4 bits.  If I decide to use your first
> suggestion, those 4 bits would have to be consecutive.  I assume it's OK to
> redefine __PROT_ATTACH to be 8 rather than 0x8000000?  Or is there some
> reason that would be bad?

Not at all.  The value was chosen arbitrarily.


Corinna
