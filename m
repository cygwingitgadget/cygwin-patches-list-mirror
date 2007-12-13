Return-Path: <cygwin-patches-return-6192-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1422 invoked by alias); 13 Dec 2007 04:12:55 -0000
Received: (qmail 1412 invoked by uid 22791); 13 Dec 2007 04:12:53 -0000
X-Spam-Check-By: sourceware.org
Received: from rv-out-0910.google.com (HELO rv-out-0910.google.com) (209.85.198.186)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 13 Dec 2007 04:12:47 +0000
Received: by rv-out-0910.google.com with SMTP id b22so404379rvf.38         for <cygwin-patches@cygwin.com>; Wed, 12 Dec 2007 20:12:46 -0800 (PST)
Received: by 10.141.44.13 with SMTP id w13mr845977rvj.181.1197519166022;         Wed, 12 Dec 2007 20:12:46 -0800 (PST)
Received: by 10.140.188.9 with HTTP; Wed, 12 Dec 2007 20:12:46 -0800 (PST)
Message-ID: <55c2fd8a0712122012q3ee2afccm3b0e42244dba7987@mail.gmail.com>
Date: Thu, 13 Dec 2007 04:12:00 -0000
From: "Craig MacGregor" <cmacgreg@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] poll() return value is actually that of select()
In-Reply-To: <20071212185714.GD6618@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <55c2fd8a0712120959q7d8cec61vb37a24c569cfb0c2@mail.gmail.com> 	 <20071212185714.GD6618@calimero.vinschen.de>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00044.txt.bz2

On Dec 12, 2007 1:57 PM, Corinna Vinschen wrote:
>
> Works for me.  How does it break the build for you?  Patch?
>

I get the following error making cygserver... i set up my dev env in a
rush and just wanted a clean build, so i rolled back string.h to 1.8
for a quick fix:

g++ -L/cyg/build/i686-pc-cygwin/winsup
-L/cyg/build/i686-pc-cygwin/winsup/cygwin
-L/cyg/build/i686-pc-cygwin/winsup/w32api/lib -isystem
/cyg/src/winsup/include -isystem /cyg/src/winsup/cygwin/include
-isystem /cyg/src/winsup/w32api/include
-B/cyg/build/i686-pc-cygwin/newlib/ -isystem
/cyg/build/i686-pc-cygwin/newlib/targ-include -isystem
/cyg/src/newlib/libc/include -o cygserver.exe cygserver.o client.o
process.o msg.o sem.o shm.o threaded_queue.o transport.o
transport_pipes.o bsd_helper.o bsd_log.o bsd_mutex.o sysv_msg.o
sysv_sem.o sysv_shm.o
/cyg/build/i686-pc-cygwin/winsup/cygwin/smallprint.o
/cyg/build/i686-pc-cygwin/winsup/cygwin/strfuncs.o
/cyg/build/i686-pc-cygwin/winsup/cygwin/version.o
-L/cyg/build/i686-pc-cygwin/winsup/cygwin -lntdll
bsd_helper.o: In function `_Z17default_tun_checkP10tun_structPcPKc':
/cyg/src/winsup/cygserver/bsd_helper.cc:525: undefined reference to
`_cygwin_strcasecmp@8'
/cyg/src/winsup/cygserver/bsd_helper.cc:525: undefined reference to
`_cygwin_strcasecmp@8'
/cyg/src/winsup/cygserver/bsd_helper.cc:525: undefined reference to
`_cygwin_strcasecmp@8'
/cyg/src/winsup/cygserver/bsd_helper.cc:525: undefined reference to
`_cygwin_strcasecmp@8'
/cyg/src/winsup/cygserver/bsd_helper.cc:525: undefined reference to
`_cygwin_strcasecmp@8'
bsd_helper.o:/cyg/src/winsup/cygserver/bsd_helper.cc:529: more
undefined references to `_cygwin_strcasecmp@8' follow
Info: resolving __ctype_ by linking to __imp___ctype_ (auto-import)
collect2: ld returned 1 exit status
make[3]: *** [cygserver.exe] Error 1
make[3]: Leaving directory `/cyg/build/i686-pc-cygwin/winsup/cygserver'
make[2]: *** [cygserver] Error 1
make[2]: Leaving directory `/cyg/build/i686-pc-cygwin/winsup'
make[1]: *** [all-target-winsup] Error 2
make[1]: Leaving directory `/cyg/build'
make: *** [all] Error 2

> Thanks for the patch.  It looks good to me, but I'll slightly reformat
> it.  I'll rather have the `ir = 1' expressions standalone on a single
> line and curly brackets.  I'll apply it tomorrow.
>

I changed as few lines as possible to avoid the next point :)

> However, this patch is already almost beyond the upper bound (in terms
> of patch size) which we can incorporate without having a signed
> copyright assignment from you, see http://cygwin.com/contrib.html,
> section "Before you get started".  I don't want to keep you from
> providing more and bigger patches, of course, but we all had to go
> through this legal stuff :}
>

I'll make a note to myself to get an agreement out... starting a new
job so I don't know how many more patches I'll be sending in, but it
can't hurt to be ready I suppose.

-craig
