Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 7EF53385800A
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 14:49:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7EF53385800A
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MzQXu-1lwcdU0BF2-00vQYh for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 15:49:28 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 86801A80988; Mon, 18 Jan 2021 15:49:27 +0100 (CET)
Date: Mon, 18 Jan 2021 15:49:27 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 02/11] syscalls.cc: Deduplicate _remove_r
Message-ID: <20210118144927.GH59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-3-ben@wijen.net>
 <20210118105603.GS59030@calimero.vinschen.de>
 <6de2f124-c5dd-34cb-1914-4eb0454b41d8@wijen.net>
 <20210118130420.GE59030@calimero.vinschen.de>
 <fed934ea-5942-a80f-bd81-a1a6b03acb24@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fed934ea-5942-a80f-bd81-a1a6b03acb24@wijen.net>
X-Provags-ID: V03:K1:BqZKm5kKiPVh1hwf8j5egaSVcPfUpPpGUjYAM+c71xd6pbl8EOP
 QGfbBaYkrDNTiYtKszfB3jdJttolgDt3IzNwxlsvQ4wwxgw26lCJC6bcHuB+QHvqg5OYcHa
 GnEolQ0lCBobLCNWjRp6pFvh70WydFlqQ1HSyUAIxhZmyxBLo6j+aQeZj5bYXxNMjzUGh1x
 uaB0oCux7m6LULSxgABww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fE3FItgOJ3w=:jxdK2lqslPOvseJAG4ZbkX
 dJ8Md6kUerhGRsUWsllkP61onlcQ7Vk54FopX9+rMGE6NeAzsvfSDes2zenRV5eZANwkKpZGl
 W5kB+IE2MDX6cJuMsmZRjD5A+CS3R7SsaAIiUB5JD5nLchPGWWEB+FwRxzlrF9QIvBG8/NAZ8
 DNjcmJ/RpQi7lhxQFGOoYMehKnpCQn0hw6miD/iEZera3FDXmR74xdH5XY4VH8bxPRFmtVbic
 7rs+MFgAjeCW3yHn76+Yvl1/EQEysUXcx39rdzPEDAnJj6KN7VtGB6O6wnBPftIyfVE1MqGlG
 yuogGzY3zGcKCPwppz71nnPTt+xyhIPae+Hk/sC1+DQpcJaCVQ23KUsZEyEfelZ7oQSDZtFSR
 4c54PPp3INAZjOMeFBgCpFJ03JcUV7sllbi+7nkTSd3mfzdKNRtK0MRuQ1TzzW9Digak8xWV/
 jKM/49YQgg==
X-Spam-Status: No, score=-100.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 18 Jan 2021 14:49:30 -0000

On Jan 18 14:51, Ben wrote:
> On 18-01-2021 14:04, Corinna Vinschen via Cygwin-patches wrote:
> > What about this instead?  It should be better optimizable:
> > 
> Hmmm:
> * _remove_r should still set reent->_errno

This is redundant:

  errno == (*__errno ()) == _REENT->_errno == __getreent ()->errno

So ptr->_errno is already set.

> * _GLOBAL_REENT isn't threadlocal, what about __getreent()

Yeah, that makes sense.  Just use the _REENT macro instead.

Care to send the resulting patch?


Thanks,
Corinna
