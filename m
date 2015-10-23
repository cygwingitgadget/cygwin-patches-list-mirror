Return-Path: <cygwin-patches-return-8263-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128537 invoked by alias); 23 Oct 2015 12:00:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 128505 invoked by uid 89); 23 Oct 2015 12:00:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.4 required=5.0 tests=AWL,BAYES_50,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,SPF_PASS,URIBL_RED autolearn=no version=3.3.2
X-Spam-User: qpsmtpd, 2 recipients
X-HELO: mout.gmx.net
Received: from mout.gmx.net (HELO mout.gmx.net) (212.227.17.20) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 23 Oct 2015 12:00:09 +0000
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0MfVzj-1a9DP43HPX-00P7tj; Fri, 23 Oct 2015 14:00:05 +0200
Date: Fri, 23 Oct 2015 12:00:00 -0000
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Allow overriding the home directory via the HOME variable
In-Reply-To: <20151023094140.GA10312@calimero.vinschen.de>
Message-ID: <alpine.DEB.1.00.1510231357310.31610@s15462909.onlinehome-server.info>
References: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com> <20151021183209.GF17374@calimero.vinschen.de> <alpine.DEB.1.00.1510221731250.31610@s15462909.onlinehome-server.info> <20151023091018.GE5319@calimero.vinschen.de> <20151023094140.GA10312@calimero.vinschen.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UI-Out-Filterresults: notjunk:1;V01:K0:IQLfitTd8Ng=:r77Xn3gA6blPNfsCDN3LNL NpNM/0MWAjRYyb818akl/fhxvwuYvULb2X7xlSwPmw+TLU+ztCD3NUOLD5DBE1o3kNh8v6Ecj MM3JDRqqPfsZzKoZ96g1YhL/5lyBNPKCXfpBQy4oHym3AHKoo9j39IbxRZe5kB3xmHSFDrcwC 0GRFujNSxL6aKNEtq25ysDfxofrIXos7cy4ForDfPZv8/qOZKac9QCdrFduql+KLJ8PmjsVHK B+YjkM80+JK8kwxOKRgBfP2vdTf9g9suu0NObuyeUBdWfkjm8PE6k4yD7nZOKPG41MPJaO9j5 OE9HZTp8hlL82iJuYAOrIb80WaOR3LXJn4QcfBZ3DSFUwd0vMGbfvrzT8siV4YamZhVchqLW7 NYAMFvoBTUdQOolDiyJDZadZAoiyuK6V+4WPEdZs/Aw3erl7/VYe4ufJ30OV180SF2GRTE9De 9FOCDE0IpVFd0+djR4DNVG4OM9CNuqXUw8vMBtP8/xWL41K4PRpD2AoOa+IvOeES9mRDcbjtz tAOCeFCF0NExT/md3lrG5MJa0VVnh56wQyPwHeap30/PKKL/T4rbC+hOs9nYfEQ9mJeEjf71N BU/Z9/c94q3jj9ivtUwWCkryPhxDpIUuZzLn79yfy5Ftfsy7Mk0f7sPJaESH7QbNHNpFdqLPQ dCK1KjgOrlsI/Chua/hVxviTh9bkvuklbob+KTxAAwWQTFLvoz81DaKJf63ob4YHS+JFVSUep pNXvLDYei/h0Km6dtSD5V5i8Z1H6gSUK6vQKFiWU9XnN/0briofBC8uOAeYU4X/iroyD6p4XR F0no3MP
X-IsSubscribed: yes
X-SW-Source: 2015-q4/txt/msg00016.txt.bz2

Hi Corinna,

On Fri, 23 Oct 2015, Corinna Vinschen wrote:

> On Oct 23 11:10, Corinna Vinschen wrote:
> > On Oct 22 17:38, Johannes Schindelin wrote:
> > > 
> > > On Wed, 21 Oct 2015, Corinna Vinschen wrote:
> > > 
> > > > On Sep 16 15:06, Johannes Schindelin wrote:
> > > > > 	* uinfo.cc (cygheap_pwdgrp::get_home): Offer an option in
> > > > > 	nsswitch.conf that let's the environment variable HOME (or
> > > > > 	HOMEDRIVE & HOMEPATH, or USERPROFILE) define the home
> > > > > 	directory.
> > > > > 
> > > > > 	* ntsec.xml: Document the `env` schema.
> > > > > 
> > > > > Detailed comments:
> > > > > 
> > > > > In the context of Git for Windows, it is a well-established technique
> > > > > to let the `$HOME` variable define where the current user's home
> > > > > directory is, falling back to `$HOMEDRIVE$HOMEPATH` and `$USERPROFILE`.
> > > > > 
> > > > > The idea is that we want to share user-specific settings between
> > > > > programs, whether they be Cygwin, MSys2 or not.  Unfortunately, we
> > > > > cannot blindly activate the "db_home: windows" setting because in some
> > > > > setups, the user's home directory is set to a hidden directory via an
> > > > > UNC path (\\share\some\hidden\folder$) -- something many programs
> > > > > cannot handle correctly.
> > > > 
> > > > -v, please.  Which applications can't handle that?  Why do we have to
> > > > care?
> > > 
> > > Oh, the first one that comes to mind is `cmd.exe`. You cannot start
> > > `cmd.exe` with a UNC working directory without getting complaints.
> > 
> > Sure, but then again, why do we have to care?  Didn't you say GfW is
> > using bash?
> 
> In particular, it affects all other native applications as well.  If that
> home setting works for the user outside GfW/Cygwin, and given Cygwin apps
> don't care, why should this suddenly be a problem for GfW?

I did say that Git for Windows uses bash to execute the shell scripts that
are part of Git. However, this says nothing about the *entry* point into
Git for Windows, which is quite often `cmd.exe`. Even worse: users are
free to provide hooks as batch scripts, in which case you encounter that
bad bug again.

The point you make about getent is a good one, I did indeed misunderstand
under what circumstances the modified code path is hit. I will change it
so that it only triggers for the current user.

Ciao,
Johannes
