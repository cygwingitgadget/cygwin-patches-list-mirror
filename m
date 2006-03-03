Return-Path: <cygwin-patches-return-5786-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29487 invoked by alias); 3 Mar 2006 15:40:43 -0000
Received: (qmail 29475 invoked by uid 22791); 3 Mar 2006 15:40:42 -0000
X-Spam-Check-By: sourceware.org
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 03 Mar 2006 15:40:39 +0000
Received: from rainbow ([192.168.1.165]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.1830); 	 Fri, 3 Mar 2006 15:40:37 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [Patch] regtool: Add load/unload commands and --binary option
Date: Fri, 03 Mar 2006 15:40:00 -0000
Message-ID: <041901c63ed8$d10bb020$a501a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20060303132128.GY3184@calimero.vinschen.de>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00095.txt.bz2


> That's actually an interesting idea.  I was always thinking along
> the lines of using POSIX file types (plain,socket,pipe,...).
> 
> However, file suffixes is something we're already suffering from
> a lot (it's not by chance that SUFFix and SUFFer are so similar, IMHO).

  Heh, yeh, who could ever forget the .exe/.lnk/.exe.lnk/.lnk.exe troubles?
However, we're in a special situation here, it's not really a dir tree and the
things in it aren't really files, and we may be able to get away with it.  I
posted the idea so that others could see if it works or if they can see
problems with the approach.

> What if a key "foo.sz" really exists and somebody wants to create
> a registry key "foo"?

  No problem.  If you want to create foo, you write to "foo.sz".  If you want
to create foo.sz, you have to write to "foo.sz.sz".  Unless of course foo.sz
is a dword, in which case you'd write to "foo.sz.dw", etc etc.

> When reading "foo", which file is meant?

  There can only be one at a time, because in the registry there can only be
one value with the name foo, regardless of what type it has.

> What's the order of checking suffixes?

  I'm proposing that the suffix is only used when creating or writing to the
file, to determine the type, but the suffix is stripped off for generating the
actual name, and is not shown in dir listings, and is not required to open the
file for read.
 
> When somebody writes to a key "foo", what's the default suffix,
> er..., key type?  Or does that fail with an error message?

  Either; I haven't a strong opinion on the matter.


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
