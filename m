Return-Path: <cygwin-patches-return-1911-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28487 invoked by alias); 27 Feb 2002 11:26:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28449 invoked from network); 27 Feb 2002 11:26:06 -0000
X-Draft-From: ("nnmh:indoos.cygwin-patches" 341)
To: "Chris January" <chris@atomice.net>
Cc: <cygwin-patches@cygwin.com>
Subject: Re: Copyright years (was Re: help/version patches)
References: <20020227045945.5521.qmail@web20009.mail.yahoo.com>
	<003301c1bf7e$ae2cca40$0100a8c0@advent02>
Organization: Jan at Appel
Mail-Followup-To: cygwin-patches@cygwin.com
From: Jan Nieuwenhuizen <janneke@gnu.org>
Date: Wed, 27 Feb 2002 04:41:00 -0000
In-Reply-To: <003301c1bf7e$ae2cca40$0100a8c0@advent02> ("Chris January"'s
 message of "Wed, 27 Feb 2002 11:05:33 -0000")
Message-ID: <m3d6yr17zo.fsf@appel.lilypond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q1/txt/msg00268.txt.bz2

"Chris January" <chris@atomice.net> writes:

>> -   Copyright 1998, 1999, 2000, 2001 Red Hat, Inc.
>> +   Copyright 1998-2002 Red Hat, Inc.
> A quick note about changing Copyright years like this... don't do it! The
> two are *not* equivalent.

No, but need they be?  The silly comma separated list will get out of
hand, at some point in the future.  Each release should hold the (c)
marker that's applicable to that release, why should later releases
hold markers that are not applicable anyway?

> Ranges are only allowed if development was carried out in that range
> of years, but a version was completed for release only in the final
> year of the range.

If you get hold of, say, a 1999 release (tarball, cvs -D checkout),
you'll see the range

   1998-1999

which will cover the only interesting thing: (c) over 1999 release.
If you look at a 2002 tarball, you'll see

   1998-2002

Greetings,
Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
