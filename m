Return-Path: <SRS0=vCDf=52=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 775AC385B535
	for <cygwin-patches@cygwin.com>; Tue, 18 Nov 2025 23:46:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 775AC385B535
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 775AC385B535
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1763509564; cv=none;
	b=UAuU5hkdOPd/8Qk6/1WYg4bla+OcPRotd6N1euvuY342V/hl4t9aKQNQXRjT9qTpkEXIR78YGJ1AdqT9D9BcMqcL2/deDYLc+tWqc9b1mP6WdP9mRANqEH1DigZ1GPtnCc1juRx6kbM4F47H0fDBCYG8FZcsDdd3uN/dR+GIz+g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1763509564; c=relaxed/simple;
	bh=fZt3Dqy60vkz60rdy3FrE4XGaWxj2Skc7hlXz/b9Ug0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=kGkAjnHVEnWXnqqxiaZosuoEgU8tVT43JHevStRjN2bSaZTKsvkfxk4oYwO9Z4uKHtN9+V4BC/5qhOR4AJnO3sW3Lg1JIFAZukKwZQAXOen+9JtM3xGnuL2lmH8/5+V06L5D0tZs9iYDTYxV7uNUocqUn7dO+VMnOtWl0hYrA9Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 775AC385B535
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=DgZh7swI
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20251118234601379.MGNS.50988.HP-Z230@nifty.com>;
          Wed, 19 Nov 2025 08:46:01 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Thomas Huth <th.huth@posteo.eu>,
	Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v3 1/2] Cygwin: dll_init: Always call __cxa_finalize() for DLL_LOAD
Date: Wed, 19 Nov 2025 08:45:17 +0900
Message-ID: <20251118234535.194356-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118234535.194356-1-takashi.yano@nifty.ne.jp>
References: <20251118234535.194356-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1763509561;
 bh=amicu78+d1I+jtQsRQ4Bt8Q3a943VTyS0JKKIZ0X6Jw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DgZh7swIpONd9t9EPluvF3oEWw9rvl6olw36EkoOO7UEgMW1GOaW96Rchg8XoZ7tbH94wwpO
 ErbK6HL+LZkMzzJffCuzP9Or63TK41chiSnroH4Pfq7NPpvDliHqzpIxdBK9DwiWp+SZMIE3dA
 vrpFimbRFkW7CwG4mF6ojMvRlvYplgrGzY0bYT1KzBtYqUfTPPSl9SpygmmSOLkTjr5t29y4ir
 0V5F7/0b9HMhhXM7s0oNVB4+FTK8ZSUwMShHN+FyWDDDsr9h+UMhbi6UztqJnbbqOWmkKFFF3v
 +5fnPlQPqCREGHMFlFGy4ACPSOi4udylFGI/2ZgUfIlzerGg==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

For dlopen()'ed DLL, __cxa_finalize() should always be called at dll
detach time. The reason is as follows. In the case that dlopen()'ed
DLL A is dlclose()'ed in the destructor of DLL B, and the destructor
of DLL B is called in exit_state, DLL A will be unloaded by dlclose().
If __cxa_finalize() for DLL A is not called here, the destructor of
DLL A will be called in exit() even though DLL A is already unloaded.
This causes crash at exit(). In this case, __cxa_finalize() should be
called before unloading DLL A even in exit_state.

Addresses: https://cygwin.com/pipermail/cygwin/2025-October/258877.html
Fixes: c019a66c32f8 ("* dll_init.cc (dll_list::detach) ... Don't call __cxa_finalize in exiting case.")
Reported-by: Thomas Huth <th.huth@posteo.eu>
Reviewed-by: Mark Geisert <mark@maxrnd.com>, Jon Turney <jon.turney@dronecode.org.uk>, Corinna Vinschen <corinna-cygwin@cygwin.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dll_init.cc | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
index 1369165c9..d2ed74bed 100644
--- a/winsup/cygwin/dll_init.cc
+++ b/winsup/cygwin/dll_init.cc
@@ -584,7 +584,16 @@ dll_list::detach (void *retaddr)
 	  /* Ensure our exception handler is enabled for destructors */
 	  exception protect;
 	  /* Call finalize function if we are not already exiting */
-	  if (!exit_state)
+	  /* For dlopen()'ed DLL, __cxa_finalize() should always be called
+	     at dll detach time. The reason is as follows. In the case that
+	     dlopen()'ed DLL A is dlclose()'ed in the destructor of DLL B,
+	     and the destructor of DLL B is called in exit_state, DLL A will
+	     be unloaded by dlclose(). If __cxa_finalize() for DLL A is not
+	     called here, the destructor of DLL A will be called in exit()
+	     even though DLL A is already unloaded. This causes crash at
+	     exit(). In this case, __cxa_finalize() should be called before
+	     unloading DLL A even in exit_state. */
+	  if (!exit_state || d->type == DLL_LOAD)
 	    __cxa_finalize (d->handle);
 	  d->run_dtors ();
 	}
-- 
2.51.0

