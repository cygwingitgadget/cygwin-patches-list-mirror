Return-Path: <SRS0=kr8w=VE=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 36FA63858C42
	for <cygwin-patches@cygwin.com>; Thu, 13 Feb 2025 01:37:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 36FA63858C42
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 36FA63858C42
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739410646; cv=none;
	b=CL/Ur/ZrAF79aJnxW4yDLnOKPIxMbNQoAy0bOlrp5J8Hrk2z0fl1qFbyIdwSu4rlXa5agseaQAdnHV7PpHnqFbsD3UDPpRbBzfyFmiatPIXSUQSJI4Ma2P73KfxbVY98lHawXvBPbemWllwdpo9+o4vN5mefPyJUtAjIebk1Xl0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739410646; c=relaxed/simple;
	bh=kJP5ZX0iA8ftD3rlR/feeFTa8M8R90ubgtdo4s5fLyQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Tbv1/OORSV0AoGpInxDHBuD2bal6USRSKcLApRN6PmYKnk49lMo235LidMXMTQ6g9dTd/fq8Wo03YkSajH8ffZeVcDxthSMeDRMidvnq3CjzshWQ3RYNnUiV6AjaK9tVNRr4a+t6o6z5Ew9feWiyOLJIhKP4/6Sm82rn5MdK6qc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 36FA63858C42
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=xWHa1SAD
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id CBFC245C1D
	for <cygwin-patches@cygwin.com>; Wed, 12 Feb 2025 20:37:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=+ZfsATAsnMg+UDFay5rQtN+Gabc=; b=xWHa1
	SAD6o1R6TJ65tClmYp3XIufU1rtZn282C+1bXSfAtLxbczOC+c4G0F/dzX1BIV62
	qpEFd5TzwxYlz6EWAUpqp2BDVZSCQxIZ4tc4qqWY42JivZ/kKkU9dxGn2uzVV768
	dOFKJKD9s1dBZCiAtClFSGZOgOXsWEW8izKf+c=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id C5A6045BF6
	for <cygwin-patches@cygwin.com>; Wed, 12 Feb 2025 20:37:25 -0500 (EST)
Date: Wed, 12 Feb 2025 17:37:25 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/2] Cygwin: expose all windows volume mount points.
In-Reply-To: <522175b6-08ed-9929-3705-aaadf30283ff@jdrake.com>
Message-ID: <ed1a01aa-8908-47a2-70e2-b955c65962c0@jdrake.com>
References: <4f314ab3-8406-0a5c-2cc5-9f2f0af9df50@jdrake.com> <Z60QiLIEAvDzSs5k@calimero.vinschen.de> <9fd9ec5e-f9a5-d510-2792-3e0ca24e3f11@jdrake.com> <522175b6-08ed-9929-3705-aaadf30283ff@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 12 Feb 2025, Jeremy Drake via Cygwin-patches wrote:

> On Wed, 12 Feb 2025, Jeremy Drake via Cygwin-patches wrote:
>
> > It was *supposed* to not return the second one.  Maybe I broke it when
> > trying to break out of the loop early...  I will test this scenario and
> > see why it doesn't work as expected.
>
> Yeah, I never actually looked at how posix_sorted was sorted.  It's sorted
> by length first, then by strcmp.  This was probably a premature
> optimization anyway.  conv_to_posix_path doesn't try to bail early, it
> just continues, and that's going to be a much more common code path than
> this...

Not only that, but there's a sash-vs-backslash mismatch between
native_path and mnt_fsname resulting in the strcasematch not matching.  I
must have only tested the root-of-drive-letter case (where the paths are
like C:), because that was the case the existing code was handling:

diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
index 4be24fbe84..ef3070dbe1 100644
--- a/winsup/cygwin/mount.cc
+++ b/winsup/cygwin/mount.cc
@@ -1645,14 +1645,8 @@ fillout_mntent (const char *native_path, const char
*posix_path, unsigned flags)
   struct mntent& ret=_my_tls.locals.mntbuf;
   bool append_bs = false;

-  /* Remove drivenum from list if we see a x: style path */
   if (strlen (native_path) == 2 && native_path[1] == ':')
-    {
-      int drivenum = cyg_tolower (native_path[0]) - 'a';
-      if (drivenum >= 0 && drivenum <= 31)
-       _my_tls.locals.available_drives &= ~(1 << drivenum);
       append_bs = true;
-    }


I have a fix for these, and I also added a patch 3 on top which removes
the de-duplication code and calls cygdrive_posix_path instead of
conv_to_posix_path.  You can not apply patch 3, apply patch 3 in case it
has to be reverted later, or squash it into 2 if you prefer, there's
options.

