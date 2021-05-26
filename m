Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 6A0B6394CC07
 for <cygwin-patches@cygwin.com>; Wed, 26 May 2021 19:19:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6A0B6394CC07
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1My3Ad-1lV6m50bkd-00zUdP for <cygwin-patches@cygwin.com>; Wed, 26 May 2021
 21:19:38 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 98DB5A8065B; Wed, 26 May 2021 21:19:37 +0200 (CEST)
Date: Wed, 26 May 2021 21:19:37 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fhandler_mqueue::mq_open: fix typo
Message-ID: <YK6fSboZgJLUHj9t@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <8dadeb18-2033-fcca-23bd-39a0aee99ecb@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8dadeb18-2033-fcca-23bd-39a0aee99ecb@cornell.edu>
X-Provags-ID: V03:K1:z1k7dX062Qu+08a7/yXScB2TV5SS4n219uZgH//HSmLMJYTsq+l
 mNukqWFEKS1GnVXxYbTUs0eM3/tW2Tnt8VPqCiUYmkSKl/W2uWeSyqzwe1pME/7xxfoVuIj
 hXVPpb6xJK73shlKpGYZ3XTsSZQGFmigKJt0QUZWB4FSf+vnqpkbF/J2A3qWF3OTZA2EJ3V
 ood6skBoUmutI/tWKXtvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OPavQlunWKM=:Yl97h4/ff+PrvtW0lkUjDm
 QlVv4tyE9ByLx5ndpgrCcgHnoAiUaXvv8NEp1WdtrvyjiGr+zfM9/rlBzf/O41FQB6x0AiEPi
 /E7aFiRqSh9EBseA4ZdzdMEihxtl/Af3Ui9dcHDhTS12mUQPHh9Wrgun5CiPusUSy/0xcw4C1
 eWKkJYWa9ud/wW4FfIGbuWmPXv9nbE3I3G8Tix5aKXTLa41kcaMkP7X8d8ZH8pjbvfzNTHnwd
 2d2tpg9uedkW6zOSijQNx7MTGxtWjMB1e7HOKVUeLnbn5Kd9fokWDDuS+dUS8Tcv5xGZXfSuW
 co88fGlvw91EwD1Nz2ILUsK5bbARTzANoEED80DYbSCv3nEIY4GLEjGm/xrT4yRWxqSpBZ3od
 ZN1vwbMBk29RNl2elnF1tTznRNPsjoCk2r3PLJqhVZ7qW1XYZSKv/lDj4EPFP3SerqD58VGBx
 ow+dPI6izm9c/TCGK3vjP54myHo13jaOiCGZ7lpBNckuxU2s4HldOds+9zv6sXKpcTVCUpNyb
 z+BXGNDTLTAm/lsA5Pdt58=
X-Spam-Status: No, score=-106.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Wed, 26 May 2021 19:19:40 -0000

On May 26 14:56, Ken Brown wrote:
> Patch attached.
> 
> Sorry for using an attachment, but my smtp server just started using
> 2-factor authorization, and I haven't figured out how to make it work with
> git-send-email.

No worries.  Thanks for catching this bug, please push.


Corinna

> >From dfe5988f961ff97d283a9c460e75499db168163a Mon Sep 17 00:00:00 2001
> From: Ken Brown <kbrown@cornell.edu>
> Date: Wed, 26 May 2021 12:48:58 -0400
> Subject: [PATCH] Cygwin: fhandler_mqueue::mq_open: fix typo
> 
> ---
>  winsup/cygwin/fhandler_mqueue.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler_mqueue.cc b/winsup/cygwin/fhandler_mqueue.cc
> index 745c80643..d81880cba 100644
> --- a/winsup/cygwin/fhandler_mqueue.cc
> +++ b/winsup/cygwin/fhandler_mqueue.cc
> @@ -117,7 +117,7 @@ exists:
>        if (status != STATUS_SHARING_VIOLATION)
>  	{
>  	  __seterrno_from_nt_status (status);
> -	  return -1;
> +	  return 0;
>  	}
>        Sleep (100L);
>      }
> -- 
> 2.31.1
> 

