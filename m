Return-Path: <cygwin-patches-return-2919-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16719 invoked by alias); 3 Sep 2002 10:32:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16705 invoked from network); 3 Sep 2002 10:32:45 -0000
Content-Type: text/plain;
  charset="us-ascii"
From: Christopher January <chris@atomice.net>
To: cygwin-patches@cygwin.com
Subject: Re: procps
Date: Tue, 03 Sep 2002 03:32:00 -0000
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <200209031132.43008.chris@atomice.net>
X-SW-Source: 2002-q3/txt/msg00367.txt.bz2

The flaw is actually in the /proc fhandler. The /proc implementation should=
 be=20
compatible with the Linux one and hence Linux /proc-based utilities (e.g.=20
procps). The problem is that procps reports the effective user ID in the us=
er=20
ID column and the /proc fhandler currently reports the effective user ID as=
=20
the user ID of the calling process (this is probably incorrect).
The procps utilities have only been modified to compile on Cygwin. They=20
haven't been changed in any other way. Therefore if they report the wrong=20
values it is the /proc fhandler that is at fault, not the procps package,=20
because the /proc fhandler should behave just like the Linux /proc filesyst=
em=20
that the procps utilities were written for.
Hope that makes sense!

Chris
