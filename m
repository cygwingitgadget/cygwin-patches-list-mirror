Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 66F2E3858D20; Wed, 20 Nov 2024 15:26:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 66F2E3858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732116392;
	bh=6Or7OSlJ/XOQhSH2jnXJOmpU7QztT5xiU8b7/+hJ16o=;
	h=From:To:Subject:Date:Reply-To:From;
	b=IS/Uvhi6P3p1qAY3u2q44F/asV2zEIVVaRuK1+/rdEIlsy6R/Qt5SdasEwIZCjMiG
	 kl6ZeRfXd92fxDYtY1ck6d+gkhVChvbO/IOrqRb/QxClUa6UROl3fewk5WEts3hPov
	 mgcEJ7TB9P76960dPi5BTeG0rd5Qf1OPGpQy4tkg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 61F6CA80C7E; Wed, 20 Nov 2024 16:26:30 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com,
	Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: SetThreadName: avoid spurious debug message
Date: Wed, 20 Nov 2024 16:26:30 +0100
Message-ID: <20241120152630.1617419-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.47.0
Reply-To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

The following debug message occassionally shows up in strace output:

  SetThreadName: SetThreadDescription() failed. 00000000 10000000

The HRESULT of 0x10000000 is not an error, rather the set bit just
indicates that this HRESULT has been created from an NTSTATUS value.

Use the IS_ERROR() macro instead of just checking for S_OK.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/miscfuncs.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/miscfuncs.cc b/winsup/cygwin/miscfuncs.cc
index 767384faa9ae..4220f6275785 100644
--- a/winsup/cygwin/miscfuncs.cc
+++ b/winsup/cygwin/miscfuncs.cc
@@ -353,7 +353,7 @@ SetThreadName (DWORD dwThreadID, const char* threadName)
       WCHAR buf[bufsize];
       bufsize = MultiByteToWideChar (CP_UTF8, 0, threadName, -1, buf, bufsize);
       HRESULT hr = SetThreadDescription (hThread, buf);
-      if (hr != S_OK)
+      if (IS_ERROR (hr))
 	{
 	  debug_printf ("SetThreadDescription() failed. %08x %08x\n",
 			GetLastError (), hr);
-- 
2.47.0

