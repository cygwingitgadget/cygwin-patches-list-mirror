Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id D1E103894C1C
 for <cygwin-patches@cygwin.com>; Tue, 27 Apr 2021 13:19:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D1E103894C1C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MFsAJ-1loL7C0LOR-00HNkR for <cygwin-patches@cygwin.com>; Tue, 27 Apr 2021
 15:19:41 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 67435A80EEC; Tue, 27 Apr 2021 15:19:40 +0200 (CEST)
Date: Tue, 27 Apr 2021 15:19:40 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: connect: implement resetting a connected DGRAM
 socket
Message-ID: <YIgPbG6NoGqxyrAI@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210426193701.19895-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210426193701.19895-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:GDIVnmNhsvyeZFo2LJ2fY2SsBDnWKY77Zbr83EtqMVoQ62ohOrR
 j+lQVsAjAtw0YHIvo7QyatyVem3BBfB9yGh+sr+5S1WulZ2AYOlYi076AXngwL/J55LPM6I
 gqjbTWE394NL+g8nIyk8jzrTc+LUDpngPLeKc1sVFYB0Y8AP5ZNCcFPBBUX91Z9szoijyJ6
 fYjZLOGDrMZwKT0cM25aA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vpl4D1MoGtI=:fP/CFKWC67Lxqzyw/qlrWa
 TCn22LfZPuC4n7nUgcAAd0hj1JGRiiIlC9L5At0VehtWtDY9pKfBLbp2BZZDydH9cuV39Eqm8
 xCjbmAXOt+gTyOWAihKNMxo3teUC9morimu6p0gliWxnjX8iFKKEKiLHlXoo1TWWiRpfIXX+J
 GIvxOzY0QBzeuh+AakWyPuotnYnPHfCQy548xghWX+0cmv0+UKJUJsWPTjxOr62u+YYZZ8zyw
 KQeOdhqhA704AwM0HciSdkuDw33IQ7zDMY1kZN4j5nA5SxgO8MYLlrSsE+oqv+Nwr0s5WqWTa
 WhuzvBZRtOo7JgWivO351HiGqXqewhksWhCCviXvWbK6tdfYzYmWjOuCLrm/Bc2Tw7KbZs0a1
 VyelCy5uy4DuH3aWneRkpZEgeRp+1aULTor27f/9MWM4cNOmGyp9B16UalLB0qz+54TArgbkp
 XtYUWP00+DJDuG8NtXD4Ckwv0qgH503z+77Oy2Ntme3sGvxZA9VQIvJnxO+BtUAlb2XPVMFLr
 ONnYWR/qGLYIzZyTrKYFtw=
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 27 Apr 2021 13:19:44 -0000

On Apr 26 15:37, Ken Brown wrote:
> Following POSIX and Linux, allow a connected DGRAM socket's connection
> to be reset (so that the socket becomes unconnected).  This is done by
> calling connect and specifing an address whose family is AF_UNSPEC.
> ---
>  winsup/cygwin/fhandler_socket_inet.cc  | 21 ++++++++++++++++--
>  winsup/cygwin/fhandler_socket_local.cc | 30 +++++++++++++++++++++-----
>  winsup/cygwin/fhandler_socket_unix.cc  |  7 ++++++
>  winsup/cygwin/release/3.2.1            |  3 +++
>  winsup/doc/new-features.xml            |  6 ++++++
>  5 files changed, 60 insertions(+), 7 deletions(-)

LGTM.

> --- a/winsup/cygwin/release/3.2.1
> +++ b/winsup/cygwin/release/3.2.1
> @@ -1,6 +1,9 @@
>  What's new:
>  -----------
>  
> +- A connected datagram socket can now have its connection reset.  As
> +  specified by POSIX and Linux, this is done by calling connect(2)
> +  with an address structure whose family is AF_UNSPEC.

Isn't that just a bug, in theory?


Thanks,
Corinna
