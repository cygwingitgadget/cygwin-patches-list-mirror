Return-Path: <cygwin-patches-return-2667-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15872 invoked by alias); 19 Jul 2002 08:50:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15857 invoked from network); 19 Jul 2002 08:50:28 -0000
From: "Ralf Habacker" <Ralf.Habacker@freenet.de>
To: <jacek@certum.pl>, <cygwin-patches@cygwin.com>
Subject: RE: /dev/dsp
Date: Fri, 19 Jul 2002 01:50:00 -0000
Message-ID: <000001c22f01$4d7f0d00$651c440a@BRAMSCHE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-Reply-To: <3D37C874.1131773@certum.pl>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
X-SW-Source: 2002-q3/txt/msg00115.txt.bz2

> 1) Who is really interested - excluding Nicholas :-) - /dev/dsp works in
> read mode. It will prevent any possible future work to be useless.

Hi Jacek,

a few month ago I've ported an x game (rocks & diamonds 2.0) to cygwin and
recognized, that cygwin /dev/dsp does not allow changing audio buffer size,
which caused some sound issues (see
http://sources.redhat.com/ml/cygwin-apps/2001-10/msg00073.html).

Becauwe this may be a problem for other sound relating cygwin/xfree application
(at least for kde, on which I'm working now, see http://cygwin.kde.org) this may
be an additional topic.

Any comments ?

Regards
Ralf


