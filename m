Return-Path: <cygwin-patches-return-2177-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19332 invoked by alias); 12 May 2002 16:53:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19318 invoked from network); 12 May 2002 16:53:27 -0000
Message-ID: <3CDE9E03.4BAFA2D0@cistron.nl>
Date: Sun, 12 May 2002 09:53:00 -0000
From: Ton van Overbeek <tvoverbe@cistron.nl>
X-Accept-Language: en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Get recursive grep to work on Win9x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00161.txt.bz2

Forgot the Changelog entry in my previous message:

2002-05-12  Ton van Overbeek <tvoverbe@cistron.nl>

	* fhandler.cc (fhandler_base::open): Set error EISDIR when trying
	to open a directory on Win9x instead of EACCESS

Regards,

Ton van Overbeek
