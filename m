Return-Path: <cygwin-patches-return-1888-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32002 invoked by alias); 25 Feb 2002 05:21:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31957 invoked from network); 25 Feb 2002 05:21:43 -0000
Message-ID: <20020225052143.77561.qmail@web20004.mail.yahoo.com>
Date: Sun, 24 Feb 2002 21:29:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: help/version patches
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q1/txt/msg00245.txt.bz2

I've got patches for each of the utils to add/correct the help and
version output options. There are 13 in all. I incremented the
version number 0.01 from the ones in CVS/Entries with the
exception of cygpath. I also added a line based on one found in
strace that imbeds the compile date into the version output:

        case 'v':
          printf ("cygpath (cygwin) 1.21\n");
          printf ("Path Conversion Utility\n");
          printf ("Copyright 1998-2002 Red Hat, Inc.\n");
          fputs("Compiled "__DATE__"\n", stdout);
          exit (0);

Please someone let me know if this is a Bad Idea for some reason.
I would also very much like to know the best way to submit these.
Thanks.

__________________________________________________
Do You Yahoo!?
Yahoo! Sports - Coverage of the 2002 Olympic Games
http://sports.yahoo.com
