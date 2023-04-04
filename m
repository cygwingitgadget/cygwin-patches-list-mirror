Return-Path: <SRS0=8BlN=73=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id EC49238515F9
	for <cygwin-patches@cygwin.com>; Tue,  4 Apr 2023 15:08:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EC49238515F9
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1680620880; i=johannes.schindelin@gmx.de;
	bh=VvoNz9MyM9Q4jMjW+7dD0Z5xk31OyH8+RfVPGXgG+g0=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=FOtfUU51NQ7J8DmwHXBNgniW1pFQotPrK8E1nYYXKYQqsq1e/4Xa0AGcs2aPyl0YD
	 bWXzBskEqVaDnfy5nbmy5C2JaCcNUL/ohkEO9qOeZQ0uQMlPzGcnwwXp96O6yoX+AR
	 s2kKXgynevII2Lf+48xbqdZUCKDv2TwW7jRtQ1kUEFjFcQ8HjF1MHhzmZF93b8LyXO
	 5Y9l706IWp94VSiVzWURfRSS/7pf3zQxEoG4FZtHEDR0W/zPcfUG4BCJ+KfdDXbpXK
	 I4ZiOsH14/tADhYYB5Ro9ARHAYD5xNDLrm+7KJ7Pngi5la36ataD582+LqwBTABf05
	 YRXACe6RCcDfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfpSb-1qLUr31jWj-00gH91 for
 <cygwin-patches@cygwin.com>; Tue, 04 Apr 2023 17:08:00 +0200
Date: Tue, 4 Apr 2023 17:07:59 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v6 4/4] Do not rely on `getenv ("HOME")`'s path conversion
In-Reply-To: <cover.1680620830.git.johannes.schindelin@gmx.de>
Message-ID: <8ac1548b9216b5b014947bb3278f9c647103fa91.1680620830.git.johannes.schindelin@gmx.de>
References: <cover.1680532960.git.johannes.schindelin@gmx.de> <cover.1680620830.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SvD0xD2wQ/gWXFCYLIqY528/pfh4ILb06lWV5Ud8gAqtRrR2PXi
 c/CKZAVsGShcvYWZKNrFz/K1QbGLEHUlr3D4s+KVK2k+MyccGXeqgXIyZYKErPDLkk3RBiP
 uTOjcGTCqPtlDVUaunyQvaNaGn9PVbehQXHeyTUk5hP9MQcpLdwwktSkev2k4hwgT0SsfT5
 Ahr1p41ybVd0p1DIdahEA==
UI-OutboundReport: notjunk:1;M01:P0:zXDiVCOrHeg=;h5n2yn1OESEIPWI+XEdhSMHOwdB
 a0BlabiWayNmhUzeQAiyEFOnTPQHx04nq+dzIUcjB5jfmoEdKGnrwhHEjtTHwpiGhERulhQ5o
 3wsdW0gYh6CoSG9WmR8fDjoPW2YVgDberVzdhEFnBwCHJKZrw86lUoP+hbsR++vTnXUWNOC7y
 EXO+aiNcygKx+gTqtCxvYlxz6uLQvD/p9TK2go7+ZUmoLqvjT+RWd1WES2zlDTvhbA4ZB4/fn
 rQxwI1i4N7ava8LZaTRyZMmu/DEsoJa6vXmM2Fsdg9Fn4ltaQ9+3zSoN7uRqiXMhuOa52JIWl
 nKU72Xfm6agr6c2xA6/CHYuLwBRz7rGh29raTIAOHIc7xq4y3VvPp/xCReNUurpTbCYbe4049
 PiMHr/dBykuKnEN4H2bMUF8rn0mm+C+hI4r3YLSrVlebN1o1Zcj0k+HsdXsTusQJ4ogUENbgV
 typjRwM5vZGLKgmCOgdfy8zckqAq0aOMR3TNllQQXGRvLpfnhYUbssMnlithuH+X79rFv+sIt
 de/wvH+2FMRMlhyc2bKw+gVO+kp8dLwFnqsTrgfpGi5uNVasuhsT/6CVjnboXkXdLGswX/dLf
 2csc3Znhi5EiVd8b46dvE09IxOeuzyMVf2GjmkQtlFJO+z/7WKpe2ahUTwcl3+saJHsHESgih
 B1OZ0lA9h5m4Flz/9zjGfeTLrylrYs0GrbZjTb+G10h5PUHI0EUIlVaWCAldLoed0zEsGXIBO
 BRX8wQWds8RDfisyXmcFTnWGLEmzJwDzthu0+DEl6m+Hl6ZLrtEdmA0wX9E4ZmJGmz0qLfzSH
 QqmEAsqz2EEJWOo8D9Wh0tnITvOvZbtXKA3ePZWjSmp/FGx4vhCwbx67jPYcL8obclx/5Qb2e
 rP7ImjbJ06b/QQcAwSDniIRWGxyf51b4LfZtw1zOyFuP7cUX+IyOwP3SpBL3UcVHo6e5W3kfB
 0msojwhBqW8I19klfBa4hJgw3QA=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In the very early code path where `dll_crt0_1 ()` calls
`user_shared->initialize ()`, the Cygwin runtime calls `internal_pwsid ()`
to initialize the user name in preparation for reading the `fstab` file.

In case `db_home: env` is defined in `/etc/nsswitch.conf`, we need to
look at the environment variable `HOME` and use it, if set.

When all of this happens, though, the `pinfo_init ()` function has had no
change to run yet (and therefore, `environ_init ()`). At this stage,
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

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/uinfo.cc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index 5e2d88bcd7..bc9e926159 100644
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
+      if (isdrive (home))
+	return (char *) cygwin_create_path (CCP_WIN_A_TO_POSIX, home);
+      return strdup (home);
+    }

   /* If `HOME` is unset, fall back to `HOMEDRIVE``HOMEPATH`
      (without a directory separator, as `HOMEPATH` starts with one). */
=2D-
2.40.0.windows.1
