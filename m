Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	by sourceware.org (Postfix) with ESMTPS id 4E002385840A
	for <cygwin-patches@cygwin.com>; Mon, 24 Oct 2022 11:37:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 4E002385840A
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MxV8b-1p2eEd1TIH-00xqYg for <cygwin-patches@cygwin.com>; Mon, 24 Oct 2022
 13:37:22 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EBCD0A80CFE; Mon, 24 Oct 2022 13:37:20 +0200 (CEST)
Date: Mon, 24 Oct 2022 13:37:20 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Allow deriving the current user's home directory
 via the HOME variable
Message-ID: <Y1Z48Mdk79/Qtwc9@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com>
 <cover.1450375424.git.johannes.schindelin@gmx.de>
 <047fe1d78c365afca7edfdf169fff5e1940c3837.1450375424.git.johannes.schindelin@gmx.de>
 <20151217202023.GA3507@calimero.vinschen.de>
 <1r1pq0r7-o3s3-so08-o426-296542797q94@tzk.qr>
 <Y07cOhhwu4ExRDzb@calimero.vinschen.de>
 <0q096627-r8pr-rno5-0863-s6n90psosq07@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0q096627-r8pr-rno5-0863-s6n90psosq07@tzk.qr>
X-Provags-ID: V03:K1:Bd7UtGjeURWNWMTRQrHTaHeYXRRM8ajqR3RlehbVcxZY/13I7xQ
 6KjHlLfq6FU37e8F4dSncolpBB/Lk8eGbnlfEXD+oDFHrFxvBIeyDNIdr+GdsD9t2y2Dtpp
 s4XgCBjt1iiWuV4KjofAE0TIFq9zWHvxnTvt72RpES38nscpzcKNcaqHs4vMo1/2jvEgRCa
 3J7ppMCqfmEHiAt4D2Aag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hYPQi+E5hmY=:AzauJOJocW1ZGtKUc28mtQ
 jEW/ytngUH+JmSAy3jMoSeUfRAL0w9EdzXandtnZ95wRd1DfG37xnMh08fhOEVQjXy/Lltn0Q
 r5APemOYtGsPeX70wZtwh6JeCjdU0KHQzhFPoeGMFIZTS3/g4PjCRHvcHuC+umb52a/OgYFZ5
 uJAbUv8EkAz6rTSye6Hf3hWHPYLgALLcc7nS6SfGdkZsfle519HK9rbFdR3SBzT2Sx887DrvK
 c87OscKPq3UBJ6qsyN4O4vByKTIwg57Diw8lxV8MK2/7mVMz97XNI8lxKEa88CufEDasOlkco
 XA+BIEnzcw4O/80Rj5OC9rVFH+42CSBUQL/Pg2ZbEw0A4+DKWVV2kklC/E9rIIL0Vs4ifItSK
 mj3CAAv+zdln8eYSv6PBzCkC2dx+HDcB0qn+fpZqWVlgVKZm91GbvE1YTTYbEvSU88o12LD5G
 dlYnstL+kVUcsSvlRIpk7+HNCa1hjjD7Sz5txZ7SWG8c54tbRT1a3q5vvuYqd26X9ZxVc14Oz
 bepmaElnmB2wC1bCeruVi5jU4fIPu5UZQtueEXLxmBnl0QgrxUtqX1ECva0Ih7toF0GvapkBr
 npa8UP6S/9r05SibAkomOxfV/IHY1cwdfVnzEHFzCrBWXSsfL+ZJexkS4VNIebnVraxzWmCY7
 k08x+uyPDxzqlBzJvqGZ3RbSdYiQy4D3O05xLB0dDhMvIlb1E2WBhyTmMf5321vgRrhTwlnVh
 TbN4nBbksYcAzzZQd6yirBclHrdNFbSRSlGBIAdVI0mVFAnnV1+BUBkxmiZPnmUGYIDzrTiNM
 vDsOJttdYFGFqyuVsbnCrTQdeEGYA==
X-Spam-Status: No, score=-95.5 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Oct 23 23:04, Johannes Schindelin wrote:
> On Tue, 18 Oct 2022, Corinna Vinschen wrote:
> [...]
> > That means, the results from the "env" method is equivalent to the
> > "windows" method, just after checking $HOME.  That's a bit of a downer.
> >
> > Assuming the "env" method would *only* check for $HOME, the user would
> > have the same result by simply setting nsswitch.conf accordingly:
> >
> >   home: env windows
> 
> Except when the domain controller is (temporarily) unreachable, e.g. when
> sitting in a train with poor or no internet connection. Then that latter
> approach would have the "benefit" of having to wait 10-15 seconds before
> the network call says "nope".
> 
> This particular issue has hit enough Git for Windows users that I found
> myself being forced to implement these patches and run with them for the
> past seven years.
> 
> Given the scenario of an unreachable domain controller, I hope you agree
> that the `env` support added in the proposed patches _has_ merit.

Yes, I don't doubt an `env' method checking for $HOME even a bit.

I'm just not sure as far as HOMEDRIVE/HOMEPATH/USERPROFILE are
concerned.  Those vars should be left alone, but we can't control that,
so reading them from genuine sources is preferred.

Sure, the downside in terms of the LDAP server is clear to me

So I guess it's ok to allow the env method to read the values of those
vars from the env.  I would just feel better if we urge the
user to set $HOME and read that exclusively.


Corinna
