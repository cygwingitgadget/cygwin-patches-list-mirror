Return-Path: <cygwin-patches-return-1982-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13287 invoked by alias); 12 Mar 2002 02:08:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13222 invoked from network); 12 Mar 2002 02:08:34 -0000
Message-ID: <20020312020833.63736.qmail@web20002.mail.yahoo.com>
Date: Mon, 11 Mar 2002 18:09:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: long-option patch for kill.cc
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q1/txt/msg00339.txt.bz2

I apologize for my hasty Changelog.

I was suprised to find in the util-linux sources included with RH7.2
that kill.c is actually BSD-licenced. So any fears were unfounded. However,
the signals (for -l, --list) are indeed hard-coded, and options are handled
in the same basic way as this patch (not getopt), so I didn't really find what 
I was looking for.

This patch changes the option-handling in kill to use a switch instead
of if/else if/else clauses. It also enables basic long-option handling.

2001-03-11 Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
* kill.cc (main): Handle options in a switch. Add long-option for --force.



__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/
