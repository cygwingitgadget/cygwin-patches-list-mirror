Return-Path: <cygwin-patches-return-5961-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25534 invoked by alias); 21 Aug 2006 18:17:30 -0000
Received: (qmail 25522 invoked by uid 22791); 21 Aug 2006 18:17:29 -0000
X-Spam-Check-By: sourceware.org
Received: from nf-out-0910.google.com (HELO nf-out-0910.google.com) (64.233.182.184)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 21 Aug 2006 18:17:23 +0000
Received: by nf-out-0910.google.com with SMTP id d4so436659nfe         for <cygwin-patches@cygwin.com>; Mon, 21 Aug 2006 11:17:20 -0700 (PDT)
Received: by 10.49.90.4 with SMTP id s4mr8083291nfl;         Mon, 21 Aug 2006 11:17:19 -0700 (PDT)
Received: by 10.78.179.13 with HTTP; Mon, 21 Aug 2006 11:17:19 -0700 (PDT)
Message-ID: <a6355d0d0608211117n7a6fb985y68579fc3205679ed@mail.gmail.com>
Date: Mon, 21 Aug 2006 18:17:00 -0000
From: "Wang Yiping" <ypwangandy@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] do_mount bug fix
In-Reply-To: <a6355d0d0608211111kcac6b0q51f8073a0d3c26d3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a6355d0d0608211052l6f756d9fq16f6ed3f1f7bba3e@mail.gmail.com> 	 <20060821175837.GF24551@trixie.casa.cgf.cx> 	 <a6355d0d0608211111kcac6b0q51f8073a0d3c26d3@mail.gmail.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00056.txt.bz2

> > Please provide a simple and complete test case which illustrates the problem.
> >
> > cgf
> >
>  OK, here is the test-case :-)
>
>  mkdir /tmp/test123
>  mount -u -o managed `cygpath -m /home/whateverdd` /tmp/test123/
>  umount /tmp/test123
>
> andy
>
I recheck, umount can delete the entry, with umount -u /tmp/test123.
But  it may be better to check it before it is mounted.
