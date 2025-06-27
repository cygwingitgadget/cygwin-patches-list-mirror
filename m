Return-Path: <SRS0=jaUm=ZK=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 396CF385C418
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 17:00:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 396CF385C418
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 396CF385C418
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751043613; cv=none;
	b=DF8KSrWm+zZn6kjcy7/QCLKTKXs5fau6k3adhJadL2s0GcFqP7MRWudIv6qeqzLiMh0g/A/yV032yO/3Qlgsq+OPb4/XW5S7kShe+s4JjX7cW445ZaGwU7+d5qCtXAlHf7WbwuN1Yy7XGmTuopxMRiautO/p4Nbhc+go5OJNhTU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751043613; c=relaxed/simple;
	bh=HoiDuz+qqlajNmibVtFtXCqPyRANMfNPrgJWSeWM5xw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=WpwP1wD1ZHHEZwBXAMCZ5auiCO1zLZvaqKKLhbrmvIYfEX3E8LUHRRf8dWayHYdCeuxMBfmJdhySZPO/iKfkSkZqrjQYDb+/W8VGU0A1SWiEW4IH7FLiIciDMZEQ+H7z299w+Hi0+PWlowxK+jAGjGkkNANzOpnw9DcyG2uOjgo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 396CF385C418
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=rIq1jwEL
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id E97D945D23
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 13:00:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=ZOHfmlMWCXVaBo4Ci2g57INni8A=; b=rIq1j
	wELA4ny9Gp1acNRdrRmn6FNgTpZotvPr5qcyKwyP2vC/UcFqRQhkLvG2qExrUWcV
	X+B1cO2Cz2yhTuBJ+RTMf2vH1drb1eMxo9VzhFWbYyT6H+O9BQRyRLvgzQVLZbzE
	pPGkP0ZaByLWthPSxmigkvYDdtIsJdLbyAX0d0=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id D12C545D22
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 13:00:12 -0400 (EDT)
Date: Fri, 27 Jun 2025 10:00:12 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: testsuite: test relative path to exe after
 addchdir.
In-Reply-To: <aF5cls2rh-njQ-PF@calimero.vinschen.de>
Message-ID: <6e4d8f37-ff04-87a4-4003-d5bf23700d3d@jdrake.com>
References: <798a4efc-cd12-42be-c155-88284d16c721@jdrake.com> <aF5cls2rh-njQ-PF@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 27 Jun 2025, Corinna Vinschen wrote:

> On Jun 26 13:29, Jeremy Drake via Cygwin-patches wrote:
> > This is apparently relative to the new cwd, but my implementation is
> > currently treating it as relative to the parent's cwd, so it's worth
> > testing.
> >
> > Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> > ---
> >  winsup/testsuite/winsup.api/posix_spawn/errors.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/winsup/testsuite/winsup.api/posix_spawn/errors.c b/winsup/testsuite/winsup.api/posix_spawn/errors.c
> > index 38563441f3..2fc3217bc0 100644
> > --- a/winsup/testsuite/winsup.api/posix_spawn/errors.c
> > +++ b/winsup/testsuite/winsup.api/posix_spawn/errors.c
> > @@ -15,6 +15,7 @@ void cleanup_tmpfile (void)
> >
> >  int main (void)
> >  {
> > +  posix_spawn_file_actions_t fa;
> >    pid_t pid;
> >    int fd;
> >    char *childargv[] = {"ls", NULL};
> > @@ -53,5 +54,12 @@ int main (void)
> >        posix_spawn (&pid, tmpsub, NULL, NULL, childargv, environ));
> >  #endif
> >
> > +  /* expected ENOENT: relative path after chdir */
> > +  errCode (posix_spawn_file_actions_init (&fa));
> > +  errCode (posix_spawn_file_actions_addchdir_np (&fa, "/tmp"));
>
> _np?  This is POSIX issue 8 now without the trailing _np.
> Cygwin supports that already.

I am also making sure these tests work on Linux (except the new win32
one), and that doesn't seem to have the functions without the _np suffix.
