Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	by sourceware.org (Postfix) with ESMTPS id AECD33858D20
	for <cygwin-patches@cygwin.com>; Thu, 10 Nov 2022 15:22:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org AECD33858D20
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1McH1Q-1pPBsO1GM0-00ckn9 for <cygwin-patches@cygwin.com>; Thu, 10 Nov 2022
 16:22:20 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D9A6AA810AF; Thu, 10 Nov 2022 16:22:19 +0100 (CET)
Date: Thu, 10 Nov 2022 16:22:19 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Allow deriving the current user's home directory
 via the HOME variable
Message-ID: <Y20XK4VybCriMmn/@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com>
 <cover.1450375424.git.johannes.schindelin@gmx.de>
 <047fe1d78c365afca7edfdf169fff5e1940c3837.1450375424.git.johannes.schindelin@gmx.de>
 <20151217202023.GA3507@calimero.vinschen.de>
 <1r1pq0r7-o3s3-so08-o426-296542797q94@tzk.qr>
 <Y07cOhhwu4ExRDzb@calimero.vinschen.de>
 <0q096627-r8pr-rno5-0863-s6n90psosq07@tzk.qr>
 <Y1Z48Mdk79/Qtwc9@calimero.vinschen.de>
 <66o0nq89-4599-np26-625n-2n8oon6p558q@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66o0nq89-4599-np26-625n-2n8oon6p558q@tzk.qr>
X-Provags-ID: V03:K1:dK60HFRbbQ1ockKndJ8QBvmJI1uSvsRGXyjAS2vdJNB2e7VCQYf
 nRiUVlQnK82hoLyYfrFV2lOQROwV/Xd//8/FRkjNU52U055cZAeURdc5+2j6c0w1E/sHU5U
 MAfTUJXgdTtJRcikkmnLxYDsPyimJDb9XGaH9KDfezx5znMjgSiIr1OvUc7qIqlxlD3Uvb5
 zzxWK+KR18d6G/sNtamfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AZd8ZlPeptU=:gCIcESL9RLV+AkRXsOQjIF
 h09tP7n3V/j/fUXPOM8KEpKPF2YN1940cIeRM8rAKB3rO4T5jJYdMQ3W1Np/JKFvn+jtZ1aiL
 15QMzXNVcyL/YpWHklYscuN5sj/TEAHDcceDPyLYW+lRl/Qa4pxi+y+0q42tkiASsz+mosUG5
 0jpJ/4wOIJrHUfELY4Vb6WmTzeqZZDh3QSfbIZji93twvXdMzmJqEHa4K+T2JHwcwbn8iw8I5
 w4bkToq3++rj84+vGuJS2cLqMap8WDgpn0DrzmoO/LoOmn9ghoDZjqYfhFYaPs3wk+JGkn3DM
 SVVuZLF6rDq8pd2Rvy0ppxnqaQsSu5YZAIn7oVXERIVhCysDGS48rum7eoWkK+FIig1DrOioW
 xJiT7l2rKjpQ8mEszp3K0DJIpBrg2gQ3l+pswHdc+BH9f2wYxYcO9KWrHVZ7msrh8Vi+hn5tH
 YQP1+Cts2oTeoQMdZJ/OWg3/PPSuDWos11c1BW9jGKM00qO5K3aNJSUxLQHR7EEMgJkC5+hLJ
 9whmA/T/urGOC3bbR8YQLguN6dg/SMeyJvJ9Ub+vQHuQH7yW9HlkmghakBNTKVCP9A4KFwIr/
 MQmZ991WfPakkXsvW8ChRlUkvldgMcgHP8BmgkmY01783Vj6kIUJPyR/F5X12frTslA2gbMb+
 KDcdaLM8kgcttc+JxVrOYx6NW34/q8d8JchZxqBg6IAaRioNwVnXKe0gEn6bmGegoczsTi9sc
 Hd9IP+FClsA3kLaH61KdEVrNPVRWx2YFBX58r4LlYsDlsLFx/6k33lE1EekmQyYHGHP0DR2Nr
 bfJ02sfltDkFBpdOz5ovZeNFBxoBg==
X-Spam-Status: No, score=-95.9 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Nov 10 16:16, Johannes Schindelin wrote:
> Hi Corinna,
> 
> On Mon, 24 Oct 2022, Corinna Vinschen wrote:
> 
> > On Oct 23 23:04, Johannes Schindelin wrote:
> > > On Tue, 18 Oct 2022, Corinna Vinschen wrote:
> > > [...]
> > > > That means, the results from the "env" method is equivalent to the
> > > > "windows" method, just after checking $HOME.  That's a bit of a downer.
> > > >
> > > > Assuming the "env" method would *only* check for $HOME, the user would
> > > > have the same result by simply setting nsswitch.conf accordingly:
> > > >
> > > >   home: env windows
> > >
> > > Except when the domain controller is (temporarily) unreachable, e.g. when
> > > sitting in a train with poor or no internet connection. Then that latter
> > > approach would have the "benefit" of having to wait 10-15 seconds before
> > > the network call says "nope".
> > >
> > > This particular issue has hit enough Git for Windows users that I found
> > > myself being forced to implement these patches and run with them for the
> > > past seven years.
> > >
> > > Given the scenario of an unreachable domain controller, I hope you agree
> > > that the `env` support added in the proposed patches _has_ merit.
> >
> > Yes, I don't doubt an `env' method checking for $HOME even a bit.
> 
> Cool!
> 
> > I'm just not sure as far as HOMEDRIVE/HOMEPATH/USERPROFILE are
> > concerned.  Those vars should be left alone, but we can't control that,
> > so reading them from genuine sources is preferred.
> 
> I do not recall the exact reasons because it has been a good while since I
> worked on these patches. But I do remember that we had to have a fall-back
> for the many scenarios in Git for Windows where `HOME` is not even set,
> and we specifically had to add HOMEDRIVE/HOMEPATH handling because
> USERPROFILE alone would lead to problems (IIRC there were plenty of
> corporate setups where USERPROFILE pointed to a potentially-disconnected
> network drive).
> 
> > Sure, the downside in terms of the LDAP server is clear to me
> >
> > So I guess it's ok to allow the env method to read the values of those
> > vars from the env.  I would just feel better if we urge the
> > user to set $HOME and read that exclusively.
> 
> I would feel better about that, too, if it was practical.
> 
> But I cannot ask millions of Git for Windows users to please go ahead and
> first configure their `HOME` variable correctly, it took much less time to
> implement the patch we're discussing than asking all users individually
> ;-)
> 
> And since there is nothing specific about Git for Windows here, I expect
> Cygwin users to benefit from this feature, too.
> 
> With this context in mind, I would like to ask to integrate the patch
> as-is, including the HOMEDRIVE/HOMEPATH and USERPROFILE fall-backs.

Can't do that, sorry.  Two replies before I sent a necessary change,
which needs inclusion first.


Thanks,
Corinna
