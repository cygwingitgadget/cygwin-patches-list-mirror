Return-Path: <cygwin-patches-return-5835-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25859 invoked by alias); 21 Apr 2006 20:12:04 -0000
Received: (qmail 25849 invoked by uid 22791); 21 Apr 2006 20:12:04 -0000
X-Spam-Check-By: sourceware.org
Received: from fios.cgf.cx (HELO cgf.cx) (71.248.179.247)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 21 Apr 2006 20:12:02 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 7DDB913C01E; Fri, 21 Apr 2006 16:12:00 -0400 (EDT)
Date: Fri, 21 Apr 2006 20:12:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Make getenv() functional before the environment is  initialized
Message-ID: <20060421201200.GA8588@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <027701c65998$178103f0$280010ac@wirelessworld.airvananet.com> <20060421172328.GD7685@calimero.vinschen.de> <01ca01c66574$b295c7d0$280010ac@wirelessworld.airvananet.com> <20060421191314.GA11311@trixie.casa.cgf.cx> <01fc01c6657c$347794c0$280010ac@wirelessworld.airvananet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01fc01c6657c$347794c0$280010ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00023.txt.bz2

On Fri, Apr 21, 2006 at 03:45:54PM -0400, Pierre A. Humblet wrote:
>----- Original Message ----- 
>From: "Christopher Faylor" <xxx-xx-xxxxxxxx-xxxxx-xxxxxx@xxxxxx.xxx>
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>To: <xxxxxx-xxxxxxx@xxxxxx.xxx>
     ^^^^^^^^^^^^^^^^^^^^^^^^^^

>Sent: Friday, April 21, 2006 3:13 PM
>Subject: Re: [Patch] Make getenv() functional before the environment is 
>initialized
>
>
>>On Fri, Apr 21, 2006 at 02:52:06PM -0400, Pierre A. Humblet wrote:
>>>
>>>In particular GetEnvironmentStrings returns a big block of
>>>storage that should be free (which we can't do), and that is
>>>going to be lost on a fork, potentially leading to trouble.
>>>
>>>Thus I have another implementation using GetEnvironmentValue
>>>and cmalloc. (with HEAP_1_MAX, so that it will be released
>>>on the next exec).
>>>I also take advantage of spawn_info, whose existence I had forgotten.
>>>Overall it's also simpler.
>>>
>>>Here is another patch, sorry for not sending this earlier.
>>
>>I don't see any reason to permanently allocate memory with cmalloc.
>>
>>I think that using GetEnvironmentStrings is still the right choice here.
>>You just have to make sure that it gets freed.  I'm going to check in a
>>cleanup of getearly which will move the rawenv variable to a static
>>which will potentially be used by environ_init.  Then environ_init will
>>free it if it has been previously set.
>
>But doesn't the program then have a pointer to memory that has been freed?
>That pointer can also be accessed after forks.

Isn't that always a possibility?  You can't rely on the persistence of
the stuff returned from getenv().

cgf
