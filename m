Return-Path: <cygwin-patches-return-1891-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9517 invoked by alias); 25 Feb 2002 14:45:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9398 invoked from network); 25 Feb 2002 14:45:41 -0000
Message-ID: <20020225144532.10947.qmail@web20001.mail.yahoo.com>
Date: Mon, 25 Feb 2002 08:42:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: RE: help/version patches
To: Robert Collins <robert.collins@itdomain.com.au>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <FC169E059D1A0442A04C40F86D9BA76062A5@itdomain003.itdomain.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q1/txt/msg00248.txt.bz2

--- Robert Collins <robert.collins@itdomain.com.au> wrote:
> Some confusion here: I was meaning that having something like:
> const char *revision="$Revision: $ ";
> in the file allows you to then use:
> const char *version = revision[11];
> to obtain the correct version number.
> 
> Rob

I'm not sure I understand. Hard-code the revision in a const char 
instead of directly in a printf? Is that just so it's near the top
of the file and easier to get to? Or is there a way to automate
(without a bunch of sed mess in the Makefile) version numbers?
It looks like the mingw headers have a lines like "* $Revision: 1.2 $ "
in the comments, but I assume that's for a script of some sort to use.


__________________________________________________
Do You Yahoo!?
Yahoo! Sports - Coverage of the 2002 Olympic Games
http://sports.yahoo.com
