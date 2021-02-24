Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id CF51B385482D
 for <cygwin-patches@cygwin.com>; Wed, 24 Feb 2021 09:43:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CF51B385482D
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MeTkC-1ln50044dY-00aSv4 for <cygwin-patches@cygwin.com>; Wed, 24 Feb 2021
 10:43:53 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 9F7F8A80D46; Wed, 24 Feb 2021 10:43:52 +0100 (CET)
Date: Wed, 24 Feb 2021 10:43:52 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: AF_UNIX: allow opening with the O_PATH flag
Message-ID: <YDYf2PqCJi/ezsZm@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210223174455.36621-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210223174455.36621-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:aKD0vAYCZOaeqhQiZE0JS3zNms4LYhlScxXLul3aKyNGlA/M4s5
 3Y9HYx7IrOiAaSvpWN9jpPYk8a++ucg4q6rJjFklLiyUaf3+vTjCmF16FNsQlmnjbyvAfIr
 aEQkPGO2LcTi9ogkuR8+FttOOSIyJWIGua/fIBBcWJYw3VjSAtVVFbzm9o10Zl4PvXdTzQS
 vY/nFmdNsUw/kZAd3Vl7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LHqD9KYY1fQ=:7bGZ4Ax6BEOX2lqhQ+C/+P
 7iWZNYtiRFBlEsXOOx2FU3Q/Uhr9x1AUdi+fSwyczctG9eh8fJTGM2xrpbLL6uwGoSYHQT58o
 NC4y/mlN3rJzWfyD1p+dcZZn4rYHpLXE15zVa4bsZwjaLY9RPb6JWChn9DiLh6zWqDElm3Si8
 czSlSteJb6qY7L2fhkMKa276JNl952z63omJcdbmychNEdWkQKD8p3o0LENeAI49wkTvD8Zt1
 fe2/nkew3zVoWgY9HOk8LTgcvJiKzm9NiotqDbzR7AXDMZgHfecriCn9d58Nwqp7kPp9dbbSA
 I+2uROYjxf6R4nWpuxtYpB3RAN7LDj0UgpLOlv1fC3FqR22AJbKjlbyIGpo6DtLTKRTeQ6vBd
 akl63hk3K0zTtX/lDoI1xFUOnqto9PeF0Y9OHOaYvb+hXwZG+QOfac+Pez0lShsoqH3U9bzaA
 OeWODNh6mA==
X-Spam-Status: No, score=-101.1 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Wed, 24 Feb 2021 09:43:58 -0000

On Feb 23 12:44, Ken Brown via Cygwin-patches wrote:
> This was done for the fhandler_socket_local class in commits
> 3a2191653a, 141437d374, and 477121317d, but the fhandler_socket_unix
> class was overlooked.
> ---
>  winsup/cygwin/fhandler.h              |  1 +
>  winsup/cygwin/fhandler_socket_unix.cc | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+)

LGTM.


Thanks,
Corinna
