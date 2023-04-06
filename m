Return-Path: <SRS0=KytC=75=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 835273858D32
	for <cygwin-patches@cygwin.com>; Thu,  6 Apr 2023 09:54:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 835273858D32
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1680774847; i=johannes.schindelin@gmx.de;
	bh=63Pw4AmO588mbLm69+4QG2u+md4+wW8d/Xo+xmg/4h4=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=KiygPFjLeOfWE4l34QS7iyes3FuX6xDFZlTZSNPtdn+3dnAlWyGyS5GY+Jpq23z0g
	 QREz/NPIz4L51uc7uATFOhgDwZYvEAiJv7Xcgs3gExaLmyffCPrF03VkrBnXZR0NHA
	 OXymmfAFE1qEqw/dtBmZzKcpUYpZC96pD07I2S1DS0C0e7eeCZIQUaJAWVbWR0Jopl
	 1Xr/B5d5TpirtudJPerVWCsFfscEszcBw5wRsaATRLoa9icD1AZor96/OpsMAclmqM
	 8NRNplTTJOZhMQA0yw9nC1E9hV6ttXO+k7CxlHMgmwj04W0j7I0esgnpXOnFwmkoHZ
	 vKL0oPoWAEwjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MStCe-1ppPjF0WGE-00UJrx for
 <cygwin-patches@cygwin.com>; Thu, 06 Apr 2023 11:54:07 +0200
Date: Thu, 6 Apr 2023 11:54:05 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 4/4] Do not rely on `getenv ("HOME")`'s path
 conversion
In-Reply-To: <ZC6EwQgygFo/GkNL@calimero.vinschen.de>
Message-ID: <097f16c8-9df1-4dad-6eb4-30fe090c9f05@gmx.de>
References: <cover.1680532960.git.johannes.schindelin@gmx.de> <cover.1680620830.git.johannes.schindelin@gmx.de> <8ac1548b9216b5b014947bb3278f9c647103fa91.1680620830.git.johannes.schindelin@gmx.de> <ZC6EwQgygFo/GkNL@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-127343416-1680774847=:26978"
X-Provags-ID: V03:K1:PMG+iAd/0sGnhVCGRoSYKsbX8ikZKHijvolDkoz16ptmsJC03pL
 MUCGdnJzL2hJ0y5GFX6mTE1QFvTTzWwdBTeRJIH3Z4nkgoTztoMHvfs2KGzXeKwQyQJDpOr
 9dfg0t1XkZdJ4eAHSf/PFrT4vOqLdjnkStg8noFHm0ePX867hwEy4MePopJjhCqq6PCdRwZ
 ZGUsXYvTc5ZArzhrsiO4A==
UI-OutboundReport: notjunk:1;M01:P0:MSezZuCnJKE=;5SAiXA6V4Z8a59tt8sOcfzhzHys
 dqyrWsJLZ3uAN58ajoynUKlIJuEcuGFnJimhac93A+d9CAuPzaZ6HNSweAyDi23g3Ox9dH2Xw
 fv6QMff9APM3MF6s3zugY+BrsSr5Vi/f5I1ndZfy1aKQmzd+d7/qzLAPs5XLkgXk3z+sIiFCI
 Iw2vvFOYqD9mbqylha1DrfbN+BuvDa8yuJAOTENSXG2NAmDl2wK0VWosvd9XsJluYlpPtur68
 TunGLw5yibL9dl0hHsZN3bFuRZtpzhnyR02ue+9jXLZ6Ie91TQJyVXouLz7Aa/tN6djsiRaP0
 OGhPPA9RVNdFkwTGuxEpXC4LAgktgQlPr4C9WAVYoeMDAOw+N2+zUTfYxYfvMXSFF1F+EkMF8
 EzoHAQ4UMW1EGHZSnwpUhKZWyUnXM7MxC8jIZV63w/suzt22FVUP1XbczZxhLO9YAOdOtyR/P
 w72S0XIYtPZQ+fwPyI7TJGtjuLtgYtcfw11yeuo2n+HhwYNXAnHsj8+JWMMShQ4DlaIIJZ2au
 2ReZnh3CKBT87x9yfgqFEAhtU8UN5UpQIcH6tyOzFOxiWlMEEXPUwfrAhSCC+432rgaxxp9Jo
 l0KRBy3CZBKyzNisVJBrBwbunRS6g/MlxCY3E+FfdKNUccHZR9o+omHKU49kGscT+FMbfr3T0
 izBFN5plx7zjFuH6Yn0zRNwP+XiZH4QPuzdJelZgX8oIOeNnd38qvXZEuUzrx4RoKh/wmVWYs
 e9xmc99dzTZSTMzw3yZsmmHDrWhj1ccAe4zpoAYWVuEUiegXLgRHdYs0Q1U+ylonzRlIiHnTJ
 3bXRjYYRkUsY+/vQNBGzzWLwq0hGEaTo7cdw3P68wB0Wn8XnWZbVvYgAnKHU1MPV+u3096wvU
 WddlmTssWB2cfcwSDruVK8/NcK7fUQcOw2e21OtEgHERR3kUCuGtC8hdaOrgqPwZz86srl3kJ
 L2Io9w==
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-127343416-1680774847=:26978
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Corinna,

