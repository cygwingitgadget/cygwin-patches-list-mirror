Return-Path: <cygwin-patches-return-2721-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28412 invoked by alias); 25 Jul 2002 20:15:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28397 invoked from network); 25 Jul 2002 20:15:13 -0000
Date: Thu, 25 Jul 2002 13:15:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: qt patch for winnt.h
Message-ID: <20020725201524.GA6611@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020725174050.GE2281@redhat.com> <015301c23413$8551d1b0$cd6007d5@BRAMSCHE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015301c23413$8551d1b0$cd6007d5@BRAMSCHE>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00169.txt.bz2

On Thu, Jul 25, 2002 at 09:43:16PM +0200, Ralf Habacker wrote:
>> I do prefer feature-centric ifdefs, but I don't think that adding this
>> particular definition of HANDLE to the windows headers makes sense.
>
>I think too, but you have another solution yet. :-)

Not my yob.

Although this is an open source project and you do have the advantage of
being able to talk to the people who own the system headers, I really think
that making changes like this in system headers should be done very very
sparingly.

What would you do if this was Sun?  Lobby them to change their headers?

I'm sure that Danny will comment on this.  He's probably doing something
selfish like sleeping or eating breakfast right now.

>> Isn't it possible to protect the handle with a define somewhere prior
>> to calling winnt.h and then undefine it after the includes?
>>
>
>I'm not sure, how this would look in real code, do you have an example ?

#define HANDLE foo_handle
#include <winnt.h>
#undef HANDLE

Another thing I have to wonder is why you are using a mixture of the
Windows API and the X API rather than X + cygwin.  That seems strange,
too.

cgf
