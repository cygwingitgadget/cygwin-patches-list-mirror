Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 64E373858432; Mon, 13 Jan 2025 11:00:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 64E373858432
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736766051;
	bh=yllqvXiFCiJTm+FPr12dH98pIWteb3VqmGq4GYc5FXU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=CRgapjVaYNJeeYBZqYg4J59Rc2JfcLBnnb/RNb7RoPZYeJ0ohGyqYOFaje6KJPvmk
	 23cc/v8qjasPQppqfLrsvUJCNzyhFiwyQxNruLzXH3RwVz5R+6Gp2KEY9x594X4VBM
	 IiSXlOVIw2khf65UT3fhA7k/J4N6o7wzqaqJXVN0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3A5ECA80A67; Mon, 13 Jan 2025 12:00:49 +0100 (CET)
Date: Mon, 13 Jan 2025 12:00:49 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: mmap: allow remapping part of an existing
 anonymous, mapping
Message-ID: <Z4TyYc2jPepx-rCn@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <a9ebb720-13a9-4903-adfb-ca0ff9a4d82d@cornell.edu>
 <9b717926-06fb-4d34-a473-a709316de429@cornell.edu>
 <Z32MB5VR4vCszv9J@calimero.vinschen.de>
 <de64c367-6695-4109-bbcb-591356a7470e@cornell.edu>
 <Z36Yr7cdOFXrWt2h@calimero.vinschen.de>
 <05430d18-35fd-4957-8277-5ae3077b3bf3@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <05430d18-35fd-4957-8277-5ae3077b3bf3@cornell.edu>
List-Id: <cygwin-patches.cygwin.com>

On Jan 11 18:43, Ken Brown wrote:
> On 1/8/2025 10:24 AM, Corinna Vinschen wrote:
> > On Jan  7 21:27, Ken Brown wrote:
> > > On 1/7/2025 3:18 PM, Corinna Vinschen wrote:
> > > > - mmap_record::prot flag, should be an array of protection bits per page
> > > >     (POSIX page i e., 64K, not Windows page).
> > > 
> > > Question: Since it only takes 3 bits to store all possible protections, do
> > > you think it's worth the trouble to pack the protections, so that each byte
> > > stores the protection bits for 2 pages?  Or should I just use an array of
> > > unsigned char, with 1 byte for each page?  Or did you have something else in
> > > mind?
> > 
> > I hadn't thought deeply about this.  I had a vague notion of a ULONG
> > array to match windows protection bits, but, as you note above, we
> > really only need 3 bits.
> > 
> > I don't think we have to define this as a bit field array, given this
> > isn't readily available in C and you would have to add bitfield
> > arithmetic by yourself.  So, yeah, a char or maybe better uint8_t
> > might be the best matching type here.
> Another question: Adding this array to mmap_record, we have two flexible
> arrays in the class: one for page_map and one for the protection array. My
> understanding is that a class or struct can have only one flexible array
> member, and it has to be at the end.  What's the best way to deal with that?
> The only thing I can think of is to use a pointer instead of an array for
> the protections, and then allocate memory for it separately when an
> mmap_record is created.  Or is there a better way?

Excellent question. Right now the page map is a bitwise array, one bit
per page.  From the top of my head I think the best way to deal with
that is to just change the existing page_map to a uint8_t per page and
store the mapping state in the upper bits and the protection in the
lower bits.

Alternatively, define a bitfield, kind of like this:

  struct {
    uint8_t	protection:3;
    uint8_t	mapped:1;
  } page_map[0];


Corinna
