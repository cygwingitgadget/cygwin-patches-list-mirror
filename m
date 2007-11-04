Return-Path: <cygwin-patches-return-6151-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6794 invoked by alias); 4 Nov 2007 04:01:37 -0000
Received: (qmail 6775 invoked by uid 22791); 4 Nov 2007 04:01:31 -0000
X-Spam-Check-By: sourceware.org
Received: from fk-out-0910.google.com (HELO fk-out-0910.google.com) (209.85.128.186)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 04 Nov 2007 04:01:29 +0000
Received: by fk-out-0910.google.com with SMTP id 19so2356435fkr         for <cygwin-patches@cygwin.com>; Sat, 03 Nov 2007 21:01:26 -0700 (PDT)
Received: by 10.86.95.20 with SMTP id s20mr2196974fgb.1194148886228;         Sat, 03 Nov 2007 21:01:26 -0700 (PDT)
Received: from ?62.169.106.18? ( [62.169.106.18])         by mx.google.com with ESMTPS id d27sm4902065nfh.2007.11.03.21.01.23         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Sat, 03 Nov 2007 21:01:24 -0700 (PDT)
Message-ID: <472D43F5.4090700@portugalmail.pt>
Date: Sun, 04 Nov 2007 04:01:00 -0000
From: Pedro Alves <pedro_alves@portugalmail.pt>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; pt-BR; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Rewrite/fix cygwin1.dbg generation
References: <472CB021.5040806@portugalmail.pt> <472CB37A.407FAE34@dessent.net> <20071104022028.GA6236@ednor.casa.cgf.cx>
In-Reply-To: <20071104022028.GA6236@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00003.txt.bz2

Christopher Faylor wrote:

> If that is the case, then this is a welcome change but I'm wondering if
> it really is true.  Since the debug stripping is linked to the way that
> cygwin manages the cygwin heap, it is possible that things only appear
> to work until you allocate more space in the heap.  Has anyone tried the
> above with a program that, say, opens a lot of file handles?
> 

Ah, got it.  VirtualAlloc fails on the first _csbrk, since it
is tripping on the VMA of .gnu_debuglink ...  I assumed it would
not be a problem, since it isn't ALLOCced, but oh well...
I tried adding an EXCLUDE/NOLOAD flag to .gnu_debuglink, but no
can do.

10 .cygheap      000a0000  611e0000  611e0000  00000000  2**2
                  ALLOC
11 .gnu_debuglink 00000010  61280000  61280000  001d0a00  2**2
                  CONTENTS, READONLY, DEBUGGING

I'll come up with a different fix.

Cheers,
Pedro Alves
