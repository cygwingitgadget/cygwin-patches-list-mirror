Return-Path: <cygwin-patches-return-2027-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15657 invoked by alias); 4 Apr 2002 08:52:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15618 invoked from network); 4 Apr 2002 08:52:00 -0000
content-class: urn:content-classes:message
Subject: RE: [PATCH] Setup Chooser integration
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Apr 2002 00:52:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA76008AC2A@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>,
	<cygwin-patches@cygwin.com>
X-SW-Source: 2002-q2/txt/msg00011.txt.bz2



> -----Original Message-----
> From: Gary R. Van Sickle [mailto:g.r.vansickle@worldnet.att.net]=20
> Sent: Thursday, April 04, 2002 3:51 PM

> I took it to mean the opposite - if you uninstalled=20
> *binutils*, it would uninstall gcc because gcc depends on=20
> them.  But on further reflection I'm no longer sure even that=20
> is desirable.  If I uninstall ash, should say make get=20
> deleted even though I have bash as sh?

You should get warned at the very least.

I believe that setup should not hinder the power user - such as myself -
but should cater for the innocents, those who think "gee I don't use
ash, I'll remove it".

Potentially bad actions should invoke a warning, with detail about the
affected packages, and the ability to
a) backout the change (click cancel and ash is left as-is)
b) override the automatic behaviour (turn make on and click 'force' and
make is left installed)
c) accept the default.

As for make depending on ash, not on sh, that needs something like
debains 'provides' clause, which is on my todo.

Rob
