Return-Path: <cygwin-patches-return-5794-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1781 invoked by alias); 3 Mar 2006 21:08:12 -0000
Received: (qmail 1770 invoked by uid 22791); 3 Mar 2006 21:08:11 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout02.sul.t-online.com (HELO mailout02.sul.t-online.com) (194.25.134.17)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 03 Mar 2006 21:08:10 +0000
Received: from fwd35.aul.t-online.de  	by mailout02.sul.t-online.com with smtp  	id 1FFHVP-0002sC-01; Fri, 03 Mar 2006 22:08:07 +0100
Received: from [10.3.2.2] (rfEV7ZZr8euOgaYfJQDv7Kta8xWKGo5rDC5VA8pH4XMFwuriCgO74Z@[80.137.91.42]) by fwd35.sul.t-online.de 	with esmtp id 1FFHVG-1aTyzI0; Fri, 3 Mar 2006 22:07:58 +0100
Message-ID: <4408B033.4050504@t-online.de>
Date: Fri, 03 Mar 2006 21:08:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch] regtool: Add load/unload commands and --binary option
References: <43D6876F.9080608@t-online.de> <20060125105240.GM8318@calimero.vinschen.de> <43D7E666.8080803@t-online.de> <20060126091944.GT8318@calimero.vinschen.de> <20060211103418.GM14219@calimero.vinschen.de> <43F0E145.6080109@t-online.de> <20060215104302.GA13856@calimero.vinschen.de> <4405F274.6080009@t-online.de> <20060301222502.GW3184@calimero.vinschen.de> <44075CAA.8030009@t-online.de> <20060303094621.GP3184@calimero.vinschen.de>
In-Reply-To: <20060303094621.GP3184@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: rfEV7ZZr8euOgaYfJQDv7Kta8xWKGo5rDC5VA8pH4XMFwuriCgO74Z
X-TOI-MSGID: 4c68c44e-13ca-417e-ab55-00167d3eea9e
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00103.txt.bz2

Corinna Vinschen wrote:
> I applied the patch.  

Thanks.

> I just had to reformat your ChangeLog slightly
> (a TAB before all lines, no extra indentation for lines which don't
> start with a '*').
>   
SeaMonkey expands tabs to spaces...
Will use attachment for ChangeLog next time.

> Btw., since you seem to be interested in hacking the registry...  would
> you also be interested to introduce registry write access below
> /proc/registry inside of the Cygwin DLL?  That would be extra cool.
>   

In fact I had the idea to hack the registry, in particular fix the read 
access to registry values starting with backslash:

$ cd /proc/registry/HKEY_LOCAL_MACHINE/SYSTEM/MountedDevices
$ ls
...
\DosDevices\C:
\DosDevices\D:
...
$ cat \\DosDevices\\C:
cat: \DosDevices\C:: No such file or directory

Using a URL-like "%XX" encoding for invalid characters (/\?%) may be the 
right thing to do.

$ ls
...
%5cDosDevices%5cC:

I found that all standard ascii chars except ^ % ` are used in value names

> I'm not quite sure how to handle the mapping from file types to
> registry key types, but there might be some simple way which I'm just
> too blind to see.
>   

Because POSIX has no notion about file types, the type has to be somehow 
encoded into the name if a new key is created.
The major drawback of this approach is that the read path is different 
from the write path.

I would suggest to add a second R/W view to the registry where both path 
are identical.
A type extension should be added via a rarely used character:

$ ls /proc/registry/SUBKEY
reg_sz_value
reg_binary_value
reg_dword_value

$ ls /proc/registry-rw/SUBKEY
reg_sz_value,sz
reg_binary_value,bin
reg_dword_value,dword

Then you should have the ability to copy subkeys to file trees and vice 
versa:
cp -r /dev/registry-rw/SUBKEY /tmp/SUBKEY
rm -r /dev/registry-rw/SUBKEY
cp -r /tmp/SUBKEY /dev/registry-rw/SUBKEY

Suggest to start a new thread for this discussion....

Christian
