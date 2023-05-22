Return-Path: <SRS0=TlDz=BL=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id B284B3858289
	for <cygwin-patches@cygwin.com>; Mon, 22 May 2023 11:13:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B284B3858289
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1684753983; i=johannes.schindelin@gmx.de;
	bh=v2rah2SndFrZDG1oy1FFZ2M9WhecDuV0LD//ZskFFjU=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=qspxcplP17jP5it6aoBlkntD6WaYUO3FZ9qi5sgvL9wcKKXMWIzfLC5KFis1o+XOE
	 QvDQnpqdHAtnk12Xln1t1Kkjz+XQa9HorBcVPf9QbtC66WPyd1XXJOI2BzzrHeHES3
	 Tfl+IlTkVkLsKnAlathHegr03URzyXtJOizxYu/csfPRwbBRZQJHFYuwuDOQExdYSL
	 nB3T2DImWET74C4YRrOFpKqrkUeGA5YCNHlZcZ+8D14XNIRdb5xkjwH7IDHgsUyqjN
	 pWd6KXxe6PyRiML42JSta2RTykpRXwK0MUjZw5xxQsyQSIDQDXqleqMUf45qdASi4B
	 YBE4SOysJaxpA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.249]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKKh-1puDxu1pIP-00Fnmj for
 <cygwin-patches@cygwin.com>; Mon, 22 May 2023 13:13:03 +0200
Date: Mon, 22 May 2023 13:13:02 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v7 4/4] Do not rely on `getenv ("HOME")`'s path conversion
In-Reply-To: <cover.1684753872.git.johannes.schindelin@gmx.de>
Message-ID: <002d94a244166f04d4326c18b5ab475e3a9f6b17.1684753873.git.johannes.schindelin@gmx.de>
References: <cover.1680620830.git.johannes.schindelin@gmx.de> <cover.1684753872.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:y/AxDzFWsJXffn3A83EHZwidx1bOLMRrWYQteIbsC8RumrLssE5
 Eo0Sfu8Ty10PgIYPoPZhJK/BTqrOdkTom19iR5TeljMXqv758Z5kMVemcpKOSkuydHCY7uS
 +DWWP9pGAh8yvD/g2j92a9bnjalxb4i6o1YUa0mwV+nkf7XvylsUZztfvsZob4ly5AG6t5t
 V2ZoK0kMLKDiUsVmw+AwA==
UI-OutboundReport: notjunk:1;M01:P0:Z/9JlJqy0is=;rcKafhsjAoyYeagRrui5ujZH2vU
 rV1HZsHIf3dP4JAafHMd1MgG6lW4AUKdKNmuFkwdsy5gvTxNYA6r4caOjTnENyShTtWJFpwTN
 dBf8VVdVljvsIH6djrRDDezuedTZDmid5+YVbX8mqGXQmILJJIYpeij7cnSY9BrZIqHbashN4
 tPJFdRNRLTWA09t0uALYDrtjmLOvGr5JqyYxsmpUWVHK5+U8KI6WHXkAvUK2QjNX4dZoVGInv
 LleDFZPle0A13mey1OtHvw0VutUzwZqtZwFVH8y0rSoe+0Ott8c3cvmwe4TWScb8e0ODz7k+s
 LUMCW9MRguXpPI9lNxs1iK05LS41CfZ1Adk37kvc3JkbBBzyqDIkxh3Az0bFRL/56JT9QIQxC
 8HKqWDEof5LtHyUHbyzRFk/jkuxhxAQVPnzwhtj+asqi0eSwfmkwTrAY3p/03ytki0QZjFb8K
 EHAG9RwENjRw8YTtavmiyF3Mapdlhjyj2xUfJ0A43gNJUTnn1FH8h6D57zYZ8ZuttJyIkvUqM
 lNVS3X8HZErFieH4jbRqgEczR4REtR1cHxe7EKQuhrQZSTBcCfrDdDuOMcu8lHTN49ByHLGwT
 kazRwZESMEvo4p4zZb1vTGdY6sQAXoWP+qn8cT5MpIpzucPY//uyxr/rHMmWPWCrCoyOeoyzW
 m4i9bwPLIMhpHUJMRgjW4Kd4urk4Td2VXGDnh/5QZk2LQhqR/037TpPXLmUfkySa9V5G2IXx6
 x+iiaiFM6kznldvB7nMvKatk8kvVwP3Jm2mWF0bCOXeGQS5ShmusqIASCCT6AmgRax89vjAq8
 APUDvmi5oDA7MBb5afdX0BLgq7iAMgy2PrTchEs0xVV/0/M34ND1JUeN7++qCgWWoDubGJeQf
 KQ83Po9UzwE03rch9qL0if4YS3rSNjC8CgHMv38fLYWjiy+qg02DkXwvEfG/VAcRQTQ4Mjqci
 MYCYhhzhBiQvARGIMB6WZV41nhg=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In the very early code path where `dll_crt0_1 ()` calls
