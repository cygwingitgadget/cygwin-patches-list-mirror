Return-Path: <cygwin-patches-return-2584-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19537 invoked by alias); 3 Jul 2002 08:07:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19503 invoked from network); 3 Jul 2002 08:07:11 -0000
Date: Wed, 03 Jul 2002 01:07:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to pass file descriptors
Message-ID: <20020703100706.M21857@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.LNX.4.30L.0207021305230.31764-100000@w20-575-40.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30L.0207021305230.31764-100000@w20-575-40.mit.edu>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00032.txt.bz2

On Tue, Jul 02, 2002 at 01:24:58PM -0400, David E Euresti wrote:
> 
> That I can tell shm doesn't work if the cygserver isn't running.  Why is
> it demanded that passing file descriptors work without the cygserver?  I
> mean currently you can't pass file descriptors so even having one optional
> solution is better than no solution.
> 
> David
> 
> >I have objections.  This is neither fully discussed nor is it clear
> >how to incorporate the call together with the cygserver-less descriptor
> >passing code into fhandler_socket.cc so far.
> >
> >Corinna

[] You saw my other mail on cygwin-developers.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
