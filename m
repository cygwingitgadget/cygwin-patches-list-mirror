Return-Path: <cygwin-patches-return-3310-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8686 invoked by alias); 12 Dec 2002 09:09:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8647 invoked from network); 12 Dec 2002 09:08:58 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Thu, 12 Dec 2002 01:09:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: quandary with pthreads
In-Reply-To: <Pine.WNT.4.44.0212110941590.294-300000@algeria.intern.net>
Message-ID: <Pine.WNT.4.44.0212121002530.171-101000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="372842-12916-1039684130=:171"
X-SW-Source: 2002-q4/txt/msg00261.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--372842-12916-1039684130=:171
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1067


I have attached a bunch of mutex testcases borrowed from the
pthreads-win32 project.

Thomas

On Wed, 11 Dec 2002, Thomas Pfaff wrote:

>
>
> Rob,
>
> thank you that you are willing to add my patches.
>
> FYI, the logic of the mutex stuff is running in pthreads-win32 about 1 1/2
> years now unchanged (guess who has contributed).
>
> I will try to add some of the testcases from pthreads-win32.
>
>
> On Wed, 11 Dec 2002, Robert Collins wrote:
>
> > I *really* want to get Thomas's contribution properly reviewed in time
> > for 1.3.18.
> >
> > Unfortunately my cygwin development machine's hard drive is failing, and
> > it will be off the air for ~ 1 week.
> >
> > So, I'd like to suggest the following:
> >
> > Thomas..
> > If you can write test cases for all the new capabilities you introduce -
> > see the ones I added based on your previous work, and the README in the
> > test-suite dir.
> > Then I will be happy to have your changes committed if the test suite
> > shows no pthreads regressions on a win9x machine, and on an NT kernel
> > based machine.
>

--372842-12916-1039684130=:171
Content-Type: APPLICATION/x-gzip; name="pthreads-tests.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0212121008500.171@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="pthreads-tests.tar.gz"
Content-length: 2697

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
F7MEC3kAeAAA

--372842-12916-1039684130=:171--
