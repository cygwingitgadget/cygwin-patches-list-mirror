Return-Path: <SRS0=Uj6Q=6Z=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 30A604BA2E04;
	Fri, 19 Dec 2025 01:20:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 30A604BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 30A604BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766107207; cv=none;
	b=sh90LQJEPHlFcWK/0kW3ol4dt3UUMvwrzd3NdVRxu6K+p/iIFbqoVTVeqBXAZ+VJjx0EUqWqWoI68ekF8aYqKI1H/AItDHwGPZMuMbqZsDXwHhNhIL4JVJQ1pM5ZIL6fJHAjRKwZr5+azlzE6kGKMJo8Gd7aauC16AaW1ogyE2c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766107207; c=relaxed/simple;
	bh=8sEunHT4xFH7f02mTEqRFrR95rtQ9EV8V0qd0BQrwEk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=YjLTRbd5oLhvaDKiCWvtx4a4Rc2MKCT/iLdiCCv5PvNrDO5HXqSZZzbNqkApfNb4Wpx1PJ1kxoGwBIdIwQoxt3txYGXT99QCv9eySqxDMpd8Q0FzaGy1HJZHt/2IaM5qaG1uPH+H89WqYRYaNzEWckHYBmt13pJpUKeFe1aoysE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 30A604BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=jljqkNu5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1766107206; x=1766712006;
	i=johannes.schindelin@gmx.de;
	bh=Ow0pywDh7sGvJmRARC76j3iN2NdISL/S6Y+PBFeBae8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jljqkNu5+fbbvbTLRMDiNU3EVWyZiD3s0oQIH5MzuBq8Iqoz7ZHDwo2mHgIk13Gm
	 yURnUVF7/p7sMIIlM9dCgcvHkSwj1cB04aDxEcDojYLttGpAq0O03MYDAnsADKlku
	 d3OiS9tp52+g6wSIUiD587xWiJKXI0sKa0j2SIdAqiQ7OKRxGDRQa9UcFvJwI3AzJ
	 PBlxBlGLclHsvZ55/6yuYa6dd+lMw1hJ33yT/Vebyq7Xq692cUcufbr8fdAGZRVxC
	 06Edob8UEhL/Fi6lQ4dEbQY+K35+II8/ICPkr8Ae97XLxmAqoWS8p3VRle0hrzJrq
	 WzQ8KZXXg6+VD90SlQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.212]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MryT9-1wHpPU3P1h-00lPeD; Fri, 19
 Dec 2025 02:20:05 +0100
Date: Fri, 19 Dec 2025 02:20:04 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/2] Cygwin: termios: Handle app execution alias in
 is_console_app()
In-Reply-To: <aUPUwmpEQRlhONO0@calimero.vinschen.de>
Message-ID: <a496cdf4-7be8-29ce-057c-75042b67f49d@gmx.de>
References: <20251217093003.375-1-takashi.yano@nifty.ne.jp> <20251217093003.375-3-takashi.yano@nifty.ne.jp> <a4777af3-0f55-1b29-9fa7-cc38c47a3291@gmx.de> <20251218020426.2d726257fd3cce4d2405d67e@nifty.ne.jp> <adf3c29b-5c94-9612-5de7-2f19141b723d@gmx.de>
 <aUPUwmpEQRlhONO0@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:q5kr2Yute9zG6MXhT9Uq5CDBvLryuWZ3P0PVaU6MmfCF2G24flv
 2WO4P/W1u6MHhsQDIqKIDZGPJJG8GFK7ZdK2B9UoVurszX+KJaDzNXe0ThRm4I50xbfhvf2
 IGMAdZkl3LsTGuO1LwCRJIiNzXBhJy1LCsWbzvF5xnmRlsgkmyDgqMfSK307nqiBOPrNQcS
 Yu1IQ408aWwR2/mTJ0DMg==
UI-OutboundReport: notjunk:1;M01:P0:RHm0OS0KZYY=;JD0M2Q+66F9pODWov8yYpIOjNRH
 +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
 gtAOENuY=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Thu, 18 Dec 2025, Corinna Vinschen wrote:

> On Dec 18 09:08, Johannes Schindelin wrote:
> > As I have debugged Cygwin bugs quite often in the past, I can tell you
> > that it is quite frustrating to end up finding commits that leave
> > everything unclear, whose diffs are too large to find any obvious
> > bugs.
>=20
> You'll come across them especially back in CVS times.  CVS didn't
> support patchsets along the lines of "one patch per problem" and the
> blessed way of CVS ChangeLog entries didn't support the notion of
> explaining at great length why a patch was necessary but rather only
> what a patch is doing where.  Whoever had the idea how a CVS ChangeLog
> entry is supposed to look like, got it wrong, and thousands of
> developers followed suit, including me.  Example:
>=20
>   2015-04-22  Corinna Vinschen  <corinna@vinschen.de>
>=20
>       * fhandler_tty.cc (fhandler_pty_slave::fch_close_handles): Don't c=
lose
>       handles not opened via fhandler_pty_slave::fch_open_handles.
>=20
> I have no idea why this was necessary at the time and we have the entire
> 20 years of history since 1995 documented this way.
>=20
> And, we have a couple of years using git, in which we had to wrap our
> heads around the new-fangled way to document patches in git commit
> messages.  And even if some of our commit messages might still be
> lacking, they are much better than some other git entries in projects,
> which don't seem to have learned how useful git commit messages can
> be, if they try to describe the problem they are solving and the way
> how to solve it.  Example from FreeBSD in 2025:
>=20
>   cxgbe: Stop using bus_space_tag/handle directly
>=20
>   Reviewed by:    np, imp
>   Sponsored by:   [...]
>   Differential Revision:  https://reviews.freebsd.org/D53030
>=20
> That's it.  They are getting better, there are actually some git commit
> messages explaining the problem they are trying to solve and how, but
> it's not standard throughout.

And let me state how grateful I am about them getting better!

> What I'm trying to say is this:
>=20
> It doesn't make sense to reflect on the past.
>=20
> We can do better, but for that, let's please stay professional and just
> review the patch.  Tell the patch contributor what you think is wrong
> and wait for v2. Rinse and repeat with v3, v4, ... until you're
> satisfied.
>=20
> Johannes, I think we all understood what you're trying to say, but this
> is *not* how to say it.

Yes, you're right, my behavior was unacceptable. I apologize!

> Review the patch, criticize the patch (including it's commit message)
> and stick to the patch.
>=20
> If you have good arguments or can point out bugs or problems, I and, I'm
> sure, Takashi and others as well, will change their patch accordingly,
> or even drop the patch if it's incorrect.  But: don't tell people *how*
> to spend their *voluntary* time.  Stick to the patch, it's what counts.
>=20
> As a side-note, I lost track of the pty patches which were already GTG
> and the patches which are not.  Takashi, can you please push what's
> already not in question and make a clean restart with a new thread on
> this list?  I'm really confused, and maybe I'm not alone...

I could not pay attention to anything on the list for the past 6h because
my laptop lost its ability to connect to the internet, and I worked
frantically to fix it ever since.

My take was that Takashi's
https://inbox.sourceware.org/cygwin-patches/20251218072813.1644-1-takashi.=
yano@nifty.ne.jp/
is in a pretty decent shape. If it was up to me, I'd take it as-is (in the
interest of moving on, and taking time off over the holidays). That's what
I did in https://github.com/msys2/msys2-runtime/pull/322 and in
https://github.com/git-for-windows/msys2-runtime/pull/122: I replaced my
patches with Takashi's v4.

Ciao,
Johannes
