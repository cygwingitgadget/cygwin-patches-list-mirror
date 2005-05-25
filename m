Return-Path: <cygwin-patches-return-5485-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3243 invoked by alias); 25 May 2005 04:35:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3219 invoked by uid 22791); 25 May 2005 04:35:09 -0000
Received: from c-66-30-17-189.hsd1.ma.comcast.net (HELO cgf.cx) (66.30.17.189)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 25 May 2005 04:35:08 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id B141C13CA0A; Wed, 25 May 2005 00:35:07 -0400 (EDT)
Date: Wed, 25 May 2005 04:35:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: mkdir -p and network drives
Message-ID: <20050525043507.GF27382@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net> <3.0.5.32.20050510205301.00b4b658@incoming.verizon.net> <20050511085307.GA2805@calimero.vinschen.de> <007b01c5572b$b3925890$3e0010ac@wirelessworld.airvananet.com> <20050512200222.GD5569@trixie.casa.cgf.cx> <20050513135745.GD10577@trixie.casa.cgf.cx> <loom.20050513T164025-465@post.gmane.org> <3.0.5.32.20050518082203.00b5ea78@incoming.verizon.net> <20050518164848.GA11455@calimero.vinschen.de> <007601c55bd9$4e8495f0$3e0010ac@wirelessworld.airvananet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007601c55bd9$4e8495f0$3e0010ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00081.txt.bz2

On Wed, May 18, 2005 at 02:42:12PM -0400, Pierre A. Humblet wrote:
>----- Original Message ----- 
>From: "Corinna Vinschen"
>To: <cygwin-patches@cygwin.com>
>Sent: Wednesday, May 18, 2005 12:48 PM
>Subject: Re: [Patch]: mkdir -p and network drives
>
>
>> Hi Pierre,
>>
>> I don't see a reason why you moved telldir just a few lines up.
>> Any reasoning, perhaps together with a ChangeLog entry?
>
>Nope, it was an accidental cut and I pasted it back a few lines off.
>
>>
>> Why did you remove fhandler_cygdrive::telldir but not
>> fhandler_cygdrive::seekdir?  Both are just calling their base class
>> variants.
>
>I am still working on  fhandler_cygdrive. I stopped to keep the size
>of the patch small.
>
>> > -  else if (isvirtual_dev (dev.devn) && fileattr ==
>INVALID_FILE_ATTRIBUTES)
>> > -    {
>> > -      error = dev.devn == FH_NETDRIVE ? ENOSHARE : ENOENT;
>> > -      return;
>> > -    }
>>
>> I don't understand this one.  What's the rational behind removing
>> these lines?
>
>- They won't work the day we support writing to the registry.
>- More generally, I think it's cleaner to do device specific error handling
>in the fhandlers, instead of adding conditionals in path.cc
>- In the case where one tries to create a file or directory on a virtual
>device,
>one gets EROFS with this patch, instead of ENOSHARE or ENOENT before.
>That seems more logical.

I checked in part of your patch last week and most of the rest today.

I don't agree that "EROFS" is more logical than "ENOSHARE" since
ENOSHARE is a more specific error message which provides more
information to the user.  So, I have left path.cc intact.

Thanks for the patch.

cgf
