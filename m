Return-Path: <cygwin-patches-return-2446-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24646 invoked by alias); 16 Jun 2002 13:13:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24630 invoked from network); 16 Jun 2002 13:13:39 -0000
Message-ID: <3D0C8E74.58BF5B1C@yahoo.com>
Date: Sun, 16 Jun 2002 06:13:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
X-Accept-Language: en
MIME-Version: 1.0
To: egor duda <cygwin-patches@cygwin.com>
Subject: Re: Patch to add NtShutdownSystem() to w32api
References: <100171979873.20020616151345@logos-m.ru>
	 <3D0C835E.CB5CDC30@yahoo.com> <27177303859.20020616164230@logos-m.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00429.txt.bz2

egor duda wrote:
> 
> Hi!
> 
> Sunday, 16 June, 2002 Earnie Boyd earnie_boyd@yahoo.com wrote:
> 
> EB> egor duda wrote:
> >>   NtShutdownSystem() is crude no-caches-flushed-and-no-apps-notified
> >> but almost always working way to restart nt system.
> 
> EB> Uh, these aren't yet a part of w32api.  Cygwin, supplies a header for
> EB> one in winsup/cygwin and I know that both WINE and ReactOS both have
> EB> their own versions.  We have discussed on the mingw-dvlpr list of
> EB> possibly adding this so that everyone doesn't have to invent new
> EB> wheels.  I see that you have a new file for ntdll.h but from where did
> EB> you get your ntdll.def?
> 
> Huh? Hasn't it just been added to winsup/w32api/lib?
> 
> http://sources.redhat.com/ml/cygwin-cvs/2002-q2/msg00276.html
> 

Sorry, missed that.  Commit your patch.

Earnie.
