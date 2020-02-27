Return-Path: <cygwin-patches-return-10136-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 116321 invoked by alias); 27 Feb 2020 18:03:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 116264 invoked by uid 89); 27 Feb 2020 18:03:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.5 required=5.0 tests=AWL,BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.1 spammy=surrounded, 1903, black
X-HELO: re-prd-fep-049.btinternet.com
Received: from mailomta25-re.btinternet.com (HELO re-prd-fep-049.btinternet.com) (213.120.69.118) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 27 Feb 2020 18:03:52 +0000
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])          by re-prd-fep-049.btinternet.com with ESMTP          id <20200227180350.JUGU7644.re-prd-fep-049.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;          Thu, 27 Feb 2020 18:03:50 +0000
Authentication-Results: btinternet.com;    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-OWM-Source-IP: 31.51.207.12 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.106] (31.51.207.12) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as jonturney@btinternet.com)        id 5E3A16DE0385301D; Thu, 27 Feb 2020 18:03:50 +0000
Subject: Re: [PATCH v2 1/4] Cygwin: console: Add workaround for broken IL/DL in xterm mode.
To: Takashi Yano <takashi.yano@nifty.ne.jp>, Cygwin Patches <cygwin-patches@cygwin.com>
References: <20200226153302.584-1-takashi.yano@nifty.ne.jp> <20200226153302.584-2-takashi.yano@nifty.ne.jp>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <05cca441-eb83-4600-90f3-bf82ec7a0190@dronecode.org.uk>
Date: Thu, 27 Feb 2020 18:03:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200226153302.584-2-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2020-q1/txt/msg00242.txt

On 26/02/2020 15:32, Takashi Yano wrote:
> - Cygwin console with xterm compatible mode causes problem reported
>    in https://www.cygwin.com/ml/cygwin-patches/2020-q1/msg00212.html
>    if background/foreground colors are set to gray/black respectively
>    in Win10 1903/1909. This is caused by "CSI Ps L" (IL), "CSI Ps M"
>    (DL) and "ESC M" (RI) control sequences which are broken. This
>    patch adds a workaround for the issue.
> ---
>   winsup/cygwin/fhandler_console.cc | 156 +++++++++++++++++++++++++++++-
>   winsup/cygwin/wincap.cc           |  10 ++
>   winsup/cygwin/wincap.h            |   2 +
>   3 files changed, 166 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
> index 328424a7d..c2198ea1e 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -57,6 +57,16 @@ bool NO_COPY fhandler_console::invisible_console;
>      Only one console can exist in a process, therefore, static is suitable. */
>   static struct fhandler_base::rabuf_t con_ra;
>   
> +/* Write pending buffer for ESC sequence handling
> +   in xterm compatible mode */
> +#define WPBUF_LEN 256
> +static unsigned char wpbuf[WPBUF_LEN];
> +static int wpixput;
> +#define wpbuf_put(x) \
> +  wpbuf[wpixput++] = x; \
> +  if (wpixput > WPBUF_LEN) \
> +    wpixput--;
> +
>   static void
>   beep ()
[...]
> +		}
> +	      else
> +		wpbuf_put (*src);
> +	      WriteConsoleA (get_output_handle (), wpbuf, wpixput, &n, 0);
> +	      con.state = normal;
> +	      wpixput = 0;
> +	    }

This generates a (useful!) warning with gcc 9.2.0:

> ../../../../winsup/cygwin/fhandler_console.cc: In member function 'virtual ssize_t fhandler_console::write(const void*, size_t)':
> ../../../../winsup/cygwin/fhandler_console.cc:67:3: error: macro expands to multiple statements [-Werror=multistatement-macros]
>    67 |   wpbuf[wpixput++] = x; \
>       |   ^~~~~
> ../../../../winsup/cygwin/fhandler_console.cc:67:3: note: in definition of macro 'wpbuf_put'
>    67 |   wpbuf[wpixput++] = x; \
>       |   ^~~~~
> ../../../../winsup/cygwin/fhandler_console.cc:2993:8: note: some parts of macro expansion are not guarded by this 'else' clause
>  2993 |        else
>       |        ^~~~

So I think either the macro need it contents contained by a 'do { ... } 
while(0)',  or that instance of it needs to be surrounded by braces, to 
do what you intend.
