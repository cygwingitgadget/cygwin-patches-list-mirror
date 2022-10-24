Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	by sourceware.org (Postfix) with ESMTPS id 095A63858439
	for <cygwin-patches@cygwin.com>; Mon, 24 Oct 2022 09:28:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 095A63858439
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N4h7p-1pC1lJ1BRv-011jOn; Mon, 24 Oct 2022 11:28:46 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A0354A80CFE; Mon, 24 Oct 2022 11:28:44 +0200 (CEST)
Date: Mon, 24 Oct 2022 11:28:44 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Cygwin: pty: Fix 'Bad address' error when running
 'cmd.exe /c dir'
Message-ID: <Y1ZazH6objN99mSz@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20221022053420.1842-1-takashi.yano@nifty.ne.jp>
 <6EED0655-71E5-43B4-988D-B5935AED8EC0@gmx.de>
 <20221022151247.1b1cf1e3fc13d4c3dabc2191@nifty.ne.jp>
 <n4on0p20-970q-8693-7n50-4q22370s7rr5@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <n4on0p20-970q-8693-7n50-4q22370s7rr5@tzk.qr>
X-Provags-ID: V03:K1:JqSAJedLbVCjBWUSvBg3YlNMl6OfxxoDX31HMDBgq/upuhmkzAj
 JyTyMfdG7N2CHiU6J4dqYeGdAxZaXvMsaNnc4Ns2Wen+G5OLveswEa4SX6fT0604n6pejK8
 Q6Ed9HyNQ4087kKHLu419sYZb8S6ua0iW2G5aZdA4IHt1XIuCRBiBji+xGjhjiMuWFotyfZ
 tZ+C2aZtWThla/FifFi0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dNzZbqdtUSU=:0zXLFP9mmvgGRlD1Z6ZLaL
 mqgdec5J0mT46S5SiTQkfMO3+YBhnD4M1JeHxNjhTxgyDOV5HoyjYYZJQ7EmKrjvhpWvuMpNM
 YLQYKNl5wTnU7K5nSDIOQARXTVV40ncLZBFH3DWvULRHIuIdDglJlFOgKfU3ybQEVJTla93i3
 0+1lHF4pM1ehhct8y6LjZNl4Os8VJyW3fg3XT6GCyjosYTa+tNPS8uFKN2PmdGdvR4Mf92vnt
 IC4mtWeMjIelzfI88HPUckzVv28/7VsmDK6d7X3onTsoqXfPXEwaeWvsNMkmyYF3Zi7jgOApb
 SMB9S/VMkKfVdMfrm8DOPvsmexlW+Upib1NlgWeyK5xaivbYa6Eue/c/K4Kv0aF817wecN83l
 /kHvDvfBSXaktFCqbUKUl5fG47NViEVj7Gq5Qufnn30qlSGzGOwtHHJ7tTDkxBJBiYrIofrc8
 DBUwINR4QHOwBAIyceVnLnxRUqDblp3GQgcDq+Ad14HM4MJ+/TW3Mg1E9iGwqaFqzBIl412by
 aecf/Iw+olz4RfXRw4waRCLO9tGK4OmJ6z6EbBb4VDB1bme+GRzsFW05fXcbvTQ4nC7Udp6rf
 BDDu7AtwJZuUZd7aVSoHGV9yqdQJOmtQgIVL3XDFtGRj8BOJf6WJTz17vOZPS1Krn+NDIDY7p
 fjquPSUgX9GfV6NdP4Em+7sVBDW+t6a10QMaaf89eE82ZEsLHh1xmZzn1yWntZew3NugXoLXD
 vjHpSBotV+scEgE6F8OPXnTZH14iaDC+8D+WncHpGRnlJgHpFwZc8HuXMq6eHcsL4oGyKHJBE
 IW3xntql/MAG1d61MZMN+mV/PoQfg==
X-Spam-Status: No, score=-101.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Oct 23 22:42, Johannes Schindelin wrote:
> On Sat, 22 Oct 2022, Takashi Yano wrote:
> > On Sat, 22 Oct 2022 07:58:37 +0200
> > Johannes Schindelin wrote:
> > > On October 22, 2022 7:34:20 AM GMT+02:00, Takashi Yano <takashi.yano@nifty.ne.jp> wrote:
> > > >- If the command executed is 'cmd.exe /c [...]', runpath in spawn.cc
> > > >  will be NULL. In this case, is_console_app(runpath) check causes
> > > >  access violation. This case also the command executed is obviously
> > > >  console app., therefore, treat it as console app to fix this issue.
> > > >
> > > >  Addresses: https://github.com/msys2/msys2-runtime/issues/108
> > > >---
> > > > winsup/cygwin/spawn.cc | 2 ++
> > > > 1 file changed, 2 insertions(+)
> > > >
> > > >diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> > > >index 5aa52ab1e..4fc842a2b 100644
> > > >--- a/winsup/cygwin/spawn.cc
> > > >+++ b/winsup/cygwin/spawn.cc
> > > >@@ -215,6 +215,8 @@ handle (int fd, bool writing)
> > > > static bool
> > > > is_console_app (WCHAR *filename)
> > > > {
> > > >+  if (filename == NULL)
> > > >+    return true; /* The command executed is command.com or cmd.exe. */
> > > >   HANDLE h;
> > > >   const int id_offset = 92;
> > > >   h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
> > >
> > > The commit message of the original patch was substantially clearer and offered a thorough analysis. This patch lost that.
> >
> > The reason which I did not apply your patch as-is is:
> > is_console_app() returns false for 'cmd.exe /c [...]' case
> > with your patch, while it should return true.

I'm a bit concerned here.

Did you notice the fact that a NULL filename *also* results in calling
CreateFileW with a NULL filename, in calling ReadFile and CloseHandle
with a INVALID_HANDLE_VALUE, and running memmem on an uninitialized
buffer?  This doesn't result in an immediate crash, but it's a serious
problem nevertheless.

Johannes' patch didn't fix that.  Takashi's patch does, but somehow you
both don't even mention it.

> Sure. And a simple "can you please modify the patch to return `true` in
> the `cmd /c <command>` case" feedback would have avoided all the
> contention.

Well...

> Having said that, I fear that you completely misread what I wrote, as I
> did not comment on your diff but on your quite improvable commit message.

Sorry, but we can't change the commit message retroactively because of
the commit hooks which disallow forced commits on non-topic branches.

However, two points:

- I'm wondering if the patch (both of yours) doesn't actually just cover
  a problem in child_info_spawn::worker().  Different runpath values,
  depending on the app path being "cmd" or "cmd.exe"?  That sounds like
  worker() is doing weird stuff.  And it does in line 400ff.

  So, if the else branch of this code is apparently working fine for
  "cmd" per Takashi's observation in
  https://cygwin.com/pipermail/cygwin-patches/2022q4/012032.html, how
  much sense is in the if branch handling "command.com" and "cmd.exe"
  specially?  Wouldn't a better patch get rid of this extra if and
  the null_app_name variable instead?

- While we never had a rule for that, it would be great in future,
  if the commit message contains a "Fixes:" tag, if it's clear that
  the patch fixes an older patch, along the lines as the Linux
  kernel does it.  As an example, for this patch it would have been
  great to see a footer in the commit message like this:

  Fixes: 2b4f986e499f ("Cygwin: pty: Treat *.bat and *.cmd as a non-cygwin console app.")


Corinna
