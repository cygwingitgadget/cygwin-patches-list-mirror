Return-Path: <cygwin-patches-return-1889-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8588 invoked by alias); 25 Feb 2002 05:29:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8549 invoked from network); 25 Feb 2002 05:29:31 -0000
Date: Sun, 24 Feb 2002 21:34:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: help/version patches
Message-ID: <20020225052938.GA24978@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020225052143.77561.qmail@web20004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020225052143.77561.qmail@web20004.mail.yahoo.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00246.txt.bz2

On Sun, Feb 24, 2002 at 09:21:43PM -0800, Joshua Daniel Franklin wrote:
>I've got patches for each of the utils to add/correct the help and
>version output options. There are 13 in all. I incremented the
>version number 0.01 from the ones in CVS/Entries with the
>exception of cygpath. I also added a line based on one found in
>strace that imbeds the compile date into the version output:
>
>        case 'v':
>          printf ("cygpath (cygwin) 1.21\n");
>          printf ("Path Conversion Utility\n");
>          printf ("Copyright 1998-2002 Red Hat, Inc.\n");
>          fputs("Compiled "__DATE__"\n", stdout);
>          exit (0);
>
>Please someone let me know if this is a Bad Idea for some reason.
>I would also very much like to know the best way to submit these.
>Thanks.

Adding version numbers is not a bad idea (although, I can't honestly
think of a time when it would have helped to have this information).
Adding version numbers in the middle of the program, in the middle of a
text string is, IMO, a bad idea.  The version number should be at
the top of the program in a

const char version[] = "something";

and referenced in the version string.

As Robert indicated, using the CVS version number is probably the best
way to handle this.  setup.exe currently uses the CVS version.  Use that
as an example.

cgf

cgf
