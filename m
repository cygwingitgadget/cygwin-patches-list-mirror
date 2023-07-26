Return-Path: <SRS0=OKPW=DM=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 1EC993858C33;
	Wed, 26 Jul 2023 09:10:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1EC993858C33
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690362649; x=1690967449; i=johannes.schindelin@gmx.de;
 bh=wIDqxa7E9OEx5UNjAxyNv356+nNZKx1MB8By3jd+dJ0=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=U5w4Q7VBtwlVl6JwEMh3JhXI/rUmBWErVdQlYxdKxmPJS6G7uo7HGQNIG/r7EjD7XDHXGt+
 PdLCvPfb4v/U2PxEGitQWfoyJehyZzZ9rNONxOnBmtmwxQ21t7hVHYluUrbkg2c5VhK9sP+VH
 PZKkUIIEpXb8Pr2NsWdB1uQ9vqNSilroSsRN1X9udByqNLlp1m3aM1Qcl22pNj0TSfdlJjgSY
 VMnRrbGAC7b3+f/AmVEWqPaL0rQbL5l6MXpETvUgZGzyDRI2xBZbHCPHM+RjAWMdDa5w5rWan
 I3ML9ek9EA3HfvnEJ2ntr6bHsXSaUAL8AMK4DFxOep7wydoXK5CA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.52]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Fnj-1qUvnS2Iel-006N4m; Wed, 26
 Jul 2023 11:10:49 +0200
Date: Wed, 26 Jul 2023 11:10:48 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/5] Fix AT_EMPTY_PATH handling
In-Reply-To: <ZL6W9M4TXFv3Igcy@calimero.vinschen.de>
Message-ID: <c6a8b6d9-0cce-afe8-75b0-71f60b9af0af@gmx.de>
References: <20230712120804.2992142-1-corinna-cygwin@cygwin.com> <ZL6W9M4TXFv3Igcy@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rEN6/ocMfLKvQgkoR4PS5T/Q41hcKCf9xIAVKUki3cuUpIsmlWQ
 uyyqqH5wVu3TtihcBpZ2AS+YtTTO/f8T0xullFgLUUoXj/EtlL/NrG7vKYIWHdXtTYXHymr
 N/FI8X0wMHSScgN8+tbJi3DSix8kTECwU//SzJKFqUSEuQWNxNPKbyG52Z/cqj3mp0fnmZV
 yLdObHBud6aUXg2m7W++Q==
UI-OutboundReport: notjunk:1;M01:P0:an1NwdXfGOs=;ab6zbRUMMtWbSOsHmOkbMEz0+wV
 X/sXYgNINX66sJCcSumilFpVjdr9lIywi69VPZdyKKnIboMwzIpBMj2qrEQP37FurPK+QVkgJ
 JWBDrfTzQzwBG8UTSXOayiv6Kn1u6FQk8V87AFVdEmAEHwx352l7fcF0cpG0SKYAZsKs7svOJ
 6xv3iFlQ7WVsmiu0KbIqu7oIFivSw1ws8uNhWE8qrNPxhVBmRzpVIHJfgBuM1xZnC268GrepH
 LnZ9Q4xH+yO5BtURNYgRicuTi3Kvfpv3pivIVR8Tr7d3CCo0DymdEt1jXUosUuy6VIZ+MofGD
 TZq1qNnQjbC2/YxTrcKZcsNVWO1CkfwG+OpN1nlkU70brRfRjUrT8pHpptvy76OR7fEQ/6CO6
 W7uQXGU4da62zgCIgu6NXBAvmrCDiFhjxh4g1IWXu7g/Np7lFOqB+oa3+c5dwCOF73o7B4GlT
 Nfed1sfboBKS/Y+MMQkLlXdtf+D11FKZEhX5wQA9vSzlNfB5P/IUAgLLsjoNCvJkVSrPe8KLA
 rGK21IdXMLJVnv7iAywCkfrOwh+LdSep6icW5gLVlAP2Gw3DuxReeqwhLE2Iy1isQksI0WEmE
 +xfyqHPdCgJcsNuO+o78wD/0CwsU2rDr0JhTNnP0sMZgn5017luR7LL0YLTk3lTKn7EhgABM/
 2Z8kRC9KifnbzJ5C4n9aWQ0D7GMf07HTG9HQ27xg8u9hGYJCUpUtJvAyybCtpLh+KmG5NGufS
 6xoqphO1RMpA5/oH4+ijote9Bb7XeqZ5YrPYWUKGmHrqfb7lAgY3z8+hnIgu+wT0+FVzxFXSN
 78QgJ09UHNYvy0tre6i/MbpBjCTzM+YnCoJG7VhP6rBgSFZPraUTgSusF+IVXF/YVQRVoiX40
 je+aSjd35c+aQi5xOrkO2qArnLul9cjM+3zFy/FbcMQV/N6pV3dW9DAZL16EerdL+zMh3fEGr
 gkWMbA==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

I had a look over the patches and they all make sense. I also tested the
code to make sure that the `tar xf` regression I needed to be fixed is
also addressed by this patch series.

As I don't really know the customs of the Cygwin project, please feel free
to add any Reviewed-by:, Acked-by: or whatever footers (or, if none of
those are appropriate, I am of course totally okay with no footer at all).

Thank you so much for fixing this!
Johannes


On Mon, 24 Jul 2023, Corinna Vinschen wrote:

> Johannes? Ping?
>
> On Jul 12 14:07, Corinna Vinschen wrote:
> > From: Corinna Vinschen <corinna@vinschen.de>
> >
> > The GLIBC extension AT_EMPTY_PATH allows the functions fchownat
> > and fstatat to operate on dirfd alone, if the given pathname is an
> > empty string.  This also allows to operate on any file type, not
> > only directories.
> >
> > Commit fa84aa4dd2fb4 broke this.  It only allows dirfd to be a
> > directory in calls to these two functions.
> >
> > Fix that by handling AT_EMPTY_PATH right in gen_full_path_at.
> > A valid dirfd and an empty pathname is now a valid combination
> > and, noticably, this returns a valid path in path_ret.  That
> > in turn allows to remove the additional path generation code
> > from the callers.
> >
> > Fixes: fa84aa4dd2fb ("Cygwin: fix errno values set by readlinkat")
> > Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> >
> > Corinna Vinschen (5):
> >   Cygwin: gen_full_path_at: drop never reached code
> >   Define _AT_NULL_PATHNAME_ALLOWED
> >   Cygwin: use new _AT_NULL_PATHNAME_ALLOWED flag
> >   Cygwin: Fix and streamline AT_EMPTY_PATH handling
> >   Cygwin: add AT_EMPTY_PATH fix to release message
> >
> >  newlib/libc/include/sys/_default_fcntl.h | 11 +++--
> >  winsup/cygwin/release/3.4.8              |  4 ++
> >  winsup/cygwin/syscalls.cc                | 61 ++++++-----------------=
-
> >  3 files changed, 25 insertions(+), 51 deletions(-)
> >
> > --
> > 2.40.1
>
