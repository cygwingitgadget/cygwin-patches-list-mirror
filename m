Return-Path: <cygwin-patches-return-5991-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13637 invoked by alias); 6 Nov 2006 16:23:24 -0000
Received: (qmail 13586 invoked by uid 22791); 6 Nov 2006 16:23:23 -0000
X-Spam-Check-By: sourceware.org
Received: from 66-162-92-75.static.twtelecom.net (HELO saturn.p3corpnet.pivot3.com) (66.162.92.75)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 06 Nov 2006 16:23:18 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Missing DEV_SD1_MAJOR in dtable.cc
Date: Mon, 06 Nov 2006 16:23:00 -0000
Message-ID: <E05F1FD208D5AA45B78B3983479ECF08E431E6@saturn.p3corpnet.pivot3.com>
From: "Loh, Joe" <joel@pivot3.com>
To: <cygwin-patches@cygwin.com>
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00009.txt.bz2

Thank you so much Eric for setting us straight on submitting patches,
and Corinna for making change before we had a chance to followup with
Eric's recommendation.

We will be sorting out the necessary documentation in order to
submitting the non-trivial patch for mapping up to 64 volumes, as
pointed out by Eric.

One other behavior we noticed is that /proc/partition currently shows
multiple entries of /dev/sdz if number of volumes exceeds 26.  It's a
pretty benign behavior and we don't have any recommended patches.

Thank you all for your support of Cygwin.

Joe Loh

