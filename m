Return-Path: <cygwin-patches-return-3294-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5520 invoked by alias); 10 Dec 2002 05:10:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5509 invoked from network); 10 Dec 2002 05:10:35 -0000
From: "Craig McGeachie" <slapdau@yahoo.com.au>
To: cygwin-patches@cygwin.com
Date: Mon, 09 Dec 2002 21:10:00 -0000
MIME-Version: 1.0
Subject: Making netdb.cc threadsafe.
Reply-to: cygwin-patches@cygwin.com
Message-ID: <3DF62E08.24168.109C9D40@localhost>
Priority: normal
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-SW-Source: 2002-q4/txt/msg00245.txt.bz2

I've been researching this.  I have looked thread.cc and thread.h, and 
the struct _winsup_t that is defined.  net.cc uses the _protoent_buf 
and _servent_buf members.  Would use of these members from netdb.cc be 
appropriate?


----------------+-------------------------------------------------
Craig McGeachie | #include <cheesy_tag.h>
+64(21)037-6917 | while (!inebriated) c2h5oh=(++bottle)->contents;
----------------+-------------------------------------------------

