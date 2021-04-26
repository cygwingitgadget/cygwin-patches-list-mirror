Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id D7D1F3857C63
 for <cygwin-patches@cygwin.com>; Mon, 26 Apr 2021 09:28:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D7D1F3857C63
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MXHBo-1m6Qhr0Jwc-00Yl0C for <cygwin-patches@cygwin.com>; Mon, 26 Apr 2021
 11:28:41 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 04429A80EA8; Mon, 26 Apr 2021 11:28:40 +0200 (CEST)
Date: Mon, 26 Apr 2021 11:28:39 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: connect: set connect state for DGRAM sockets
Message-ID: <YIaHx1Wvm2yuFga/@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210423185141.7687-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210423185141.7687-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:URvoqwh5nq1rDjo+GvAvIpUbfI+WFHYhh0pGLyaB6USjmnXZUzu
 iKKBz9xJSY5pB80Mhai/wPnPbTK+VwCycUK3L+hzJaZFybxsTSKOGXES9ok4IMfzKSEf88N
 dBE6hq9t0q1Jzanq9xtDtlYiJUQEiKheVrsvDwdRhjMDAbsvFs0cR/+SdalIWhHY8Om5nrI
 K0IdP5nXErHd9hl4NmfBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YURzSbLrqfw=:uVOvFScHRr45tF+/ullmCM
 7OP5Rzi1vvXJhP3ZgZYhXSJK5oQM3dVivYew+LArqDtYle+5bPeXbuFMJ4xWGI0hkLMV28XiC
 GFn6wy5Lk/j37JJ2O/9YH1S5PyT0D5VbEbHpUkgHu+jw6eX4Yt8hDS7AsrN9OOxBD/lx/bWmc
 JZTUvgdc1IZGK47vnXlGsO6zF0wUrL7GdAmLwhk3hIf1bpAk0HaT7HJfd2Sj0Ji4F31sfRbOp
 v7uxge979VSRt0o1vajbi/ahHe6ptCvaXZWY+5w336Cmu1wF0N3mPGScEhDPsWuXZvag+SVHw
 xrYyxtJsmUGcnSv5yjzxsa0vQHEzNN533G83yrpWv4+5vo/72/eNFc7hewTXHop+ziuiGsddP
 sdalPkjNlVqaO7azdEPkUNzsv0isHjx+e/zWGOUf02lf0zwJDmWORweGWnBxRsEvqdsXAZayn
 dzxGNZdoE4rGiLAeqLGm5RWrO2ciTWaJ2y/5hPgqL00T3PS0KuyalZcOpRAaGnb/Mj9AGNItT
 QGlCNlY4svzmhjVBNdA60c=
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
X-List-Received-Date: Mon, 26 Apr 2021 09:28:46 -0000

On Apr 23 14:51, Ken Brown wrote:
> When connect is called on a DGRAM socket, the call to Winsock's
> connect can immediately return successfully rather than failing with
> WSAEWOULDBLOCK.  Set the connect state to "connected" in this case.
> 
> Previously the connect state remained "connect_pending" after the
> successful connection.
> ---
>  winsup/cygwin/fhandler_socket_inet.cc  | 19 +++++++++++--------
>  winsup/cygwin/fhandler_socket_local.cc | 19 +++++++++++--------
>  2 files changed, 22 insertions(+), 16 deletions(-)

ACK.  Please push (a release msg entry would be nice, too).


Thanks,
Corinna
