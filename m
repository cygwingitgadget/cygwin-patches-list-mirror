Return-Path: <SRS0=ViIi=V5=chrisdenton.dev=chris@sourceware.org>
Received: from sender2-op-o14.zoho.eu (sender2-op-o14.zoho.eu [136.143.171.14])
	by sourceware.org (Postfix) with ESMTPS id 24F503858C98
	for <cygwin-patches@cygwin.com>; Mon, 10 Mar 2025 15:46:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 24F503858C98
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=chrisdenton.dev
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=chrisdenton.dev
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 24F503858C98
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=136.143.171.14
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1741621570; cv=pass;
	b=jhCtjL8ohBBcbHnLChr5z0O9WL1MMZIe1eQlVTEnxYoagc+Y92hOMpuaK1qJKOvKbCjNwVoIZGr/n1e9+e9z1up9xMmhO97DFKhfE9LjTc9DLl7YVuEyn7fW89FlWpdJtpN1c76IlWr66ehGKqq+V60pXZjQjeU59KYzts3aZMI=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741621570; c=relaxed/simple;
	bh=0HuJ2v7Av1PDYFilLl4uK5xTC8ph0BXDhn8GaURY5Z8=;
	h=DKIM-Signature:Date:From:To:Message-ID:Subject:MIME-Version; b=fsErgBEzP2s4PdEm278oS6QmlCNbuvL2uKM/WF6cSnawh7GBkp/vtgy8TWb/dGTU+S/gve/YTofTK1FIMEA+SL2KgmZiyK/LS/2u588vRHh3evqkuflR3wY4cIa0NW52bpIANZ+WaMoBjEO/XT3eOtioBwvJZIrA5J/URPCuOEQ=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 24F503858C98
ARC-Seal: i=1; a=rsa-sha256; t=1741621566; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=F0ZqQzwhfIEcBKLVEZ+rW3daUR22j79IP9UNz9vuBbUmRqm7eglHA8/KTtzo1QJ2wnWOaVNyL/1M/RZDP3+laTREAhVirKDM49USYJUW8DNCksHtACwVTrB/fDG0tLZrnPhrLJtWI3xejn8TBlOiryZ+D36xSUUK6jJA2mR3DW4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1741621566; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=B83OwZ217x4vl9qlU+HWF1NqmUU1WqmnnlMAUB+9teg=; 
	b=R8wKCm1lRUmwJGjkDCwwFZ+jL8ospvIm/B0Fl0Mcr33JpocQXBARj8B9cqkhRncsIcdyjbi8a4LIU8n8OO0DsswXznMrVWxe+64u9NALF7MfdNZZHItxJXJgSznxZB+Dgwogyn6qWWdGr1EL65Zj+QgDwsKbiZTZYyNSsYww+5Q=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=chrisdenton.dev;
	spf=pass  smtp.mailfrom=chris@chrisdenton.dev;
	dmarc=pass header.from=<chris@chrisdenton.dev>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741621566;
	s=zmail; d=chrisdenton.dev; i=chris@chrisdenton.dev;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=B83OwZ217x4vl9qlU+HWF1NqmUU1WqmnnlMAUB+9teg=;
	b=Otvg61VmXqQ8TGR0iG07HXDjq2EogJyiq3TQAO6B83jEF7zf/2lRIVQPAsebq7oo
	/0VmY6ib0bI1kbMFihJLk44JhYaY9uQOe8Q6EJ2iBRIED5pin9cvOVEEF8y79vCCB5D
	cYcspPCQD3h4jEXEWINg5pM1E2fqYp2Ivmbqyt6A=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 174162156396039.9496923440571; Mon, 10 Mar 2025 16:46:03 +0100 (CET)
Date: Mon, 10 Mar 2025 15:46:03 +0000
From: Chris Denton <chris@chrisdenton.dev>
To: "cygwin-patches" <cygwin-patches@cygwin.com>
Cc: "Chris Denton" <chris@chrisdenton.dev>
Message-ID: <19580bc11ec.e77085b5699413.240072222093655736@chrisdenton.dev>
In-Reply-To: 
Subject: [PATCH] fix native symlink spawn passing wrong arg0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_INVALID,DKIM_SIGNED,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_STOCKGEN,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This upstreams the msys2 patch:
https://github.com/msys2/MSYS2-packages/blob/6a02000fd93c6b2001220507e5369a726b6381c4/msys2-runtime/0021-Fix-native-symbolic-link-spawn-passing-wrong-arg0.patch

Original msys2 issue:
https://github.com/msys2/MSYS2-packages/issues/1327
---
 winsup/cygwin/spawn.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 06b84236d..b81ccefb7 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -43,7 +43,7 @@ perhaps_suffix (const char *prog, path_conv& buf, int& err, unsigned opt)
 
   err = 0;
   debug_printf ("prog '%s'", prog);
-  buf.check (prog, PC_SYM_FOLLOW | PC_NULLEMPTY | PC_POSIX, stat_suffixes);
+  buf.check (prog, PC_SYM_FOLLOW | PC_SYM_NOFOLLOW_REP | PC_NULLEMPTY | PC_POSIX, stat_suffixes);
 
   if (buf.isdir ())
     {
-- 
2.48.1.windows.1

