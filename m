Return-Path: <cygwin-patches-return-4513-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10942 invoked by alias); 11 Jan 2004 08:52:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10927 invoked from network); 11 Jan 2004 08:52:16 -0000
Message-ID: <20040111085215.80204.qmail@web61110.mail.yahoo.com>
Date: Sun, 11 Jan 2004 08:52:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Many updates to winsup/doc
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2004-q1/txt/msg00003.txt.bz2

I just committed several changes to winsup/doc. Most are
small edits to various sections of the User's Guide, but
there are two that I should draw attention to. 

First, I updated the DTD declaration in the sgml.in files to the
official DocBook 4.2 SGML DTD, added a new DSSSL stylesheet 
called cygwin.dsl, and edited Makefile.in to use cygwin.dsl 
instead of cygnus-both.dsl. This fixes a couple small problems
from the 1998 DTDs and makes it easier to make the single-file
HTML version of the User's Guide.

Second, I applied an FAQ patch that was submitted to the mailing
list about 3 months ago. David's said recently that he is very behind:
<http://sources.redhat.com/ml/cygwin-patches/2003-q4/msg00082.html>
and so I thought I'd help out since this one that's I'd noted down
was for the FAQ:

"Hannu E K Nevalainen" <garbage_collector at telia dot com>
http://www.cygwin.com/ml/cygwin/2003-10/msg01052.html
-how-programming.texinfo: Add some words about -mno-cygwin,
the difference with regard to preprocessor symbols and how to
investigate it further.

The small edits were:

DONE
"Dave Korn" <dk at artimi dot com>
http://www.cygwin.com/ml/cygwin/2004-01/msg00111.html
-default values of CYGWIN=(no)ntsec (no)export error_start

DONE
"Gary L. Feldman" <gaf_ml_01 at comcast dot net>
http://cygwin.com/ml/cygwin/2003-08/msg00668.html
-add reminder to not unselect any Base category packages

DONE
linda w <cygwin at tlinx dot org>
http://cygwin.com/ml/cygwin/2003-12/msg00716.html
-add /proc discussion to User's Guide

DONE
"Roy Clemmons" <roy_clemmons at hotmail dot com>
http://cygwin.com/ml/cygwin/2003-12/msg00839.html
-add discussion of cyg prefix to dll section

__________________________________
Do you Yahoo!?
Yahoo! Hotjobs: Enter the "Signing Bonus" Sweepstakes
http://hotjobs.sweepstakes.yahoo.com/signingbonus
