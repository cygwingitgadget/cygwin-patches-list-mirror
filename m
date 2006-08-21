Return-Path: <cygwin-patches-return-5959-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4924 invoked by alias); 21 Aug 2006 17:58:45 -0000
Received: (qmail 4909 invoked by uid 22791); 21 Aug 2006 17:58:44 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-229.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.229)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 21 Aug 2006 17:58:38 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 1141913C042; Mon, 21 Aug 2006 13:58:37 -0400 (EDT)
Date: Mon, 21 Aug 2006 17:58:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] do_mount bug fix
Message-ID: <20060821175837.GF24551@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <a6355d0d0608211052l6f756d9fq16f6ed3f1f7bba3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6355d0d0608211052l6f756d9fq16f6ed3f1f7bba3e@mail.gmail.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00054.txt.bz2

On Mon, Aug 21, 2006 at 01:52:06PM -0400, Wang Yiping wrote:
>When doing managed mount with none exist win32path It can't umount again.
>We have to delete the entry from the windows registry by hand.
>
>$ df
>Filesystem           1K-blocks      Used Available Use% Mounted on
>D:\dev\cygwin\home\ypeang\tmp
>                     36862556  32039836   4822720  87% /home/ypwang/tmp
>$ umount /home/ypwang/tmp
>umount: /home/ypwang/tmp: No such file or directory
>
>
>2006-08-21  Yiping Wang  <ypwangandy@gmail.com>
>
>       * mount.cc (do_mount): Exit with error msg when using managed mount
>       option on none exist win32path.

Sorry but I can't duplicate this problem so I'm reluctant to check in
this patch.

Please provide a simple and complete test case which illustrates the problem.

cgf
