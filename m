Return-Path: <SRS0=4oHy=ZD=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 9CBA139299E9
	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2025 18:00:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9CBA139299E9
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9CBA139299E9
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750442424; cv=none;
	b=Sslmcm4NcoNTSxBN88irh8Fl5i012Dey/LL440B8eoNFLxERefAEeSYz15uAkRs7RPhhvVMa9hkh1xD6J5E/oa14l/rE8qcGJVXD0sRhsVPMYHsla3IrZYo1YaCFjyxKP/8UD1T5G3mJTTkryx5IXW6SflAq5gP8oyqbZJZTY6I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750442424; c=relaxed/simple;
	bh=8gOljf1lV9v0SwhEfRt48B6rBy3aYGy8hH3FE4ko8q8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=KF6pFpNOv2lGpCHJSIy9A9WGomtSe07b4dGosi0HVES5u1BwbSLwuCuw4UE8Rtg3qbbxJJzdgKYlZeNRMtmo9Twe3YSNl4Z0cHszrt/IOgUWd1yvEmi7OEf/oYgCpSOE59aT48YwetzhtrBgVDSCzUnNzyz6jlFgQsOBaNdfBlA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9CBA139299E9
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=C6+WuHic
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 7051C45D03
	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2025 14:00:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=UFVoJ
	crQljvwaTs+IiZCGTkyCj8=; b=C6+WuHicDoEqVPIIFXhczn8F+kBocImC/5vrm
	u5B9w5JCGBVjtpffAZovwqqV6DUOH9bXGjZegrr7wdjNP40tMvHU1IWbGmfz+huz
	wIL0kQUunFDjqfW0JHpPR6sVU0gWWPAoEGWLHk7UOgfFXVt91x44vNeW3WGr9eez
	8dQkvY=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 58E0345CFE
	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2025 14:00:23 -0400 (EDT)
Date: Fri, 20 Jun 2025 11:00:23 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 0/4] Add tests for posix_spawn
Message-ID: <a86dac1a-d11d-d993-d0f7-d80fddeff087@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

I got all of the tests that I had written ported to run within the
winsup/testsuite context.  I did not include a test for NULL envp, since
that seems to not be specified by the POSIX standard, and behavior differs
between Cygwin and Linux.

More tests could be added (notably for
posix_spawn_file_actions_add(f)chdir), but this is a good start.


Jeremy Drake (4):
  Cygwin: testsuite: add posix_spawn tests
  Cygwin: testsuite: test posix_spawnp
  Cygwin: testsuite: test signal mask and ignore options.
  Cygwin: testsuite: test posix_spawn_file_actions.

 winsup/testsuite/Makefile.am                  |   4 +
 .../testsuite/winsup.api/posix_spawn/errors.c |  57 ++++++++
 winsup/testsuite/winsup.api/posix_spawn/fds.c | 124 ++++++++++++++++++
 .../winsup.api/posix_spawn/signals.c          |  82 ++++++++++++
 .../testsuite/winsup.api/posix_spawn/spawnp.c |  25 ++++
 .../testsuite/winsup.api/posix_spawn/test.h   |  48 +++++++
 6 files changed, 340 insertions(+)
 create mode 100644 winsup/testsuite/winsup.api/posix_spawn/errors.c
 create mode 100644 winsup/testsuite/winsup.api/posix_spawn/fds.c
 create mode 100644 winsup/testsuite/winsup.api/posix_spawn/signals.c
 create mode 100644 winsup/testsuite/winsup.api/posix_spawn/spawnp.c
 create mode 100644 winsup/testsuite/winsup.api/posix_spawn/test.h

-- 
2.49.0.windows.1

