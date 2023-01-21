Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	by sourceware.org (Postfix) with ESMTPS id 65E493858D32
	for <cygwin-patches@cygwin.com>; Sat, 21 Jan 2023 17:22:37 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MxE1Q-1oUrm00pOy-00xbBs for <cygwin-patches@cygwin.com>; Sat, 21 Jan 2023
 18:22:36 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9AA4FA8079F; Sat, 21 Jan 2023 18:22:35 +0100 (CET)
Date: Sat, 21 Jan 2023 18:22:35 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fsync: Fix EINVAL for block device.
Message-ID: <Y8wfW7LwHHPZnCK6@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230121124403.1847-1-takashi.yano@nifty.ne.jp>
 <Y8v8cdscNlnXbVxE@calimero.vinschen.de>
 <20230122002237.1770130e6ab0b0fadd7189b2@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230122002237.1770130e6ab0b0fadd7189b2@nifty.ne.jp>
X-Provags-ID: V03:K1:Sd+qi+9PXQIuY0Z8mcbuoVKxSOyXA0xD+voAWs9ILt2ljIHM7LB
 lhR4f+41pOTExmR9GgEYURMdv752+gU69/6LFRosQwe+lN3XjEMK6faly4rlxJGxTRtijjf
 fMLUd/NmTMD/HOH5wczCVAUL/pqbbYr+JWpXg5iR0gQsxD9cfQ76fn3IL0lYi0iPNIKC5HY
 tnQedNU/kDOSKR1qxT2bA==
UI-OutboundReport: notjunk:1;M01:P0:xeJwJrQSV7E=;6uNRjHJXhIYmCO9FK3ZvNctizTR
 ZLQvCeiutIZCIXuI02yrRH3W/sm+b4GTiS7niNVJhiB9fLIa/PQ8SOH7g23vfjC8+qqmgDSHE
 8aULR86D7R11ZldWtpfhTSvNOBjeq7I7TziYt//reOseqS0+PGQR+sjxBhqTGl/kYC2udatyD
 jXsH5/DMgiCDdWtbl2Rwxs4A6RNJzEG4mF4LR6LeOnFTOsyQhzU0nJxFEAhe68ZhyMgmzHzU7
 DslAszf9vlN69iKuCpCPCM7HNiFLFPC+XGjWNHUvP7/iPFOBLBACJdcyqQqcBZwPf5Kum8oh2
 grPC+8kKIV9y3AoaKHxDfVyH578eUOzyV2F2XjXMrAXKPzHupL3cN5aRgM2xroarcbKDDKbOZ
 09SZ12kgk9x9otpOWAKd7KNgOq0Xdpy/SjRHsJIfJWSd9QCf6fBIzBqD7ILGhPU4C9rZESWTG
 o8gG1YMo382iho25g3/YpjbKojuGNWxSPSTIQeHFeMsgPRGWJbHf3iiEoleWRfUBVFe39k+gi
 PxR2CpgmSZvjOfLZjMfn4n00nWBXA0aLntFwm3bFs+iXSDJ7RKUBllf1mI/eaOn6cJwTY77Jc
 +nBkcqiyTP9vzO2bnP/Ewk/gdtTBRI4Fw2ZO0YzRL++u9Nhrrd9aRjBRDVv8VrTSwzx7ZFNxY
 pcr0POqfJXKt5zMJxXZLNqSBNlFHJHlT7zSax2kAZg==
X-Spam-Status: No, score=-103.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Jan 22 00:22, Takashi Yano wrote:
> On Sat, 21 Jan 2023 15:53:37 +0100
> Corinna Vinschen wrote:
> > Hi Takashi,
> > 
> > On Jan 21 21:44, Takashi Yano wrote:
> > > The commit af8a7c13b516 has a problem that fsync returns EINVAL for
> > > block device. This patch treats block devices as a special case.
> > > https://cygwin.com/pipermail/cygwin/2023-January/252916.html
> > > 
> > > Fixes: af8a7c13b516 ("Cygwin: fsync: Return EINVAL for special files.")
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > ---
> > >  winsup/cygwin/fhandler/base.cc | 23 ++++++++++++++++++++++-
> > >  1 file changed, 22 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/winsup/cygwin/fhandler/base.cc b/winsup/cygwin/fhandler/base.cc
> > > index b2738cf20..fc0410522 100644
> > > --- a/winsup/cygwin/fhandler/base.cc
> > > +++ b/winsup/cygwin/fhandler/base.cc
> > > @@ -1725,10 +1725,31 @@ fhandler_base::utimens (const struct timespec *tvp)
> > >    return -1;
> > >  }
> > >  
> > > +static bool
> > > +is_block_device (_major_t major)
> > > +{
> > > +  switch (major)
> > > +    {
> > > +    case DEV_FLOPPY_MAJOR:
> > > +    case DEV_SD_MAJOR:
> > > +    case DEV_CDROM_MAJOR:
> > > +    case DEV_SD1_MAJOR:
> > > +    case DEV_SD2_MAJOR:
> > > +    case DEV_SD3_MAJOR:
> > > +    case DEV_SD4_MAJOR:
> > > +    case DEV_SD5_MAJOR:
> > > +    case DEV_SD6_MAJOR:
> > > +    case DEV_SD7_MAJOR:
> > > +      return true;
> > > +    }
> > > +  return false;
> > > +}
> > > +
> > 
> > You shouldn't need that. Just check S_ISBLK (pc.dev.mode ())
> 
> Thanks for the advice. I looked into the S_ISBLK macro and
> winsup/cygwin/devices.cc and noticed that S_ISBLK() returns
> true for tape device. Is this the right thing?

Oops, no.  Tape devices are supposed to be character devices.
I'll fix that.


Thanks,
Corinna
