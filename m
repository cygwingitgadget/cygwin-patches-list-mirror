Return-Path: <SRS0=KdRA=YY=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 16F0A3858D38
	for <cygwin-patches@cygwin.com>; Mon,  9 Jun 2025 22:51:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 16F0A3858D38
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 16F0A3858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749509507; cv=none;
	b=jql2hszkZvlkcJHtirZMq4zpLiPUA9bFtGJCd8wktQeFqD44jOVNBKvlZMoxaBNPV6OFb1V/5PBdXKE0q5dKRDOZFikGI7F4MtqhTxWmgz/4EeizxlahcgHS6b3tHvCzGh5PWATyDennRlyFUcyrX9qlolM5QV5l9xqoaDZzkQM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749509507; c=relaxed/simple;
	bh=bd2umop78Wa465WSZ3FUKLFh7LIAG1mbDBQt5BcYu4M=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=qor81ny6NAhwkgmVQRZIZN8vPZiFHQLNHTqHa84BS52p6GdosCV2fEm8HkaSG/Vr21minUgIOmcIAGHnfVDF45Dymfyda6+/yU6qQ0OwUVn9LnZEiawvbnrwoK2DEw34YVMIr3FimXuWAD3j71sxDDyunIxjlYBjBosjVI2AKNk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 16F0A3858D38
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=aCwUjGiA
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id CC2EE45CC9
	for <cygwin-patches@cygwin.com>; Mon, 09 Jun 2025 18:51:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=0nRd5GrQbC+Mygh/1aNEtjFUqOA=; b=aCwUj
	GiA3+xtK+EOCqhcUgdlISC2RhciNeongbgBOctv1MhZMnGN1OsWQfw+eYnhAsmps
	ISpqjkQHhhZl7WLr5wiGEJIaVWaM8L8jM3PBSNZ07Udi5eVm1wQvOqaTY8ELEWHF
	o5s/KCLvWJg0eyYDhAMvHzsmT7SV+gOeOmYxXE=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id C8E0645CC5
	for <cygwin-patches@cygwin.com>; Mon, 09 Jun 2025 18:51:46 -0400 (EDT)
Date: Mon, 9 Jun 2025 15:51:46 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix compatibility with MinGW v13 headers
In-Reply-To: <0f598539-d282-47d8-817a-4c3fc4f7235e@SystematicSW.ab.ca>
Message-ID: <638a2bc6-5cda-6f3e-0fe6-c45a473d821d@jdrake.com>
References: <DB9PR83MB09238924363B70583AA08BA5926BA@DB9PR83MB0923.EURPRD83.prod.outlook.com> <7178d417-9d6b-14b2-95cb-b5c4fb53b463@jdrake.com> <1ef68eee-d80a-4dde-af43-c4fdea1e4c40@SystematicSW.ab.ca> <2aa8fb0c-9a96-b260-2f28-aea8dab08bcc@jdrake.com>
 <0f598539-d282-47d8-817a-4c3fc4f7235e@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,POISEN_SPAM_PILL_3,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 9 Jun 2025, Brian Inglis wrote:

> On 2025-06-09 15:56, Jeremy Drake via Cygwin-patches wrote:
> > > > an #ifndef cmsghdr with a comment about this situation?  Or how do other
> > > > Cygwin headers handle potential conflicts with Windows headers?
> > > I appear to be missing where Mingw headers other than ntstatus.h are
> > > included
> > > in these Cygwin headers so how would Mingw version be defined here?
> >
> > Inside Cygwin, additional Windows headers are included, including winsock
> > headers to implement sockets within Cygwin.
>
> I understand that happens during the DLL build, but I am still not seeing
> where any of those nested header includes, whether __INSIDE_CYGWIN__ or not,
> includes any Mingw headers to define that version.
> So I do not believe any such fix should be applied here.

In file included from
/cygdrive/c/a/cygwin/cygwin/winsup/cygwin/include/cygwin/if.h:17,
                 from
/cygdrive/c/a/cygwin/cygwin/winsup/cygwin/include/ifaddrs.h:42,
                 from ../../../../winsup/cygwin/net.cc:26:
/cygdrive/c/a/cygwin/cygwin/winsup/cygwin/include/cygwin/socket.h:72:8:
error: redefinition of 'struct cmsghdr'
   72 | struct cmsghdr
      |        ^~~~~~~
In file included from ../../../../winsup/cygwin/net.cc:21:
/usr/include/w32api/mswsock.h:174:18: note: previous definition of 'struct
cmsghdr'
  174 |   typedef struct _WSACMSGHDR {
      |                  ^~~~~~~~~~~


> The conflict seems to be between the Mingw SIZE_T & INT definitions and the
> Cygwin size_t & int definitions used in the respective struct cmsghdr
> definitions.

My tweak to the submitted patch, which I don't presume to be correct but I
feel is safer than the version check, is

diff --git a/winsup/cygwin/include/cygwin/socket.h b/winsup/cygwin/include/cygwin/socket.h
index 3a504d223c..6a71bb19a0 100644
--- a/winsup/cygwin/include/cygwin/socket.h
+++ b/winsup/cygwin/include/cygwin/socket.h
@@ -65,7 +65,9 @@ struct msghdr
   int                  msg_flags;      /* Received flags on recvmsg    */
 };

-#if __MINGW64_VERSION_MAJOR < 13
+/* Windows headers define struct cmsghdr via _WSACMSGHDR if
+   _WIN32_WINNT >= 0x0600, as of mingw-w64 v13 */
+#ifndef _WSACMSGHDR

 struct cmsghdr
 {
