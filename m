Return-Path: <cygwin-patches-return-4514-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24133 invoked by alias); 11 Jan 2004 22:45:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24123 invoked from network); 11 Jan 2004 22:45:20 -0000
Message-ID: <20040111224520.38647.qmail@web61110.mail.yahoo.com>
Date: Sun, 11 Jan 2004 22:45:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Are cygwin-ug and cygwin-api-int used?
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2004-q1/txt/msg00004.txt.bz2

I would like to remove two build targets from winsup/doc/Makefile.in:

        cygwin-ug/cygwin-ug.html 
        cygwin-api-int/cygwin-api-int.html 

As far as I can tell, these are not used for anything and have
references to "the GNUPro release". This would not effect the
"net release" versions of the User's Guide and API Reference:

        cygwin-ug-net/cygwin-ug-net.html
        cygwin-api/cygwin-api.html

I will remove them in a week if no one has any reason not to.

__________________________________
Do you Yahoo!?
Yahoo! Hotjobs: Enter the "Signing Bonus" Sweepstakes
http://hotjobs.sweepstakes.yahoo.com/signingbonus
