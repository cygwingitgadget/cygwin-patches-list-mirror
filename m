Return-Path: <cygwin-patches-return-9702-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128286 invoked by alias); 18 Sep 2019 21:31:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 128268 invoked by uid 89); 18 Sep 2019 21:31:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-12.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS autolearn=ham version=3.3.1 spammy=Senior
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Sep 2019 21:31:32 +0000
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id A16494E83E	for <cygwin-patches@cygwin.com>; Wed, 18 Sep 2019 21:31:31 +0000 (UTC)
Received: from ovpn-121-37.rdu2.redhat.com (ovpn-121-37.rdu2.redhat.com [10.10.121.37])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A0BF19C5B	for <cygwin-patches@cygwin.com>; Wed, 18 Sep 2019 21:31:31 +0000 (UTC)
Message-ID: <7aa9ec47cbde83bcd4c618433a98275f16ace6f6.camel@redhat.com>
Subject: Re: [PATCH v2 1/1] Cygwin: console: Revive Win7 compatibility.
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Date: Wed, 18 Sep 2019 21:31:00 -0000
In-Reply-To: <20190918204955.2131-2-takashi.yano@nifty.ne.jp>
References: <20190918204955.2131-1-takashi.yano@nifty.ne.jp>	 <20190918204955.2131-2-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30)
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q3/txt/msg00222.txt.bz2

On Thu, 2019-09-19 at 05:49 +0900, Takashi Yano wrote:
> - The commit fca4cda7a420d7b15ac217d008527e029d05758e broke Win7
>   compatibility. This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler.h          | 6 ++++++
>  winsup/cygwin/fhandler_console.cc | 6 ------
>  winsup/cygwin/select.cc           | 1 -
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
> index 4efb6a4f2..94b0e520b 100644
> --- a/winsup/cygwin/fhandler.h
> +++ b/winsup/cygwin/fhandler.h
> @@ -43,6 +43,12 @@ details. */
>  
>  #define O_TMPFILE_FILE_ATTRS (FILE_ATTRIBUTE_TEMPORARY | FILE_ATTRIBUTE_HIDDEN)
>  
> +/* Buffer size for ReadConsoleInput() and PeakConsoleInput(). */
> +/* Per MSDN, max size of buffer required is below 64K. */
> +/* (65536 / sizeof (INPUT_RECORD)) is 3276, however,
> +   ERROR_NOT_ENOUGH_MEMORY occurs in win7 if this value is used. */
> +#define INREC_SIZE 2048
> +

Would it make sense to define this using wincap so it is 2048 for
Win7/2K8 and 3276 for newer versions?

>  extern const char *windows_device_names[];
>  extern struct __cygwin_perfile *perfile_table;
>  #define __fmode (*(user_data->fmode_ptr))
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
> index 709b8255d..86c39db25 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -499,9 +499,6 @@ fhandler_console::process_input_message (void)
>  
>    termios *ti = &(get_ttyp ()->ti);
>  
> -	  /* Per MSDN, max size of buffer required is below 64K. */
> -#define	  INREC_SIZE	(65536 / sizeof (INPUT_RECORD))
> -
>    fhandler_console::input_states stat = input_processing;
>    DWORD total_read, i;
>    INPUT_RECORD input_rec[INREC_SIZE];
> @@ -1165,9 +1162,6 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
>  	return -1;
>        case FIONREAD:
>  	{
> -	  /* Per MSDN, max size of buffer required is below 64K. */
> -#define	  INREC_SIZE	(65536 / sizeof (INPUT_RECORD))
> -
>  	  DWORD n;
>  	  int ret = 0;
>  	  INPUT_RECORD inp[INREC_SIZE];
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index ed8c98d1c..e7014422b 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -1209,7 +1209,6 @@ peek_pty_slave (select_record *s, bool from_select)
>  	{
>  	  if (ptys->is_line_input ())
>  	    {
> -#define INREC_SIZE (65536 / sizeof (INPUT_RECORD))
>  	      INPUT_RECORD inp[INREC_SIZE];
>  	      DWORD n;
>  	      PeekConsoleInput (ptys->get_handle (), inp, INREC_SIZE, &n);

-- 
Yaakov Selkowitz
Senior Software Engineer - Platform Enablement
Red Hat, Inc.

