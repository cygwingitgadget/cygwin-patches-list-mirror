Return-Path: <cygwin-patches-return-1910-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12513 invoked by alias); 27 Feb 2002 11:03:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12462 invoked from network); 27 Feb 2002 11:03:22 -0000
Message-ID: <003301c1bf7e$ae2cca40$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
References: <20020227045945.5521.qmail@web20009.mail.yahoo.com>
Subject: Copyright years (was Re: help/version patches)
Date: Wed, 27 Feb 2002 03:26:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00267.txt.bz2

> -   Copyright 1998, 1999, 2000, 2001 Red Hat, Inc.
> +   Copyright 1998-2002 Red Hat, Inc.
A quick note about changing Copyright years like this... don't do it! The
two are *not* equivalent.
See http://www.gnu.org/prep/maintain_8.html on the GNU website for more
information, but basically if a new release of Cygwin was tagged in CVS in
any of those years, it should appear as a separate year in a comma separated
list. Ranges are only allowed if development was carried out in that range
of years, but a version was completed for release only in the final year of
the range.

Regards
Chris

