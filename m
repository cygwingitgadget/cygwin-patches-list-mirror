Return-Path: <cygwin-patches-return-3012-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21170 invoked by alias); 20 Sep 2002 15:45:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21133 invoked from network); 20 Sep 2002 15:45:01 -0000
Date: Fri, 20 Sep 2002 08:45:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread_fork Part 3
Message-ID: <20020920154517.GE24740@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0208162232370.-283127@thomas.kefrig-pfaff.de> <1032526255.9135.61.camel@lifelesswks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032526255.9135.61.camel@lifelesswks>
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q3/txt/msg00460.txt.bz2

On Fri, Sep 20, 2002 at 10:50:55PM +1000, Robert Collins wrote:
>On Sat, 2002-08-17 at 06:55, Thomas Pfaff wrote:
>> 
>> Pthread key destructor handling revised. IMHO it does not make sense to
>> handle two lists with keys, one with all keys, one with its destructors.
>> The destructors are now part of the key class.
>
>I agree with the duplication of code. This is one area I'd really really
>really like to use templates. 
>
>Chris, Corinna, if we ever get the chance to use templates please tell
>me so! It makes code clarity and size so much better.

I actually used to use templates in environ.cc.  I think DJ yanked them
out because some version of g++ couldn't handle them.

AFAIK, use of templates won't cause any code bloat so I don't see any
reason to avoid them.

cgf