On Thu, 6 Apr 2023, Corinna Vinschen wrote:

> On Apr  4 17:07, Johannes Schindelin wrote:
> > In the very early code path where `dll_crt0_1 ()` calls
> > `user_shared->initialize ()`, the Cygwin runtime calls `internal_pwsid=
 ()`
> > to initialize the user name in preparation for reading the `fstab` fil=
e.
> >
> > In case `db_home: env` is defined in `/etc/nsswitch.conf`, we need to
> > look at the environment variable `HOME` and use it, if set.
>
> I'm a bit puzzled by this.  HOME is not a Windows variable.  You're
> usually not supposed to set it to Windows values, but to the POSIX
> value.  I'm aware that Cygwin makes the conversion, too, for historical
> reasons.
>
> But why on earth would you set a variable you have under your own
> control, and which only makes sense in a POSIX environment, to a Windows
> value?

This is actually a well-documented feature of Git for Windows, which
cannot handle Cygwin paths (at least not `git.exe`, which is a MINGW
program).

And since Git for Windows is also used in third-party software like Visual
Studio, it is quite conceivable that the `HOME` variable is intended to be
used by Git for Windows and Cygwin. I know that I will use it for both,
once a Cygwin runtime version is released with these patches.

And even if it is not Git for Windows, we are talking about system-wide
environment variables. And that system is Windows...

So yes, we absolutely have to expect the `HOME` variable to potentially
contain a Windows path.

> > When all of this happens, though, the `pinfo_init ()` function has had=
 no
> > change to run yet (and therefore, `environ_init ()`). At this stage,
>
>   chance

=F0=9F=91=8D

> > therefore, `getenv ()`'s `findenv_func ()` call still finds `getearly =
()`
> > and we get the _verbatim_ value of `HOME`. That is, the Windows form.
> > But we need the "POSIX" form.
> > [...]
> > Let's detect when the `HOME` value is still in Windows format in
> > `fetch_home_env ()`, and convert it in that case.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  winsup/cygwin/uinfo.cc | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> > index 5e2d88bcd7..bc9e926159 100644
> > --- a/winsup/cygwin/uinfo.cc
> > +++ b/winsup/cygwin/uinfo.cc
> > @@ -929,7 +929,13 @@ fetch_home_env (void)
> >    /* If `HOME` is set, prefer it */
> >    const char *home =3D getenv ("HOME");
> >    if (home)
> > -    return strdup (home);
> > +    {
> > +      /* In the very early code path of `user_info::initialize ()`, t=
he value
> > +         of the environment variable `HOME` is still in its Windows f=
orm. */
> > +      if (isdrive (home))
>
> While the description is clear on the colon problem, shouldn't this
> catch UNC paths as well?  I. e., just check for strchr(home, '\\')?

Good idea! I do not know off-hand how well things work when `HOME` is an
UNC path, but we can fix those things when (and if) they arrive.

I'll use `isdrive (home) || home[0] =3D=3D '\\'` as is used elsewhere, oka=
y?

Ciao,
Johannes

>
> > +	return (char *) cygwin_create_path (CCP_WIN_A_TO_POSIX, home);
>
>
> > +      return strdup (home);
> > +    }
> >
> >    /* If `HOME` is unset, fall back to `HOMEDRIVE``HOMEPATH`
> >       (without a directory separator, as `HOMEPATH` starts with one). =
*/
> > --
> > 2.40.0.windows.1
>

--8323328-127343416-1680774847=:26978--
