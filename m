Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	by sourceware.org (Postfix) with ESMTPS id D19523858034
	for <cygwin-patches@cygwin.com>; Tue, 18 Oct 2022 17:02:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D19523858034
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MFspV-1ouT9Y3rpf-00HMnf for <cygwin-patches@cygwin.com>; Tue, 18 Oct 2022
 19:02:51 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CD77EA80706; Tue, 18 Oct 2022 19:02:50 +0200 (CEST)
Date: Tue, 18 Oct 2022 19:02:50 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Allow deriving the current user's home directory
 via the HOME variable
Message-ID: <Y07cOhhwu4ExRDzb@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com>
 <cover.1450375424.git.johannes.schindelin@gmx.de>
 <047fe1d78c365afca7edfdf169fff5e1940c3837.1450375424.git.johannes.schindelin@gmx.de>
 <20151217202023.GA3507@calimero.vinschen.de>
 <1r1pq0r7-o3s3-so08-o426-296542797q94@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1r1pq0r7-o3s3-so08-o426-296542797q94@tzk.qr>
X-Provags-ID: V03:K1:kWlhWwA6o8jsIpdFpnX7KNLRRP6ERlvs27MUnzCKrv1bVW+IUpx
 //nQSwaW7KSSef8JqGMRtK1GpM7r2dGLKIGmGC1VKe/PRICLfTxoCe28KQR9yEQ0T4IAKDj
 ZW6guuU5VbKv7p9pWt6JTUwLDkC4mA5nHH2wAPSFVEyUbULM7Y25M71YGv2+lH8MtxJMNXR
 QKaV4HsFDx10Lp5EQE4lg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LINocfYdb5c=:Oz8jUyT0+EnTDBpmK/98R2
 LAOLWK4hxrHS/W43zsOw/AMFjqx5CG5jJKWM4iy2pllL7F53AooejickcoqL8Lrz1v1RDBJsI
 pRE+T03rUh9jTXMar8qUWZ29n0YIj3S0r81JLcCfbd45uBIJGRlZrNGEgDhkxTu94TvIqvQMl
 FFjS92RpMl7CpFUrZM/hRlu1CAUbLFLCq3fEn97yqBoLgOn8XB+AQwh5GhWVUXmWXo5HMFdC0
 qX3wYYGggek4OesL6+7dqAq/dV+yZM8z0hg+Renp931SNr1KK56r0xK1ApDlAUHnzhwdbT3NM
 IU+2stL2Ec6a+1yjhAMpgElz2yQ64F7jiHBUVkupTsYgLqG3N2/mNLW32+psaL33Ki2l6bXSK
 642OwZIT2Si6Ksi4jl7mvYLtLE4wRJ8wVBTEIxLA9XU8pfhPT9oux6eYedEjG5hkcs5PPQzHy
 VzIRdJ3eBAPJiEB/2U1woafkSJ9qitJXWfhF6MjEHlmDyS3t+eBN5JbaMHOzfJfEtTZk0xVPM
 6qXHbuXCrLsyI/u/7OuwBNMW7LVYffksXUPJZuzhxJYAvkYcz5wWYsl1DNZbXsVZ5eAOWdw7J
 yox3G1gqXzfasg1xJlO1l+ai/3ciDLt250zEMhDShcxjbZDij1nzp+mnksdrDonTIvYuyqQkb
 /rkW62J2FGnwXuHy1KYjaTiRTzdwuRzIkTWPhjCHMeRpO+uOZKPGFIelCPcWuFK2JULOVNYw+
 HHeBZMAO9HrMYLyIM+mWl8aPuKa8qMjhbGIWagVAuwfZz6ODQkH0Ytu45z225mosCoXYtyfIJ
 SS5v20eLxomYnMwwlCHfZafRRBJbQ==
X-Spam-Status: No, score=-95.5 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Sep 21 13:58, Johannes Schindelin wrote:
> Hi Corinna,
> 
> sorry for the blast from the past, but I am renewing my efforts to
> upstream Git for Windows' patches that can be upstreamed.
> 
> On Thu, 17 Dec 2015, Corinna Vinschen wrote:

Well, not even 7 years, so what? :)

> > On Dec 17 19:05, Johannes Schindelin wrote:
> > > +  DWORD max = sizeof wbuf / sizeof *wbuf;
> > > +  DWORD len = GetEnvironmentVariableW (key, wbuf, max);
> >
> > This call to GetEnvironmentVariableW looks gratuitous to me.  Why don't
> > you simply call getenv?  It did the entire job already, it avoids the
> > requirement for a local buffer, and in case of $HOME it even did the
> > Win32->POSIX path conversion.  If there's a really good reason for using
> > GetEnvironmentVariableW it begs at least for a longish comment.
> 
> My only worry is that `getenv("HOME")` might receive a "Cygwin-ified"
> version of the value. That is, `getenv("HOME")` might return something
> like `/cygdrive/c/Users/corinna` when we expect it to return
> `C:\Users\corinna` instead.

Haha, yeah, that's exactly what it does.  Look at environ.cc, search for
conv_envvars.  There's a list of env vars which are converted
automatically.  So getenv ("HOME") already does what you need, you just
have to adapt the code accordingly, i. e.

  if ((home = getenv ("HOME")))
    return strdup (home);
  if (((home_drive = getenv ("HOMEDRIVE")
           [...]
    return (char *) cygwin_create_path (CCP_WIN_A_TO_POSIX, home);

However, on second thought, I wonder if the HOMEDRIVE/HOMEPATH/USERPROFILE
code is really required.  AFAICS, it's just a duplication of the effort
already done in fetch_windows_home(), isn't it?

HOMEDRIVE/HOMEPATH are generated from the DB data returned in
USER_INFO_3 or via ldap anyway, and fetch_windows_home() also falls back
to fetching the user profile path, albeit from the registry.

That means, the results from the "env" method is equivalent to the
"windows" method, just after checking $HOME.  That's a bit of a downer.

Assuming the "env" method would *only* check for $HOME, the user would
have the same result by simply setting nsswitch.conf accordingly:

  home: env windows


Corinna
