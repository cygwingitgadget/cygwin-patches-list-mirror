Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1870E3858428; Mon, 14 Jul 2025 16:06:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1870E3858428
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1752509196;
	bh=TB/8ogq0tIq0roccjRl5uyPWMf8YqCRddcuVAnRMd1c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ArGIR9eUI5sSqRegDASYJaA01zv20B6yII5PnSoa+NEQ2L4tY/xo4Cau6BOUTQEwR
	 +KGCD33TuK39+fmAS6r7JlORjcUR929NVbbuApDseF9iSdPR/K9PVghdpLHpa0QgQJ
	 aGUelv4FrBnDsDE/s8kNusuRyhdhANMW+/v3lTK4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 29145A809E4; Mon, 14 Jul 2025 18:06:34 +0200 (CEST)
Date: Mon, 14 Jul 2025 18:06:34 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2] Cygwin: gendef: stub implementations of routines for
 AArch64
Message-ID: <aHUrCtb7YnU5OvAX@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DB9PR83MB0923C9E8CCEA2C6CF37A60739242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB09233DE9CBD5304BB8D2D69E9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aHTwZ-lCwbHtuIKp@calimero.vinschen.de>
 <DB9PR83MB09239FE0F8762D882392064A9254A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB09239FE0F8762D882392064A9254A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul 14 14:26, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> > Can you please explain how you're planning to go forward from here, so
> we can all understand if and why this patch makes sense during bootstrap?
> 
> My intention is to upstream a minimum set of changes that would allow to build `cygwin1.dll` and `crt0.o`, respectively bootstrap either a Linux-based or Windows x64 Cygwin `aarch64-pc-cygwin` cross-compilation GNU toolchain. With the toolchain available and Cygwin build passing and tests running, the community can further contribute to the project while having CI checks to compare with.
> 
> One can check out what does this actually include in https://github.com/Windows-on-ARM-Experiments/newlib-cygwin/compare/woarm64...aarch64-patch-series1-v1 branch where the commit messages have `SENT` prefix if the change has been already submitted to the mailing list, `TODO` prefix if some rework is needed and `SKIP` prefix if that change is there only to allow validation on our CI https://github.com/Windows-on-ARM-Experiments/newlib-cygwin/blob/woarm64/.github/workflows/cygwin.yml.
> 
> As you can see here https://github.com/Windows-on-ARM-Experiments/newlib-cygwin/actions/runs/16268410995/job/45929514517, with changes from that branch, the tests pass rate is already 216/287 that could serve as the baseline.
> 
> Nitpick: Currently, our CI is using an `aarch64-pc-cygwin` Ubuntu and Windows x64 Cygwin host cross-compilation GNU toolchains, pre-built from our development branch that contains everything we've done so far but once the above branch will be upstreamed there will be only minimum changes left on top of that.
> 
> In context of this patch, the only changes left to add to `gendef` to achieve such baseline results are in https://github.com/Windows-on-ARM-Experiments/newlib-cygwin/commit/c7e082d457e0b2a356d1fce169c2224b46e3a0af commit. They are surely incorrect in a sense of the full signals handling implementations as they are just relocating to the target symbol. I was going to submit them as a separate patches to open discussion whether such temporary implementations could be accepted. Nevertheless, IMO it's better to keep them as separate commits in the history. The full-features signals implementation is in progress but it will take some time to finish and it's actually not needed to bootstrap the cross-compilers and get some baseline test results.
> 
> Please, let me know if something deserves more explanation.
> 
> Radek

Thanks for the explanation.  I pushed your patch.

Looking forward to more :)


Thanks,
Corinna
