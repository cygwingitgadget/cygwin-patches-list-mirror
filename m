Return-Path: <cygwin-patches-return-6372-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11785 invoked by alias); 5 Dec 2008 09:57:03 -0000
Received: (qmail 11769 invoked by uid 22791); 5 Dec 2008 09:57:02 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 05 Dec 2008 09:56:28 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id EE92E6D4356; Fri,  5 Dec 2008 10:57:42 +0100 (CET)
Date: Fri, 05 Dec 2008 09:57:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Avoid duplicate names in /proc/registry (which may 	crash  find)
Message-ID: <20081205095742.GP12905@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49384250.7080707@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49384250.7080707@t-online.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00016.txt.bz2

On Dec  4 21:49, Christian Franke wrote:
> Here is a simple approach to handle the duplicate key/value name problem in 
> /proc/registry. A value is skipped if key with same name exists. Number of 
> actual key existence checks are reduced by a simple hash table.
>
> The patch also adds dirent.d_type support, find does no longer crash.
>
> Christian
>
>
> 2008-12-04  Christian Franke  <franke@computer.org>
>
> 	* fhandler_registry.cc (__DIR_hash): New class.
> 	(d_hash): New macro.
> 	(key_exists): New function.
> 	(fhandler_registry::readdir): Allocate __DIR_hash.
> 	Record key names in hash table. Skip value if key
> 	with same name exists. Fix error handling of
> 	encode_regname (). Set dirent.d_type.
> 	(fhandler_registry::closedir): Delete __DIR_hash.

That looks like a quite neat idea to rectify this problem but, now that
I think of it I'm wondering if this isn't a good starting point for
a better solution as you proposed on the Cygwin list.

So let's assume there's a key and a value with the same name. 

The old implementation just ignored the problem.  Trying to access the
value failed because the value was simply shadowed by the key.  `cat
foo' returned "is a directory" or something.

The now proposed solution hides the value instead.  There just isn't a
value of that name anymore.  In the end, the result is the same.
Accessing the value still doesn't work.

However, since these value were never accessible, doesn't that mean
there is no backward compatibility problem if we actually change the
name of the values instead to, say, foo.val?  That's what you proposed
on the main list, right?

Is the above line of thought correct?  If yes, together with your hash
table it would be quite simle to implement this.  We would just have to
think of a good value for ".val".  Unfortunately, there's no character
disallowed in the registry names, not even a \0 :(

Maybe ".val" is already a good suffix?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
