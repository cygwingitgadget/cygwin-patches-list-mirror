Return-Path: <cygwin-patches-return-3279-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4289 invoked by alias); 5 Dec 2002 10:22:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4278 invoked from network); 5 Dec 2002 10:22:41 -0000
From: "Craig McGeachie" <slapdau@yahoo.com.au>
To: cygwin-patches@cygwin.com
Date: Thu, 05 Dec 2002 02:22:00 -0000
MIME-Version: 1.0
Subject: Re: PATCH: Implementation of functions in netdb.h
Reply-to: cygwin-patches@cygwin.com
Message-ID: <3DEFDFAE.28834.59A88C2@localhost>
Priority: normal
In-reply-to: <20021204204751.GA5562@redhat.com>
References: <20021204135549.D1140@cygbert.vinschen.de>
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-SW-Source: 2002-q4/txt/msg00230.txt.bz2

On 4 Dec 2002 at 15:47, Christopher Faylor wrote:
> >please use strtok_r().  It helps to avoid clashes with the application
> >using strtok() as well.

Righto.  Not a problem.

> It's not a simple job by any means but maybe the code in perthread.h
> will provide a clue. 

It doesn't look outrageously hard.  As I understand it, I should:
 - declare a subclass of per_thread into perthread.h for
   whatever data netdb.cc uses.
 - declare a single global instance of this subclass in perthread.h
 - define the global instance in dcrt0.cc
 - add it to threadstuff in dcrt0.cc
 - use the global instance, with its get and create methods, in
   netdb.cc instead of the static varibles.

Have I missed something?

----------------+-------------------------------------------------
Craig McGeachie | #include <cheesy_tag.h>
+64(21)037-6917 | while (!inebriated) c2h5oh=(++bottle)->contents;
----------------+-------------------------------------------------

