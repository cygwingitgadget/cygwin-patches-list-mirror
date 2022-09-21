Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 8E8B13858C52
	for <cygwin-patches@cygwin.com>; Wed, 21 Sep 2022 11:58:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 8E8B13858C52
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1663761529;
	bh=L/lCUUvh0S8S8ZaGh1Uz+v3XSsYO4lfdMJJngln2DCQ=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=THpiVqVe7gL8W3iKSL0HWiZjO5KXIwML4FBKvK0YrfAPIMvFeT+bLVZcmHehanAkY
	 z5iAaf8DeUkgHTfoQ5sk4e5PpzYVlCfRmm97GnMB4KLAbj6MwTyl5gyJHaUfzO9+S5
	 2D51z9N3kziGI7jOOun0TqR0FmIGhrZ2jJkC0TOs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.115.55] ([89.1.213.188]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybGh-1pV6pR3zvp-00z1Dy for
 <cygwin-patches@cygwin.com>; Wed, 21 Sep 2022 13:58:48 +0200
Date: Wed, 21 Sep 2022 13:58:48 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Allow deriving the current user's home directory
 via the HOME variable
In-Reply-To: <20151217202023.GA3507@calimero.vinschen.de>
Message-ID: <1r1pq0r7-o3s3-so08-o426-296542797q94@tzk.qr>
References: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com> <cover.1450375424.git.johannes.schindelin@gmx.de> <047fe1d78c365afca7edfdf169fff5e1940c3837.1450375424.git.johannes.schindelin@gmx.de> <20151217202023.GA3507@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Z0+N79jWISZMdXWBZSzUVQlvUP8AZflFGEhyLYHNPj8NDfn4XtQ
 dG+FpfY1VOeopB7N98Sbf4urJ57iRTciZ4b9UDj0jW400VUbTGnsG84NQPmJWuU97FXmV/+
 Vnp9HV3EVSvqkcNWb7uI1MVbuxXKuEJhBAbAntZ+ylxgr6NVN+wlyW1xRT4IdHfHYJSBFqL
 rdZbuGlqT/hhmd1CTEUJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P8TAw+VmN1U=:9sOz3TllLC0G32PNGgIMe9
 4kN61nobaTFqT82P36oEzJDm4e0pa+vtQVEZ1JUbmu8dV4SPML2e4osHekCv5qUoEYTLCdT88
 E8pgPjmUmhK7+U4b4DkbPX01XSMsMkVbxHdR2Vww0wg5V4ZaT0nNzEMHqQFaNwylG3utp6BxT
 6Vm6sLFy1Hmuxs7fxzTcpykY6W+bBUGAfK9SEtkJnThdPgtuF8EM0+Y+34AhhuX5A3EvTO/PJ
 D4qUzIvnwEcVc7hXdCIa6cRMspD+2IvGzGirfchY9P9aSRBEc2pqkX+9D1g0XwcIOXhtEMTJH
 GqIZSIX1wSbMRQdWyJiJyshsTZbzIorA5fkMqdWaITmtkXyzvMFEb6Kvnd24HeeYK7Gj6Ieh2
 LhoqnNdSN47X7WwUNDX5irAookOpEhI6H5EcW42XDvympDSvDcrjDQC+ste14iTgy2SzJHMp2
 NutqGL26iPPzGPtsmdSbntqyVwzaZAAYWaYrlKSHuuJtOh0KSA1CQlINIawZL5otLu+eOf8cm
 2zvJqlAUYLpnc2+6ItCuyyQzuNSVV3CHz86ULq/WWJIgxpwXmgWSMEu596W/tH7P4XmRiTtnc
 MUB5LnHAi5BPrToEC/0x1nTY7onRysLaMx1c8o8A0qAd9AUdZFRSW9Ixwse/DesPGhTGfD2h/
 NwLDpG8kO4Zvj2DRl57LnjBVCdpNuCwAzBwkVPtAuz/wL07Y/TQkkO22uXSjIFVv+pQ2/R3NI
 u4Iy7KxgNDPlA7gacI4PK2qnHAD7wdTsCExooC7P4z/J14ZSyiZiUONOd8yopr1/fchAj3cgy
 G4dOOA9cCK7Bv/Z8WPE4qIH4id8yad+cdIqrNgr6lGUXXfy3wCzzoXlAemR6SzXH5ypQ+uXvo
 fjSx/Dl3WVL2dGd3k50IACZ81y3hL+kZrTw9xJ4RnJ5zt2JI+8yFRfbiYztgkeaFME8pIFp2n
 djlxtKXs9BUHJI/2IxH5qAQKdiii0hRejDL7hJrMrkpHyx3uKTZE2VlnKocir9kDi4vMjsglL
 8rlrPo1nxgDELmz7iopvwiMVkz7cRNw4lSpRysjLvhYFq+t9iuJIAUg2vGwRkZCvesHh9q3MG
 y7bDSDjG7TfKHxdiQwHTy2QlIihXK7UiRP8o+xPDXv0tnIgSXotQVDb4ouHIreKhU3xjPF439
 OYRKlw2Kako0U0ZNK5AVG0WfeP
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

sorry for the blast from the past, but I am renewing my efforts to
upstream Git for Windows' patches that can be upstreamed.

On Thu, 17 Dec 2015, Corinna Vinschen wrote:

> On Dec 17 19:05, Johannes Schindelin wrote:
> > [...]
> > diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> > index c9b3e09..a5d6270 100644
> > --- a/winsup/cygwin/uinfo.cc
> > +++ b/winsup/cygwin/uinfo.cc
> > [...]
> > +static size_t
> > +fetch_env(LPCWSTR key, char *buf, size_t size)
>            ^^^
>            space
>
> > +{
> > +  WCHAR wbuf[32767];
>
> Ok, there are a couple of problems here.  First, since this buffer
> is a filename buffer, use NT_MAX_PATH from winsup.h as buffer size.
>
> But then again, please avoid allocating 64K buffers on the stack.
> That's what tmp_pathbuf:w_get () is for.

Excellent. I did it exactly as you suggested.

> > +  DWORD max =3D sizeof wbuf / sizeof *wbuf;
> > +  DWORD len =3D GetEnvironmentVariableW (key, wbuf, max);
>
> This call to GetEnvironmentVariableW looks gratuitous to me.  Why don't
> you simply call getenv?  It did the entire job already, it avoids the
> requirement for a local buffer, and in case of $HOME it even did the
> Win32->POSIX path conversion.  If there's a really good reason for using
> GetEnvironmentVariableW it begs at least for a longish comment.

My only worry is that `getenv("HOME")` might receive a "Cygwin-ified"
version of the value. That is, `getenv("HOME")` might return something
like `/cygdrive/c/Users/corinna` when we expect it to return
`C:\Users\corinna` instead.

I do not think that the current iteration is resilient against that.

This problem might not be a big issue with Cygwin (I don't think it
automatically converts environment variables that look like paths from
Windows to Unix-style), but it will most likely cause issues with MSYS2
(where we do precisely that with environment variables that look like
paths). Meaning: it will probably take some follow-up work to make this
work correctly, even if it is just to verify that things work when `HOME`
is in Unix-style already while calling into the runtime.

> > +
> > +  if (!len || len >=3D max)
> > +    return 0;
> > +
> > +  len =3D sys_wcstombs (buf, size, wbuf, len);
> > +  return len && len < size ? len : 0;
> > +}
> > +
> > +static char *
> > +fetch_home_env (void)
> > +{
> > +  char home[32767];
> > +  size_t max =3D sizeof home / sizeof *home, len;
> > +
> > +  if (fetch_env (L"HOME", home, max)
> > +      || ((len =3D fetch_env (L"HOMEDRIVE", home, max))
> > +        && fetch_env (L"HOMEPATH", home + len, max - len))
> > +      || fetch_env (L"USERPROFILE", home, max))
> > +    {
> > +      tmp_pathbuf tp;
> > +      cygwin_conv_path (CCP_WIN_A_TO_POSIX | CCP_ABSOLUTE,
> > +	  home, tp.c_get(), NT_MAX_PATH);
>                        ^^^
>                        space
> > +      return strdup(tp.c_get());
>                      ^^^      ^^^
>                      space......s
>
> Whoa, tp.c_get() twice to access the same space?  That's a dirty trick
> which may puzzle later readers of the code and heavily depends on
> knowing the internals of tmp_pathbuf.  Please use a variable and only
> assign tp.c_get () once.
>
> OTOH, the above's a case for a cygwin_create_path call, rather than
> cygwin_conv_path+strdup.  Also, if there's *really* a good reason to use
> GetEnvironmentVariableW, you should collapse sys_wcstombs+cygwin_conv_pa=
th+
> strdup into a single cygwin_create_path (CCP_WIN_W_TO_POSIX, ...).

Right, that `cygwin_create_path()` call nicely avoids all the problems of
my original code.

>
> > [...]
> > @@ -1079,6 +1123,7 @@ cygheap_pwdgrp::get_shell (cyg_ldap *pldap, cygp=
sid &sid, PCWSTR dom,
> >  	case NSS_SCHEME_FALLBACK:
> >  	  return NULL;
> >  	case NSS_SCHEME_WINDOWS:
> > +	case NSS_SCHEME_ENV:
> >  	  break;
> >  	case NSS_SCHEME_CYGWIN:
> >  	  if (pldap->fetch_ad_account (sid, false, dnsdomain))
>
> You know that I don't exactly like the "env" idea, but if we implement
> it anyway, wouldn't it make sense to add some kind of $SHELL handling as
> well, for symmetry?

I have decided against that.

The reason: the home directory is a very different thing from the `SHELL`
variable because Windows users _do_ have a home directory even if it is
called differently in Windows speak, while they do not have any POSIX
shell available. There is `COMSPEC`, of course, but it is _not_ a POSIX
shell and cannot be used in place of `SHELL`.

For that reason, I do not believe that we need to do anything about
`SHELL`.

> > [...]
> > @@ -1487,6 +1497,16 @@ of each schema when used with <literal>db_home:=
</literal>
> >  	      for a detailed description.</listitem>
> >    </varlistentry>
> >    <varlistentry>
> > +    <term><literal>env</literal></term>
> > +    <listitem>Derives the home directory of the current user from the
> > +	      environment variable <literal>HOME</literal> (falling back to
> > +	      <literal>HOMEDRIVE\HOMEPATH</literal> and
> > +	      <literal>USERPROFILE</literal>, in that order).  This is faste=
r
> > +	      than the <term><literal>windows</literal></term> schema at the
> > +	      expense of determining only the current user's home directory
> > +	      correctly.</listitem>
>
> In both case of the documentation it might make sense to add a few words
> along the lines of "This schema is skipped for any other account",
> wouldn't it?

Yes!

(Belated) thank you very much for your review!
Dscho
