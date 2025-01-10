Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 200383858D34; Fri, 10 Jan 2025 11:04:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 200383858D34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736507073;
	bh=qBIxE805aI7Y+VwyCeidmFQPbjl8VlprwVR9klbHF+w=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ZugekquQMxml2v2aQLT7JEEL85yza8i55jpsxo/zkevFRuVTLgfriUgkXiO9Byrsc
	 4q41fPLEx6AoMO9KpRA6VUix68D9UeJTojluHV0xnEj8CF5NuqKBBkTpkBb1QMtrTa
	 hUzcqUfmKy78UJ1GXsdLYzeKK4Gx/I6I1mMwYus8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 63620A80C3B; Fri, 10 Jan 2025 12:04:31 +0100 (CET)
Date: Fri, 10 Jan 2025 12:04:31 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/5] Cygwin: mmap: remove __PROT_FILLER and the
 associated methods
Message-ID: <Z4D-v8zTkkhlOh-k@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <dc8fa635-bc5e-4ef4-824a-0d2a73e838bc@cornell.edu>
 <Z4AcJx4KSdyMZ60i@calimero.vinschen.de>
 <b80e5b71-9656-4b11-a95d-89c54be1c657@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b80e5b71-9656-4b11-a95d-89c54be1c657@cornell.edu>
List-Id: <cygwin-patches.cygwin.com>

On Jan  9 15:25, Ken Brown wrote:
> On 1/9/2025 1:57 PM, Corinna Vinschen wrote:
> > Given we don't do filler pages because Windows doesn't let us anyway, we
> > could switch to 64K allocation_granularity() bookkeeping now, too.
> I'll take a look at doing that before I try to implement your suggestion
> about maintaining per page protection in an array.  I've got a lot going on
> at the moment, so this might take some time.

No worries.  Lately I had a look (again) into the MapViewOfFile3
function and the placeholder type of allocation, in the hope this
might allow us filler pages.  There's also the funny (and wrong)
description of MapViewOfFile3 on MSDN claiming

 "[in] ViewSize

  The number of bytes to map. A value of zero (0) specifies that the
  entire section is to be mapped.

  The size must always be a multiple of the page size."
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This doesn't match with how file-backed mappings are handled, but
grasping for straws, it gave me hope for the most part of a minute...


Corinna
