Return-Path: <cygwin-patches-return-3016-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4848 invoked by alias); 22 Sep 2002 00:48:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4830 invoked from network); 22 Sep 2002 00:48:34 -0000
Date: Sat, 21 Sep 2002 17:48:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin_daemon merge
Message-ID: <20020922004849.GD4163@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <00c601c261a5$da1ac200$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c601c261a5$da1ac200$6132bc3e@BABEL>
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q3/txt/msg00464.txt.bz2

On Sat, Sep 21, 2002 at 08:34:06PM +0100, Conrad Scott wrote:
>The attached patch is the (small) subset of the cygwin_daemon merge that
>I need clearance on.  The files affected are:
>
>src/winsup/cygwin/Makefile.in
>src/winsup/cygwin/dcrt0.cc
>src/winsup/cygwin/fhandler_tty.cc
>src/winsup/cygwin/tty.cc
>
>There are just two changes reflected here:
>
>* The code only connects to cygserver when necessary, rather than at
>startup.  This is also the reason for the changes to the
>`cygserver_running' checks.
>
>* The cygserver request objects are now stack rather than heap
>allocated.
>
>I've not attached the whole patch since it is about 300Kb (oops); the
>accumulated ChangeLog entries alone amount to over a 1000 lines.  If
>anyone wants to see this, I'll happily post it or put it up on my
>website.  Effectively I'm intending to merge all outstanding changes
>except for those to cygwin.din, i.e., I'm excluding all the System V IPC
>entry points.

Looks ok.  Go ahead and check it in.

cgf
