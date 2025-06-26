Return-Path: <SRS0=8F9w=ZJ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 3E53F385C6F5
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 23:53:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3E53F385C6F5
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3E53F385C6F5
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750982028; cv=none;
	b=lnw3vzBMjJh0l3nbeu1LQlUxtvMivHW0QSqlRo9oLQ5quOXVnf5b2mtMEmFRN0U9jj8a1Az/kpHKVSxnbIxW/olCa6FWXg440KG42xkvTraldCZTiJf5nZMQf6f+pFTOXPieOQbH1U0n3B/Coh5HWdeGMROpkKdhs3tIgHAb1tY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750982028; c=relaxed/simple;
	bh=HS91SmbWEx25IJOSjIBi15cFH6GanVah8F68+RMQ0m0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=WtzuK8yg7sKGS4IpMgXOXJQG/Wq4qssZbUKe2f2mFZeh7Qy8ooEFVS3xQQ3OE0c4vCDCjgtH5XhK5ic1Vt1ktsVEhgrN0h4avyKBvEancI1RGR0/OEa/LpqLpkThukLNCpceyFqpz382h0TCMctP3x7jTZS3/imCOGpO1tXbywk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3E53F385C6F5
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=ifvXj1b7
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id D520245D31
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 19:53:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=ptjaN
	7NbS2Hi11l7YsPAnLdI3JQ=; b=ifvXj1b7s1gVIpVK6E5VuA86Vpr8rNV+7rW/v
	0jUkWNBm0aXsdcXunGIw52NjDh025syvhvgL06rEtj4aySKyVUfbonuteRJ7XxZe
	a3E9N8dHcd70m4BhkrUCvYxi81+tWZcxRtTCVPoY5yv2TiXeOG3jTaHWXu04jQTA
	Ze3Gy4=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id CF3FC45D30
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 19:53:47 -0400 (EDT)
Date: Thu, 26 Jun 2025 16:53:47 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/5] posix_spawn fast path
Message-ID: <5c8c9bad-0109-b328-195e-0a1d1da0c4cf@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

I *thought* this was all finally good to go, but while working on
posix_spawn tests today I found that it does not properly handle the case
where an (f)chdir file action is present and the path/file argument is
relative.  In that case, it should be relative to the child's cwd, not the
parent's.  As a result, I have left out a patch to actually hook up the
(f)chdir actions in the fast path, so it will continue to fall back to
fork/exec in that case.

I *think* it would need a find_exec overload that uses a specified cwd, as
well as perhaps_suffix.  I am not sure if av::setup needs to know about
this or not.  It takes the path_conv real_path that came out of
perhaps_suffix, and only uses the prog_arg in the case of a script
replacing argv[0].  By the time the interpreter is run, the startup code
would have already chdir'd, so that'd be fine.  I am not sure about the
use of find_exec in av::setup though, I don't think something like
#!./prog is legal but if it is that will need to know the child's cwd too.

Basically, this one little issue is seeming rather complicated, so I
figured I'd get what's working out for review while I figure that out.

Jeremy Drake (5):
  Cygwin: allow redirecting stderr in ch_spawn
  Cygwin: add ability to pass cwd to child process
  Cygwin: hook posix_spawn/posix_spawnp
  Cygwin: add fast-path for posix_spawn(p)
  Cygwin: posix_spawn: add fastpath support for SETSIGMASK and
    SETSIGDEF.

 winsup/cygwin/cygwin.din                  |   4 +-
 winsup/cygwin/dcrt0.cc                    |  21 +-
 winsup/cygwin/local_includes/child_info.h |   8 +-
 winsup/cygwin/spawn.cc                    | 275 +++++++++++++++++++++-
 4 files changed, 292 insertions(+), 16 deletions(-)

-- 
2.49.0.windows.1

