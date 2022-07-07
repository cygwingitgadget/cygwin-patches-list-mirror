Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 5DA1E385842B
 for <cygwin-patches@cygwin.com>; Thu,  7 Jul 2022 08:44:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5DA1E385842B
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MiIlc-1nclb90g3q-00fSuD for <cygwin-patches@cygwin.com>; Thu, 07 Jul 2022
 10:44:29 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 621F1A807DB; Thu,  7 Jul 2022 10:44:28 +0200 (CEST)
Date: Thu, 7 Jul 2022 10:44:28 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: redefine some macros for Linux compatibility
Message-ID: <Ysac7M2R4NKpDMHK@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <efb21775-c0c5-768f-e1fd-d38145fb2f0b@cornell.edu>
 <b3d8d4c2-59f6-e3c4-4394-1a77a6ad9c9d@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3d8d4c2-59f6-e3c4-4394-1a77a6ad9c9d@cornell.edu>
X-Provags-ID: V03:K1:SB/ktjRrG2gk9uJn/RWkkHdwzzQ/ZnQ7XMXuarSqiT+HuoUPO2U
 8L4g0qPqIIqvgOzy5dDr9bcROrqpT5J3FxAlqKLafLk+dibyFikO3NaFrqM1Ozhb5EmER7p
 CPAsnTiZMKU8zwqJnGDfwO95v2huc7PuOSad3lHPfn8EkjQgFJ6s8kO0n6EpU1GHMEh2eij
 OESqdSyA8BvmM/70vB3YQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EoBTas6zaKs=:rioHuT9PB/kEsFpGQdaU6Q
 N3QThVhmIM5dIGfng9sFMxD8ew3mBHgniWpEUjwkZVEhxg7kZKQPokhdW+qWkKPOtQlgnCPps
 8M8YgntTzvD0x/KZRERelZek+TBQohilv35Oh/N7Mfxndep75rQpBg54zn2uGtq8SV9GQPmgS
 LwOzpLD8cvRYMU7xAq6ovqdiEuVDnLC/zFLKfRmliYhp5tPU++iOBYUXgdZY00gz6LGEvKXBn
 sMr1BjKYwsWPNU5L/aIf2nKflNqTJ7XTYjhGo7x+FUei4brw9SA3zg6UPLq4ROHM4Uo/0w6gB
 4Fz75XueKM5N+s/5bW+trjdWB1aaL3tzCztZP18pxdV2ugp8nBj7+eBqOyOT2vbBgTakxQY7G
 ADDPCjtoaDXP04/Ns29Fy66X4inKvCipClrs5h5O2Ox4T43pCdJI3MbJ0zI+fN+k3CR1iCU+w
 P1lFHyRKTGCd5kEKQCzZdtlZwzfX4ppxOPTGzPCu+vmugok4I/vn1XwKrXeTl4wekQA83tlW7
 wFjhrcM24NBtYt6CIMRXdPTtH0xTu5v1GOiRnBgBzYzpS3lLT7uY2YTJF/ve+wLsK6xh3CQlb
 7ZwpOFwJo+9msKEQ/SX2/Cddaa2X3D1y9klW/q1JBwnQlphvR7yn8MiUm8YxRzynm6aui9D8E
 +t2RwEzBqV8SuNBsIyxzhobKZjhN/iAVVIZ3qyD6KRZp4dNnwx0C3VURL4QR1iivZDddYVcJF
 tAM4hxGMbZ9w1F0sdkwImnu68LCmssCaMHM/Q3EmASm+oSRUPwzPXnpIsMI=
X-Spam-Status: No, score=-95.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Thu, 07 Jul 2022 08:44:33 -0000

On Jul  6 16:51, Ken Brown wrote:
> On 7/6/2022 4:25 PM, Ken Brown wrote:
> > Patch attached.
> > 
> > I wasn't sure whether the API bump was warranted for such a trivial
> > change.  But the fact is that some programs compiled prior to the patch
> > will behave differently if they are recompiled after the patch.  For
> > example, emacs limits the number of open subprocesses to FD_SETSIZE, so
> > this number will change when emacs is recompiled for Cygwin 3.4.0.  Is
> > that a good enough reason to bump the API?
> 
> Oh, wait a minute there's already been an API bump from 341 to 342, so I
> guess there's no need for another.  I could just add the FD_SETSIZE and
> NOFILE changes to the explanation for that bump.

Just bump.  It doesn't hurt.

The patch is fine.  I was going to say we should drop OPEN_MAX, too,
just as on Linux, but that would be wrong because we really use OPEN_MAX
as a limit.


Thanks,
Corinna


Idle musing:

We could think about dropping OPEN_MAX, too.  getdtablesize() and
sysconf(_SC_OPEN_MAX) could be implemented as requesting the rlimit_cur
value of getrlimit(RLIMIT_NOFILE), as in glibc.  Per the current Linux
source, the start values for RLIMIT_NOFILE are 1024 as soft, and 4096 as
hard limit...
