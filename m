Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8360A3858D1E; Mon, 21 Jul 2025 09:36:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8360A3858D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753090610;
	bh=ngN7P9Hhd/Z4liUNyHjHZm6YifbgilO4nC3mQbmdb/E=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=tMaky6nMkgMpf9fg9i/IdbS7MyXbWO7w8Q0U4RP7rT8mECpxFby/wFIZCZ4P696OR
	 wtpgTdoFQB4SemPY//6ocIdB/ujaAGf13+I8ROH8nds2JuwQPciF0N/WwdmRUbJ4iQ
	 Lqx5fuParSQ3fOsph+CHTI8tas3TJIJPSUT1VD0A=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 95C41A80DCD; Mon, 21 Jul 2025 11:36:48 +0200 (CEST)
Date: Mon, 21 Jul 2025 11:36:48 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: doc: add note about raw devices of BitLocker
 partitions
Message-ID: <aH4KMO_UjlEtEfd8@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <2c6df85b-efd1-2209-5bf4-41d90b6d27db@t-online.de>
 <aHi1Wme5GNrCbYZl@calimero.vinschen.de>
 <80cf416c-6382-6a6a-a148-bd17829b40f9@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80cf416c-6382-6a6a-a148-bd17829b40f9@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Jul 18 17:24, Christian Franke wrote:
> Corinna Vinschen wrote:
> > On Jul 16 11:38, Christian Franke wrote:
> > > Another un?documented Windows behavior -- occasionally useful in this case
> > > :)
> > Ok.  Maybe as a <note>?
> > 
> 
> I'm not sure because unlike the other note nearby it is not a cautionary
> note. Alternative patch attached. Please vote :)

Yeah, on second thought... please push your original patch.


Thanks,
Corinna
