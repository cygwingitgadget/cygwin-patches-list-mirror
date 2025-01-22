Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7986F3857C68; Wed, 22 Jan 2025 11:08:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7986F3857C68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737544100;
	bh=dtoH3IeN9e3fVCTamf3ZRoFQW+gygeLscETVcK8OxbA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ZHPOI3zcOhSueGX2pDWoq5eeqpJvyvxdYm11qVDNm1S6o8jdzy3u/Ng6VpuBeUK/9
	 ichZmY9ajtrEbQvIO9N7Z75fcuXDFVRZmJmgCpa2HfMJp+BbW/MdAhQhDuXVCZJ5jP
	 AXdo8Woe2wYbVmy1/A0e6xw0AwL82vSnysl6PdE4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 75C38A80D05; Wed, 22 Jan 2025 12:08:18 +0100 (CET)
Date: Wed, 22 Jan 2025 12:08:18 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 3/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 not implemented new additions
Message-ID: <Z5DRovbwX9QpofDO@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
 <342fdec23f175f816177ac73945ed7fbf5538b90.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z5DQzmtsrcGeFPxx@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z5DQzmtsrcGeFPxx@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Jan 22 12:04, Corinna Vinschen wrote:
> On Jan 17 10:01, Brian Inglis wrote:
> > Add unavailable POSIX additions to Not Implemented section.
> > 
> > Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> > ---
> >  winsup/doc/posix.xml | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> > 
> > diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
> > index ac05657d2246..7e66cb8fc1c0 100644
> > --- a/winsup/doc/posix.xml
> > +++ b/winsup/doc/posix.xml
> > @@ -16,6 +16,9 @@ ISO/IEC DIS 9945 Information technology
> >  - Issue 8.</para>
> >  
> >  <screen>
> > +    CMPLX			
> > +    CMPLXF			
> > +    CMPLXL			
> >      FD_CLR
> >      FD_ISSET
> >      FD_SET
> > @@ -554,6 +557,7 @@ ISO/IEC DIS 9945 Information technology
> >      jn
> >      jrand48
> >      kill
> > +    kill_dependency		
> >      killpg
> >      l64a
> >      labs
> > @@ -1466,6 +1470,8 @@ ISO/IEC DIS 9945 Information technology
> >      mempcpy
> >      memrchr
> >      mkostemps
> > +    posix_spawn_file_actions_addchdir_np
> > +    posix_spawn_file_actions_addfchdir_np
> >      pow10
> >      pow10f
> >      pow10l
> 
> These first three hunks belong into patch #1 of the set, don't they?

No, sorry, into patch #2, of course.


Corinna
