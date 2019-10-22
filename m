Return-Path: <cygwin-patches-return-9777-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4986 invoked by alias); 22 Oct 2019 07:20:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 4973 invoked by uid 89); 22 Oct 2019 07:20:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=screen, yourself
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 22 Oct 2019 07:20:33 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 09:20:30 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1iMoSz-0005uz-HV; Tue, 22 Oct 2019 09:20:29 +0200
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
To: cygwin-patches@cygwin.com
References: <20191018113721.2486-1-takashi.yano@nifty.ne.jp>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <b13f5d3c-c557-ff4e-6fcd-399952bad47e@ssi-schaefer.com>
Date: Tue, 22 Oct 2019 07:20:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018113721.2486-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q4/txt/msg00048.txt.bz2

Hi Takashi,

On 10/18/19 1:37 PM, Takashi Yano wrote:
> ---
>  winsup/cygwin/fhandler_tty.cc | 21 ++++++++++++++++++++-
>  winsup/cygwin/tty.cc          |  1 +
>  winsup/cygwin/tty.h           |  1 +
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index da6119dfb..163f93f35 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -1305,6 +1305,20 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
>    if (bg <= bg_eof)
>      return (ssize_t) bg;
>  
> +  if (get_ttyp ()->need_clear_screen_on_write)
> +    {
> +      const char *term = getenv ("TERM");
> +      if (term && strcmp (term, "dumb") && !strstr (term, "emacs") &&
> +	  wcsstr (myself->progname, L"\\usr\\sbin\\sshd.exe"))

Again, my real problem does not utilize ssh at all, but is some python script
using multiple pty.openpty() to spawn commands inside, to allow for herding
all the subprocesses started by the commands (Ctrl-C or similar).

The ssh -t is just the sample showing a similar effect.

Unfortunately, I'm not deep enough into that python script to quickly provide
a test case with pty.openpty() combined with all the tty settings used there.

I've started to extract the important bits, but that may take a while.  OTOH,
this is an open source project if you like to try yourself: prefix.gentoo.org

Thanks!
/haubi/
