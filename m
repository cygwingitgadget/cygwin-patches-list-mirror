Return-Path: <cygwin-patches-return-2018-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4252 invoked by alias); 2 Apr 2002 11:44:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4234 invoked from network); 2 Apr 2002 11:44:51 -0000
content-class: urn:content-classes:message
Subject: RE: [PATCH] Setup Chooser integration
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Apr 2002 03:44:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA76008AC08@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>,
	"Cygwin-Patches" <cygwin-patches@sources.redhat.com>
X-SW-Source: 2002-q2/txt/msg00002.txt.bz2

Gary, I haven't reviewed this yet...

Can we, with the patch as is, do the following:

Pop up a chooser?

That's it. Nice and simple eh? Well, once I've got the collection based
PickView together, then that should be all there is to it.

What is this in aid of?

Image: you click on 'install' for 'gcc', and up pops a window that lists
everything that gcc depends on (both requires as we have today, and
'suggested' items that aren't always needed but are useful - ie
autoconf), that was not selected before that click.=20

Likewise, if you click ash off, up pops a window listing everything that
depends on ash, with an addiotnal message of "Warning: removing ash will
cause these packages to be removed as well.

So what I'm asking you now, is if your patch to the chooser will work in
with this long term plan, or are they orthogonal, or is it a step
backwards?

I guess we could replace the view in-place within the setup window -
maybe that would be better and cleaner? (Noting that the PickView class
is heading to be a win32 window with reflector inheriting from your
Window class, so we need some way of removing/hiding the saved window
and then restoring it...)

Anyway, is this clear as mud?

Rob
