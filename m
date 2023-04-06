Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	by sourceware.org (Postfix) with ESMTPS id 3EAD23858C1F
	for <cygwin-patches@cygwin.com>; Thu,  6 Apr 2023 10:28:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3EAD23858C1F
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MrxfX-1qEDV03rzp-00o12I for <cygwin-patches@cygwin.com>; Thu, 06 Apr 2023
 12:28:35 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2507EA80C68; Thu,  6 Apr 2023 12:28:35 +0200 (CEST)
Date: Thu, 6 Apr 2023 12:28:35 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 4/4] Do not rely on `getenv ("HOME")`'s path conversion
Message-ID: <ZC6e00dkKQeOgpNh@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1680532960.git.johannes.schindelin@gmx.de>
 <cover.1680620830.git.johannes.schindelin@gmx.de>
 <8ac1548b9216b5b014947bb3278f9c647103fa91.1680620830.git.johannes.schindelin@gmx.de>
 <ZC6EwQgygFo/GkNL@calimero.vinschen.de>
 <097f16c8-9df1-4dad-6eb4-30fe090c9f05@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <097f16c8-9df1-4dad-6eb4-30fe090c9f05@gmx.de>
X-Provags-ID: V03:K1:hQ36UhNj04slkYzPtO2SlVmeUARDKfXGz5IPExWFB0oFIt+Sc4+
 K4Y7E+85DtXm4CKf3tUWcdfAM3MwxcCwlcESHU+e3fkA7YemBZQbEhGHTH5ZU+D/GnPzw1b
 +9Jud85zvJA+1IJv8htrDSfEHs7D5UT5CJ/tZaFLMjBXh2mSoLtGtM8IN7ZYwq2i7v5S9gV
 ut2yZxH4EHhq/08heKZ1g==
UI-OutboundReport: notjunk:1;M01:P0:vguNVG6mGeE=;i2aB1E/Q7Cyqw/EYxlT9SZuFDOl
 HvrZQBXec+Mm6NHBXW+8POV+m2x4pX2NhSXqxAVdu0yS/kR1qbRNyyj1noDvLg2RZ9+E91TJ6
 bqHhljEmQWHit60TAl8WvHVzDf/IrJWxs0qGHYHzKOi/CWZVMHwRVVdVx6mhyvq9Oku0oD+9e
 NvgymY8zQXFI16GG42dHORz1u7olcpShYnndJKCLRM+KDMMmbhwPNqtngUp2FqY+TJyiA/VHe
 8OcQdUFVz9ihFWENyvVgkKrfnJ0bH0PG4PMEKTdF/bp9IkTPt4eOi1vXQA6gAXs3dLB3bLozW
 Kq2H8EfNVRt/m5Pi24juYgKZzUkKRKWzM62AbQ5GnZADnsAvjR1Fz8DaRY9eblg1sfV1+FYjw
 xkXpyf54Aasjvm6u85FbTya/Avgsyyto7Tjyg6NNbXeGnSBoPciXtPim0WDvqtp7PhxS4DSAN
 9s+Qd2iBG5u9bUxSDJj3kJqvPDxFVB67qbgmU0J1iZ63Ygy0H0QRnIBH7pjXRNLM4TnV9Ztjf
 guupcVsAWXQIdU4hRGZUaETBJyVD1uMrWuSHK1j9ScL6FulXCYRAUIUHyHbfJL0xH5Oik7adL
 EWoO7iZkcd/dpAb1/qe7Cp3mo1R9i6+Q2rwZwgpWKQ5YqbkexaBNocgsAM9Fi2ToHsiYtt7Fv
 luUR4RU3FtxDCW2TrASMbCg6AKFHtTsbuwflhpIYpw==
X-Spam-Status: No, score=-97.8 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Apr  6 11:54, Johannes Schindelin wrote:
> On Thu, 6 Apr 2023, Corinna Vinschen wrote:
> > While the description is clear on the colon problem, shouldn't this
> > catch UNC paths as well?  I. e., just check for strchr(home, '\\')?
> 
> Good idea! I do not know off-hand how well things work when `HOME` is an
> UNC path, but we can fix those things when (and if) they arrive.
> 
> I'll use `isdrive (home) || home[0] == '\\'` as is used elsewhere, okay?

I was thinking of simplifying this to the strchr test for backslash
because all paths with a backslash are handled as Windows paths.
Without actually checking the source, I'd guess the above is checking
for an absolute path in the first place.  Hopefully everybody is
aware that HOME should be a full path... :)

But yes, your above expression is ok, too.


Corinna
