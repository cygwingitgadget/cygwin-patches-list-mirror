Return-Path: <cygwin-patches-return-2741-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9297 invoked by alias); 28 Jul 2002 03:45:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9282 invoked from network); 28 Jul 2002 03:45:33 -0000
Message-ID: <3D436906.F0A86453@yahoo.com>
Date: Sat, 27 Jul 2002 20:45:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To: cygwin-patches@cygwin.com
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Habacker <Ralf.Habacker@freenet.de>
CC: cygwin-patches@cygwin.com
Subject: Re: qt patch for winnt.h
References: <016901c2347c$b19f2060$cd6007d5@BRAMSCHE>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00189.txt.bz2

Ralf Habacker wrote:
> 
> The problem with the current implemantation is, that there is no way to hide the
> HANDLE definition and I can't see why an implementation in the following manner
> 

The problem is your problem, not mine or Danny's.  You need to not
define HANDLE if _WIN32 or __CYGWIN__ is defined.

> winnt.h
> 
> #ifndef DONT_DEFINE_HANDLE
> typedef void * HANDLE
> #endif
> 
> makes such big problems as Danny stated.
> 
> It is compatible to the current header, but pave the way for an official qt/x11
> release (or do you expect that trolltech would change their definitions of the
> x11 HANDLE type only based on the fact that this is a precedent ?)
> 

You'll have to fix qt/x11 to live within W32API not the other way round.

Earnie.