`user_shared->initialize ()`, the Cygwin runtime calls `internal_pwsid ()`
to initialize the user name in preparation for reading the `fstab` file.

In case `db_home: env` is defined in `/etc/nsswitch.conf`, we need to
look at the environment variable `HOME` and use it, if set.

When all of this happens, though, the `pinfo_init ()` function has had no
chance to run yet (and therefore, `environ_init ()`). At this stage,
therefore, `getenv ()`'s `findenv_func ()` call still finds `getearly ()`
and we get the _verbatim_ value of `HOME`. That is, the Windows form.
But we need the "POSIX" form.

To add insult to injury, later calls to `getpwuid (getuid ())` will
receive a cached version of the home directory via
`cygheap->pg.pwd_cache.win.find_user ()` thanks to the first
`internal_pwsid ()` call caching the result via
`add_user_from_cygserver ()`, read: we will never receive the converted
`HOME` but always the Windows variant.

So, contrary to the assumptions made in 27376c60a9 (Allow deriving the
current user's home directory via the HOME variable, 2023-03-28), we
cannot assume that `getenv ("HOME")` returned a "POSIX" path.

This is a real problem. Even setting aside that common callers of
`getpwuid ()` (such as OpenSSH) are unable to handle Windows paths in the
`pw_dir` attribute, the Windows path never makes it back to the caller
unscathed. The value returned from `fetch_home_env ()` is not actually
used as-is. Instead, the `fetch_account_from_windows ()` method uses it
to write a pseudo `/etc/passwd`-formatted line that is _then_ parsed via
the `pwdgrp::parse_passwd ()` method which sees no problem with
misinterpreting the colon after the drive letter as a field separator of
that `/etc/passwd`-formatted line, and instead of a Windows path, we now
have a mere drive letter.

Let's detect when the `HOME` value is still in Windows format in
`fetch_home_env ()`, and convert it in that case.

For good measure, interpret this "Windows format" not only to include
absolute paths with drive prefixes, but also UNC paths.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/uinfo.cc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index 5e2d88bcd7..21d729d5dc 100644
=2D-- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -929,7 +929,13 @@ fetch_home_env (void)
   /* If `HOME` is set, prefer it */
   const char *home =3D getenv ("HOME");
   if (home)
-    return strdup (home);
+    {
+      /* In the very early code path of `user_info::initialize ()`, the v=
alue
+         of the environment variable `HOME` is still in its Windows form.=
 */
+      if (isdrive (home) || home[0] =3D=3D '\\')
+	return (char *) cygwin_create_path (CCP_WIN_A_TO_POSIX, home);
+      return strdup (home);
+    }

   /* If `HOME` is unset, fall back to `HOMEDRIVE``HOMEPATH`
      (without a directory separator, as `HOMEPATH` starts with one). */
=2D-
2.41.0.rc0.windows.1
