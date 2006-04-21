Return-Path: <cygwin-patches-return-5833-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23315 invoked by alias); 21 Apr 2006 19:13:18 -0000
Received: (qmail 23303 invoked by uid 22791); 21 Apr 2006 19:13:18 -0000
X-Spam-Check-By: sourceware.org
Received: from fios.cgf.cx (HELO cgf.cx) (71.248.179.247)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 21 Apr 2006 19:13:16 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 93C0813C01E; Fri, 21 Apr 2006 15:13:14 -0400 (EDT)
Date: Fri, 21 Apr 2006 19:13:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Make getenv() functional before the environment is  initialized
Message-ID: <20060421191314.GA11311@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <027701c65998$178103f0$280010ac@wirelessworld.airvananet.com> <20060421172328.GD7685@calimero.vinschen.de> <01ca01c66574$b295c7d0$280010ac@wirelessworld.airvananet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01ca01c66574$b295c7d0$280010ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00021.txt.bz2

On Fri, Apr 21, 2006 at 02:52:06PM -0400, Pierre A. Humblet wrote:
>----- Original Message ----- 
>From: "Corinna Vinschen"
>To: <cygwin-patches@cygwin.com>
>Sent: Friday, April 21, 2006 1:23 PM
>Subject: Re: [Patch] Make getenv() functional before the environment is 
>initialized
>
>
>>On Apr  6 12:35, Pierre A. Humblet wrote:
>>>       * environ.cc (getearly): New function.
>>>          (getenv) : Call getearly if needed.
>>
>>Thanks for the patch and sorry for the loooong delay.  I've applied a
>>slightly tweaked version of your patch, which uses a function pointer in
>>getenv, instead of adding a conditional.
>>
>
>Corinna,
>
>Thanks! Since sending the patch, I have found some issues with it :(
>
>In particular GetEnvironmentStrings returns a big block of
>storage that should be free (which we can't do), and that is
>going to be lost on a fork, potentially leading to trouble.
>
>Thus I have another implementation using GetEnvironmentValue
>and cmalloc. (with HEAP_1_MAX, so that it will be released
>on the next exec).
>I also take advantage of spawn_info, whose existence I had forgotten.
>Overall it's also simpler.
>
>Here is another patch, sorry for not sending this earlier.

I don't see any reason to permanently allocate memory with cmalloc.

I think that using GetEnvironmentStrings is still the right choice here.
You just have to make sure that it gets freed.  I'm going to check in a
cleanup of getearly which will move the rawenv variable to a static
which will potentially be used by environ_init.  Then environ_init will
free it if it has been previously set.

I've made some other minor stylistic changes to the function as well.

cgf
