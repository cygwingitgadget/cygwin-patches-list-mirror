Return-Path: <cygwin-patches-return-5960-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23286 invoked by alias); 21 Aug 2006 18:11:51 -0000
Received: (qmail 23274 invoked by uid 22791); 21 Aug 2006 18:11:51 -0000
X-Spam-Check-By: sourceware.org
Received: from nf-out-0910.google.com (HELO nf-out-0910.google.com) (64.233.182.186)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 21 Aug 2006 18:11:47 +0000
Received: by nf-out-0910.google.com with SMTP id d4so435180nfe         for <cygwin-patches@cygwin.com>; Mon, 21 Aug 2006 11:11:44 -0700 (PDT)
Received: by 10.49.90.4 with SMTP id s4mr8073996nfl;         Mon, 21 Aug 2006 11:11:44 -0700 (PDT)
Received: by 10.78.179.13 with HTTP; Mon, 21 Aug 2006 11:11:44 -0700 (PDT)
Message-ID: <a6355d0d0608211111kcac6b0q51f8073a0d3c26d3@mail.gmail.com>
Date: Mon, 21 Aug 2006 18:11:00 -0000
From: "Wang Yiping" <ypwangandy@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] do_mount bug fix
In-Reply-To: <20060821175837.GF24551@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a6355d0d0608211052l6f756d9fq16f6ed3f1f7bba3e@mail.gmail.com> 	 <20060821175837.GF24551@trixie.casa.cgf.cx>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00055.txt.bz2

On 8/21/06, Christopher Faylor <cgf-no-personal-reply-please@cygwin.com> wrote:
> On Mon, Aug 21, 2006 at 01:52:06PM -0400, Wang Yiping wrote:
> >When doing managed mount with none exist win32path It can't umount again.
> >We have to delete the entry from the windows registry by hand.
> >
> >$ df
> >Filesystem           1K-blocks      Used Available Use% Mounted on
> >D:\dev\cygwin\home\ypeang\tmp
> >                     36862556  32039836   4822720  87% /home/ypwang/tmp
> >$ umount /home/ypwang/tmp
> >umount: /home/ypwang/tmp: No such file or directory
> >
> >
> >2006-08-21  Yiping Wang  <ypwangandy@gmail.com>
> >
> >       * mount.cc (do_mount): Exit with error msg when using managed mount
> >       option on none exist win32path.
>
> Sorry but I can't duplicate this problem so I'm reluctant to check in
> this patch.
>
> Please provide a simple and complete test case which illustrates the problem.
>
> cgf
>
 OK, here is the test-case :-)

 mkdir /tmp/test123
 mount -u -o managed `cygpath -m /home/whateverdd` /tmp/test123/
 umount /tmp/test123

andy
