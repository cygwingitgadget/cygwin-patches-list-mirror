Return-Path: <cygwin-patches-return-5796-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32090 invoked by alias); 3 Mar 2006 22:18:21 -0000
Received: (qmail 32076 invoked by uid 22791); 3 Mar 2006 22:18:21 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 03 Mar 2006 22:18:19 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id k23MIHfo018205; 	Fri, 3 Mar 2006 17:18:17 -0500 (EST)
Date: Fri, 03 Mar 2006 22:18:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Christian Franke <Christian.Franke@t-online.de>
cc: cygwin-patches@cygwin.com
Subject: Re: [Patch] regtool: Add load/unload commands and --binary option
In-Reply-To: <4408B033.4050504@t-online.de>
Message-ID: <Pine.GSO.4.63.0603031711410.11990@access1.cims.nyu.edu>
References: <43D6876F.9080608@t-online.de> <20060125105240.GM8318@calimero.vinschen.de>  <43D7E666.8080803@t-online.de> <20060126091944.GT8318@calimero.vinschen.de>  <20060211103418.GM14219@calimero.vinschen.de> <43F0E145.6080109@t-online.de>  <20060215104302.GA13856@calimero.vinschen.de> <4405F274.6080009@t-online.de>  <20060301222502.GW3184@calimero.vinschen.de> <44075CAA.8030009@t-online.de>  <20060303094621.GP3184@calimero.vinschen.de> <4408B033.4050504@t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00105.txt.bz2

On Fri, 3 Mar 2006, Christian Franke wrote:

> In fact I had the idea to hack the registry, in particular fix the read
> access to registry values starting with backslash:
>
> $ cd /proc/registry/HKEY_LOCAL_MACHINE/SYSTEM/MountedDevices
> $ ls
> ...
> \DosDevices\C:
> \DosDevices\D:
> ...
> $ cat \\DosDevices\\C:
> cat: \DosDevices\C:: No such file or directory

This is more likely a problem with Cygwin's path handling, which treats
any path with an embedded '\' as a Windows path that doesn't get
translated into POSIX (so you're not trying to open
'/proc/registry/HKEY_LOCAL_MACHINE/SYSTEM/MountedDevices/\DosDevices\C:',
but '\DosDevices\C:'.  Look at the strace to confirm it.  Maybe Cygwin
should check if a path starts with /proc/registry (or any virtual
filesystem) before deciding to not translate it...

> Using a URL-like "%XX" encoding for invalid characters (/\?%) may be the
> right thing to do.
>
> $ ls
> ...
> %5cDosDevices%5cC:

Yep, in effect making /proc/registry a managed mount.  You'd need
something like this anyway to process values that have '/'s in them.

> I found that all standard ascii chars except ^ % ` are used in value names
>
> > I'm not quite sure how to handle the mapping from file types to
> > registry key types, but there might be some simple way which I'm just
> > too blind to see.
>
> Because POSIX has no notion about file types, the type has to be somehow
> encoded into the name if a new key is created.

What's wrong with using open() flags?

> The major drawback of this approach is that the read path is different
> from the write path.
>
> I would suggest to add a second R/W view to the registry where both path
> are identical.
> A type extension should be added via a rarely used character:
>
> $ ls /proc/registry/SUBKEY
> reg_sz_value
> reg_binary_value
> reg_dword_value
>
> $ ls /proc/registry-rw/SUBKEY
> reg_sz_value,sz
> reg_binary_value,bin
> reg_dword_value,dword

Yep, except I suggested ':'.

> Then you should have the ability to copy subkeys to file trees and vice
> versa:
> cp -r /dev/registry-rw/SUBKEY /tmp/SUBKEY
> rm -r /dev/registry-rw/SUBKEY
> cp -r /tmp/SUBKEY /dev/registry-rw/SUBKEY
>
> Suggest to start a new thread for this discussion....

Right, good idea, except not on this list (as Dave pointed out).  What
would be a good place -- cygwin-developers?
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_	    pechtcha@cs.nyu.edu | igor@watson.ibm.com
ZZZzz /,`.-'`'    -.  ;-;;,_		Igor Peshansky, Ph.D. (name changed!)
     |,4-  ) )-,_. ,\ (  `'-'		old name: Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Las! je suis sot... -Mais non, tu ne l'es pas, puisque tu t'en rends compte."
"But no -- you are no fool; you call yourself a fool, there's proof enough in
that!" -- Rostand, "Cyrano de Bergerac"
