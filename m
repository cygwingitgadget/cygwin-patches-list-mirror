Return-Path: <cygwin-patches-return-3281-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26426 invoked by alias); 5 Dec 2002 14:43:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26413 invoked from network); 5 Dec 2002 14:43:49 -0000
Date: Thu, 05 Dec 2002 06:43:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: PATCH: Implementation of functions in netdb.h
Message-ID: <20021205144443.GB16892@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021204204751.GA5562@redhat.com> <3DEFE178.12552.5A181F1@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DEFE178.12552.5A181F1@localhost>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00232.txt.bz2

On Thu, Dec 05, 2002 at 11:30:00PM +1300, Craig McGeachie wrote:
>On 5 Dec 2002 at 23:22, Craig McGeachie wrote:
>>  - declare a subclass of per_thread into perthread.h for
>>    whatever data netdb.cc uses.
>>  - declare a single global instance of this subclass in perthread.h
>>  - define the global instance in dcrt0.cc
>>  - add it to threadstuff in dcrt0.cc
>
>Actually, messing about with dcrt0.cc and perthread.h makes me a little 
>uncomfortable.  The per_thread objects only seem to need to be in there 
>if fork.cc needs to check for clear_on_fork.  Could I just put 
>everything into netdb.cc?

Yes.  You're right.  In fact, it hit me this morning as I was waking up
that I might have steered you wrong here.  There are other per-thread
entities in cygwin that don't use the perthread interface.  So, rolling
your own is fine.

cgf
