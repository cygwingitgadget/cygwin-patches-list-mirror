Return-Path: <cygwin-patches-return-1539-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 11013 invoked by alias); 28 Nov 2001 00:17:19 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 10986 invoked from network); 28 Nov 2001 00:17:14 -0000
From: "Gary R Van Sickle" <tiberius@braemarinc.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire streamas a  header
Date: Mon, 22 Oct 2001 13:26:00 -0000
Message-ID: <000101c177a1$e96ed780$2101a8c0@NOMAD>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1006904553.2048.20.camel@lifelesswks>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2001-q4/txt/msg00071.txt.bz2

> On Wed, 2001-11-28 at 10:09, Christopher Faylor wrote:
> > References?  A simple google search for 'NULL C++ deprecated' didn't
> > unearth this information.
>
> Deprecated may have been too strong a word. Anyway, references:
>
> The C++ annotations - http://www.icce.rug.nl/documents/cpp.shtml
> Specifically...
> http://www.icce.rug.nl/documents/cplusplus/cplusplus02.html#an78

This must predate the ratification of the standard:

"2.5.3: NULL-pointers vs. 0-pointers
[snip]  Indeed, according to the descriptions of the pointer-returning
operator new 0 rather than NULL is returned when memory allocation fails."

When new fails, it doesn't return anything, but rather throws an exception
now.  (Well, unless you use the (std::nothrow) syntax which I've never seen
used and in fact just found out about).  Oops, now it's my turn to document!
;-):  Chuck Allison here: http://www.freshsources.com/newcpp.html

Anywhoo, tell you guys what:  I'll roll all four permutations and whoever
checks it in can pick which patch or patches they want ;-).

--
Gary R. Van Sickle
Braemar Inc.
11481 Rupp Dr.
Burnsville, MN 55337
