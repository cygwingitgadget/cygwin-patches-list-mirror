Return-Path: <cygwin-patches-return-4027-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13887 invoked by alias); 26 Jul 2003 01:55:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13878 invoked from network); 26 Jul 2003 01:55:11 -0000
Date: Sat, 26 Jul 2003 01:55:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch for winsup/cygwin/Makefile.in
Message-ID: <20030726015509.GA22031@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030723171718.GA2875@linux_rln.harvest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030723171718.GA2875@linux_rln.harvest>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00043.txt.bz2

On Wed, Jul 23, 2003 at 07:17:18PM +0200, Ronald Landheer-Cieslak wrote:
>The attached patch fixes a (micro) problem that has been bugging me for
>a while now: the various header files could not be installed with a
>`make install` without creating the proper directories first.
>
>patch is against current CVS
>
>HTH

I appreciate your tracking this down but I have chosen to just revert
to the previous behavior of always using install-sh.  I've applied a
patch to all of the affected makefiles.

cgf
