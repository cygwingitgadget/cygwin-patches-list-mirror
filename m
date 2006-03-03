Return-Path: <cygwin-patches-return-5785-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17048 invoked by alias); 3 Mar 2006 13:21:35 -0000
Received: (qmail 17036 invoked by uid 22791); 3 Mar 2006 13:21:33 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Fri, 03 Mar 2006 13:21:30 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 22A0E544001; Fri,  3 Mar 2006 14:21:28 +0100 (CET)
Date: Fri, 03 Mar 2006 13:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] regtool: Add load/unload commands and --binary option
Message-ID: <20060303132128.GY3184@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20060303094621.GP3184@calimero.vinschen.de> <03f701c63ec4$0eee53d0$a501a8c0@CAM.ARTIMI.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f701c63ec4$0eee53d0$a501a8c0@CAM.ARTIMI.COM>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00094.txt.bz2

On Mar  3 13:12, Dave Korn wrote:
> On 03 March 2006 09:46, Corinna Vinschen wrote:
> 
> > 
> > Btw., since you seem to be interested in hacking the registry...  would
> > you also be interested to introduce registry write access below
> > /proc/registry inside of the Cygwin DLL?  That would be extra cool.
> > I'm not quite sure how to handle the mapping from file types to
> > registry key types, but there might be some simple way which I'm just
> > too blind to see.
> 
> 
>   Hey, how about using pseudo filename-extensions on the pseudo-files that
> represent registry keys?
> 
>   i.e
> 
> $  echo "Foo" >/proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.sz
> creates /proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName, type
> REG_SZ, content "Foo<NUL>"
> 
> $  echo "%WINDIR%"
> >/proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.xsz
> creates /proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName as
> REG_EXPAND_SZ
> 
> $  echo "23"
> >/proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.dword
> $  echo "0x17"
> >/proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.dword
> 
> $  dd bs=1024 count=3 if=/dev/random
> of=/proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.bin
> 
> $  touch /proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.none
> 
> etc etc ?  (We might even want a $CYGWIN option to make the extension show up
> in dir listings, but it wouldn't be backwardly-compatible to do so in
> general).
> 
>   Hmm, and how about for MULTI_SZ taking account of the open mode?
> 
> $ echo "String1"
> >/proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.msz
> $ echo "String2"
> >>/proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.msz
> $ echo "String3"
> >>/proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.msz
> $ echo "String4"
> >>/proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.msz
> $ od -c < /proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.msz
>   String1\0String2\0String3\0String4\0\0

That's actually an interesting idea.  I was always thinking along
the lines of using POSIX file types (plain,socket,pipe,...).

However, file suffixes is something we're already suffering from
a lot (it's not by chance that SUFFix and SUFFer are so similar, IMHO).

What if a key "foo.sz" really exists and somebody wants to create
a registry key "foo"?  When reading "foo", which file is meant?
What's the order of checking suffixes?

When somebody writes to a key "foo", what's the default suffix,
er..., key type?  Or does that fail with an error message?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
