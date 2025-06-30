Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 25BE23852134; Mon, 30 Jun 2025 09:50:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 25BE23852134
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751277003;
	bh=y8hWMMl1ZuQFeGXJPkALGX1R1Wo3DriMSRo3A0HTNnk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=S6636Fp85DUi2vnA8WaK0NFIdhQCShRwpcVlmpgQHRWB8jE63DCBaxyiHypyixcir
	 od6CBHNa7nMp+8jIUS/j3pGjQJhBx96bybnu/zEhSNuNLbeKSCI3Laj9L+6CbmpUrj
	 PBW3+JpF09D85a1z9U7Pqqc6TNac1gZbO78OZZl4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 77DC7A80B7A; Mon, 30 Jun 2025 11:50:00 +0200 (CEST)
Date: Mon, 30 Jun 2025 11:50:00 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: testsuite: test relative path to exe after
 addchdir.
Message-ID: <aGJdyP8SeAOwNqYD@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <798a4efc-cd12-42be-c155-88284d16c721@jdrake.com>
 <aF5cls2rh-njQ-PF@calimero.vinschen.de>
 <6e4d8f37-ff04-87a4-4003-d5bf23700d3d@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e4d8f37-ff04-87a4-4003-d5bf23700d3d@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 27 10:00, Jeremy Drake via Cygwin-patches wrote:
> On Fri, 27 Jun 2025, Corinna Vinschen wrote:
> 
> > On Jun 26 13:29, Jeremy Drake via Cygwin-patches wrote:
> > > This is apparently relative to the new cwd, but my implementation is
> > > currently treating it as relative to the parent's cwd, so it's worth
> > > testing.
> > >
> > > Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> > > ---
> > >  winsup/testsuite/winsup.api/posix_spawn/errors.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/winsup/testsuite/winsup.api/posix_spawn/errors.c b/winsup/testsuite/winsup.api/posix_spawn/errors.c
> > > index 38563441f3..2fc3217bc0 100644
> > > --- a/winsup/testsuite/winsup.api/posix_spawn/errors.c
> > > +++ b/winsup/testsuite/winsup.api/posix_spawn/errors.c
> > > @@ -15,6 +15,7 @@ void cleanup_tmpfile (void)
> > >
> > >  int main (void)
> > >  {
> > > +  posix_spawn_file_actions_t fa;
> > >    pid_t pid;
> > >    int fd;
> > >    char *childargv[] = {"ls", NULL};
> > > @@ -53,5 +54,12 @@ int main (void)
> > >        posix_spawn (&pid, tmpsub, NULL, NULL, childargv, environ));
> > >  #endif
> > >
> > > +  /* expected ENOENT: relative path after chdir */
> > > +  errCode (posix_spawn_file_actions_init (&fa));
> > > +  errCode (posix_spawn_file_actions_addchdir_np (&fa, "/tmp"));
> >
> > _np?  This is POSIX issue 8 now without the trailing _np.
> > Cygwin supports that already.
> 
> I am also making sure these tests work on Linux (except the new win32
> one), and that doesn't seem to have the functions without the _np suffix.

Ok.  Then GTG


Thanks,
Corinna
