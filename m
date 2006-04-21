Return-Path: <cygwin-patches-return-5837-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19920 invoked by alias); 21 Apr 2006 21:00:23 -0000
Received: (qmail 19909 invoked by uid 22791); 21 Apr 2006 21:00:23 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Fri, 21 Apr 2006 21:00:21 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 3DB8D544005; Fri, 21 Apr 2006 23:00:18 +0200 (CEST)
Date: Fri, 21 Apr 2006 21:00:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Make getenv() functional before the environment is  initialized
Message-ID: <20060421210018.GA28450@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <027701c65998$178103f0$280010ac@wirelessworld.airvananet.com> <20060421172328.GD7685@calimero.vinschen.de> <01ca01c66574$b295c7d0$280010ac@wirelessworld.airvananet.com> <20060421191314.GA11311@trixie.casa.cgf.cx> <01fc01c6657c$347794c0$280010ac@wirelessworld.airvananet.com> <20060421201200.GA8588@trixie.casa.cgf.cx> <022b01c66582$b3d396a0$280010ac@wirelessworld.airvananet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <022b01c66582$b3d396a0$280010ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00025.txt.bz2

On Apr 21 16:32, Pierre A. Humblet wrote:
> 
> ----- Original Message ----- 
> From: "Christopher Faylor" <cgf-no-personal-reply-please@cygwin.com>
> To: <cygwin-patches@cygwin.com>
> Sent: Friday, April 21, 2006 4:12 PM
> Subject: Re: [Patch] Make getenv() functional before the environment is 
> initialized
> 
> 
> >>
> >>But doesn't the program then have a pointer to memory that has been freed?
> >>That pointer can also be accessed after forks.
> >
> >Isn't that always a possibility?  You can't rely on the persistence of
> >the stuff returned from getenv().
> 
> That's not my reading of 
> http://www.opengroup.org/onlinepubs/000095399/functions/getenv.html
> 
> "The string pointed to may be overwritten by a subsequent call to getenv(),
> but shall not be overwritten by a call to any other function in this volume 
> of IEEE Std 1003.1-2001."
> 
> Athough Posix allows the string to be overwritten, indicating that 
> persistence is implied,
> it does not allow the pointer to become invalid.
> 
> See also
> http://developer.apple.com/documentation/Darwin/Reference/Manpages/man3/getenv.3.html
> which says that the environment semantics make it inherently leaky.
> That's why I didn't hesitate calling cmalloc

The getearly function is only called in the initialization phase of the
application, when the Cygwin environment isn't initialized.

Why is it necessary to make this so complicated?  Why isn't it
sufficient to return the value in a static buffer and tolerate that a
lib or application which hooks into this early stage of initialization
has to copy the value, if it needs it later on?


Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
