Return-Path: <cygwin-patches-return-8907-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130387 invoked by alias); 7 Nov 2017 15:33:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130375 invoked by uid 89); 7 Nov 2017 15:33:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=
X-HELO: out4-smtp.messagingengine.com
Received: from out4-smtp.messagingengine.com (HELO out4-smtp.messagingengine.com) (66.111.4.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 07 Nov 2017 15:33:53 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])	by mailout.nyi.internal (Postfix) with ESMTP id 0804D20D5E;	Tue,  7 Nov 2017 10:33:52 -0500 (EST)
Received: from frontend2 ([10.202.2.161])  by compute6.internal (MEProxy); Tue, 07 Nov 2017 10:33:52 -0500
X-ME-Sender: <xms:X9IBWqXIf-XhhtuQxP3sCmp6AtlGIok2xeX837ZqjdjAxnfBRDWeuw>
Received: from [192.168.1.102] (host86-162-230-154.range86-162.btcentralplus.com [86.162.230.154])	by mail.messagingengine.com (Postfix) with ESMTPA id 9D4AB24DF9;	Tue,  7 Nov 2017 10:33:51 -0500 (EST)
Subject: Re: [PATCH] Fix two bugs in the limit of large numbers of sockets:
To: "Erik M. Bray" <erik.m.bray@gmail.com>
References: <20171107134449.11532-1-erik.m.bray@gmail.com>
Cc: Cygwin Patches <cygwin-patches@cygwin.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <a9f1369e-a8d2-d668-de1c-6c0e78099035@dronecode.org.uk>
Date: Tue, 07 Nov 2017 15:33:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171107134449.11532-1-erik.m.bray@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2017-q4/txt/msg00037.txt.bz2

On 07/11/2017 13:44, Erik M. Bray wrote:
> * Fix the maximum number of sockets allowed in the session to 2048,
>    instead of making it relative to sizeof(wsa_event).
> 
>    The original choice of 2048 was in order to fit the wsa_events array
>    in the .cygwin_dll_common shared section, but there is still enough
>    room to grow there to have 2048 sockets on 64-bit as well.
> 
> * Return an error and set errno=ENOBUF if a socket can't be created
>    due to this limit being reached.
> ---
>   winsup/cygwin/fhandler_socket.cc | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_socket.cc b/winsup/cygwin/fhandler_socket.cc
> index 7a6dbdc..b8eda57 100644
> --- a/winsup/cygwin/fhandler_socket.cc
> +++ b/winsup/cygwin/fhandler_socket.cc
> @@ -496,7 +496,7 @@ fhandler_socket::af_local_set_secret (char *buf)
>   /* Maximum number of concurrently opened sockets from all Cygwin processes
>      per session.  Note that shared sockets (through dup/fork/exec) are
>      counted as one socket. */
> -#define NUM_SOCKS       (32768 / sizeof (wsa_event))
> +#define NUM_SOCKS       ((unsigned int) 2048)
>   
>   #define LOCK_EVENTS	\
>     if (wsock_mtx && \
> @@ -623,7 +623,14 @@ fhandler_socket::init_events ()
>         NtClose (wsock_mtx);
>         return false;
>       }
> -  wsock_events = search_wsa_event_slot (new_serial_number);
> +  if (!(wsock_events = search_wsa_event_slot (new_serial_number)));

This has a stray ';' at the end of the line

../../../../winsup/cygwin/fhandler_socket.cc: In member function 'bool 
fhandler_socket::init_events()':
../../../../winsup/cygwin/fhandler_socket.cc:626:3: error: this 'if' 
clause does not guard... [-Werror=misleading-indentation]
    if (!(wsock_events = search_wsa_event_slot (new_serial_number)));
    ^~
../../../../winsup/cygwin/fhandler_socket.cc:627:5: note: ...this 
statement, but the latter is misleadingly indented as if it is guarded 
by the 'if'
      {
      ^

> +    {
> +      set_errno (ENOBUFS);
> +      NtClose (wsock_evt);
> +      NtClose (wsock_mtx);
> +      return false;
> +    }
> +
>     /* sock type not yet set here. */
>     if (pc.dev == FH_UDP || pc.dev == FH_DGRAM)
>       wsock_events->events = FD_WRITE;
> 

How did you test this?
