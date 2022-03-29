Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id A53023857C4A
 for <cygwin-patches@cygwin.com>; Tue, 29 Mar 2022 15:40:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org A53023857C4A
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 70499CC21;
 Tue, 29 Mar 2022 11:40:19 -0400 (EDT)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 6D470CC1C;
 Tue, 29 Mar 2022 11:40:19 -0400 (EDT)
Date: Tue, 29 Mar 2022 08:40:19 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: pipe: Avoid deadlock for non-cygwin writer.
In-Reply-To: <20220329090753.47207-1-takashi.yano@nifty.ne.jp>
Message-ID: <alpine.BSO.2.21.2203290837290.56460@resin.csoft.net>
References: <20220329090753.47207-1-takashi.yano@nifty.ne.jp>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, SPF_HELO_PASS, SPF_PASS,
 TXREP, T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Tue, 29 Mar 2022 15:40:22 -0000

On Tue, 29 Mar 2022, Takashi Yano wrote:

> diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
> index b87160edb..006c7b4bf 100644
> --- a/winsup/cygwin/fhandler.h
> +++ b/winsup/cygwin/fhandler.h
> @@ -1194,6 +1194,7 @@ private:
>    HANDLE hdl_cnt_mtx;
>    HANDLE query_hdl_proc;
>    HANDLE query_hdl_value;
> +  HANDLE query_hdl_close_req_evt;
>    uint64_t pipename_key;
>    DWORD pipename_pid;
>    LONG pipename_id;
> @@ -1258,6 +1259,16 @@ public:
>    }
>    bool reader_closed ();
>    HANDLE temporary_query_hdl ();
> +  bool need_close_query_hdl ()
> +    {
> +      return query_hdl_close_req_evt ?
> +	IsEventSignalled (query_hdl_close_req_evt) : false;
> +    }
> +  void request_close_query_hdl ()
> +    {
> +      if (query_hdl_close_req_evt)
> +	SetEvent (query_hdl_close_req_evt);
> +    }
>  };
>
>  #define CYGWIN_FIFO_PIPE_NAME_LEN     47

Oh, a minor optimization: should close_query_handle also close (and NULL)
the query_hdl_close_req_evt?
