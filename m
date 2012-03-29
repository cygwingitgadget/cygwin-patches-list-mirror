Return-Path: <cygwin-patches-return-7627-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12549 invoked by alias); 29 Mar 2012 14:36:58 -0000
Received: (qmail 12449 invoked by uid 22791); 29 Mar 2012 14:36:56 -0000
X-SWARE-Spam-Status: No, hits=-0.7 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL,TW_CP
X-Spam-Check-By: sourceware.org
Received: from smtp4.epfl.ch (HELO smtp4.epfl.ch) (128.178.224.218)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 29 Mar 2012 14:36:40 +0000
Received: (qmail 30310 invoked by uid 107); 29 Mar 2012 14:36:36 -0000
Received: from 76-10-162-117.dsl.teksavvy.com (HELO [192.168.0.100]) (76.10.162.117) (authenticated)  by smtp4.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Thu, 29 Mar 2012 16:36:37 +0200
Message-ID: <4F747373.5030605@cs.utoronto.ca>
Date: Thu, 29 Mar 2012 14:36:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Compiler warnings when building latest cygwin cvs with gcc-4.6 (0/2)
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
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q1/txt/msg00050.txt.bz2

Hi all

While trying to build the cygwin dll from source, I accidentally left my 
home-built gcc-4.6 in PATH... and it complains loudly about all kinds of 
things, some of which might actually be of interest. I'll follow up 
shortly with two patches that fix those problems in a backwards 
compatible way, in case this provides a improvement in code quality (and 
future-proofing for when we upgrade cygwin's gcc4).

The patched code compiles cleanly under both cygwin's gcc4 and my 
gcc-4.6.2, but the latter produces a broken cygwin1.dll. I haven't tried 
to figure out what goes wrong, since I don't know what changes went into 
cygwin's gcc4 to make it work properly in the first place. It could be 
something as simple as PATH/LD_LIBRARY_PATH...

Patch 1: fix function attribute conflicts
Patch 2: fix compiler misc. warnings

NOTE: the warnings patch applies safely, but with fuzz, if the 
attributes patch has already been applied. If you're paranoid, apply the 
warnings patch first.

Overview of changes:

1a. Conflicting function definition errors, due to functions declared 
with __attribute__((regparm(...))) and later defined without it. AFAIK, 
if both declaration and definition exist for a function, the definition 
must either give no attributes or all must match the declaration. This 
includes the __stdcall attribute...

1b. Related to #1, some member functions seem to have the wrong regparm 
number, probably somebody forgot about ``this'' when counting args. Even 
more strangely, the compiler complained about fhandler_{disk_file,tty}, 
but not fhandler_{socket,virtual}, even though the header file declares 
all as regparm(1). A similar story applies to fchown.

1c. Constructs like this:
> void __stdcall foo(int,int)  __attribute__ ((regparm (2)));
>
> void __stdcall foo(int,int)
> {
>     ...
Can be replaced by this:
> void __stdcall  __attribute__ ((regparm (2)))
> foo(int,int)
> {
>     ...

2a. Several variables are set but never used. While we could silence the 
compiler by marking them unused (see below), it's probably best to just 
remove them to avoid atrophied code. I decided which to do on a 
case-by-case basis, best-effort.
> - void *unused_ptr = ...;
> +void * __attribute__((unused)) unused_ptr = ...;

2b. There's one array out of bounds warning in the pointer arithmetic 
for fhandler_disk_file.cc near line 813; after consulting ntdll.h, I'm 
pretty sure the fix below is correct.
>        struct {
>          FILE_FULL_EA_INFORMATION ffei;
>          char buf[sizeof (NFS_V3_ATTR) + sizeof (fattr3)];
>        } ffei_buf;
>        ffei_buf.ffei.NextEntryOffset = 0;
>        ffei_buf.ffei.Flags = 0;
>        ffei_buf.ffei.EaNameLength = sizeof (NFS_V3_ATTR) - 1;
>        ffei_buf.ffei.EaValueLength = sizeof (fattr3);
>        strcpy (ffei_buf.ffei.EaName, NFS_V3_ATTR);
> -      fattr3 *nfs_attr = (fattr3 *) (ffei_buf.ffei.EaName
> -                                    + ffei_buf.ffei.EaNameLength + 1);
> +      fattr3 *nfs_attr = (fattr3 *) (ffei_buf.buf + 
> ffei_buf.ffei.EaNameLength);
>        memset (nfs_attr, 0, sizeof (fattr3));

Regards,
Ryan
