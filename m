Return-Path: <cygwin-patches-return-1628-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9715 invoked by alias); 26 Dec 2001 17:40:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9691 invoked from network); 26 Dec 2001 17:40:12 -0000
Date: Fri, 09 Nov 2001 03:27:00 -0000
Message-ID: <20011226174012.23919.qmail@lizard.curl.com>
From: Jonathan Kamens <jik@curl.com>
To: cygwin-patches@cygwin.com
CC: cygwin-patches@cygwin.com
In-reply-to: <20011226173530.GB21023@redhat.com> (message from Christopher
	Faylor on Wed, 26 Dec 2001 12:35:30 -0500)
Subject: Re: A few fixes to winsup/utils/cygpath.cc
References: <20011226130350.7718.qmail@lizard.curl.com> <20011226173530.GB21023@redhat.com>
X-SW-Source: 2001-q4/txt/msg00160.txt.bz2

2001-12-26  Jonathan Kamens  <jik@curl.com>

	* cygpath.cc (doit): Detect and warn about an empty path.  Detect
	and warn about errors converting a path.
	(main): Set prog_name correctly -- don't leave an extra slash or
	backslash at the beginning of it.
