Return-Path: <cygwin-patches-return-2020-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20275 invoked by alias); 3 Apr 2002 14:31:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20261 invoked from network); 3 Apr 2002 14:31:42 -0000
Date: Wed, 03 Apr 2002 06:31:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Setup Chooser integration
Message-ID: <20020403143152.GF4053@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <FC169E059D1A0442A04C40F86D9BA76008AC08@itdomain003.itdomain.net.au> <000c01c1da8b$604fb3f0$2101a8c0@BRAEMARINC.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000c01c1da8b$604fb3f0$2101a8c0@BRAEMARINC.COM>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00004.txt.bz2

On Tue, Apr 02, 2002 at 03:14:28PM -0600, Gary R Van Sickle wrote:
>> Image: you click on 'install' for 'gcc', and up pops a window 
>> that lists
>> everything that gcc depends on (both requires as we have today, and
>> 'suggested' items that aren't always needed but are useful - ie
>> autoconf), that was not selected before that click. 
>> 
>
>I'm drawing a blank at the utility of such a feature, at least in the guise
>of a popup of any kind.  You're saying that as you go through the dozens of
>packages you want and select them, that a box pops up bugging you about the
>dependencies of each selection, which you can't do anything about anyways?
>That sounds like it would be extremely irritating.

Ditto.  I also have to admit that I don't see how this corresponds with any
complaints or requests that I've seen in the cygwin mailing list.

>>Likewise, if you click ash off, up pops a window listing everything
>>that depends on ash, with an addiotnal message of "Warning: removing
>>ash will cause these packages to be removed as well.
>>
>
>This does make quite a bit of sense to me.  But wouldn't MessageBox()
>or something akin to it be a better fit to the task?  The only possible
>user input here would be "Yes, remove ash and everything dependent on
>it" and "Cancel", and the only output a list of package names.

Actually, I think that automatically removing dependencies is not a good
idea.  If I select binutils specifically, then select gcc, then uninstall
gcc, I would probably be annoyed to see binutils disappear.

cgf
