Return-Path: <cygwin-patches-return-2552-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12424 invoked by alias); 1 Jul 2002 08:04:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12292 invoked from network); 1 Jul 2002 08:04:17 -0000
Date: Mon, 01 Jul 2002 01:04:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to pass file descriptors
Message-ID: <20020701100414.B17641@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.LNX.4.33.0206291214370.4768-100000@this>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0206291214370.4768-100000@this>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00000.txt.bz2

On Sat, Jun 29, 2002 at 12:22:04PM -0400, David Euresti wrote:
> So here are three reasons to use the cygserver to pass file descriptors.
> 
> #1 Security - as has been mentioned.  Althought currently the patch has no 
> security it can easily be added.
> 
> #2 My application is not allowed to block on anything.  I 
> can't send a file descriptor and then block this changes the whole 
> semantics of sendmsg.  I call select and it tells me I can write but then 
> my call to sendmsg blocks?  That is really bad.  

A change in the concept would eliminate that.  The sender process
could start a thread and duplicate all file handlers/HANDLEs.  So
the main thread in the sender isn't blocked.  The receiver is blocked
anyway since it has to wait until all file handle information has
been correctly transmitted/regenerated.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
