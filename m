Return-Path: <cygwin-patches-return-5841-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6231 invoked by alias); 24 Apr 2006 16:36:03 -0000
Received: (qmail 6218 invoked by uid 22791); 24 Apr 2006 16:36:02 -0000
X-Spam-Check-By: sourceware.org
Received: from fios.cgf.cx (HELO cgf.cx) (71.248.179.247)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 24 Apr 2006 16:36:00 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 2265913C02B; Mon, 24 Apr 2006 12:35:59 -0400 (EDT)
Date: Mon, 24 Apr 2006 16:36:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Make getenv() functional before the environment is  initialized
Message-ID: <20060424163558.GE3753@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <027701c65998$178103f0$280010ac@wirelessworld.airvananet.com> <20060421172328.GD7685@calimero.vinschen.de> <01ca01c66574$b295c7d0$280010ac@wirelessworld.airvananet.com> <20060421191314.GA11311@trixie.casa.cgf.cx> <01fc01c6657c$347794c0$280010ac@wirelessworld.airvananet.com> <20060421201200.GA8588@trixie.casa.cgf.cx> <022b01c66582$b3d396a0$280010ac@wirelessworld.airvananet.com> <20060421213928.GC31141@trixie.casa.cgf.cx> <029001c667ba$754ff470$280010ac@wirelessworld.airvananet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <029001c667ba$754ff470$280010ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00029.txt.bz2

On Mon, Apr 24, 2006 at 12:16:34PM -0400, Pierre A. Humblet wrote:
>----- Original Message ----- 
>From: "Christopher Faylor"
>To: <cygwin-patches@cygwin.com>
>Sent: Friday, April 21, 2006 5:39 PM
>Subject: Re: [Patch] Make getenv() functional before the environment is 
>initialized
>
>
>>I just talked to Corinna about this on IRC and neither of us really
>>cares enough about this to merit a long discussion so I've just checked
>>in a variation of the cmalloc patch.  The only change that I made was to
>>define a HEAP_2_STR value so that the HEAP_1_MAX usage is confined to
>>cygheap.cc where I'd intended it.
>
>Thanks a lot, Chris & Corinna.
>
>Now that I am trying it, it doesn't work anymore when launched from Cygwin.
>
>I am starting to wonder if the current
>*ptr[len] == '='
>is equivalent to the former
>*(*ptr + s) == '='
>when s = len and ptr is a char **

If it didn't work, I'd think that g++ would complain.  However, this
isn't really something that needs much discussion since it is easy to
test.

Create the below program and name it 'foo'.  Then, make sure that the
current directory is in your path, and type 'foo'.

I get a "it works" when I do this.

cgf

#include <stdio.h>

int
main (int argc, char **argv)
{
  if (*argv[0] == 'f')
    puts ("it works");
}
