Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by sourceware.org (Postfix) with ESMTPS id 849DD3857829
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 21:04:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 849DD3857829
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=Johannes.Schindelin@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1616533468;
 bh=0EMglruI+PdfgfbyhqBO+Lrrg3vcvNaLaAXJmyUb4CM=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
 b=inba+0SH9E0haswlciXM0xQ3nsi5kk+GIfl40YPjUPgyjAJ9mwXZdWOviYl5kyLxk
 QF65yscsSqE3pYDnXtw/Ol0jpBUx06O2S1IV2iXYCWjxuRnOnvu9dY+sIGkRwnkILq
 kWQPUvQfMjPqOqxiZPn5l0Pz04oDTQRT3CMX4bTw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.9.78] ([213.196.212.127]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26r3-1lMtJy3gAD-002V4m for
 <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 22:04:28 +0100
Date: Tue, 23 Mar 2021 22:04:25 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/2] Handle "app execution aliases"
In-Reply-To: <YFoQPRMwf1RYBufS@calimero.vinschen.de>
Message-ID: <nycvar.QRO.7.76.6.2103232152560.50@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2103121606540.50@tvgsbejvaqbjf.bet>
 <cover.1616428114.git.johannes.schindelin@gmx.de>
 <YFoQPRMwf1RYBufS@calimero.vinschen.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
X-Provags-ID: V03:K1:NOdthP0LetXxTKi3hW2beDgXTO7GfHGvc3tBC7d7Qs7GC6g4ZJX
 TNheeLnFExYYgYLFMfsDfg5X3l99K+g2ulHBRpA7ajVZ8zLD144AF3gn6UG7+1qerUdySwN
 UkSJJUm2nS6D9R0ZIp4TQ88de2aCTNw8ODWX4s25GHptNwZvcbd4rcg1Pu2CBYeRjPeSq8G
 ZJNE5RxDJpI3/5U7h9ZLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EcnqGJ4fguY=:/Ge5weCJJSWPjAqG+6zcDF
 2M6T5J0yR10NrhanUD4XweEVhh3avyJMXWZucwQeLPv/dADmn7FXqzj4oHY3E2J1PDSqMhiHJ
 19cPFEspr7AX7YZQNiywTEUxsxpuWMWPjIgH6kyAdY8JGUpnYUdiOBqvnTjr1ZQfVM8xN7Qel
 A8DGT50te9B8mNWmf3SFd14fj7spsrgwpEb+NtywstrC6/VbwD8f5XW8snrQLucIXKmagOB4H
 fSo1BqamvuwRD7g+vhpzQTCFPJoklrdDk6usg85wj5Cybf9ejc1anm+l8DGoYJBrbb26Ti9Kj
 f4Zmoq6oVtAc74PN8UeoU3AN4ktMgH7WqrrJr79yEIO/FfRaKo+UKG2x9Rinx6HVDoaXkhNcE
 E0vXvN1gUGHX8CPJCq1NBY82kU6QsY3LxB1zGI+H0W4M6FpwwntZlEoEp93553hECoXG40lnB
 bS4lVSPJC6A9Y6ohJMv5FJYe9zR5tVoBKsOtOM/wgdfnMOaLnwk7HidpFGFjxXiOVROyektoR
 uWbLtDlBFCDvD22Eb1Nv8Wio2zzGlh53LnyNfi0SRtM5uei7C2TWi1v5+hzdYdtnnBmxjrafr
 /0sJjjZrF/pCuFYMc1+1D44GcZEafccgbit0b+u3iEr1+owfgdkQKHqsnL4gNEqiZyz2krWgz
 MAQ76+Dom9h5ILzqsS1H0aHHZdpprrFb7C1hCFvGx7Uv3xJw4zsNM8WmBuBXlIVBY5wNGnVAu
 wIwtqpt8/S9f9Yv7e5ZOPYQYUuIvyS2MCriI0KofRI0iqRfg2GXI3AHzsAEiXSdGx8C8VwmLe
 C9PyHVAIYpLNSrA+r0y3pKvl5jBOCmr1sUBQ4kNmYppoVTeMXBxlheMoCPmCcXMVdEbfeumy/
 JZ4Vst3dm2puop5aptOsWnrn8lz6PHAh4XUBN7Wxc=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_LOW,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 23 Mar 2021 21:04:31 -0000

Hi Corinna,

On Tue, 23 Mar 2021, Corinna Vinschen wrote:

> On Mar 22 16:51, Johannes Schindelin via Cygwin-patches wrote:
> > When installing e.g. Python via the Windows Store, it is common that t=
he
> > `python3.exe` entry in the `PATH` is not actually an executable at all=
,
> > but an "app executaion alias" (i.e. a special class of reparse point).
> >
> > These filesystem entries are presented as 0-size files, but they are n=
ot
> > readable, which is why Cygwin has problems to execute them, with the e=
rror
> > message "Permission denied".
> >
> > This issue has been reported a couple of times in the Git for Windows =
and
> > in the MSYS2 project, and even in Cygwin
> > (https://cygwin.com/pipermail/cygwin/2020-May/244969.html, the thread
> > devolved into a discussion about Thunderbird vs Outlook before long,
> > though).
> >
> > The second patch fixes that, and for good measure, the first patch tea=
ches
> > Cygwin to treat these reparse points as symbolic links.
> >
> > Changes since v1:
> >
> > - Introduce and use `struct _REPARSE_APPEXECLINK_BUFFER`.
> >
> > Johannes Schindelin (2):
> >   Treat Windows Store's "app execution aliases" as symbolic links
> >   Allow executing Windows Store's "app execution aliases"
> >
> >  winsup/cygwin/path.cc  | 40 ++++++++++++++++++++++++++++++++++++++++
> >  winsup/cygwin/spawn.cc |  7 +++++++
> >  2 files changed, 47 insertions(+)
>
> I decided to apply this now, while we're still discussing the osf handle
> problem.
>
> Pushed with two fixes.  I prepended "Cygwin:" to the git log subject and
> I patched this compile time problem:
>
>   path.cc: In function =E2=80=98int check_reparse_point_target(HANDLE, b=
ool, PREPARSE_DATA_BUFFER, PUNICODE_STRING)=E2=80=99:
>   path.cc:2581:25: error: =E2=80=98struct _REPARSE_APPEXECLINK_BUFFER=E2=
=80=99 has no member named =E2=80=98Strings=E2=80=99
>    2581 |       WCHAR *buf =3D rpl->Strings;
> 	|                         ^~~~~~~

Uh oh. Sorry for the breakage. I thought I had test-compiled it...
Apparently I didn't (or I ignored a warning or something).
>
> I also added this to the release notes.

Thank you!

Ciao,
Johannes
