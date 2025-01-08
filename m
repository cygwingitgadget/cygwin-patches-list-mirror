Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C2F5B3858D29; Wed,  8 Jan 2025 15:24:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C2F5B3858D29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736349874;
	bh=yXQljbzud8do8aCgYkxfsDBE0TFTt9xGeQdOiTEd9jY=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=SOovEAjDjUL+qpmTqY022M8FtSx7wr/kYzA6gn3BqxfdvMSRvXkfBUv3WnfNSSxJf
	 iPENMn5A9jTgenTthOSWncEzh3KCoK5NIzQ5T2yXivzHqc5s7/zZbrUHGCUH+TRTqE
	 DvPCNvni0/bB6U18cSDwHGiRhG/W2uZerVF11eVQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8A73DA805BC; Wed,  8 Jan 2025 16:24:31 +0100 (CET)
Date: Wed, 8 Jan 2025 16:24:31 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: mmap: allow remapping part of an existing
 anonymous, mapping
Message-ID: <Z36Yr7cdOFXrWt2h@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <a9ebb720-13a9-4903-adfb-ca0ff9a4d82d@cornell.edu>
 <9b717926-06fb-4d34-a473-a709316de429@cornell.edu>
 <Z32MB5VR4vCszv9J@calimero.vinschen.de>
 <de64c367-6695-4109-bbcb-591356a7470e@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de64c367-6695-4109-bbcb-591356a7470e@cornell.edu>
List-Id: <cygwin-patches.cygwin.com>

On Jan  7 21:27, Ken Brown wrote:
> On 1/7/2025 3:18 PM, Corinna Vinschen wrote:
> > - mmap_record::prot flag, should be an array of protection bits per page
> >    (POSIX page i e., 64K, not Windows page).
> 
> Question: Since it only takes 3 bits to store all possible protections, do
> you think it's worth the trouble to pack the protections, so that each byte
> stores the protection bits for 2 pages?  Or should I just use an array of
> unsigned char, with 1 byte for each page?  Or did you have something else in
> mind?

I hadn't thought deeply about this.  I had a vague notion of a ULONG
array to match windows protection bits, but, as you note above, we
really only need 3 bits.

I don't think we have to define this as a bit field array, given this
isn't readily available in C and you would have to add bitfield
arithmetic by yourself.  So, yeah, a char or maybe better uint8_t
might be the best matching type here.


Thanks,
Corinna
