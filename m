Return-Path: <cygwin-patches-return-2158-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7231 invoked by alias); 6 May 2002 18:51:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7216 invoked from network); 6 May 2002 18:51:56 -0000
From: "Norbert Schulze" <Norbert.Schulze@web.de>
To: <cygwin-patches@cygwin.com>
Subject: RE: automatic TZ in non-english windows
Date: Mon, 06 May 2002 11:51:00 -0000
Message-ID: <000201c1f52f$18bb9860$010115ac@NEXUS>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20020506120908.I9238@cygbert.vinschen.de>
X-SW-Source: 2002-q2/txt/msg00142.txt.bz2

> What I'd like to see is just a bit more of an
> explanation why the patch is needed.  Especially two points,
> where in the common standards did you find that a timezone
> string must be three chars to be valid and could you give
> an example what else is stored at that point in non-english
> OSes?

excerpt from http://www.opengroup.org/onlinepubs/007908799/xbd/envvar.html

----------------------------------------------------------------------
stdoffset[dst[offset][,start[/time],end[/time]]]

Where:
std and dst

Indicates no less than three, nor more than {TZNAME_MAX}, bytes that
                       ^^^^^
are the designation for the standard ( std ) or the alternative
( dst - such as Daylight Savings Time) timezone. Only std is required;
if dst is missing, then the alternative time does not apply in this
locale. Upper- and lower-case letters are explicitly allowed. Any
graphic characters except a leading colon (:) or digits, the comma (,),
the minus (-), the plus (+), and the null character are permitted to
appear in these fields, but their meaning is unspecified.
----------------------------------------------------------------------

As well in localtime.cc (tzparse) line 1173 and line 1188 parsing of
TZ is aborted when the std or dst fields have less than three characters.

The std and dst fields are computed in localtime.cc (tzsetwall) by an
algorithm that takes every capital letter from the StandardName and
DaylightName members of the TIME_ZONE_INFORMATION struct.

In an english windows these members have values like:

Eastern Standard Time
Eastern Daylight Time
Pacific Standard Time
Pacific Daylight Time
Central European Standard Time
Central European Daylight Time

and the computed values are:

EST
EDT
PST
PDT
CEST
CEDT

These are all valid timezone names because they have three or more
characters. But they are not all correct. The correct timezone names
are CET and CEST for Central European Time and Central European Summer Time.
But that's another point.

In a non-english windows these members may have values like: (e.g. german)

Eastern Normalzeit
Eastern Sommerzeit
Pazifik Normalzeit
Pazifik Sommerzeit
Westeuropaische Normalzeit
Westeuropaische Sommerzeit

and the computed values are:

EN
ES
PN
PS
WN
WS

As you can see all values are invalid and incorrect timezone names.

Because non of the cygwin tools use the tzname variable my patch
sets the std and dst fields to the default value wildabbr (three spaces)
if the computed names are invalid. This prevents tzparse from aborting
and a correct timezone offset is computed, which is needed by many cygwin
functions/tools.

Regards
    Norbert

