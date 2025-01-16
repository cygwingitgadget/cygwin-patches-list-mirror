Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2F783384D146; Thu, 16 Jan 2025 18:51:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2F783384D146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737053486;
	bh=IACIMt4EIHQUxMxL/lJoXCXxMHRC1dNIx9gfUALD4kQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=P7ckJp82QFDETm9RGc0yLjqXMCon3mNPIy8uubkpk3/Vq6gm/FtZFfnvrfj8surmM
	 K60ft73JG4MAi7ZgFBmVUXFr2N9eCZz6m3jS9mln1BB1VrFCjbhcJRMEeLCkl/m5Ii
	 h5cZXYq8L+Cz7vAywfuT88PBhv2ZhXzJM851UPHI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8A272A80DAA; Thu, 16 Jan 2025 19:51:24 +0100 (CET)
Date: Thu, 16 Jan 2025 19:51:24 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 4/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 move or remove dropped entries
Message-ID: <Z4lVLGMwH4XfCtGO@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
 <6da73f73a786a556d4c7be93ed05bc50b268bb30.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6da73f73a786a556d4c7be93ed05bc50b268bb30.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan 15 12:39, Brian Inglis wrote:
> Move entries no longer in POSIX from the SUS/POSIX section to
> Deprecated Interfaces section and mark with (SUSv4).
> Remove entries no longer in POSIX from the NOT Implemented section.
> [...]
> @@ -1558,6 +1533,7 @@ ISO/IEC DIS 9945 Information technology
>      fegetprec
>      fesetprec
>      futimesat
> +    getdomainname		(NIS)

The hint doesn't make sense in the SUN/Solaris section.  I think this
should be moved to the BSD section since getdomainname was already
available on 4.2BSD.

> +<<<<<<< HEAD
>      isastream
> +=======
> +    kill_dependency		(not available in "stdatomic.h" header)
> +>>>>>>> 5888275d7f48 (Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 move or remove dropped entries)

Oops.


Corinna
