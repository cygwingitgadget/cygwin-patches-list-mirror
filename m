Return-Path: <cygwin-patches-return-1883-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3785 invoked by alias); 24 Feb 2002 15:42:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3742 invoked from network); 24 Feb 2002 15:42:36 -0000
Message-ID: <20020224154235.12431.qmail@web20008.mail.yahoo.com>
Date: Sun, 24 Feb 2002 15:48:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Re: version information for cygcheck
To: Robert Collins <robert.collins@itdomain.com.au>, cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q1/txt/msg00240.txt.bz2

>The usual thing to do for versions is to get the CVS version number and
>apply that.

I'm assuming that lines like this in CVS/Entries give the version numbers:

/cygcheck.cc/1.22/Tue Jan 29 03:08:42 2002/-ko/
/cygpath.cc/1.13/Thu Jan 17 16:54:01 2002/-ko/
/dump_setup.cc/1.4/Tue Jan 29 18:37:00 2002//
/dumper.cc/1.8/Fri Sep 14 15:07:31 2001//
/dumper.h/1.2/Thu Aug 30 16:47:51 2001//
/getfacl.c/1.5/Tue Jan 29 03:08:42 2002/-ko/
/kill.cc/1.10/Mon Oct  8 03:06:25 2001/-ko/
/mkgroup.c/1.9/Tue Jan 29 03:08:42 2002/-ko/
/mkpasswd.c/1.20/Thu Jan 31 12:43:29 2002/-ko/
...

I've got a problem then. Currently `cygpath --version` outputs 1.2, where it
should be 1.13 apparently. Is there a way to get the CVS version up to 1.21
with a patch? Also, if I add --version options to each util,
should I increment the version by .01 each time, so cygcheck will be v1.23,
mkgroup 1.91, etc.? I guess the question should be, does CVS automatically
increment the version by a certain amount after a patch?

Also, if I'm going to patch several files, should I tar up several 
.cc-patch files or do one big patch?

Thanks.

__________________________________________________
Do You Yahoo!?
Yahoo! Sports - Coverage of the 2002 Olympic Games
http://sports.yahoo.com
