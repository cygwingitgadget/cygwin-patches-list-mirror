Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 713AA3858D26; Mon, 24 Feb 2025 11:45:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 713AA3858D26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1740397553;
	bh=MDlJ4JrQcFOBNgg8DO+xkPs6SxP3To1eon46sp0HM+k=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=VnfONd8I9cKa1y9ntXFLNd6QB3fTvtuya3aAlWq2KxPeEXe+oJT52fbEFi0vRqjtx
	 YW4V8T6QGDTQmhHIMzbW2Hvd+n2zaU6+hAmqrQusdJRVPUuRSQ3nGPDTEr9x9zM0GC
	 SXb/nnaEvDQEduhLnqeyMQEzzjhgJPKrc4XXPLRE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6F478A80610; Mon, 24 Feb 2025 12:45:51 +0100 (CET)
Date: Mon, 24 Feb 2025 12:45:51 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 0/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 TOG Issue 8 ISO 9945 updates
Message-ID: <Z7xb74lbu0tHVfoT@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z7BsdyPyN1sM6SpV@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7BsdyPyN1sM6SpV@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Feb 15 11:29, Corinna Vinschen wrote:
> Hi Brian,
> 
> On Jan 17 10:01, Brian Inglis wrote:
> > Please note some changes are displaced due to rebase conflicts.
> > 
> > Brian Inglis (5):
> >   Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 TOG Issue 8 ISO 9945 move new
> >   Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 new additions available
> >   Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 not implemented new additions
> >   Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 move or remove dropped entries
> >   Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 combine multiple notes
> > 
> >  winsup/doc/posix.xml | 285 ++++++++++++++++++++++++++++---------------
> >  1 file changed, 184 insertions(+), 101 deletions(-)
> > 
> > -- 
> > 2.45.1
> 
> since we're going 3.6 (hopefully) in two weeks, is there a new patchset
> forthcoming?  From what I can tell, the number of changes compared to v7
> isn't that big and it might be nice to get this into the repo for the
> 3.6 docs.  I'm waiting for your stuff before adding POSIX 1.e and eaccess.

Done. Funny enough eaccess was already documented as BSD.


Corinna
