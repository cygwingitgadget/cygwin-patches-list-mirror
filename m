Return-Path: <cygwin-patches-return-7565-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7612 invoked by alias); 18 Dec 2011 20:16:55 -0000
Received: (qmail 7600 invoked by uid 22791); 18 Dec 2011 20:16:53 -0000
X-SWARE-Spam-Status: No, hits=1.9 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM
X-Spam-Check-By: sourceware.org
Received: from mail-ww0-f41.google.com (HELO mail-ww0-f41.google.com) (74.125.82.41)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 18 Dec 2011 20:16:40 +0000
Received: by wgbdt12 with SMTP id dt12so5747558wgb.2        for <cygwin-patches@cygwin.com>; Sun, 18 Dec 2011 12:16:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.180.8.162 with SMTP id s2mr2655750wia.29.1324239399466; Sun, 18 Dec 2011 12:16:39 -0800 (PST)
Received: by 10.227.165.4 with HTTP; Sun, 18 Dec 2011 12:16:39 -0800 (PST)
In-Reply-To: <CAL-4N9sx=asy0r3fcD65=WfvW0VHByv-Hn0CAJgaAFK3C8Vw_Q@mail.gmail.com>
References: <CAL-4N9uVjoqNTXPQGvsjnT+q=KJx9_QNzT-m8U_K=46+zOyheQ@mail.gmail.com>	<20111205101715.GA13067@calimero.vinschen.de>	<CAL-4N9sx=asy0r3fcD65=WfvW0VHByv-Hn0CAJgaAFK3C8Vw_Q@mail.gmail.com>
Date: Sun, 18 Dec 2011 20:16:00 -0000
Message-ID: <CAL-4N9v8QU-mZfE-4gtpjtybD8A1BYt8QJNGAHOOHv25fkF0Mg@mail.gmail.com>
Subject: Re: Add support for creating native windows symlinks
From: Russell Davis <russell.davis@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q4/txt/msg00055.txt.bz2

Can someone respond to this? If there's a problem with my suggested
approach I'd like to know what it is. Let me know if clarification is
needed. Thanks...

On Mon, Dec 5, 2011 at 11:17 AM, Russell Davis <russell.davis@gmail.com> wr=
ote:
>
> > See also http://sourceware.org/ml/cygwin/2009-10/msg00756.html
>
> Quoting from that link:
>
> - Due to the way they are used in the Win32 API, there's no way to
> =A0use them with POSIX paths *and* Win32 paths for interoperability.
> =A0So why bother?
>
> Yeah, this is rather unfortunate. I agree, since we can't store both
> the Win32 AND the POSIX path, it's not possible for native symlinks to
> function correctly both inside and outside of cygwin for all possible
> cases. But the point I've been making is this -- if we can make them
> work within cygwin for 100% of cases, and outside of cygwin for 90% of
> cases, what's the problem? It's still better than the existing cygwin
> symlinks which work 100% within cygwin and 0% outside of cygwin.
>
> If the "works within cygwin for 100% of cases" is in question, let's
> discuss that. (Any path that might be problematic as a Win32 path can
> just be stored as a POSIX path, and would fall into the bucket of
> "works inside cygwin but not outside").
>
>
> > There's also a problem with your patch.
>
> Thanks, I figured it would need some clean up and polish. I wanted to
> get it out there as a starting point.
>
>
> Thanks,
> Russell
