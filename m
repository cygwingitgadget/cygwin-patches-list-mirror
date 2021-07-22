Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 6FEC23857014
 for <cygwin-patches@cygwin.com>; Thu, 22 Jul 2021 14:21:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6FEC23857014
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MkprN-1lNq5Y0Gcx-00mO1j for <cygwin-patches@cygwin.com>; Thu, 22 Jul 2021
 16:21:35 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 4C21EA80D6A; Thu, 22 Jul 2021 16:21:34 +0200 (CEST)
Date: Thu, 22 Jul 2021 16:21:34 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Add more winsymlinks values
Message-ID: <YPl+7gROlATG/ggs@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210719163134.9230-1-jon.turney@dronecode.org.uk>
 <YPfYgz0EHe7Yw5ko@calimero.vinschen.de>
 <0b2f3506-b5f8-5e73-b92f-62583dbd4fdb@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b2f3506-b5f8-5e73-b92f-62583dbd4fdb@dronecode.org.uk>
X-Provags-ID: V03:K1:lS9mzDQ3iWdkcc4RZRpwBsPiD0x7I+CLGi0YB+8PqKFMpvcziOb
 xfCoM5//xPpv7hJ4A4xt6rB8a8g4nMgSAQrpe1T+QmduIIidMNHHJfb/TAeeE1gyIAzQNfM
 72goUnNdy3zuQhqFEl/lG9Wxo2NzS3xD5RqNxihZGBSPngrC3/CMWaqfJYVUboQUPlpXGRP
 ZnrVNXknvtdgkMHxqdx9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BtIiuy6Gkzk=:TJaTHayZx+F/7qXldH61+z
 /JbZajTfBxGRby2CTBfcBtnO85mtZ8Yd3VxUzUHdMOXolBVBXPlqzPeIU4W/zLlFxBgIOI83u
 3O/9o3mExmjHqlPgzjZt+MUZ1sLRCZ/TXYK4E/ONSck1zR+/6bAqJD0WcCLQkThbt+y12ZYZ7
 NSOK6jaA230NfFKJBgdkEqM0F9WBoI9ENsWAh5SmVfEILjGcDnDKZuxClmhBfjs5XzjLSCU2d
 qgd7EVZ1ZGXr1y184rg7ZNAF8HPdZANreoLq2iJRKXegAKgqsX2Mrm3cWX6vFsuh8MU/Xtsf6
 1Rj4W6cAUs6oG5ReU4RFUYeIWryr7FNU5K8iQWU0HDiNm0i/UO42dBLeHA+TdjGAzePwM4HgQ
 IA931WaFXjrjhQ80zGLfXkFb7ZSw/Ptb7+e6wVBUq1vpmFTcj3noD34+GdbKclI/AA4oTY9CM
 2suMsXOs5DccfEv2tZKAqjxsqPl3CG2FqqFmV8Hq3SP11luYWLQT7CVRMzL+kzPCwQuf2+eEp
 GkC29AUiK0Ka7x5+1rOwTT3ddWZhqo+qoyYh8Vesi7Xcv5OU2U9+aSnhiyBpdUMUDmMUodirM
 kh1y+Wrx3kbrOeSG8+Y4qGHMPIKzb/85BmikfetDJ4nspSQ1FzzP+VJ8OPREtiaKvs4ebdo1f
 yGjxZLyPg1+F37a0IAlq8KSrlvl++I/wcKPG5h5vXhC7f6dXg58QFmeNoX/H76lgmNajEFArF
 OMb4QMKMh1mIgVSlyEZxISga28kxjGMDjS+hSrMT3yRlUNUEx9VXGkh7vPFrxD0cMeZubW3bC
 Pd7ilm18dkFWCcCSeumYgaQ3Dwte4jRnhrH7MGXkVsA9PsLYt+hKM6lOD8uEFukc6IhA6Y2FG
 YTWLSjT2yNW+TT1IUMFQ==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H2,
 SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
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
X-List-Received-Date: Thu, 22 Jul 2021 14:21:38 -0000

On Jul 22 14:53, Jon Turney wrote:
> On 21/07/2021 09:19, Corinna Vinschen wrote:
> > On Jul 19 17:31, Jon Turney wrote:
> > > I'm not sure this is the best idea, since it adds more configurations that
> > > aren't going to get tested often, but the idea is that this would enable
> > > proper and consistent control of the symlink type used from setup, as
> > > discussed in [1].
> > > 
> > > [1] https://cygwin.com/pipermail/cygwin-apps/2021-May/041327.html
> > 
> > Why isn't it sufficient to use 'winsymlinks:native' from setup?
> 
> I think in the default Windows configuration (developer mode off, no
> SeCreateSymbolicLinkPrivilege), 'native' will try to create a native symlink
> and fail, and fallback to WSL IO_REPARSE_TAG_LX_SYMLINK reparse point, then
> magic cookie + sys attribute.
> 
> This leads to cygwin installations with WSL symlinks created by post-install
> scripts, which can't be put into Docker containers [1], which is the
> original problem I was trying to fix.
> 
> [1] https://cygwin.com/pipermail/cygwin/2020-August/245994.html

Did nobody ask the Docker guys why they fail to support perfectly
valid reparse points?

> I haven't yet looked at adding 'native' symlink support to setup itself, but
> it's probably going to be a bit of a pain.

That may be not a bad idea after all.  Setup typically runs as elevated
process, so it has the required permissions to create native symlinks.
Scripts could then run with CYGWIN=winsymlinks:native by default.

As long as nobody has the hare-brained idea to move a Cygwin distro
manually, native symlinks should be just as well as Cygwin symlinks.

> > The way we express symlinks shouldn't be a user choice, really.  The
> > winsymlinks thingy was only ever introduced in a desperate attempt to
> > improve access to symlinks from native tools, and I still don't see a
> > way around that.  But either way, what's the advantage in allowing the
> > user complete control over the type, even if the type is only useful in
> > Cygwin?
>  If we can come up with a fixed policy that works everywhere, there is no
> advantage.  But that seems unlikely :)
> 
> I could buy an argument that 'native' should be the default (although maybe
> all that does is slow things down in the majority of installs?).

It may slow down installations a tiny little bit because the target
paths have to be converted to POSIX, but I doubt this is more than just
a marginal slowdown.


Corinna
