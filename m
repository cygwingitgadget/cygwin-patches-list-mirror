Return-Path: <cygwin-patches-return-3280-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5438 invoked by alias); 5 Dec 2002 10:30:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5422 invoked from network); 5 Dec 2002 10:30:39 -0000
From: "Craig McGeachie" <slapdau@yahoo.com.au>
To: cygwin-patches@cygwin.com
Date: Thu, 05 Dec 2002 02:30:00 -0000
MIME-Version: 1.0
Subject: Re: PATCH: Implementation of functions in netdb.h
Reply-to: cygwin-patches@cygwin.com
Message-ID: <3DEFE178.12552.5A181F1@localhost>
Priority: normal
In-reply-to: <3DEFDFAE.28834.59A88C2@localhost>
References: <20021204204751.GA5562@redhat.com>
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-SW-Source: 2002-q4/txt/msg00231.txt.bz2

On 5 Dec 2002 at 23:22, Craig McGeachie wrote:
>  - declare a subclass of per_thread into perthread.h for
>    whatever data netdb.cc uses.
>  - declare a single global instance of this subclass in perthread.h
>  - define the global instance in dcrt0.cc
>  - add it to threadstuff in dcrt0.cc

Actually, messing about with dcrt0.cc and perthread.h makes me a little 
uncomfortable.  The per_thread objects only seem to need to be in there 
if fork.cc needs to check for clear_on_fork.  Could I just put 
everything into netdb.cc?

----------------+-------------------------------------------------
Craig McGeachie | #include <cheesy_tag.h>
+64(21)037-6917 | while (!inebriated) c2h5oh=(++bottle)->contents;
----------------+-------------------------------------------------

