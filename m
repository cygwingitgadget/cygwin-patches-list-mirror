Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id EF15B386EC4B
 for <cygwin-patches@cygwin.com>; Mon,  1 Mar 2021 12:31:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EF15B386EC4B
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MGzDv-1l4LVV0sxH-00E7Sa for <cygwin-patches@cygwin.com>; Mon, 01 Mar 2021
 13:31:18 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id AA9A7A80D87; Mon,  1 Mar 2021 13:31:17 +0100 (CET)
Date: Mon, 1 Mar 2021 13:31:17 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/7] Fix some system calls on sockets
Message-ID: <YDzelaED+w/aWlDQ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210225224812.61523-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210225224812.61523-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:7qz8zSAPAR9LORGDMZKiLhVUsCcRjJK87SfYf2bWTJxwU26nIZx
 TScTCG/zOyFN4OgKLXKONeCDMkIUvFkF18rZTaG1zhbHJaZqv6hyod65QImmn+otu27nOH5
 PxgfjY56nfNnubdM1VylbDYuyhNEMsp5JdopU3tU1+7yAJHX+tdCmPbfCEzcNo1Qbg++bMj
 8uuT00C3Uy9GUhiqOofAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mzT+5MLSMyg=:c9wQ3R4ZiK89/jq5n/yfsi
 D/km8BFkQlAukorn5rEiJUuB4JZeIG3dhTXahDA5gbNSP+7PqpMVtFndQCCFoi7cl7wcR5Cen
 69FT/m5zUXWn82JGQGi8MMzcglcq5V7E3BFGBULWGdorGcfBggPqMtt8n/BeygxRdh5NYiq8S
 q5bGhZ4lGR7KJ+kA/MfsKqOpgLE73HLHfTI2Gr2z6uC5If/KkIVRC3blvbT5ZreFAx0murxwt
 ckGtQ1s+4u/bnCjelP7B+uAQrgy4WNJEpau0ufgu5NftM61w/0QQNflfOwEquWB0spP8iHQkm
 KMMzuA3AqRYF3r0w+Q1tm1T6hTS/2+LZREP0ov3+do+PUFGIjytODP+aIY5QeNdm+ORupIjLB
 Md7OpBpiF6Q2dkgdY2eA7Uo3E8dZsMMpfzJ8yXBIEgQ3IXjlp6UwHPlt79ws42gu06HJJlrGh
 ugaLqD22Ag==
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
X-List-Received-Date: Mon, 01 Mar 2021 12:31:23 -0000

On Feb 25 17:48, Ken Brown via Cygwin-patches wrote:
> Several of the fhandler_socket_local and fhandler_socket_unix methods
> that support system calls are written as though they are operating on
> socket files unless the socket is an abstract socket.  This patchset
> (except for the last patch) attempts to fix this by checking whether
> the fhandler is associated with a socket file.  If not, we call an
> fhandler_socket_wsock or fhandler_socket method instead of an
> fhandler_disk_file method.
> 
> The last patch is just a code simplification that arose while I was
> working on fhandler_socket_local::link.
> 
> Ken Brown (7):
>   Cygwin: fix fstat on sockets that are not socket files
>   Cygwin: fix fstatvfs on sockets that are not socket files
>   Cygwin: fix fchmod on sockets that are not socket files
>   Cygwin: fix fchown on sockets that are not socket files
>   Cygwin: fix facl on sockets that are not socket files
>   Cygwin: fix linkat(2) on sockets that are not socket files
>   Cygwin: simplify linkat with AT_EMPTY_PATH
> 
>  winsup/cygwin/fhandler_socket_local.cc | 39 +++++++++++++-----
>  winsup/cygwin/fhandler_socket_unix.cc  | 56 ++++++++++++++++----------
>  winsup/cygwin/syscalls.cc              | 24 +++++++----
>  3 files changed, 81 insertions(+), 38 deletions(-)
> 
> -- 
> 2.30.0

LGTM, please push.


Thanks,
Corinna
