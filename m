Return-Path: <cygwin-patches-return-5789-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26600 invoked by alias); 3 Mar 2006 16:33:11 -0000
Received: (qmail 26590 invoked by uid 22791); 3 Mar 2006 16:33:11 -0000
X-Spam-Check-By: sourceware.org
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 03 Mar 2006 16:33:09 +0000
Received: from rainbow ([192.168.1.165]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.1830); 	 Fri, 3 Mar 2006 16:33:05 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [Patch] regtool: Add load/unload commands and --binary option
Date: Fri, 03 Mar 2006 16:33:00 -0000
Message-ID: <042101c63ee0$2588b330$a501a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.GSO.4.63.0603031106010.9494@access1.cims.nyu.edu>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00098.txt.bz2


> Now, what if you write a file as foo.sz, and then write it as foo.dw.  Do
> we change the key type?  

  Absolutely.

> Do we fail with ENOENT?  What is the semantics there?

  Well, the semantics of the registry API is that you specify the type
explicitly every time you set a value, and that doing so overrides the old
type in just the same way as setting the value overrides the old value.

> Also, this suffix idea reminds me more of versions on VMS or streams on
> NT, rather than real extensions.  I wonder if we could/should use "foo:dw"
> or "foo:sz", rather than using the extension...  

  I don't think it would matter very much precisely how we do it; after all
it's a virtual FS and we can implement whatever standards we like.  

> IOW, "foo.sz" might be a
> valid filename, but "foo:sz" already cannot be on certain filesystems...

  Yes, but then again it's perfectly valid on others, including managed
mounts, and given that it's *not* a filename that could /never/ occur, it
doesn't really gain you any real separation of the namespaces.

> The question about using two different filetypes in a row still applies,
> though.

  Like I said, setting a value always sets the content and type at the same
time; same would apply in this case.


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
