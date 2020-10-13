Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id A33223840C3C
 for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020 11:49:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A33223840C3C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M7NaW-1kXmzK0ZAa-007pev for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020
 13:49:34 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id A1CA6A82BD0; Tue, 13 Oct 2020 13:49:33 +0200 (CEST)
Date: Tue, 13 Oct 2020 13:49:33 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/6] Some AF_UNIX fixes
Message-ID: <20201013114933.GJ26704@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201004164948.48649-1-kbrown@cornell.edu>
 <87bd83c6-5333-6287-01ce-d91ffec83244@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bd83c6-5333-6287-01ce-d91ffec83244@cornell.edu>
X-Provags-ID: V03:K1:ORilx4/FN/UoX6CnEN17C+QXf+QqbxOFEAqi0gSgnlaCeMFFWdA
 y2NXnhCzc7ctBYNdUp9Tfu9pv5mmPQuU7Ch7WnpnzR6vaiqUr6NgvuoyQT3FjGJphlHl8gO
 +vpEnCElo9xPL+m+CPcXdhKRekb8QpzUaraAOrKmXnj7vdO4v1sPkIqrp/RF9aNLrVnjwIL
 H4pq911fCU+4afFFpEAkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ffECa2/jOCY=:N/+g+AH00+zIBzHZvg5I+O
 +ldSceSbZBpXokcAdoqjtbNvXXjqcbGfak2+hiNXkbUWzZ2tHVl0mm91iTYv5O4aIvjiKvjx8
 sTvqcSGN7IVSfB32beTtf8rXKbcZDiV94rhURCyG/ko+aaLOs7bBa2fCzo2zD53a3v96iWkuj
 emS/OTsnz9fHSU8YIXwW6TBRLang7tBXN+xDCl3E8LpO/LsUrMGe+Xg7N8y5xkbhCCAx8rdW2
 HI7CMXkU1luQSrUsfuWGEMr5wqwUcGLoWfgBrWvkSQ4X/RLfjucAt+7E+WJG2Fij4nsoCzaF3
 PVUMyBdIT0UKRaycPatQHXI+GxmsdGid0qWZxfW1Dz6Q3btI47Ubru1tR/Go2IlOQNAgtR4LM
 EIxvRmFcKHLAbRN5pFnIL+DiMPhV4i3udRldm585w2M4AhH0cliAPZiC3HaAs602dV6V88mPv
 YlBDMwqDug==
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
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
X-List-Received-Date: Tue, 13 Oct 2020 11:49:38 -0000

On Oct  8 17:36, Ken Brown via Cygwin-patches wrote:
> On 10/4/2020 12:49 PM, Ken Brown via Cygwin-patches wrote:
> > I'm about to push these.  Corinna, please check them when you return.
> > The only difference between v2 and v1 is that there are a few more
> > fixes.
> > 
> > I'm trying to help get the AF_UNIX development going again.  I'm
> > mostly working on the topic/af_unix branch.  But when I find bugs that
> > exist on master, I'll push those to master and then merge master to
> > topic/af_unix.
> 
> FYI to Corinna and anyone else interested in AF_UNIX development.  After
> pushing a few patches to the topic/af_unix branch I did some cleanup
> (locally) and merged master into the topic branch.  I don't want to do a
> forced push and risk messing up the branch, so I've created a new branch,
> topic/af_unix_new, and will do all further work there until Corinna returns
> and decides how we should proceed.

No, that's ok, just force push.


Thanks,
Corinna
