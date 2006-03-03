Return-Path: <cygwin-patches-return-5784-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11744 invoked by alias); 3 Mar 2006 13:12:06 -0000
Received: (qmail 11733 invoked by uid 22791); 3 Mar 2006 13:12:05 -0000
X-Spam-Check-By: sourceware.org
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 03 Mar 2006 13:12:03 +0000
Received: from rainbow ([192.168.1.165]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.1830); 	 Fri, 3 Mar 2006 13:12:01 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [Patch] regtool: Add load/unload commands and --binary option
Date: Fri, 03 Mar 2006 13:12:00 -0000
Message-ID: <03f701c63ec4$0eee53d0$a501a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20060303094621.GP3184@calimero.vinschen.de>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00093.txt.bz2

On 03 March 2006 09:46, Corinna Vinschen wrote:

> 
> Btw., since you seem to be interested in hacking the registry...  would
> you also be interested to introduce registry write access below
> /proc/registry inside of the Cygwin DLL?  That would be extra cool.
> I'm not quite sure how to handle the mapping from file types to
> registry key types, but there might be some simple way which I'm just
> too blind to see.


  Hey, how about using pseudo filename-extensions on the pseudo-files that
represent registry keys?

  i.e

$  echo "Foo" >/proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.sz
creates /proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName, type
REG_SZ, content "Foo<NUL>"

$  echo "%WINDIR%"
>/proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.xsz
creates /proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName as
REG_EXPAND_SZ

$  echo "23"
>/proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.dword
$  echo "0x17"
>/proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.dword

$  dd bs=1024 count=3 if=/dev/random
of=/proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.bin

$  touch /proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.none

etc etc ?  (We might even want a $CYGWIN option to make the extension show up
in dir listings, but it wouldn't be backwardly-compatible to do so in
general).

  Hmm, and how about for MULTI_SZ taking account of the open mode?

$ echo "String1"
>/proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.msz
$ echo "String2"
>>/proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.msz
$ echo "String3"
>>/proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.msz
$ echo "String4"
>>/proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.msz
$ od -c < /proc/registry/HKEY_CURRENT_USER/Software/App/Key/ValueName.msz
  String1\0String2\0String3\0String4\0\0


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
